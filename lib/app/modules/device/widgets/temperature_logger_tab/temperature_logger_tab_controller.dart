import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';

import '../../../../data/models/local/model_temperature_logger.dart';
import '../../device_controller.dart';
import '../../../../utils/constants/ble_api/temperature_logger/temperature_logger_constants.dart';
import '../../../../utils/constants/ble_api/temperature_logger/temperature_logger_commands.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/helpers/helpers.dart';

class TemperatureLoggerTabController extends GetxController {
  ModelTemperatureLogger modelTemperatureLogger = ModelTemperatureLogger();

  RxBool _setAllSameAlarms = false.obs;
  bool get setAllSameAlarms => _setAllSameAlarms.value;

  bool get isFwHigherOrEqual1_0_3 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.0.3',
      );

  Map<int, String> ntcSensorMapDynamic = {
    1: 'Sensor 1',
    2: 'Sensor 2',
    3: 'Sensor 3',
    4: 'Sensor 4',
  };

  Map<int, String> ntcSensorMap = {
    1: 'Sensor 1',
    2: 'Sensor 2',
    3: 'Sensor 3',
    4: 'Sensor 4',
  };

  Map<int, String> ntcSensorMapDynamicV103 = {
    1: 'Sensor 1',
    2: 'Sensor 2',
    3: 'Sensor 3',
    4: 'Sensor 4',
    5: 'Sensor digital (Temp)',
    6: 'Sensor digital (Hum)',
  };

  Map<int, String> ntcSensorMapV103 = {
    1: 'Sensor 1',
    2: 'Sensor 2',
    3: 'Sensor 3',
    4: 'Sensor 4',
    5: 'Sensor digital (Temp)',
    6: 'Sensor digital (Hum)',
  };

  RxInt _numNtcSensorToSet = 1.obs;
  int get numNtcSensorToSet => _numNtcSensorToSet.value;
  final int totalNtcSensor = 4;

  // [ idx, 'delta', 'min', 'max', error_delta, error_min, error_max]
  List<List<dynamic>> alarmValuesToSet = [
    //[null, '', '', '', null, null, null]
  ];

  RxString _errorNoneAlarmToSet = ''.obs;
  String get errorNoneAlarmToSet => _errorNoneAlarmToSet.value;

  void addSensorToSet() {
    _numNtcSensorToSet.value++;
  }

  void removeSensorToSet(int idx) {
    try {
      int lastV = alarmValuesToSet[idx][0];

      if (modelTemperatureLogger.deviceVersion == 3.0 &&
          isFwHigherOrEqual1_0_3) {
        if (lastV < 5) {
          ntcSensorMapDynamicV103[lastV] = 'Sensor $lastV';
        } else if (lastV == 5) {
          ntcSensorMapDynamicV103[lastV] = 'Sensor digital (Temp)';
        } else {
          ntcSensorMapDynamicV103[lastV] = 'Sensor digital (Hum)';
        }
      }

      alarmValuesToSet.removeAt(idx);
    } catch (e) {}

    _numNtcSensorToSet.value--;
  }

  void onChangedSetAllSameAlarms(bool v) {
    _setAllSameAlarms.value = v;
  }

  void onChangedDropdownNtcSensor(int v, lastV) {
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

      if (modelTemperatureLogger.deviceVersion == 3.0 &&
          isFwHigherOrEqual1_0_3) {
        if (lastV < 5) {
          ntcSensorMapDynamicV103[lastV] = 'Sensor $lastV';
        } else if (lastV == 5) {
          ntcSensorMapDynamicV103[lastV] = 'Sensor digital (Temp)';
        } else {
          ntcSensorMapDynamicV103[lastV] = 'Sensor digital (Hum)';
        }
      }
    } else {
      alarmValuesToSet.add([v, '', '', '', null, null, null]);
    }

    (modelTemperatureLogger.deviceVersion == 3.0 && isFwHigherOrEqual1_0_3)
        ? ntcSensorMapDynamicV103.remove(v)
        : ntcSensorMapDynamic.remove(v);
    update(['ntcSensorAlarmCard']);
  }

  void onChangedDeltaValue(String t, int idx) {
    alarmValuesToSet[idx][1] = t;
  }

  void onChangedMinValue(String t, int idx) {
    alarmValuesToSet[idx][2] = t;
  }

  void onChangedMaxValue(String t, int idx) {
    alarmValuesToSet[idx][3] = t;
  }

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiReloadView() async {
    await sendDataToDevice([TEMPERATURE_LOGGER_CMDS.DATA_REPORT]);
    await sendDataToDevice([TEMPERATURE_LOGGER_CMDS.GET_ALARM_PARAMETERS]);
  }

  Future<void> bleApiSetAlarms() async {
    bool error = false;

    if (alarmValuesToSet.length > 0) {
      _errorNoneAlarmToSet.value = '';

      alarmValuesToSet.forEach((e) {
        for (int i = 1; i < 4; i++) {
          String property = e[i];
          int errorPos = i + 3;

          // Limits
          int upper = i > 1 ? 99 : 10;

          if (property.length > 0) {
            if (CONSTANTS.positiveIntegerFormat.hasMatch(property)) {
              int value = int.parse(property);

              if (!(value >= 1 && value <= upper)) {
                e[errorPos] =
                    'range_error'.trArgs(['(1 - ${upper.toString()})']);
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
      _errorNoneAlarmToSet.value = 'no_sensor_select_error'.tr;
      error = true;
    }

    update(['ntcSensorAlarmCard']);

    if (!error) {
      int totalNtcSensorToSet = alarmValuesToSet.length;
      List<int> ntcSensorAlarm = [];

      int res = TEMPERATURE_LOGGER_CONSTANTS.ADC_RESOLUTION;
      int ro = TEMPERATURE_LOGGER_CONSTANTS.NTC_RO;
      int rf = TEMPERATURE_LOGGER_CONSTANTS.NTC_RF;
      int externalB = TEMPERATURE_LOGGER_CONSTANTS.NTC_EXTERNAL_B;

      if (!_setAllSameAlarms.value &&
          totalNtcSensorToSet <=
              ((modelTemperatureLogger.deviceVersion == 3.0 &&
                      isFwHigherOrEqual1_0_3)
                  ? 6
                  : 4)) {
        List<int> bleApiNtcSensorAlarm = [];
        for (int i = 0; i < totalNtcSensorToSet; i++) {
          bleApiNtcSensorAlarm = [];

          ntcSensorAlarm.add(alarmValuesToSet[i][0]); // Establecer el ID

          // delta
          bleApiNtcSensorAlarm +=
              divideIntInNBytes(int.parse(alarmValuesToSet[i][1]), 2);

          print(bleApiNtcSensorAlarm);

          for (int j = 2; j < 4; j++) {
            // min, max

            bleApiNtcSensorAlarm += divideIntInNBytes(
                (alarmValuesToSet[i][0] > 4
                    ? int.parse(alarmValuesToSet[i][j])
                    : temperatureToAdc(double.parse(alarmValuesToSet[i][j]),
                        res, ro, rf, externalB)),
                2);
          }

          ntcSensorAlarm +=
              bleApiNtcSensorAlarm; // Agregar el payload de la alarma a configurar

          print("ID: $ntcSensorAlarm");
        }
      } else {
        totalNtcSensorToSet = (modelTemperatureLogger.deviceVersion == 3.0 &&
                isFwHigherOrEqual1_0_3)
            ? 6
            : totalNtcSensor;
        for (int i = 0; i < totalNtcSensorToSet; i++) {
          // idx
          int idx = i + 1;
          ntcSensorAlarm.add(idx);
          print(idx);
          // delta
          ntcSensorAlarm +=
              divideIntInNBytes(int.parse(alarmValuesToSet[0][1]), 2);

          for (int j = 2; j < 4; j++) {
            ntcSensorAlarm += divideIntInNBytes(
                (idx > 4
                    ? int.parse(alarmValuesToSet[0][j])
                    : temperatureToAdc(double.parse(alarmValuesToSet[0][j]),
                        res, ro, rf, externalB)),
                2);
          }
        }
      }

      print("Configuraré: ${[
        TEMPERATURE_LOGGER_CMDS.SET_ALARM_PARAMETERS,
        totalNtcSensorToSet,
        ...ntcSensorAlarm
      ]}");

      await sendDataToDevice([
        TEMPERATURE_LOGGER_CMDS.SET_ALARM_PARAMETERS,
        totalNtcSensorToSet,
        ...ntcSensorAlarm
      ]);
    }
  }

  void onChangedI2cSensor(int k) {
    modelTemperatureLogger.setI2cSensor = k;
    if (modelTemperatureLogger.errorSetI2cSensor != null)
      modelTemperatureLogger.errorSetI2cSensor = null;
  }

  Future<void> bleApiSetI2cSensor() async {
    if (TEMPERATURE_LOGGER_CONSTANTS.I2C_SENSOR_MAP
        .containsKey(modelTemperatureLogger.setI2cSensor)) {
      await sendDataToDevice([
        TEMPERATURE_LOGGER_CMDS.SET_I2C_SENSOR,
        modelTemperatureLogger.setI2cSensor
      ], log: 'Digital sensor: ${TEMPERATURE_LOGGER_CONSTANTS.I2C_SENSOR_MAP[modelTemperatureLogger.setI2cSensor]}');
    } else
      modelTemperatureLogger.errorSetI2cSensor = 'select_error'.tr;
  }
}
