import 'package:iobix/app/data/models/local/model_log_console.dart';
import 'package:iobix/app/data/models/local/model_tilt_sensor.dart';
import 'package:iobix/app/utils/constants/ble_api/ble_general_constants.dart';
import 'package:iobix/app/utils/constants/ble_api/tilt_sensor/tilt_sensor_commands.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

ModelLogConsole bleApiTiltSensor(
    List<int> frame, ModelTiltSensor modelTiltSensor) {
  final int cmd = frame[0], status = frame[1];
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    int ptr = 2;
    if (modelTiltSensor.deviceVersion == 1.0) {
      switch (cmd) {
        case TILT_SENSOR_CMDS.DATA_REPORT:
          modelTiltSensor.angleIncl =
              listBytesToInt(frame.sublist(ptr, ptr + 2)) / 100.0;
          // print('Angulo de inclinacion: ${modelTiltSensor.angleIncl}');
          ptr += 2;
          modelTiltSensor.angleX = hexC2ToDecimal(
                  (frame[ptr] << 24) |
                      (frame[ptr + 1] << 16) |
                      (frame[ptr + 2] << 8) |
                      (frame[ptr + 3]),
                  4) /
              100.0;
          // print('Angulo en X: ${modelTiltSensor.angleX}');
          ptr += 4;
          modelTiltSensor.angleY = hexC2ToDecimal(
                  (frame[ptr] << 24) |
                      (frame[ptr + 1] << 16) |
                      (frame[ptr + 2] << 8) |
                      (frame[ptr + 3]),
                  4) /
              100.0;
          // print('Angulo en Y: ${modelTiltSensor.angleY}');
          ptr += 4;
          modelTiltSensor.angleZ = hexC2ToDecimal(
                  (frame[ptr] << 24) |
                      (frame[ptr + 1] << 16) |
                      (frame[ptr + 2] << 8) |
                      (frame[ptr + 3]),
                  4) /
              100.0;
          // print('Angulo en Z: ${modelTiltSensor.angleZ}');
          ptr += 4;
          modelTiltSensor.getAlarmModeStatus = frame[ptr];
          // print('Estado del modo de alarma: ${modelTiltSensor.getAlarmModeStatus}');
          ptr += 1;
          modelTiltSensor.getAlarmTransmitionPeriod =
              listBytesToInt(frame.sublist(ptr, ptr + 4));
          // print(modelTiltSensor.getAlarmTransmitionPeriod);
          ptr += 4;
          modelTiltSensor.getAngleDelta =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          // print('Delta: ${modelTiltSensor.getAngleDelta}');
          ptr += 2;
          modelTiltSensor.getAngleMin =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          // print('Min: ${modelTiltSensor.getAngleMin}');
          ptr += 2;
          modelTiltSensor.getAngleMax =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          //// print('Max: ${modelTiltSensor.getAngleMax}');
          break;
        case TILT_SENSOR_CMDS.ALARM_CONFIG:
          modelTiltSensor.getAngleDelta =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          // print('Delta: ${modelTiltSensor.getAngleDelta}');
          ptr += 2;
          modelTiltSensor.getAngleMin =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          // print('Min: ${modelTiltSensor.getAngleMin}');
          ptr += 2;
          modelTiltSensor.getAngleMax =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          //// print('Max: ${modelTiltSensor.getAngleMax}');
          break;
        case TILT_SENSOR_CMDS.ALARM_TRANSMITION_PERIOD_CONFIG:
          modelTiltSensor.getAlarmTransmitionPeriod =
              listBytesToInt(frame.sublist(ptr, ptr + 4));
          break;
        case TILT_SENSOR_CMDS.ALARM_MODE_CONFIG:
          modelTiltSensor.getAlarmModeStatus = frame[ptr];
          break;
        default:
          break;
      }
    }
  }
  log += ' Ok';
  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}
