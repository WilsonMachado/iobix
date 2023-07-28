import 'package:get/get.dart';
import 'package:iobix/app/data/models/local/model_tilt_sensor.dart';
import 'package:iobix/app/modules/device/device_controller.dart';
import 'package:iobix/app/utils/constants/ble_api/tilt_sensor/tilt_sensor_commands.dart';
import 'package:iobix/app/utils/constants/constants.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

class TiltSensorTabController extends GetxController {
  ModelTiltSensor modelTiltSensor = ModelTiltSensor();

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiReloadView() async {
    await sendDataToDevice([TILT_SENSOR_CMDS.DATA_REPORT]);
  }

  Future<void> updateAlarmMode(int v) async {
    await sendDataToDevice([TILT_SENSOR_CMDS.ALARM_MODE_CONFIG, v]);
  }

  //! Funciones auxiliares para capturar el ingreso de datos

  void onChangedSetAngleDelta(String text) {
    modelTiltSensor.setAngleDelta = text;
    if (modelTiltSensor.errorSetAngleDelta != null) {
      modelTiltSensor.errorSetAngleDelta = null;
    }
  }

  void onChangedSetAngleMin(String text) {
    modelTiltSensor.setAngleMin = text;
    if (modelTiltSensor.errorSetAngleMin != null) {
      modelTiltSensor.errorSetAngleMin = null;
    }
  }

  void onChangedSetAngleMax(String text) {
    modelTiltSensor.setAngleMax = text;
    if (modelTiltSensor.errorSetAngleMax != null) {
      modelTiltSensor.errorSetAngleMax = null;
    }
  }

  void onChangedSetAlarmTransmitionPeriod(String text) {
    modelTiltSensor.setAlarmTransmitionPeriod = text;
    if (modelTiltSensor.errorSetAlarmTransmitionPeriod != null) {
      modelTiltSensor.errorSetAlarmTransmitionPeriod = null;
    }
  }

  //! Funciones auxiliares para validar y setear los datos ingresados

  //* TODOS

  Future<void> bleApiSetAnglesAll() async {
    bool errorDelta = false;
    int valueDelta;
    bool errorMax = false;
    int valueMax;
    bool errorMin = false;
    int valueMin;

    //? Delta

    if (modelTiltSensor.setAngleDelta.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelTiltSensor.setAngleDelta)) {
        valueDelta = int.parse(modelTiltSensor.setAngleDelta);
        if (valueDelta > 90 || valueDelta < 10) {
          modelTiltSensor.errorSetAngleDelta =
              'range_error'.trArgs(['10° - 90°']);
          errorDelta = true;
        }
      } else {
        modelTiltSensor.errorSetAngleDelta = 'format_error'.tr;
        errorDelta = true;
      }
    } else {
      modelTiltSensor.errorSetAngleDelta = 'empty_error'.tr;
      errorDelta = true;
    }

    //? Min

    if (modelTiltSensor.setAngleMin.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelTiltSensor.setAngleMin)) {
        valueMin = int.parse(modelTiltSensor.setAngleMin);
        if (valueMin > 360 || valueMin < 0) {
          modelTiltSensor.errorSetAngleMin =
              'range_error'.trArgs(['0° - 360°']);
          errorMin = true;
        }
      } else {
        modelTiltSensor.errorSetAngleMin = 'format_error'.tr;
        errorMin = true;
      }
    } else {
      modelTiltSensor.errorSetAngleMin = 'empty_error'.tr;
      errorMin = true;
    }

    //? Max

    if (modelTiltSensor.setAngleMax.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelTiltSensor.setAngleMax)) {
        valueMax = int.parse(modelTiltSensor.setAngleMax);
        if (valueMax > 360 || valueMax < 0) {
          modelTiltSensor.errorSetAngleMax =
              'range_error'.trArgs(['0° - 360°']);
          errorMax = true;
        }
      } else {
        modelTiltSensor.errorSetAngleMax = 'format_error'.tr;
        errorMax = true;
      }
    } else {
      modelTiltSensor.errorSetAngleMax = 'empty_error'.tr;
      errorMax = true;
    }

    if (!errorDelta && !errorMin && !errorMax) {
      await sendDataToDevice(([
        TILT_SENSOR_CMDS.ALARM_CONFIG,
        ...(divideIntInNBytes(valueDelta, 2)),
        ...(divideIntInNBytes(valueMin, 2)),
        ...(divideIntInNBytes(valueMax, 2)),
      ]));
    }
  }

  //* ALARM_TRANSMITION_PERIOD

  Future<void> bleApiSetAlarmTransmitionPeriod() async {
    bool error = false;
    int value;

    if (modelTiltSensor.setAlarmTransmitionPeriod.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelTiltSensor.setAlarmTransmitionPeriod)) {
        value = int.parse(modelTiltSensor.setAlarmTransmitionPeriod);
        if (value > 71000000 || value < 1) {
          modelTiltSensor.errorSetAlarmTransmitionPeriod =
              'range_error'.trArgs(['2 - 71000000']);
          error = true;
        }
      } else {
        modelTiltSensor.errorSetAlarmTransmitionPeriod = 'format_error'.tr;
        error = true;
      }
    } else {
      modelTiltSensor.errorSetAlarmTransmitionPeriod = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(([
        TILT_SENSOR_CMDS.ALARM_TRANSMITION_PERIOD_CONFIG,
        ...(divideIntInNBytes(value, 4))
      ]));
    }
  }
}
