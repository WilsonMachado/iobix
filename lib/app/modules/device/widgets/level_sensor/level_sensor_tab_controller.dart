import 'package:get/get.dart';

import '../../../../data/models/local/model_level_sensor.dart';
import '../../device_controller.dart';
import '../../../../utils/constants/ble_api/level_sensor/level_sensor_commands.dart';
import '../../../../utils/constants/ble_api/level_sensor/level_sensor_constants.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../../utils/constants/constants.dart';

class LevelSensorTabController extends GetxController {
  ModelLevelSensor modelLevelSensor = ModelLevelSensor();

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiReloadView() async {
    await sendDataToDevice([LEVEL_SENSOR_CMDS.DATA_REPORT]);
    await sendDataToDevice([LEVEL_SENSOR_CMDS.GET_ALARM_PARAMETERS]);
  }

  void onChangedDeltaValue(String t) {
    modelLevelSensor.setMaxsonarDelta = t;
    if (modelLevelSensor.errorSetMaxsonarDelta != null) {
      modelLevelSensor.errorSetMaxsonarDelta = null;
    }
  }

  void onChangedMinValue(String t) {
    modelLevelSensor.setMaxsonarMin = t;
    if (modelLevelSensor.errorSetMaxsonarMin != null) {
      modelLevelSensor.errorSetMaxsonarMin = null;
    }
  }

  void onChangedMaxValue(String t) {
    modelLevelSensor.setMaxsonarMax = t;
    if (modelLevelSensor.errorSetMaxsonarMax != null) {
      modelLevelSensor.errorSetMaxsonarMax = null;
    }
  }

  List<dynamic> checkAlarmParameterValue(String param, double min, max) {
    bool error = false;
    String errorText;

    if (param.length > 0) {
      List split = param.split('.');

      if (split.length == 2 && (split[1].length == 2)) {
        double v = double.parse(param);

        if (v < min || v > max) {
          errorText = 'range_error'.trArgs(['($min-$max)']);
          error = true;
        }
      } else {
        errorText = 'format_error'.tr;
        error = true;
      }
    } else {
      errorText = 'empty_error'.tr;
      error = true;
    }

    return [error, errorText];
  }

  Future<void> bleApiSetAlarmParameters() async {
    bool error = false;

    List checkDelta =
        checkAlarmParameterValue(modelLevelSensor.setMaxsonarDelta, 0.10, 2.00);
    if (checkDelta[0]) {
      modelLevelSensor.errorSetMaxsonarDelta = checkDelta[1];
      error = true;
    }

    List checkMin =
        checkAlarmParameterValue(modelLevelSensor.setMaxsonarMin, 1.00, 9.95);
    if (checkMin[0]) {
      modelLevelSensor.errorSetMaxsonarMin = checkMin[1];
      error = true;
    }

    List checkMax =
        checkAlarmParameterValue(modelLevelSensor.setMaxsonarMax, 1.00, 9.95);
    if (checkMax[0]) {
      modelLevelSensor.errorSetMaxsonarMax = checkMax[1];
      error = true;
    }

    if (!error) {
      int delta =
          (double.parse(modelLevelSensor.setMaxsonarDelta) * 1000).round();
      int min = (double.parse(modelLevelSensor.setMaxsonarMin) * 1000).round();
      int max = (double.parse(modelLevelSensor.setMaxsonarMax) * 1000).round();

      if (min >= max) {
        modelLevelSensor.errorSetMaxsonarMax = 'max_threshold_error'.tr;
      } else {
        await sendDataToDevice([
          LEVEL_SENSOR_CMDS.SET_ALARM_PARAMETERS,
          ...listIntLsbToMsb(divideIntInNBytes(delta, 2)),
          ...listIntLsbToMsb(divideIntInNBytes(min, 2)),
          ...listIntLsbToMsb(divideIntInNBytes(max, 2))
        ], log: 'Delta: $delta, Umbral inferior: $min, Umbral superior: $max');
      }
    }
  }

  void onChangedI2cSensor(int k) {
    modelLevelSensor.setI2cSensor = k;
    if (modelLevelSensor.errorSetI2cSensor != null)
      modelLevelSensor.errorSetI2cSensor = null;
  }

  Future<void> bleApiSetI2cSensor() async {
    if (LEVEL_SENSOR_CONSTANTS.I2C_SENSOR_MAP
        .containsKey(modelLevelSensor.setI2cSensor)) {
      await sendDataToDevice([
        LEVEL_SENSOR_CMDS.SET_I2C_SENSOR,
        modelLevelSensor.setI2cSensor
      ], log: 'Digital sensor: ${LEVEL_SENSOR_CONSTANTS.I2C_SENSOR_MAP[modelLevelSensor.setI2cSensor]}');
    } else
      modelLevelSensor.errorSetI2cSensor = 'select_error'.tr;
  }

  void onChangedGnssEnableSyncMinute(bool v) {
    modelLevelSensor.enableGnssSyncMinute =
        !modelLevelSensor.enableGnssSyncMinute;
  }

  void onChangedGnssSyncMinute(String t) {
    modelLevelSensor.setGnssSyncMinute = t;
    if (modelLevelSensor.errorSetGnssSyncMinute.length > 0) {
      modelLevelSensor.errorSetGnssSyncMinute = '';
    }
  }

  void onChangedGnssEnableSyncHour(bool v) {
    modelLevelSensor.enableGnssSyncHour = !modelLevelSensor.enableGnssSyncHour;
  }

  void onChangedGnssSyncHour(String t) {
    modelLevelSensor.setGnssSyncHour = t;
    if (modelLevelSensor.errorSetGnssSyncHour.length > 0) {
      modelLevelSensor.errorSetGnssSyncHour = '';
    }
  }

  void onChangedGnssEnableSyncDayWeekOrMonth(bool v) {
    modelLevelSensor.enableGnssSyncDayWeekOrMonth =
        !modelLevelSensor.enableGnssSyncDayWeekOrMonth;
  }

  void onChangedGnssSyncDayWeekOrMonth(String t) {
    modelLevelSensor.setGnssSyncDayWeekOrMonth = t;
    if (modelLevelSensor.errorSetGnssSyncDayWeekOrMonth.length > 0) {
      modelLevelSensor.errorSetGnssSyncDayWeekOrMonth = '';
    }
  }

  void onChangedSelectGnssSyncDayWeekOrMonth(int v) {
    modelLevelSensor.selectGnssSyncDayWeekOrMonth = v;
    modelLevelSensor.errorSetGnssSyncDayWeekOrMonth = '';
  }

  List<dynamic> checkGnssSyncParameterValue(String param, int min, max) {
    bool error = false;
    String errorText = '';

    if (param.length > 0) {
      if (CONSTANTS.positiveIntegerFormat.hasMatch(param)) {
        int v = int.parse(param);

        if (!(v >= min && v <= max)) {
          errorText = 'range_error'.trArgs(['($min - $max)']);
          error = true;
        }
      } else {
        errorText = 'format_error'.tr;
        error = true;
      }
    } else {
      errorText = 'empty_error'.tr;
      error = true;
    }

    return [error, errorText];
  }

  Future<void> bleApiSetGnssSync() async {
    bool error = false;

    modelLevelSensor.errorSetGnssSyncMinute = '';
    modelLevelSensor.errorSetGnssSyncHour = '';
    modelLevelSensor.errorSetGnssSyncDayWeekOrMonth = '';

    if (!modelLevelSensor.enableGnssSyncMinute &&
        !modelLevelSensor.enableGnssSyncHour &&
        !modelLevelSensor.enableGnssSyncDayWeekOrMonth) {
      modelLevelSensor.isAnyEnableGnssSync = true;
      error = true;
    } else {
      modelLevelSensor.isAnyEnableGnssSync = false;
    }

    if (modelLevelSensor.enableGnssSyncMinute) {
      List checkGnssMinute = checkGnssSyncParameterValue(
          modelLevelSensor.setGnssSyncMinute, 0, 59);
      error = checkGnssMinute[0];
      modelLevelSensor.errorSetGnssSyncMinute = checkGnssMinute[1];
    }

    if (modelLevelSensor.enableGnssSyncHour) {
      List checkGnssHour =
          checkGnssSyncParameterValue(modelLevelSensor.setGnssSyncHour, 0, 23);
      error = checkGnssHour[0];
      modelLevelSensor.errorSetGnssSyncHour = checkGnssHour[1];
    }

    if (modelLevelSensor.enableGnssSyncDayWeekOrMonth) {
      List checkGnssDayWeekOrMonth = checkGnssSyncParameterValue(
          modelLevelSensor.setGnssSyncDayWeekOrMonth,
          (modelLevelSensor.selectGnssSyncDayWeekOrMonth == 0) ? 0 : 1,
          (modelLevelSensor.selectGnssSyncDayWeekOrMonth == 0) ? 6 : 30);
      error = checkGnssDayWeekOrMonth[0];
      modelLevelSensor.errorSetGnssSyncDayWeekOrMonth =
          checkGnssDayWeekOrMonth[1];
    }

    if (!error) {
      await sendDataToDevice([
        LEVEL_SENSOR_CMDS.SET_GNSS_PERIODICITY,
        _processByteSetGnssSync(modelLevelSensor.setGnssSyncMinute,
            modelLevelSensor.enableGnssSyncMinute),
        _processByteSetGnssSync(modelLevelSensor.setGnssSyncHour,
            modelLevelSensor.enableGnssSyncHour),
        (modelLevelSensor.selectGnssSyncDayWeekOrMonth == 0)
            ? _processByteSetGnssSync(
                modelLevelSensor.setGnssSyncDayWeekOrMonth,
                modelLevelSensor.enableGnssSyncDayWeekOrMonth)
            : 0,
        (modelLevelSensor.selectGnssSyncDayWeekOrMonth == 1)
            ? _processByteSetGnssSync(
                modelLevelSensor.setGnssSyncDayWeekOrMonth,
                modelLevelSensor.enableGnssSyncDayWeekOrMonth)
            : 0,
      ]);
    }
  }

  int _processByteSetGnssSync(String v, bool enable) {
    if (!enable) return 0;

    int byte = 0;

    List<String> split = ((int.parse(v) / 10).toStringAsFixed(1)).split('.');

    byte = (int.parse(split[0]) & 0x07) << 4;
    byte |= (int.parse(split[1]) & 0x0F);
    byte |= ((enable ? 1 : 0) & 0x01) << 7;

    return byte;
  }
}
