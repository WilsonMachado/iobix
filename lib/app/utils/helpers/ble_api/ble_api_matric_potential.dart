import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../modules/device/widgets/matric_potential/matric_potential_tab_controller.dart';

import '../../../data/models/local/model_matric_potential.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../utils/constants/ble_api/matric_potential/matric_potential_commands.dart';
import '../../../utils/helpers/helpers.dart';
import '../../../utils/constants/ble_api/matric_potential/matric_potential_constants.dart';

ModelLogConsole bleApiMatricPotential(
    List<int> frame, ModelMatricPotential modelMatricPotential) {
  final int cmd = frame[0], status = frame[1];
  int ptr = 2;

  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  bool isFwHigherOrEqual1_0_8 =
      Get.find<MatricPotentialTabController>().isFwHigherOrEqual1_0_8;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    switch (cmd) {
      case MATRIC_POTENTIAL_CMDS.DATA_REPORT:
        List<String> _tempResistance = [
          '0.00',
          '0.00',
          '0.00',
          '0.00',
          '0.00',
          '0.00'
        ];
        String _disconnectedStr = 'disconnected';

        for (int i = 0; i < modelMatricPotential.mgResistance.length; i++) {
          int _tempValue = listBytesToInt(
            listIntLsbToMsb(
              frame.sublist(
                ptr,
                ptr + (isFwHigherOrEqual1_0_8 ? 4 : 2),
              ),
            ),
          );

          _tempResistance[i] = ((isFwHigherOrEqual1_0_8 &&
                  modelMatricPotential.deviceVersion == 4 &&
                  _tempValue == 0xFFFFFFFF))
              ? _disconnectedStr
              : ((modelMatricPotential.deviceVersion == 3.1 &&
                      _tempValue == 0xFFFFFFFF))
                  ? _disconnectedStr
                  : ((modelMatricPotential.deviceVersion == 4 &&
                              _tempValue == 0xFFFF) ||
                          (modelMatricPotential.deviceVersion == 1 &&
                              _tempValue == 0xFFFF))
                      ? _disconnectedStr
                      : _tempValue.toStringAsFixed(2);

          ///* Cambio realizado para que aparezca 'Desconectado si se reciben 0xFFFF desde el PM V1'
          ptr += ((isFwHigherOrEqual1_0_8 &&
                      modelMatricPotential.deviceVersion == 4) ||
                  (modelMatricPotential.deviceVersion == 3.1)
              ? 4
              : 2);
        }

        modelMatricPotential.mgResistance.assignAll(_tempResistance);

        modelMatricPotential.pluv =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
        ptr += 2;

        int adcSoilTemperature =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));

        modelMatricPotential.soilTemperature =
            _getNtcTemperature(adcSoilTemperature);
        ptr += 2;

        List<String> _tempKpa = [
          '0.00',
          '0.00',
          '0.00',
          '0.00',
          '0.00',
          '0.00'
        ];
        // To KPA
        for (int i = 0; i < modelMatricPotential.mgKpa.length; i++) {
          _tempKpa[i] = (_tempResistance[i] == _disconnectedStr)
              ? _disconnectedStr
              : _resistanceToKpa(
                  double.parse(_tempResistance[i]),
                  (adcSoilTemperature >= 0xFF0)
                      ? 24.0
                      : double.parse(modelMatricPotential.soilTemperature),
                );
        }

        modelMatricPotential.mgKpa.assignAll(_tempKpa);

        // ohms
        modelMatricPotential.getResistanceCalibValue = listBytesToInt(
                listIntLsbToMsb(
                    frame.sublist(ptr, ptr + (isFwHigherOrEqual1_0_8 ? 4 : 2))))
            .toString();

        ///? Es diferente??: ptr += (isFwHigherOrEqual1_0_8 ? 4 : 2);
        ptr += ((isFwHigherOrEqual1_0_8 &&
                    modelMatricPotential.deviceVersion == 4) ||
                (modelMatricPotential.deviceVersion == 3.1)
            ? 4
            : 2);

        if (modelMatricPotential.deviceVersion == 3.1) {
          print('ID del sensor I2C (BME280): ${frame[ptr]}');
          ptr += 1;
          modelMatricPotential.i2cStatus = frame[ptr];
          // ignore: invalid_use_of_protected_member
          Get.find<MatricPotentialTabController>().refresh();

          switch (frame[ptr]) {
            case 0x00:
              ptr += 1;

              ///! Pasamos a leer el valor de la temperatura
              modelMatricPotential.getSoilTemp = roundDouble(
                      ((listBytesToInt(
                            frame.sublist(
                              ptr,
                              ptr + 4,
                            ),
                          )) /
                          100),
                      2)
                  .toString();
              print(modelMatricPotential.getSoilTemp);
              ptr += 4;

              ///! Pasamos a leer el valor de humedad
              modelMatricPotential.getSoilHum = ((listBytesToInt(
                        frame.sublist(
                          ptr,
                          ptr + 4,
                        ),
                      )) /
                      1024)
                  .round()
                  .toString();
              ptr += 4;

              ///! Pasamos a leer el valor de presión
              modelMatricPotential.getSoilElectro = roundDouble(
                      (listBytesToInt(
                            frame.sublist(
                              ptr,
                              ptr + 4,
                            ),
                          ) *
                          .01),
                      2)
                  .toString();
              break;

            case 0xFF:
              print('NULL_PTR');
              modelMatricPotential.getSoilTemp = 'Error code 0xFF';
              modelMatricPotential.getSoilHum = 'Error code 0xFF';
              modelMatricPotential.getSoilElectro = 'Error code 0xFF';
              break;
            case 0xFE:
              modelMatricPotential.getSoilTemp = 'Error code 0xFE';
              modelMatricPotential.getSoilHum = 'Error code 0xFE';
              modelMatricPotential.getSoilElectro = 'Error code 0xFE';
              print('DEV_NOT_FOUND');
              break;
            case 0xFD:
              print('INVALID_LEN');
              modelMatricPotential.getSoilTemp = 'Error code 0xFD';
              modelMatricPotential.getSoilHum = 'Error code 0xFD';
              modelMatricPotential.getSoilElectro = 'Error code 0xFD';
              break;
            case 0xFC:
              print('COMM_FAIL');
              modelMatricPotential.getSoilTemp = 'Error code 0xFC';
              modelMatricPotential.getSoilHum = 'Error code 0xFC';
              modelMatricPotential.getSoilElectro = 'Error code 0xFC';
              break;
            case 0xFB:
              print('SLEEP_MODE_FAIL');
              modelMatricPotential.getSoilTemp = 'Error code 0xFB';
              modelMatricPotential.getSoilHum = 'Error code 0xFB';
              modelMatricPotential.getSoilElectro = 'Error code 0xFB';
              break;
            case 0xFA:
              print('NVM_COPY_FAILED');
              modelMatricPotential.getSoilTemp = 'Error code 0xFA';
              modelMatricPotential.getSoilHum = 'Error code 0xFA';
              modelMatricPotential.getSoilElectro = 'Error code 0xFA';
              break;
          }
        } else if (modelMatricPotential.deviceVersion == 4) {
          int adcSoilTemperature2 =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));

          modelMatricPotential.soilTemperature2 =
              _getNtcTemperature(adcSoilTemperature2);
          ptr += 2;

          // status bits
          int ssc1Data =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
          ptr += 2;

          if (ssc1Data == 0 || ssc1Data == 0xffff) {
            modelMatricPotential.pressureStatus1 =
                MATRIC_POTENTIAL_CONSTANTS_V4.PRESSURE_STATUS_DISCONNECT;
            modelMatricPotential.pressure1 = 0.0;
          } else {
            modelMatricPotential.pressureStatus1 = (ssc1Data >> 14) & 0x03;

            //if (modelMatricPotential.pressureStatus1 ==
            //    MATRIC_POTENTIAL_CONSTANTS_V4.PRESSURE_STATUS_OK)
            modelMatricPotential.pressure1 =
                _getPressureWithSSCData(ssc1Data & 0x3FFF);
            //else
            // modelMatricPotential.pressure1 = 0.0;
          }

          // status bits0xFFFF
          int ssc2Data =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
          ptr += 2;

          if (ssc2Data == 0 || ssc2Data == 0xffff) {
            modelMatricPotential.pressureStatus2 =
                MATRIC_POTENTIAL_CONSTANTS_V4.PRESSURE_STATUS_DISCONNECT;
            modelMatricPotential.pressure2 = 0.0;
          } else {
            modelMatricPotential.pressureStatus2 = (ssc2Data >> 14) & 0x03;

            //if (modelMatricPotential.pressureStatus2 ==
            //    MATRIC_POTENTIAL_CONSTANTS_V4.PRESSURE_STATUS_OK)
            modelMatricPotential.pressure2 =
                _getPressureWithSSCData(ssc2Data & 0x3FFF);
            //else
            //  modelMatricPotential.pressure2 = 0.0;
          }
        }

        break;

      case MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_TIME:
        if (modelMatricPotential.deviceVersion == 3.1) {
          modelMatricPotential.rtcCLKOUT = frame[ptr].toString();
          log += 'Ok';
        } else {
          log += BLE_GENERAL_CONSTANTS.STATUS[status];
        }
        break;

      case MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_WAIT_TIME:
        if (modelMatricPotential.deviceVersion == 3.1) {
          modelMatricPotential.rtcOffsetCalibration = frame[ptr].toString();
          modelMatricPotential.rtcCLKOUT = frame[ptr + 1].toString();
          log += 'Ok';
        } else {
          log += BLE_GENERAL_CONSTANTS.STATUS[status];
        }
        break;

      case MATRIC_POTENTIAL_CMDS.START_IRRIGATION_MANUAL:
      case MATRIC_POTENTIAL_CMDS.SET_PV_TO_START_IRRIGATION:
      case MATRIC_POTENTIAL_CMDS.SET_PV_TO_STOP_IRRIGATION:
      case MATRIC_POTENTIAL_CMDS.SET_GM_IRRIGATION_CONTROL:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case MATRIC_POTENTIAL_CMDS.RESISTANCE_CALIBRATION:
        // Status calib
        modelMatricPotential.getResistanceCalibStatus = frame[ptr];
        ptr++;

        if (modelMatricPotential.getResistanceCalibStatus != 0) {
          modelMatricPotential.errorSetResistanceCalibValue = getMapValueByKey(
              MATRIC_POTENTIAL_CONSTANTS.RESISTANCE_CALIB_STATUS,
              modelMatricPotential.getResistanceCalibStatus,
              'Error desconocido');
        }

        // ohms
        modelMatricPotential.getResistanceCalibValue = listBytesToInt(
                listIntLsbToMsb(
                    frame.sublist(ptr, ptr + (isFwHigherOrEqual1_0_8 ? 4 : 2))))
            .toString();
        ptr += (isFwHigherOrEqual1_0_8 ? 4 : 2);

        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        log += (modelMatricPotential.getResistanceCalibStatus != 0)
            ? ', ${modelMatricPotential.errorSetResistanceCalibValue}'
            : ', Resistive compensation value: ${modelMatricPotential.getResistanceCalibValue}';
        break;

      case MATRIC_POTENTIAL_CMDS.GET_IRRIGATION_PARAMS:
        if (modelMatricPotential.deviceVersion == 1) {
          modelMatricPotential.irrigationStatus =
              (frame[ptr] == 0x01) ? true : false;
          ptr++;

          // minutes
          modelMatricPotential.getIrrigationTime =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
                  .toString();
          ptr += 4;

          // minutes
          modelMatricPotential.getIrrigationWaitTime =
              listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
                  .toString();
          ptr += 4;

          // kpa
          modelMatricPotential.getPvToStartIrrigation = frame[ptr].toString();
          ptr++;

          // kpa
          modelMatricPotential.getPvToStopIrrigation = frame[ptr].toString();
          ptr++;

          modelMatricPotential.electrovalveStatus =
              (frame[ptr] == 1) ? true : false;
          ptr++;

          modelMatricPotential.getElectrovalveControl = frame[ptr];
          ptr++;

          modelMatricPotential.getGmIrrigationControl = frame[ptr];
          ptr++;

          modelMatricPotential.getIrrigationCycleStatus = frame[ptr];
          ptr++;
        } else if ((modelMatricPotential.deviceVersion == 4) &&
            (frame.length == 9)) {
          modelMatricPotential.deviceVariation = 1;

          ///! Ojo acá. Si la longitud de la trama de respuesta al comando 0xF2 (Leer variables de control de riego) es 9 y la versión del devices es 4, entonces estamos hablado de un logger V 4.1

          String result = frame
              .map((e) => e.toRadixString(16))
              .toList()
              .toString()
              .toUpperCase();

          print('Datos provenientes del PM 4: $result');
          modelMatricPotential.setIrrigationThreshold = frame[2].toString();

          modelMatricPotential.electrovalveActivationSource =
              (frame[3] == 0x01) ? 'Manual' : 'Automático';

          //? Para saber cuáles sensores controlan el riego automático

          modelMatricPotential.setSensorsForIrrigation = 0;

          ///* Para evitar el bug de ver más de dos sensores marcados al seleccionar los sensores para iniciar el riego

          String bits = frame[4].toRadixString(2).toString();
          print(' $bits | ${bits.length}');
          String sensors = '';
          int count = bits.length - 1;
          while (count >= 0) {
            if (bits[count] == '1') {
              modelMatricPotential.setSensorsForIrrigation +=
                  (pow(2, (bits.length - 1) - count)).toInt();
              print(pow(2, count));
              if (sensors.length > 0) {
                sensors = sensors + ' y ';
              }
              sensors = sensors + (bits.length - count).toString();
            }
            count--;
          }
          print(sensors);
          modelMatricPotential.gmIrrigationControlSensors = sensors;

          // ? Para saber la hora de riego configurada
          //print(modelMatricPotential.getIrrigationTime);

          DateTime alarm = DateTime(
            DateTime.now().year, // No se usa, pero es obligatorio

            DateTime.now().month, // No se usa, pero es obligatorio

            DateTime.now().day, // No se usa, pero es obligatorio

            int.parse(((frame[6] & 0x30) >> 4).toString() +
                (frame[6] & 0x0F).toString()), //* Hora

            int.parse(((frame[5] & 0x70) >> 4).toString() +
                (frame[5] & 0x0F).toString()), //* Minutos
          ).subtract(
            Duration(
                hours: 5), //! Se restan 5 horas porque en Colombia es GMT-5
          );
          modelMatricPotential.hoursIrrigationTime =
              (alarm.hour < 10 ? '0' : '') + alarm.hour.toString();
          modelMatricPotential.minutesIrrigationTime =
              (alarm.minute < 10 ? '0' : '') + alarm.minute.toString();
          modelMatricPotential.getIrrigationTime = DateFormat('kk:mm')
              .format(alarm)
              .toString(); //! Se asigna la hora de la alarma, wp.

        }

        ///! acá pongamos el updater

        // ignore: invalid_use_of_protected_member
        Get.find<MatricPotentialTabController>().refresh();

        break;

      case MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_STATUS:
        if (modelMatricPotential.deviceVersion == 1) {
          modelMatricPotential.irrigationStatus =
              frame[ptr] == 0x01 ? true : false;
          ptr++;
        } else if (modelMatricPotential.deviceVersion == 4) {
          log = 'Ok';
        } else if (modelMatricPotential.deviceVersion == 3.1) {
          modelMatricPotential.rtcOffsetCalibration = frame[ptr].toString();
          print(modelMatricPotential.rtcOffsetCalibration);
          log = 'Ok';
        }
        break;

      case MATRIC_POTENTIAL_CMDS.SET_ELECTROVALVE_CONTROL:
        if (modelMatricPotential.deviceVersion == 1) {
          modelMatricPotential.electrovalveStatus =
              frame[ptr] == 0x01 ? true : false;
          ptr++;
          modelMatricPotential.getElectrovalveControl = frame[ptr];
          ptr++;
          log =
              'Electrovalve status: ${modelMatricPotential.electrovalveStatus ? 'Opened' : 'Closed'}';
        } else if (modelMatricPotential.deviceVersion == 4 &&
            modelMatricPotential.deviceVariation == 1) {
          ///! Comando específico del V 4.1
          String result = frame
              .map((e) => e.toRadixString(16))
              .toList()
              .toString()
              .toUpperCase();
          print('Datos recibidos del GEMHO: $result');

          if (frame[3] == 0) {
            modelMatricPotential.getSoilTemp =
                (concatenateBytes(frame[5], frame[4], 8) / 100).toString();
            modelMatricPotential.getSoilHum =
                (concatenateBytes(frame[7], frame[6], 8) / 100).toString();
            modelMatricPotential.getSoilElectro =
                (concatenateBytes(frame[9], frame[8], 8)).toString();
            modelMatricPotential.getSoilpH =
                (concatenateBytes(frame[11], frame[10], 8) / 100).toString();
            modelMatricPotential.getSoilN = (frame[12]).toString();
            modelMatricPotential.getSoilK = (frame[14]).toString();
            modelMatricPotential.getSoilP = (frame[16]).toString();
          } else {
            log =
                'Error de sensor de suelo: code ' + frame[3].toRadixString(16);
          }
        }

        break;

      case MATRIC_POTENTIAL_CMDS.GET_IRRIGATION_CYCLE_STATUS:
        modelMatricPotential.getIrrigationCycleStatus = frame[ptr];
        ptr++;
        break;

      case MATRIC_POTENTIAL_CMDS.GET_RTC_CALIBRATION_DATA:
        if (modelMatricPotential.deviceVersion == 4.0) {
          modelMatricPotential.getRtcOffset = frame[ptr].toString();
          modelMatricPotential.getRtcOffsetSign =
              (frame[ptr + 1] == 0x80) ? '+' : '-';
          log += ' Ok';
        }
        break;

      case MATRIC_POTENTIAL_CMDS.SET_RTC_CALIBRATION_DATA:
        if (modelMatricPotential.deviceVersion == 4.0) {
          log += ' Ok';
        }
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
  if (measure < 0xFF0) {
    return (adcToTemperature(
            measure,
            MATRIC_POTENTIAL_CONSTANTS.ADC_RESOLUTION,
            MATRIC_POTENTIAL_CONSTANTS.NTC_RO,
            MATRIC_POTENTIAL_CONSTANTS.NTC_RF,
            MATRIC_POTENTIAL_CONSTANTS.NTC_EXTERNAL_B))
        .toStringAsFixed(digits);
  } else
    return 'sensor_disconnected'.tr;
}

/*double _adcToResistance(int adc, int res, double ref) {
  double numerator = adcToValue(adc, res, ref) * 10000;
  double denominator = 1.25 - ((adc * ref) / res);
  return denominator != 0
      ? double.parse((numerator / denominator).toStringAsFixed(2))
      : 0.00;
}*/

String _resistanceToKpa(double resistance, double temp) {
  double kpa;

  if (resistance < 550)
    kpa = 0.00;
  else if (resistance < 1000)
    kpa = kpa = (((resistance / 1000.00) * 23.156) - 12.736) *
        (-1.00) *
        (1.00 + 0.018 * (temp - 24.00));

  ///! Ecuación cambiada: (-20.00) * ((resistance / 1000.00) * (1.00 + 0.018 * (temp - 24.00)) - 0.55);
  else if (resistance < 8000)
    kpa = (-3.213 * (resistance / 1000.00) - 4.093) /
        (1 - 0.009733 * (resistance / 1000.00) - 0.01205 * (temp));
  else
    kpa = (-2.246) -
        (5.239) * (resistance / 1000.00) * (1 + 0.018 * (temp - 24.00)) -
        (0.06756) *
            (resistance / 1000.00) *
            (resistance / 1000.00) *
            ((1.00 + 0.018 * (temp - 24.00)) * (1.00 + 0.018 * (temp - 24.00)));

  // Correción según datos
  if (kpa < 0) kpa = -kpa;

  return kpa.toStringAsFixed(2);
}

double _getPressureWithSSCData(int sscData) {
  int outMin = 1638, outMax = 14745, pressMin = 0, pressMax = 30;

  double press =
      (((sscData - outMin) * (pressMax - pressMin)) / (outMax - outMin)) +
          pressMin;

  if (press > 30)
    press = 30;
  else if (press < 0) press = 0;

  // kPa
  return double.parse(press.toStringAsFixed(2));
}

int concatenateBytes(int high, int low, int shift) {
  int c = ((high << (shift)) + low);
  return c;
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
