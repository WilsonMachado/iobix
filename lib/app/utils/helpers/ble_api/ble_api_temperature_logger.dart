import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';

import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_temperature_logger.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/temperature_logger/temperature_logger_commands.dart';
import '../../helpers/helpers.dart';
import '../../constants/ble_api/temperature_logger/temperature_logger_constants.dart';

ModelLogConsole bleApiTemperatureLogger(
    List<int> frame, ModelTemperatureLogger modelTemperatureLogger) {
  final int cmd = frame[0], status = frame[1];

  bool isFwHigherOrEqual1_0_3 = isFirmwareVersionIsHigherOrEqualThat(
    Get.find<SystemTabController>().modelDeviceInformation.firmware,
    'v1.0.3',
  );

  int ntcMOQ =
      (modelTemperatureLogger.deviceVersion == 3 && isFwHigherOrEqual1_0_3)
          ? 6
          : 4;

  int ptr = 2;
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    switch (cmd) {
      case TEMPERATURE_LOGGER_CMDS.DATA_REPORT:
        // NTC Data
        List<List<String>> ntcData = [
          ['0', '', '', ''],
          ['0', '', '', ''],
          ['0', '', '', ''],
          ['0', '', '', ''],
          ['0', '', '', ''],
          ['0', '', '', ''],
        ];

        // save old
        for (int i = 0; i < ntcMOQ; i++) {
          for (int j = 1; j < 4; j++) {
            ntcData[i][j] = modelTemperatureLogger.ntcData[i][j];
          }
        }

        for (int i = 0; i < 4; i += 2) {
          int ntc1 = (frame[ptr] << 4) | ((frame[ptr + 1] & 0xF0) >> 4);
          int ntc2 = ((frame[ptr + 1] & 0x0F) << 8) | frame[ptr + 2];

          ntcData[i][0] = _getNtcTemperature(ntc1);
          ntcData[i + 1][0] = _getNtcTemperature(ntc2);

          ptr += 3;
        }

        modelTemperatureLogger.ntcData.assignAll(ntcData);
        log += 'Ok';

        // i2c sensor
        modelTemperatureLogger.i2cSensor = frame[ptr];
        ptr++;

        switch (modelTemperatureLogger.i2cSensor) {
          case TEMPERATURE_LOGGER_CONSTANTS.I2C_BME280_SENSOR:
            int bme280Status = frame[ptr];
            ptr++;

            if (bme280Status != BLE_GENERAL_CONSTANTS.I2C_BME280_STATUS_OK) {
              log +=
                  ', ' + BLE_GENERAL_CONSTANTS.I2C_BME280_STATUS[bme280Status];
              modelTemperatureLogger.i2cBme280Status = 'Error';
              ptr = frame.length;
            } else {
              modelTemperatureLogger.i2cBme280Temperature =
                  _getI2cBme280Temperature(frame.sublist(ptr, ptr + 4));
              ptr += 4;

              modelTemperatureLogger.i2cBme280Humidity =
                  _getI2cBme280Humidity(frame.sublist(ptr, ptr + 4));
              ptr += 4;

              modelTemperatureLogger.i2cBme280Pressure =
                  _getI2cBme280Pressure(frame.sublist(ptr, ptr + 4));
              ptr += 4;

              modelTemperatureLogger.i2cBme280Status = 'Ok';
            }

            break;

          case TEMPERATURE_LOGGER_CONSTANTS.I2C_SHT31_SENSOR:
            int sht31Status = frame[ptr];
            ptr++;

            if (sht31Status != 0) {
              log += ', ' + 'SHT31 Status Code: {$sht31Status}';
              modelTemperatureLogger.i2cBme280Status = 'Error';
              ptr = frame.length;
            } else {
              int _crcTemp = _crc8Calc(frame.sublist(ptr, ptr + 2), 0x31, 0xFF);

              if (_crcTemp != frame[ptr + 2]) {
                log += ", SHT31 CRC code doesn't match";
                modelTemperatureLogger.i2cBme280Status = 'Error';
                ptr = frame.length;
                break;
              } else {
                modelTemperatureLogger.i2cBme280Status = 'Ok';
                modelTemperatureLogger.i2cBme280Temperature =
                    _getSHT31Temp(frame.sublist(ptr, ptr + 2));
                print(modelTemperatureLogger.i2cBme280Temperature);
              }
              ptr += 3;

              int _crcHum = _crc8Calc(frame.sublist(ptr, ptr + 2), 0x31, 0xFF);

              if (_crcHum != frame[ptr + 2]) {
                log += "CRC code doesn't match";
                modelTemperatureLogger.i2cBme280Status = 'Error';
                ptr = frame.length;
                break;
              } else {
                modelTemperatureLogger.i2cBme280Status = 'Ok';
                modelTemperatureLogger.i2cBme280Humidity =
                    _getSHT31Hum(frame.sublist(ptr, ptr + 2));
                print(modelTemperatureLogger.i2cBme280Humidity);
              }
              ptr += 3;
            }

            break;

          case TEMPERATURE_LOGGER_CONSTANTS.I2C_NOT_SENSOR:
          default:
            break;
        }

        if (frame.length > ptr) {
          modelTemperatureLogger.isAbpSensor = true;

          // Pressure sensor status
          modelTemperatureLogger.abpSensorStatus = frame[ptr];
          ptr++;

          modelTemperatureLogger.abpSensorPressureAdc =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
          modelTemperatureLogger.abpSensorPressure = _getAbpSensorPressure(
              modelTemperatureLogger.abpSensorPressureAdc);
          ptr += 2;
        } else
          modelTemperatureLogger.isAbpSensor = false;

        break;

      case TEMPERATURE_LOGGER_CMDS.GET_ALARM_PARAMETERS:
        List<List<String>> ntcData = [
          ['', '0', '0', '0'],
          ['', '0', '0', '0'],
          ['', '0', '0', '0'],
          ['', '0', '0', '0'],
          ['', '0', '0', '0'],
          ['', '0', '0', '0'],
        ];

        for (int i = 0; i < ntcMOQ; i++) {
          // save old
          ntcData[i][0] = modelTemperatureLogger.ntcData[i][0];

          // delta
          ntcData[i][1] =
              listBytesToInt(frame.sublist(ptr, ptr + 2)).toString();
          ptr += 2;

          // min - max
          for (int j = 2; j < 4; j++) {
            ntcData[i][j] = (i < 4)
                ? _getNtcTemperature(
                    listBytesToInt(frame.sublist(ptr, ptr + 2)),
                    digits: 0)
                : listBytesToInt(frame.sublist(ptr, ptr + 2)).toString();

            ptr += 2;
          }
        }

        modelTemperatureLogger.ntcData.assignAll(ntcData);

        log += 'Ok';
        break;

      case TEMPERATURE_LOGGER_CMDS.SET_ALARM_PARAMETERS:
      case TEMPERATURE_LOGGER_CMDS.SET_I2C_SENSOR:
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

String _getNtcTemperature(int measure, {int digits = 2}) {
  if (measure < 0xFFF) {
    return (adcToTemperature(
            measure,
            TEMPERATURE_LOGGER_CONSTANTS.ADC_RESOLUTION,
            TEMPERATURE_LOGGER_CONSTANTS.NTC_RO,
            TEMPERATURE_LOGGER_CONSTANTS.NTC_RF,
            TEMPERATURE_LOGGER_CONSTANTS.NTC_EXTERNAL_B))
        .toStringAsFixed(digits);
  } else
    return 'sensor_disconnected'.tr;
}

String _getI2cBme280Temperature(List<int> measure) {
  int temperature = getSignedNumber(measure);
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

String _getAbpSensorPressure(int adc) {
  int outputMax = 14745, outputMin = 1638, pressMax = 30, pressMin = 0;
  return ((adc - outputMin) * (pressMax - pressMin) / (outputMax - outputMin) +
          pressMin)
      .toStringAsFixed(5);
}

String _getSHT31Temp(List<int> rawData) {
  double temp = -45 + 175 * (listBytesToInt(rawData) / 65535);
  return temp.toStringAsFixed(2);
}

String _getSHT31Hum(List<int> rawData) {
  double temp = 100 * (listBytesToInt(rawData) / 65535);
  return temp.toStringAsFixed(0);
}

int _crc8Calc(List<int> data, int poly, int initial) {
  int crc = initial;
  int x;
  int i, j;

  for (i = 0; i < data.length; i++) {
    x = data[i] ^ crc;
    for (j = 0; j < 8; j++) {
      if ((x & 0x80) != 0) {
        x <<= 1;
        x ^= poly;
      } else {
        x <<= 1;
      }
    }
    crc = x;
  }

  return crc & 0xFF;
}
