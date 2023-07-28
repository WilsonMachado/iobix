import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/vantage_logger_tab/vantage_logger_tab_controller.dart';
import 'package:iobix/app/utils/helpers/ble_api/ble_api_matric_potential.dart';

import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_vantage_logger.dart';
import '../../constants/ble_api/vantage_logger/vantage_logger_commands.dart';
import '../../constants/ble_api/vantage_logger/vantage_logger_constants.dart';
import '../../helpers/helpers.dart';
import '../../constants/ble_api/ble_general_constants.dart';

ModelLogConsole bleApiVantageLogger(
    List<int> frame, ModelVantageLogger modelVantageLogger) {
  final int cmd = frame[0], status = frame[1];
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  bool isFwHigherOrEqual1_0_15 =
      Get.find<VantageLoggerTabController>().isFwHigherOrEqual1_0_15;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    int ptr = 2;
    if (modelVantageLogger.deviceVersion == 2.0) {
      switch (cmd) {
        case VANTAGE_LOGGER_CMDS_V2.DATA_REPORT:
          modelVantageLogger.measureTime =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
          ptr += 4;

          modelVantageLogger.rainRate = _getRainRate(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
              modelVantageLogger.measureTime);

          modelVantageLogger.rainCount +=
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
          ptr += 2;

          modelVantageLogger.windSpeed = _getWindSpeed(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4))),
              modelVantageLogger.measureTime);
          ptr += 4;

          modelVantageLogger.windDirection = _getWindDirection(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));
          ptr += 2;

          modelVantageLogger.solarRadiation = _getSolarRadiation(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));
          ptr += 2;

          modelVantageLogger.uvIndex = _getUvIndex(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));
          ptr += 2;

          modelVantageLogger.temperature = _getTemperature(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));
          ptr += 2;

          modelVantageLogger.humidity = _getHumidity(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
              modelVantageLogger.temperature);
          ptr += 2;
          break;
        default:
          log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
          cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
      }
    } else if (modelVantageLogger.deviceVersion == 3.0) {
      switch (frame[0]) {
        case VANTAGE_LOGGER_CMDS_V3.GET_PERIODIC_MEASURE:

          ///* (0xF0)

          if (frame[ptr] == 0) {
            ///* Leer el InstaDataStatus
            ptr += 1;
          } else {
            log +=
                ': La lectura demorará algunos segundos debido a la incialización del sensor de calidad de aire.\n';
            log += 'Busy.';
            break;
          }

          ///! BLE Periodic Measure Time
          modelVantageLogger.blePeriodicMeasureTime =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));

          ptr += 4;

          ///! Datos instantáneos de la Davis
          ///? Radiación
          modelVantageLogger.solarRadiation = _getSolarRadiation(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));

          ptr += 2;

          ///? UV
          modelVantageLogger.uvIndex = _getUvIndex(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));

          ptr += 2;

          ///? Temp
          modelVantageLogger.temperature = _getTemperature(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));

          ptr += 2;

          ///? RH
          modelVantageLogger.humidity = _getHumidity(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
              modelVantageLogger.temperature);
          ptr += 2;

          ///? Pluviometro
          modelVantageLogger.rainCount +=
              (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));

          ptr += 2;

          ///? Wind Speed
          modelVantageLogger.windSpeed = _getWindSpeed(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
              modelVantageLogger.blePeriodicMeasureTime);
          ptr += 2;

          ///? Wind Direction
          modelVantageLogger.windDirection = _getWindDirection(
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))));

          ptr += 2;

          ///! Datos instantáneos del sensores RS485
          ///? RS485 devices
          ptr += 1;

          ///? Estamos en el status del primer sensor
          int mask = 0x01;
          while (mask <= 0x08) {
            if (frame[ptr] == 0) {
              ptr += 1;
              switch (mask) {
                case 0x01:
                  modelVantageLogger.instantNoiseRika = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);

                  break;
                case 0x02:
                  modelVantageLogger.instantNoiseGemho = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);

                  break;
                case 4:
                  modelVantageLogger.instantNoisePR300 = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  break;
                case 8:
                  modelVantageLogger.instantNoiseRenke = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  break;
                default:
                  break;
              }
              ptr += 2;
            } else {
              ptr += 1;
            }
            mask <<= 1;
          }

          ///! Datos instantáneos del sensor de calidad del aire
          log += "\r\nSensor de calidad de aire:\n";

          if (frame[ptr] & 0x80 == 0x80 && frame[ptr] & 0x40 == 0x40) {
            log += "- Inicialización del sensor falló.\n";
            log += "Error.\n";
            break;
          } else if (frame[ptr] & 0x80 == 0x80 && frame[ptr] & 0x40 == 0x00) {
            log += "- El sensor no responde.\n";
            log += "Error.\n";
            break;
          } else if (frame[ptr] & 0x80 == 0x00 && frame[ptr] & 0x40 == 0x40) {
            log += "- La comunicación I2C falló.\n";
            log += "Error.\n";
            break;
          } else if (frame[ptr] == 0xFF) {
            log +=
                "- El sensor está arrojando mediciones incorrectas (0xFF).\n";
            log += "Error.\n";
            break;
          } else {
            log += "- Lectura correcta del sensor.\n";
          }

          if (frame[ptr] & 0x01 == 0x01) {
            log += "- La velocidad del ventilador no es normal.\n";
          } else {
            log += "- Velocidad del ventilador OK.\n";
          }
          if (frame[ptr] & 0x02 == 0x02) {
            log += "- Ventilador en proceso de limpieza.\n";
          } else {
            log += "- Ventilador normal.\n";
          }
          if (frame[ptr] & 0x04 == 0x04) {
            log += "- Error en el sensor de gas.\n";
          } else {
            log += "- Sensor de gas OK.\n";
          }
          if (frame[ptr] & 0x08 == 0x08) {
            log = "- Error en el sensor de Hum/Temp.\n";
          } else {
            log += "- Sensor de Hum/Temp OK.\n";
          }
          if (frame[ptr] & 0x10 == 0x10) {
            log += "- Láser encendido y corriente fuera de rango.\n";
          } else {
            log += "- Láser OK.\n";
          }
          if (frame[ptr] & 0x20 == 0x20) {
            log +=
                "- Ventilador encendido pero la velocidad medida es 0 RPM.\n";
          } else {
            log += "- Ventilador sin daños.\n";
          }

          ptr += 1;

          modelVantageLogger.instantPM1_0 =
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  10);
          ptr += 2;
          modelVantageLogger.instantPM2_5 =
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  10);
          ptr += 2;
          modelVantageLogger.instantPM4_0 =
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  10);
          ptr += 2;
          modelVantageLogger.instantPM10 =
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  10);
          ptr += 2;
          modelVantageLogger.instantRH =
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  100);

          ptr += 2;
          modelVantageLogger.instantTemp = roundDouble(
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  200),
              2);
          ptr += 2;
          modelVantageLogger.instantVOC =
              ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                  100);
          ptr += 2;

          log += ' OK';

          break;

        case VANTAGE_LOGGER_CMDS_V3.GET_CURRENT_CONFIGURATIONS: //(0xF1)

          modelVantageLogger.sensorsRS485 = frame[ptr];
          ptr += 1;

          modelVantageLogger.sensorRS485Mismatch =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
          ptr += 2;

          if (isFwHigherOrEqual1_0_15) {
            modelVantageLogger.getHourToCleanFan =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
                    .toString();
          }

          log += ' OK';

          break;

        case VANTAGE_LOGGER_CMDS_V3.SET_RS485_DEVICES:
          log += ' Ok';
          break;

        case VANTAGE_LOGGER_CMDS_V3.GET_SENSOR_POWER_BEHAVIOUR: //(0xF4)
          ptr = 3;
          switch (modelVantageLogger.selectedSensorPowerBehaviour) {
            case 1:
              modelVantageLogger.statusSensorPowerBehaviour = frame[ptr];
              break;
            case 2:
              modelVantageLogger.statusSensorPowerBehaviour = frame[ptr + 2];
              break;
            case 3:
              modelVantageLogger.statusSensorPowerBehaviour = frame[ptr + 4];
              break;
            default:
              break;
          }

          log += ' OK';

          break;

        case VANTAGE_LOGGER_CMDS_V3.GET_DAVIS_STATS_DATA:

          ///* (0xF6)

          if (frame.length == 4 && frame[2] == 0x02 && frame[3] == 0x02) {
            modelVantageLogger.maxPM1_0 = -1.0;
            modelVantageLogger.minPM1_0 = -1.0;
            modelVantageLogger.avgPM1_0 = -1.0;
            modelVantageLogger.maxPM2_5 = -1.0;
            modelVantageLogger.minPM2_5 = -1.0;
            modelVantageLogger.avgPM2_5 = -1.0;
            modelVantageLogger.maxPM4 = -1.0;
            modelVantageLogger.minPM4 = -1.0;
            modelVantageLogger.avgPM4 = -1.0;
            modelVantageLogger.maxPM10 = -1.0;
            modelVantageLogger.minPM10 = -1.0;
            modelVantageLogger.avgPM10 = -1.0;
            modelVantageLogger.maxRH = -1.0;
            modelVantageLogger.minRH = -1.0;
            modelVantageLogger.avgRH = -1.0;
            modelVantageLogger.maxTemp = -1.0;
            modelVantageLogger.minTemp = -1.0;
            modelVantageLogger.avgTemp = -1.0;
            modelVantageLogger.maxVOC = -1.0;
            modelVantageLogger.minVOC = -1.0;
            modelVantageLogger.avgVOC = -1.0;
          } else {
            modelVantageLogger.sampleTime =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
                    .toDouble();

            ptr += 4;
            modelVantageLogger.maxSolarRad = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        3) /
                    (4095 * 0.00167),
                2);
            ptr += 2;
            modelVantageLogger.minSolarRad = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        3) /
                    (4095 * 0.00167),
                2);
            ptr += 2;
            modelVantageLogger.avgSolarRad = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        3) /
                    (4095 * 0.00167),
                2);
            ptr += 2;
            modelVantageLogger.maxUV = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        3) /
                    (4095 * 0.150),
                2);
            ptr += 2;
            modelVantageLogger.minUV = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        3) /
                    (4095 * 0.150),
                2);
            ptr += 2;
            modelVantageLogger.avgUV = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        3) /
                    (4095 * 0.150),
                2);
            ptr += 2;
            modelVantageLogger.maxTempDavis = roundDouble(
                (-40.1 +
                    0.01 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))),
                2);
            ptr += 2;
            modelVantageLogger.minTempDavis = roundDouble(
                (-40.1 +
                    0.01 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))),
                2);
            ptr += 2;
            modelVantageLogger.avgTempDavis = roundDouble(
                (-40.1 +
                    0.01 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))),
                2);
            ptr += 2;
            modelVantageLogger.maxRHDavis = roundDouble(
                (-2.0468 +
                    0.0367 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) -
                    1.5955E-6 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))),
                2);
            ptr += 2;
            modelVantageLogger.minRHDavis = roundDouble(
                (-2.0468 +
                    0.0367 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) -
                    1.5955E-6 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))),
                2);
            ptr += 2;
            modelVantageLogger.avgRHDavis = roundDouble(
                (-2.0468 +
                    0.0367 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) -
                    1.5955E-6 *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        listBytesToInt(
                            listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))),
                2);
            ptr += 4;
            modelVantageLogger.accPluv =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))
                    .toDouble();
            ptr += 2;
            modelVantageLogger.maxWindSpeed = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        2.25) /
                    (modelVantageLogger.sampleTime),
                2);
            ptr += 2;
            modelVantageLogger.minWindSpeed = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        2.25) /
                    (modelVantageLogger.sampleTime),
                2);
            ptr += 2;
            modelVantageLogger.avgWindSpeed = roundDouble(
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        2.25) /
                    (modelVantageLogger.sampleTime),
                2);
            ptr += 2;
            modelVantageLogger.maxWindDirection = roundDouble(
                ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                            345.096) /
                        4095) +
                    7.35,
                2);
            ptr += 2;
            modelVantageLogger.minWindDirection = roundDouble(
                ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                            345.096) /
                        4095) +
                    7.35,
                2);
            ptr += 2;
            modelVantageLogger.avgWindDirection = roundDouble(
                ((listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                            345.096) /
                        4095) +
                    7.35,
                2);
          }
          log += ' OK';
          break;
        case VANTAGE_LOGGER_CMDS_V3.GET_AIR_Q_STATS_DATA:

          ///* (0xF7)
          if (frame.length == 4 && frame[2] == 0x02 && frame[3] == 0x02) {
            modelVantageLogger.maxPM1_0 = -1.0;
            modelVantageLogger.minPM1_0 = -1.0;
            modelVantageLogger.avgPM1_0 = -1.0;
            modelVantageLogger.maxPM2_5 = -1.0;
            modelVantageLogger.minPM2_5 = -1.0;
            modelVantageLogger.avgPM2_5 = -1.0;
            modelVantageLogger.maxPM4 = -1.0;
            modelVantageLogger.minPM4 = -1.0;
            modelVantageLogger.avgPM4 = -1.0;
            modelVantageLogger.maxPM10 = -1.0;
            modelVantageLogger.minPM10 = -1.0;
            modelVantageLogger.avgPM10 = -1.0;
            modelVantageLogger.maxRH = -1.0;
            modelVantageLogger.minRH = -1.0;
            modelVantageLogger.avgRH = -1.0;
            modelVantageLogger.maxTemp = -1.0;
            modelVantageLogger.minTemp = -1.0;
            modelVantageLogger.avgTemp = -1.0;
            modelVantageLogger.maxVOC = -1.0;
            modelVantageLogger.minVOC = -1.0;
            modelVantageLogger.avgVOC = -1.0;
          } else {
            modelVantageLogger.maxPM1_0 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.minPM1_0 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.avgPM1_0 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.maxPM2_5 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.minPM2_5 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.avgPM2_5 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.maxPM4 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.minPM4 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.avgPM4 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.maxPM10 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.minPM10 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.avgPM10 = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10,
                2);
            ptr += 2;
            modelVantageLogger.maxRH = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    100,
                2);
            ptr += 2;
            modelVantageLogger.minRH = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    100,
                2);
            ptr += 2;
            modelVantageLogger.avgRH = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    100,
                2);
            ptr += 2;
            modelVantageLogger.maxTemp = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    200,
                2);
            ptr += 2;
            modelVantageLogger.minTemp = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    200,
                2);
            ptr += 2;
            modelVantageLogger.avgTemp = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    200,
                2);
            ptr += 2;
            modelVantageLogger.maxVOC = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    100,
                2);
            ptr += 2;
            modelVantageLogger.minVOC = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    100,
                2);
            ptr += 2;
            modelVantageLogger.avgVOC = roundDouble(
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    100,
                2);
          }
          log += ' OK';
          break;

        case VANTAGE_LOGGER_CMDS_V3.GET_RS485_STATS_DATA:

          ///* (0xF8)

          ///! Datos estadísticos de los sensores RS485
          ///? RS485 devices

          ptr += 1;

          ///? Estamos en el status del primer sensor
          int mask = 0x01;
          while (mask <= 0x08) {
            if (frame[ptr] == 0) {
              ptr += 1;

              switch (mask) {
                case 1:
                  modelVantageLogger.maxNoiseRika = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.minNoiseRika = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.avgNoiseRika = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  break;
                case 2:
                  modelVantageLogger.maxNoiseGemho = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.minNoiseGemho = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.avgNoiseGemho = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);

                  break;
                case 4:
                  modelVantageLogger.maxNoisePR300 = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.minNoisePR300 = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.avgNoisePR300 = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  break;
                case 8:
                  modelVantageLogger.maxNoiseRenke = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.minNoiseRenke = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  ptr += 2;
                  modelVantageLogger.avgNoiseRenke = ((listBytesToInt(
                          listIntLsbToMsb(frame.sublist(ptr, ptr + 2)))) /
                      10);
                  break;
                default:
                  break;
              }
            } else {
              ptr += 1;
            }

            mask <<= 1;
          }
          log += ' OK';
          break;

        case VANTAGE_LOGGER_CMDS_V3.SET_HOUR_TO_CLEAN_FAN:
          log += ' Ok';
          break;

        case VANTAGE_LOGGER_CMDS_V3.CLEAN_FAN:
          log += ' Ok. Wait 20 seconds.';
          break;

        default:
          break;
      }
    }
  }

  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}

ModelVantageLogger modelVantageLogger = ModelVantageLogger();

double _getRainRate(int ticks, measureTime) {
  if (modelVantageLogger.deviceVersion == 2) {
    return (double.parse(
        (measureTime > 0 ? (ticks * 0.1) / (measureTime / 60) : 0.0)
            .toStringAsFixed(2)));
  } else {
    return roundDouble(ticks * 0.2, 2);
  }
}

double _getWindSpeed(int ticks, measureTime) {
  if (modelVantageLogger.deviceVersion == 2.0) {
    return double.parse((ticks * (2.25 / measureTime)).toStringAsFixed(2));
  } else {
    return 1.60934 *
        (double.parse((ticks * (2.25 / measureTime)).toStringAsFixed(2)));
  }
}

double _getWindDirection(int measureAdc) {
  if (modelVantageLogger.deviceVersion == 2.0) {
    double direction = double.parse(
        (((360 * measureAdc) / VANTAGE_LOGGER_CONSTANTS_V2.ADC_RESOLUTION) *
                    (0.9586) +
                7.35)
            .toStringAsFixed(2));
    if (direction > 360.0)
      direction = 360.00;
    else if (direction < 0) direction = 0.00;
    return direction;
  } else {
    double direction = double.parse(
        (((360 * measureAdc) / VANTAGE_LOGGER_CONSTANTS_V3.ADC_RESOLUTION) *
                    (0.9586) +
                7.35)
            .toStringAsFixed(2));
    if (direction > 360.0)
      direction = 360.00;
    else if (direction < 0) direction = 0.00;
    return direction;
  }
}

double _getSolarRadiation(int measureAdc) {
  if (modelVantageLogger.deviceVersion == 2.0) {
    double measure = adcToValue(
        measureAdc,
        VANTAGE_LOGGER_CONSTANTS_V2.ADC_RESOLUTION,
        VANTAGE_LOGGER_CONSTANTS_V2.VOLTAGE_REFERENCE);
    return double.parse(((measure) / 0.00167).toStringAsFixed(2));
  } else {
    double measure = adcToValue(
        measureAdc,
        VANTAGE_LOGGER_CONSTANTS_V3.ADC_RESOLUTION,
        VANTAGE_LOGGER_CONSTANTS_V3.VOLTAGE_REFERENCE);
    return double.parse(((measure) / 0.00167).toStringAsFixed(2));
  }
}

double _getUvIndex(int measureAdc) {
  if (modelVantageLogger.deviceVersion == 2.0) {
    double measure = adcToValue(
        measureAdc,
        VANTAGE_LOGGER_CONSTANTS_V2.ADC_RESOLUTION,
        VANTAGE_LOGGER_CONSTANTS_V2.VOLTAGE_REFERENCE);

    return double.parse(((measure) / 0.150).toStringAsFixed(2));
  } else {
    double measure = adcToValue(
        measureAdc,
        VANTAGE_LOGGER_CONSTANTS_V3.ADC_RESOLUTION,
        VANTAGE_LOGGER_CONSTANTS_V3.VOLTAGE_REFERENCE);

    return double.parse(((measure) / 0.150).toStringAsFixed(2));
  }
}

double _getTemperature(int measure) {
  if (measure != 0xFFFF) {
    double temp = double.parse((-40.1 + 0.01 * measure).toStringAsFixed(2));
    if (temp < 0) temp = 0.00;
    return temp;
  } else
    return 0.00;
}

double _getHumidity(int measure, double temperature) {
  if (measure != 0xFFFF) {
    double rhLinear =
        -2.0468 + 0.0367 * measure - 0.0000015955 * measure * measure;

    double humidity = double.parse(
        ((temperature - 25) * (0.01 + 0.00008 * measure) + rhLinear)
            .toStringAsFixed(2));

    if (humidity > 100)
      humidity = 100.00;
    else if (humidity < 0) humidity = 0.00;

    return humidity / 100;
  } else
    return 0.00;
}
