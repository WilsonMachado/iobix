import 'package:get/get.dart';

import '../../device_controller.dart';
import '../../../../data/models/local/model_smart_meter_dc.dart';
import '../../../../utils/constants/ble_api/smart_meter_dc/smart_meter_dc_commands.dart';
import '../../../../utils/helpers/ble_api/ble_api_smart_meter_dc.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/helpers/helpers.dart';

class SmartMeterDcTabController extends GetxController {
  ModelSmartMeterDc modelSmartMeterDc = ModelSmartMeterDc();

  final int totalChannel = 2;

  RxString _errorNoneAlarmToSet = ''.obs;
  String get errorNoneAlarmToSet => _errorNoneAlarmToSet.value;

  RxInt _numChannelsToSet = 1.obs;
  int get numChannelsToSet => _numChannelsToSet.value;

  RxBool _setAllSameAlarms = false.obs;
  bool get setAllSameAlarms => _setAllSameAlarms.value;

  // [ idx, 'delta', 'min', 'max', error_delta, error_min, error_max]
  List<List<dynamic>> alarmValuesToSet = [
    //[null, '', '', '', null, null, null]
  ];

  Map<int, String> dynamicChannelMap = {
    1: 'Canal 1',
    2: 'Canal 2',
  };

  Map<int, String> channelMap = {
    1: 'Canal 1',
    2: 'Canal 2',
  };

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiDataReport() async {
    await sendDataToDevice([SMART_METER_DC_CMDS.DATA_REPORT]);
    await Future.delayed(Duration(milliseconds: 10));
    await sendDataToDevice([SMART_METER_DC_CMDS.GET_ALARM_PARAMETERS]);
  }

  void onChangedSetAllSameAlarms(bool v) => _setAllSameAlarms.value = v;

  void onChangedDeltaValue(String t, int idx) {
    alarmValuesToSet[idx][1] = t;
  }

  void onChangedMinValue(String t, int idx) {
    alarmValuesToSet[idx][2] = t;
  }

  void onChangedMaxValue(String t, int idx) {
    alarmValuesToSet[idx][3] = t;
  }

  void addSensorToSet() {
    _numChannelsToSet.value++;
  }

  void removeChannelToSet(int idx) {
    try {
      int lastV = alarmValuesToSet[idx][0];
      dynamicChannelMap[lastV] = 'Canal $lastV';
      alarmValuesToSet.removeAt(idx);
    } catch (e) {}

    _numChannelsToSet.value--;
  }

  void onChangedDropdownChannel(int v, lastV) {
    _errorNoneAlarmToSet.value = '';

    int lastAlarm = alarmValuesToSet.indexWhere((e) => e[0] == lastV);
    if (lastAlarm != -1) {
      alarmValuesToSet.add([
        v,
        alarmValuesToSet[lastAlarm][1],
        alarmValuesToSet[lastAlarm][2],
        alarmValuesToSet[lastAlarm][3],
        null,
        null,
        null
      ]);
      alarmValuesToSet.removeAt(lastAlarm);
      dynamicChannelMap[lastV] = 'Canal $lastV';
    } else {
      alarmValuesToSet.add([v, '', '', '', null, null, null]);
    }

    dynamicChannelMap.remove(v);
    update(['tabSetView']);
  }

  Future<void> bleApiSetDataAlarms() async {
    bool error = false;

    if (alarmValuesToSet.length > 0) {
      _errorNoneAlarmToSet.value = '';

      alarmValuesToSet.forEach((e) {
        for (int i = 1; i < 4; i++) {
          String property = e[i];
          int errorPos = i + 3;

          // Limits
          int lower = (i == 3) ? 48 : 1;
          int upper = (i == 1)
              ? 10
              : (i == 2)
                  ? 48
                  : 60;

          if (property.length > 0) {
            if (CONSTANTS.positiveIntegerFormat.hasMatch(property)) {
              int value = int.parse(property);

              if (!(value >= lower && value <= upper)) {
                e[errorPos] = 'range_error'
                    .trArgs(['(${lower.toString()} - ${upper.toString()})']);
                error = true;
              } else if (i == 3) {
                if (e[errorPos - 1] == null) {
                  if (value <= int.parse(e[i - 1])) {
                    e[errorPos] = 'max_threshold_error'.tr;
                    error = true;
                  }
                }
              }
            } else {
              e[errorPos] = 'format_error'.tr;
              error = true;
            }
          } else {
            e[errorPos] = 'empty_error'.tr;
            error = true;
          }

          if (!error) e[errorPos] = null;
        }
      });
    } else {
      _errorNoneAlarmToSet.value = 'Aún no seleccionas un canal'.tr;
      error = true;
    }

    update(['tabSetView']);

    if (!error) {
      int totalChannelToSet = alarmValuesToSet.length;
      List<int> channelAlarm = [];

      if (_setAllSameAlarms.value && totalChannelToSet == 1) {
        List<int> bleApiChannelAlarm = [];
        totalChannelToSet = totalChannel;

        // delta, min, max
        for (int i = 1; i < 4; i++) {
          bleApiChannelAlarm += divideIntInNBytes(
            getAdcVoltage(
              int.parse(alarmValuesToSet[0][i]),
            ),
            2,
          );
        }

        for (int i = 0; i < totalChannel; i++) {
          // idx
          channelAlarm.add(i + 1);
          // params
          channelAlarm += bleApiChannelAlarm;
        }
      } else {
        for (int i = 0; i < totalChannelToSet; i++) {
          // idx
          channelAlarm.add(alarmValuesToSet[i][0]);

          for (int j = 1; j < 4; j++) {
            channelAlarm += divideIntInNBytes(
              getAdcVoltage(
                int.parse(alarmValuesToSet[i][j]),
              ),
              2,
            );
          }
        }
      }

      await sendDataToDevice([
        SMART_METER_DC_CMDS.SET_ALARM_PARAMETERS,
        totalChannelToSet,
        ...channelAlarm,
      ]);
    }
  }

  void onChangedSetCurrentRange(String t) {
    modelSmartMeterDc.setCurrentRange = t;
    if (modelSmartMeterDc.errorSetCurrentRange != null) {
      modelSmartMeterDc.errorSetCurrentRange = null;
    }
  }

  Future<void> bleApiSetCurrentRange() async {
    bool error = false;
    int value;

    if (modelSmartMeterDc.setCurrentRange.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelSmartMeterDc.setCurrentRange)) {
        value = int.parse(modelSmartMeterDc.setCurrentRange);
        if (value > 9999 || value < 0) {
          modelSmartMeterDc.errorSetCurrentRange =
              'range_error'.trArgs(['0 - 9999']);
          error = true;
        }
      } else {
        modelSmartMeterDc.errorSetCurrentRange = 'format_error'.tr;
        error = true;
      }
    } else {
      modelSmartMeterDc.errorSetCurrentRange = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice([
        SMART_METER_DC_CMDS.SET_CURRENT_RANGE,
        ...listIntLsbToMsb(divideIntInNBytes(value, 2)),
      ], log: 'Set current range: $value A');
    }
  }
}
