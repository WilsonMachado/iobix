import 'dart:typed_data';

import '../../../data/models/local/model_level_sensor.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../utils/constants/ble_api/level_sensor/level_sensor_commands.dart';
import '../../../utils/constants/ble_api/level_sensor/level_sensor_constants.dart';
import '../../../utils/helpers/helpers.dart';

ModelLogConsole bleApiLevelSensor(
  List<int> frame,
  ModelLevelSensor modelLevelSensor,
) {
  final int cmd = frame[0], status = frame[1];

  int ptr = 2, cmdError = 0x00;
  String log = '';
  bool isResponseOk = true;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    switch (cmd) {
      case LEVEL_SENSOR_CMDS.DATA_REPORT:
        int distance =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));

        modelLevelSensor.getMaxsonarDistance =
            (distance == 9999 || distance == 0)
                ? (distance == 9999)
                    ? 'Fuera de rango'
                    : 'Desconectado'
                : (distance / 1000).toStringAsFixed(2);
        ptr += 2;

        // i2c sensor
        modelLevelSensor.getI2cSensor = frame[ptr];
        ptr++;

        // GNSS Periodicity
        modelLevelSensor.getGnssSyncPeriodicity = _getGnssSyncPeriodicity(
            frame[ptr], frame[ptr + 1], frame[ptr + 2], frame[ptr + 3]);
        ptr += 4;

        switch (modelLevelSensor.getI2cSensor) {
          case LEVEL_SENSOR_CONSTANTS.I2C_BME280_SENSOR:
            int bme280Status = frame[ptr];
            ptr++;

            if (bme280Status != BLE_GENERAL_CONSTANTS.I2C_BME280_STATUS_OK) {
              log +=
                  ', ' + BLE_GENERAL_CONSTANTS.I2C_BME280_STATUS[bme280Status];
              modelLevelSensor.i2cBme280Status = 'Error';
            } else {
              modelLevelSensor.i2cBme280Temperature =
                  _getI2cBme280Temperature(frame.sublist(ptr, ptr + 4));
              ptr += 4;

              modelLevelSensor.i2cBme280Humidity =
                  _getI2cBme280Humidity(frame.sublist(ptr, ptr + 4));
              ptr += 4;

              modelLevelSensor.i2cBme280Pressure =
                  _getI2cBme280Pressure(frame.sublist(ptr, ptr + 4));
              ptr += 4;

              modelLevelSensor.i2cBme280Status = 'Ok';
            }
            break;

          case LEVEL_SENSOR_CONSTANTS.I2C_SHT31_SENSOR:
          case LEVEL_SENSOR_CONSTANTS.I2C_NOT_SENSOR:
          default:
            break;
        }

        break;

      case LEVEL_SENSOR_CMDS.GET_ALARM_PARAMETERS:
        modelLevelSensor.getMaxsonarDelta =
            (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    1000)
                .toStringAsFixed(2);
        ptr += 2;

        modelLevelSensor.getMaxsonarMin =
            (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    1000)
                .toStringAsFixed(2);
        ptr += 2;

        modelLevelSensor.getMaxsonarMax =
            (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    1000)
                .toStringAsFixed(2);
        ptr += 2;

        break;

      case LEVEL_SENSOR_CMDS.SET_ALARM_PARAMETERS:
      case LEVEL_SENSOR_CMDS.SET_I2C_SENSOR:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case LEVEL_SENSOR_CMDS.SET_GNSS_PERIODICITY:
        modelLevelSensor.getGnssSyncPeriodicity = _getGnssSyncPeriodicity(
            frame[ptr], frame[ptr + 1], frame[ptr + 2], frame[ptr + 3]);
        ptr += 4;

        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      default:
        log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
        cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
    }
  }

  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}

String _getI2cBme280Temperature(List<int> measure) {
  Int8List _temp = new Int8List(4)
    ..[0] = measure[0]
    ..[1] = measure[1]
    ..[2] = measure[2]
    ..[3] = measure[3];

  int temperature = ByteData.sublistView(_temp).getInt32(0);

  return (temperature / 100).toStringAsFixed(2);
}

String _getI2cBme280Humidity(List<int> measure) {
  double humidity = listBytesToInt(measure) / 1024;

  if (humidity > 100) humidity = 100;

  return humidity.toStringAsFixed(0);
}

String _getI2cBme280Pressure(List<int> measure) {
  return (listBytesToInt(measure) / 1000).toStringAsFixed(2);
}

String _getGnssSyncPeriodicity(int minute, hour, week, month) {
  return 'Message';
}
