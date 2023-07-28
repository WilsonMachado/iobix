import 'dart:typed_data';

import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/multipurpose_rs485/multipurpose_rs485_commands.dart';

import '../helpers.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_multipurpose_rs485.dart';

ModelLogConsole bleApiMultipurposeRS485(
    List<int> frame, ModelMultipurposeRS485 modelMultipurposeRS485) {
  final int cmd = frame[0], status = frame[1];

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
      case MULTIPURPOSE_RS485_CMDS.DATA_REPORT:
        modelMultipurposeRS485.setDevices = frame[ptr];
        int selector = frame[ptr];
        ptr++;

        // ISKRA => Rika Noise Sensor
        if (selector & 0x01 == 1) {
          modelMultipurposeRS485.isNoiseSensorRika = true;
          modelMultipurposeRS485.noiseSensorRikaStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.noiseSensorRikaStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // dB
            modelMultipurposeRS485.noiseSensorRikaNoiseLevel =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.1)
                    .toStringAsFixed(1);
            ptr += 2;

            // modelMultipurposeRS485.iskramt174Serie =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
            //         .toString();
            // ptr += 4;

            // // %
            // modelMultipurposeRS485.iskramt174InternalBattery =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4))) *
            //         0.0001;
            // ptr += 4;

            // modelMultipurposeRS485.iskramt174Firmware =
            //     '${utf8.decode([frame[ptr]])}.${utf8.decode([
            //   frame[ptr + 1]
            // ])}.${utf8.decode([frame[ptr + 2]])}';
            // ptr += 3;

            // // Wh
            // modelMultipurposeRS485.iskramt174TotalActiveEnergy =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
            // ptr += 4;

            // // VArh
            // modelMultipurposeRS485.iskramt174TotalPositiveReactiveEnergy =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
            // ptr += 4;

            // // VAh
            // modelMultipurposeRS485.iskramt174TotalApparentEnergy =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
            // ptr += 4;

            // // A
            // modelMultipurposeRS485.iskramt174TotalICurrent =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.01;

            // ptr += 2;

            // // A
            // modelMultipurposeRS485.iskramt174Phase1ICurrent =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.01;
            // ptr += 2;

            // // A
            // modelMultipurposeRS485.iskramt174Phase2ICurrent =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.01;
            // ptr += 2;

            // // A
            // modelMultipurposeRS485.iskramt174Phase3ICurrent =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.01;
            // ptr += 2;

            // // V
            // modelMultipurposeRS485.iskramt174Phase1IVoltage =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.1;
            // ptr += 2;

            // // V
            // modelMultipurposeRS485.iskramt174Phase2IVoltage =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.1;
            // ptr += 2;

            // // V
            // modelMultipurposeRS485.iskramt174Phase3IVoltage =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.1;
            // ptr += 2;

            // // Factor
            // modelMultipurposeRS485.iskramt174IPowerFactor =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.001;
            // ptr += 2;

            // // Hz
            // modelMultipurposeRS485.iskramt174Frequency =
            //     listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
            //         0.01;
            // ptr += 2;
          }
        } else
          modelMultipurposeRS485.isNoiseSensorRika = false;

        // Sensor de ruido Gemho
        if ((selector >> 1) & 0x01 == 1) {
          modelMultipurposeRS485.isNoiseSensorGemho = true;
          modelMultipurposeRS485.noiseSensorGemhoStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.noiseSensorGemhoStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // dB
            modelMultipurposeRS485.noiseSensorGemhoNoiseLevel =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.1)
                    .toStringAsFixed(1);
            ptr += 2;
          }
        } else
          modelMultipurposeRS485.isNoiseSensorGemho = false;

        // Sensor de amoniaco
        if ((selector >> 2) & 0x01 == 1) {
          modelMultipurposeRS485.isAmmoniaSensorGemho = true;
          modelMultipurposeRS485.ammoniaSensorGemhoStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.ammoniaSensorGemhoStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // Amoniaco
            modelMultipurposeRS485.ammoniaSensorGemhoAmmoniaLevel =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.01)
                    .toStringAsFixed(2);
            ptr += 2;
          }
        } else
          modelMultipurposeRS485.isAmmoniaSensorGemho = false;

        // Sensor de humedad / temp / iluminacion
        if ((selector >> 3) & 0x01 == 1) {
          modelMultipurposeRS485.isTemphumiluxSensorGemho = true;
          modelMultipurposeRS485.temphumiluxSensorGemhoStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.temphumiluxSensorGemhoStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // °C
            modelMultipurposeRS485.temphumiluxSensorGemhoTemperature =
                _getTempHumIluxSensorTemperature(
                    listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;

            // % (// Se divide por 100 por el Widget)
            double percent =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.1) /
                    100;
            if (percent > 1) percent = 1;
            modelMultipurposeRS485.temphumiluxSensorGemhoHumidity = percent;
            ptr += 2;

            // lx
            modelMultipurposeRS485.temphumiluxSensorGemhoIlluminance =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
            ptr += 4;
          }
        } else
          modelMultipurposeRS485.isTemphumiluxSensorGemho = false;

        //  Sensor de suelo
        if ((selector >> 4) & 0x01 == 1) {
          modelMultipurposeRS485.isSoilSensorGemho = true;
          modelMultipurposeRS485.soilSensorGemhoStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.soilSensorGemhoStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // °C
            modelMultipurposeRS485.soilSensorGemhoTemperature =
                _getSoilSensorTemperature(
                    listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;

            // % (// Se divide por 100 por el Widget)
            double percent =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.1) /
                    100;
            if (percent > 1) percent = 1;
            modelMultipurposeRS485.soilSensorGemhoHumidity = percent;
            ptr += 2;

            // uS/cm
            modelMultipurposeRS485.soilSensorGemhoElectroconductivity =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;

            // ph
            modelMultipurposeRS485.soilSensorGemhoPh =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                    0.01;
            ptr += 2;

            // mg/kg
            modelMultipurposeRS485.soilSensorGemhoNitrogen =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;

            // mg/kg
            modelMultipurposeRS485.soilSensorGemhoPhosphorus =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;

            // mg/kg
            modelMultipurposeRS485.soilSensorGemhoPotassium =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;
          }
        } else
          modelMultipurposeRS485.isSoilSensorGemho = false;

        // Estación del clima china
        if ((selector >> 5) & 0x01 == 1) {
          modelMultipurposeRS485.isCwsSensorHonde = true;
          modelMultipurposeRS485.cwsSensorHondeStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.cwsSensorHondeStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // Temp (°C)
            modelMultipurposeRS485.cwsSensorHondeTemperature =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                        100.0) -
                    40;
            ptr += 2;

            // Hum (%) Se divide por 100 por el Widget
            double percent =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.01) /
                    100;
            if (percent > 1) percent = 1;
            modelMultipurposeRS485.cwsSensorHondeHumidity = percent;
            ptr += 2;

            // Pressure (hPa)
            modelMultipurposeRS485.cwsSensorHondePressure =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10.0;
            ptr += 2;

            // RainFall (mm)
            modelMultipurposeRS485.cwsSensorHondeRainFall =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) /
                    10.0;
            ptr += 2;

            // Radiation (W/m2)
            modelMultipurposeRS485.cwsSensorHondeRadiation =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;
          }
        } else
          modelMultipurposeRS485.isCwsSensorHonde = false;

        // Sensor de particulas
        if ((selector >> 6) & 0x01 == 1) {
          modelMultipurposeRS485.isParticleSensorRenke = true;
          modelMultipurposeRS485.particleSensorRenkeStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.particleSensorRenkeStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // ug/m3
            modelMultipurposeRS485.particleSensorRenkeParticulateMatter2_5 =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;

            // ug/m3
            modelMultipurposeRS485.particleSensorRenkeParticulateMatter10 =
                listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
            ptr += 2;
          }
        } else
          modelMultipurposeRS485.isParticleSensorRenke = false;

        // Sensor de particulas
        if ((selector >> 7) & 0x01 == 1) {
          modelMultipurposeRS485.isNoiseSensorRenke = true;
          modelMultipurposeRS485.noiseSensorRenkeStatus = frame[ptr];
          ptr++;

          if (modelMultipurposeRS485.noiseSensorRenkeStatus ==
              BLE_GENERAL_CONSTANTS.STATUS_OK) {
            // dB
            modelMultipurposeRS485.noiseSensorRenkeNoiseLevel =
                (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                        0.1)
                    .toStringAsFixed(1);
            ptr += 2;
          }
        } else
          modelMultipurposeRS485.isNoiseSensorRenke = false;

        break;

      case MULTIPURPOSE_RS485_CMDS.SET_DEVICES:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case MULTIPURPOSE_RS485_CMDS.DATA_REPORT_PRESSURE_SCOUT:
        modelMultipurposeRS485.isPressureScout = true;
        if (frame[ptr] != 0) {
          modelMultipurposeRS485.pressureScoutStatus = 'Error';
          log += 'Error en el Gateway Stick';
          break;
        } else {
          modelMultipurposeRS485.pressureScoutStatus = 'Ok';

          ptr += 1;

          modelMultipurposeRS485.voltageSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.psiIntSensorScout =
              hexC2ToDecimal(listBytesToInt(frame.sublist(ptr, ptr + 2)), 2);
          ptr += 2;

          modelMultipurposeRS485.psiIntSensorScoutx100 =
              hexC2ToDecimal(listBytesToInt(frame.sublist(ptr, ptr + 2)), 2);
          ptr += 2;

          modelMultipurposeRS485.highAlarmSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.lowAlarmSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.lowBatteryAlarmSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.psiRangeSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.psiStatusSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          //! Acá arrancan los floats de la primera parte de la trama

          modelMultipurposeRS485.psiFloatReadingSensorScout =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.psiScaleReadingSensorScout =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.alarmHighThreshold =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.alarmLowThreshold =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 6;

          //! Segunda parte de la trama del pressureScout

          modelMultipurposeRS485.mainCardTopRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.mainCardBotRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.radioTopRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.radioBotRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.sftsNodeAddress =
              listBytesToInt(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.modbusAddressSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;
          print(listBytesToInt(frame.sublist(ptr, ptr + 2)));
          modelMultipurposeRS485.rssiSensorScout =
              hexC2ToDecimal(listBytesToInt(frame.sublist(ptr, ptr + 2)), 2);
          ptr += 2;

          modelMultipurposeRS485.sensorBatteryVoltage =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.timeToLive =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.numberOfRegisterCatched =
              frame[ptr] * 256 + frame[ptr + 1];
          ptr += 2;

          modelMultipurposeRS485.sensorType =
              listBytesToInt(frame.sublist(ptr, ptr + 2));

          ptr += 2;

          //! ___________________________ HART SENSOR FRAME 1 _____________________________________
          modelMultipurposeRS485.hartMfgID = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartDeviceType = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartDeviceId =
              listBytesToInt(frame.sublist(ptr, ptr + 3));
          ptr += 3;

          modelMultipurposeRS485.hartStatus = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartPvUnitsCode = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartSvUnitsCode = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartTvUnitsCode = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartQvUnitsCode = frame[ptr];
          ptr += 1;

          modelMultipurposeRS485.hartPv =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.hartSv =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.hartTv =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.hartQv =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.hartCommunicationStatus =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartAlarmHighAlert =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartAlarmLowAlert =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;
          //! _____________________________________________________________________________________

          //! ___________________________ HART SENSOR FRAME 2 _____________________________________
          if (listBytesToInt(frame.sublist(ptr, ptr + 2)) == 0) {
            modelMultipurposeRS485.sentinelStatus = 'Ok';
          } else if (listBytesToInt(frame.sublist(ptr, ptr + 2)) == 1) {
            modelMultipurposeRS485.sentinelStatus = 'Low bat';
          } else if (listBytesToInt(frame.sublist(ptr, ptr + 2)) == 2) {
            modelMultipurposeRS485.sentinelStatus = 'Fail';
          } else if (listBytesToInt(frame.sublist(ptr, ptr + 2)) == 3) {
            modelMultipurposeRS485.sentinelStatus = 'Fail & Low bat';
          } else {
            modelMultipurposeRS485.sentinelStatus = 'Error';
          }
          ptr += 2;

          modelMultipurposeRS485.hartMainCardTopRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartMainCardBotRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartRadioTopRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartRadioBotRevisionNumber =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartSftsNodeAddress =
              listBytesToInt(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelMultipurposeRS485.hartModbusAddressSensorScout =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartRssiSensorScout =
              hexC2ToDecimal(listBytesToInt(frame.sublist(ptr, ptr + 2)), 2);
          ptr += 2;

          modelMultipurposeRS485.hartSensorBatteryVoltage =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartTimeToLive =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartNumberOfRegisterCatched =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;

          modelMultipurposeRS485.hartSensorType =
              listBytesToInt(frame.sublist(ptr, ptr + 2));
          ptr += 2;
          //! _____________________________________________________________________________________
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

double _getSoilSensorTemperature(List<int> measure) {
  Int8List _temp = new Int8List(4)
    ..[2] = measure[0]
    ..[3] = measure[1];

  int temperature = ByteData.sublistView(_temp).getInt32(0);

  return temperature * 0.01;
}

double _getTempHumIluxSensorTemperature(List<int> measure) {
  Int8List _temp = new Int8List(4)
    ..[2] = measure[0]
    ..[3] = measure[1];

  int temperature = ByteData.sublistView(_temp).getInt32(0);

  return temperature * 0.1;
}

double _listToFloat32(List<int> subList) {
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, listBytesToInt(subList));

  return double.parse(byteData.getFloat32(0).toStringAsFixed(4));
}
