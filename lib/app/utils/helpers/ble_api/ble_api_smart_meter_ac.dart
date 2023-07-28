import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';

import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_smart_meter_ac.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/smart_meter_ac/smart_meter_ac_commands.dart';
import '../../helpers/helpers.dart';
import '../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';
import '../../../modules/device/widgets/smart_meter_ac_tab/smart_meter_ac_tab_controller.dart';

ModelLogConsole bleApiSmartMeterAc(
    List<int> frame, ModelSmartMeterAc modelSmartMeterAc) {
  final int cmd = frame[0], status = frame[1];

  bool _isFwHigherOrEqual1_0_4 = isFirmwareVersionIsHigherOrEqualThat(
    Get.find<SystemTabController>().modelDeviceInformation.firmware,
    'v1.0.4',
  );

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
      case SMART_METER_AC_CMDS.WRITE_REGISTER:
      case SMART_METER_AC_CMDS.WRITE_PARAMETER:
      case SMART_METER_AC_CMDS.RESET_ENERGY_ACCUMULATION:
      case SMART_METER_AC_CMDS.SET_CALIB_STATUS_REG:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case SMART_METER_AC_CMDS.GET_PARAMETER:
        while (ptr < frame.length) {
          int varType = frame[ptr];
          ptr++;

          int lenData = 4 * 3;
          if (Get.find<SmartMeterAcTabController>()
              .isCurrentParameterCardCurrent(varType))
            lenData = 4 * 4;
          else if (varType ==
              SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE)
            lenData = 4 * 1;

          ptr += _processGetParameter(
            varType,
            frame.sublist(ptr, ptr + lenData),
            modelSmartMeterAc,
          );
        }

        Get.find<SmartMeterAcTabController>().updateParameterCardVariables();

        //Comando de versión 2
        /*
        int type = frame[ptr];
        ptr++;
        int subtype = frame[ptr];
        ptr++;
        bool value = frame[ptr] == 0x01 ? true : false;
        ptr++;

        switch (type) {
          case SMART_METER_AC_CONSTANTS.CURRENT_REG_TYPE_CODE:
            switch (subtype) {
              case SMART_METER_AC_CONSTANTS.RMS_GAIN_CURRENT_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setRmsCurrentGainCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS.RMS_OFFSET_CURRENT_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setRmsCurrentOffsetCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS
                  .RMS_FUNDAMENTAL_OFFSET_CURRENT_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setRmsFundamentalCurrentOffsetCalib = value;
                break;
            }
            break;

          case SMART_METER_AC_CONSTANTS.VOLTAGE_REG_TYPE_CODE:
            switch (modelSmartMeterAc.setWriteRegSubtype) {
              case SMART_METER_AC_CONSTANTS.RMS_GAIN_VOLTAGE_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setRmsVoltageGainCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS.RMS_OFFSET_VOLTAGE_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setRmsVoltageOffsetCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS
                  .RMS_FUNDAMENTAL_OFFSET_VOLTAGE_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setRmsFundamentalVoltageOffsetCalib = value;
                break;
            }
            break;

          case SMART_METER_AC_CONSTANTS.PHASE_REG_TYPE_CODE:
            modelSmartMeterAc.setPhaseCalib = value;
            break;

          case SMART_METER_AC_CONSTANTS.POWER_REG_TYPE_CODE:
            switch (modelSmartMeterAc.setWriteRegSubtype) {
              case SMART_METER_AC_CONSTANTS.RMS_GAIN_POWER_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setPowerGainCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS
                  .RMS_ACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setActivePowerOffsetCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS
                  .RMS_ACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setFundamentalActivePowerOffsetCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS
                  .RMS_REACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setReactivePowerOffsetCalib = value;
                break;

              case SMART_METER_AC_CONSTANTS
                  .RMS_REACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE:
                modelSmartMeterAc.setFundamentalReactivePowerOffsetCalib =
                    value;
                break;
            }
            break;

          default:
        }

        log += BLE_GENERAL_CONSTANTS.CONFIGURED[frame[2]][0].toUpperCase() +
            BLE_GENERAL_CONSTANTS.CONFIGURED[frame[2]].substring(1);
        */
        break;

      case SMART_METER_AC_CMDS.DATA_REPORT:
        int adcExternalTemperature =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));

        modelSmartMeterAc.externalTemperature =
            _getNtcTemperature(adcExternalTemperature);
        ptr += 2;

        modelSmartMeterAc.externalSupplyStatus =
            'Adaptador ' + (frame[ptr] == 0 ? 'desconectado' : 'conectado');
        ptr++;

        modelSmartMeterAc.adeType = frame[ptr];
        ptr++;

        // RMS Data
        int intVa = (frame[ptr] << 2) | ((frame[ptr + 1] >> 6) & 0x03);
        int decVa =
            ((frame[ptr + 1] & 0x3F) << 1) | ((frame[ptr + 2] >> 7) & 0x01);
        modelSmartMeterAc.getVA =
            double.parse('$intVa.$decVa').toStringAsFixed(2);

        // Ejemplo usando la función getRmsData
        /*modelSmartMeterAc.getVA = _getRmsData(
            frame.sublist(ptr, ptr + 3), 0xFF, 2, 0x03, 6, 0x3F, 1, 0x01, 7);*/

        int intVb =
            ((frame[ptr + 2] & 0x7F) << 3) | ((frame[ptr + 3] >> 5) & 0x07);
        int decVb =
            ((frame[ptr + 3] & 0x1F) << 2) | ((frame[ptr + 4] >> 6) & 0x03);
        modelSmartMeterAc.getVB =
            double.parse('$intVb.$decVb').toStringAsFixed(2);

        int intVc =
            ((frame[ptr + 4] & 0x3F) << 4) | ((frame[ptr + 5] >> 4) & 0x0F);
        int decVc =
            ((frame[ptr + 5] & 0x0F) << 3) | ((frame[ptr + 6] >> 5) & 0x07);
        modelSmartMeterAc.getVC =
            double.parse('$intVc.$decVc').toStringAsFixed(2);

        int intIa =
            ((frame[ptr + 6] & 0x1F) << 5) | ((frame[ptr + 7] >> 3) & 0x1F);
        int decIa =
            ((frame[ptr + 7] & 0x07) << 4) | ((frame[ptr + 8] >> 4) & 0x0F);
        modelSmartMeterAc.getIA =
            double.parse('$intIa.$decIa').toStringAsFixed(2);

        int intIb =
            ((frame[ptr + 8] & 0x0F) << 6) | ((frame[ptr + 9] >> 2) & 0x3F);
        int decIb =
            ((frame[ptr + 9] & 0x03) << 5) | ((frame[ptr + 10] >> 5) & 0x1F);
        modelSmartMeterAc.getIB =
            double.parse('$intIb.$decIb').toStringAsFixed(2);

        int intIc =
            ((frame[ptr + 10] & 0x07) << 7) | ((frame[ptr + 11] >> 1) & 0x7F);
        int decIc =
            ((frame[ptr + 11] & 0x01) << 6) | ((frame[ptr + 12] >> 2) & 0x3F);
        modelSmartMeterAc.getIC =
            double.parse('$intIc.$decIc').toStringAsFixed(2);

        int intIn = ((frame[ptr + 12] & 0x03) << 8) | frame[ptr + 13];
        int decIn = (frame[ptr + 14] >> 1) & 0x7F;
        modelSmartMeterAc.getIN =
            double.parse('$intIn.$decIn').toStringAsFixed(2);

        ptr += 15;

        Get.find<SmartMeterAcTabController>().updatePhaseCardVariables();

        // Procesamiento de lecturas en SMAC V2

        /*case SMART_METER_AC_CMDS.CURRENT_DATA_REPORT:
        modelSmartMeterAc.constantIA =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.constantIB =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.constantIC =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.constantIN =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.getIAHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getIA = _getCurrent(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantIA);
        ptr += 4;

        modelSmartMeterAc.getIBHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getIB = _getCurrent(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantIB);
        ptr += 4;

        modelSmartMeterAc.getICHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getIC = _getCurrent(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantIC);
        ptr += 4;

        modelSmartMeterAc.getINHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getIN = _getCurrent(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantIN);
        ptr += 4;

        modelSmartMeterAc.getIAPGAHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        ptr += 4;

        modelSmartMeterAc.getIBPGAHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        ptr += 4;

        modelSmartMeterAc.getICPGAHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        ptr += 4;

        modelSmartMeterAc.getINPGAHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        ptr += 4;

        break;

      case SMART_METER_AC_CMDS.VOLTAGE_DATA_REPORT:
        modelSmartMeterAc.constantVA =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.constantVB =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.constantVC =
            String.fromCharCodes(frame.sublist(ptr, ptr + 12));
        ptr += 12;

        modelSmartMeterAc.getVAHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getVA = _getVoltage(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantVA);
        ptr += 4;

        modelSmartMeterAc.getVBHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getVB = _getVoltage(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantVB);
        ptr += 4;

        modelSmartMeterAc.getVCHex =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        modelSmartMeterAc.getVC = _getVoltage(
            frame.sublist(ptr, ptr + 4), modelSmartMeterAc.constantVC);
        ptr += 4;
      */

        break;

      case SMART_METER_AC_CMDS.ENERGY_DATA_REPORT:
        if (modelSmartMeterAc.deviceVersion == 3.1 && _isFwHigherOrEqual1_0_4) {
          modelSmartMeterAc.phaseAPositiveActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBPositiveActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCPositiveActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseAPositiveReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBPositiveReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCPositiveReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseAPositiveApparentEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBPositiveApparentEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCPositiveApparentEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseANegativeActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBNegativeActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCNegativeActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseANegativeReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBNegativeReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCNegativeReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseANegativeApparentEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBNegativeApparentEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCNegativeApparentEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;
        } else {
          modelSmartMeterAc.phaseAPositiveActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBPositiveActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCPositiveActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseAPositiveReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBPositiveReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCPositiveReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseANegativeActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBNegativeActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCNegativeActiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseANegativeReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseBNegativeReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;

          modelSmartMeterAc.phaseCNegativeReactiveEnergy =
              _getEnergy(frame.sublist(ptr, ptr + 6));
          ptr += 6;
        }

        Get.find<SmartMeterAcTabController>().updatePhaseCardVariables();
        break;

      case SMART_METER_AC_CMDS.POWER_REPORT:
        modelSmartMeterAc.phaseAActivePower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseBActivePower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseCActivePower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseAReactivePower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseBReactivePower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseCReactivePower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseAApparentPower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseBApparentPower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseCApparentPower =
            _getPower(frame.sublist(ptr, ptr + 5));
        ptr += 5;

        modelSmartMeterAc.phaseAPowerFactor =
            _getPowerFactor(frame.sublist(ptr, ptr + 4));
        ptr += 4;

        modelSmartMeterAc.phaseBPowerFactor =
            _getPowerFactor(frame.sublist(ptr, ptr + 4));
        ptr += 4;

        modelSmartMeterAc.phaseCPowerFactor =
            _getPowerFactor(frame.sublist(ptr, ptr + 4));
        ptr += 4;
        Get.find<SmartMeterAcTabController>().updatePhaseCardVariables();
        break;

      case SMART_METER_AC_CMDS.DEBUG_READ:
        modelSmartMeterAc.analogMeasureProcess = frame[ptr];
        ptr++;

        modelSmartMeterAc.loraMeasureProcess = frame[ptr];
        ptr++;

        modelSmartMeterAc.bleMeasureProcess = frame[ptr];
        ptr++;

        modelSmartMeterAc.loraApiProcess = frame[ptr];
        ptr++;

        modelSmartMeterAc.rak4600Process = frame[ptr];
        ptr++;

        modelSmartMeterAc.adeProcess = frame[ptr];
        ptr++;

        modelSmartMeterAc.adeIrq0Process = frame[ptr];
        ptr++;

        modelSmartMeterAc.adeIrq1Process = frame[ptr];
        ptr++;

        modelSmartMeterAc.adeEnergyProcess = frame[ptr];
        ptr++;

        modelSmartMeterAc.adeBurstReadProcess = frame[ptr];
        ptr++;

        if (frame.length > ptr) {
          modelSmartMeterAc.rakSendDataStatus = frame[ptr];
          ptr++;

          modelSmartMeterAc.rakSendingProcess = frame[ptr];
          ptr++;
        }

        Get.find<SmartMeterAcTabController>().updateDebugCard();
        break;

      case SMART_METER_AC_CMDS.GET_CALIB_STATUS_REG:
        int regCalibStatus2 = frame[ptr];
        int regCalibStatus1 = frame[ptr + 1];
        ptr += 2;

        modelSmartMeterAc.setRmsCurrentGainCalib =
            _regCalibStatusSelector(regCalibStatus1, 8);

        modelSmartMeterAc.setRmsCurrentOffsetCalib =
            _regCalibStatusSelector(regCalibStatus1, 7);

        modelSmartMeterAc.setRmsFundamentalCurrentOffsetCalib =
            _regCalibStatusSelector(regCalibStatus1, 6);

        modelSmartMeterAc.setRmsVoltageGainCalib =
            _regCalibStatusSelector(regCalibStatus1, 5);

        modelSmartMeterAc.setRmsVoltageOffsetCalib =
            _regCalibStatusSelector(regCalibStatus1, 4);

        modelSmartMeterAc.setRmsFundamentalVoltageOffsetCalib =
            _regCalibStatusSelector(regCalibStatus1, 3);

        modelSmartMeterAc.setPhaseCalib =
            _regCalibStatusSelector(regCalibStatus1, 2);

        modelSmartMeterAc.setPowerGainCalib =
            _regCalibStatusSelector(regCalibStatus1, 1);

        modelSmartMeterAc.setActivePowerOffsetCalib =
            _regCalibStatusSelector(regCalibStatus2, 8);

        modelSmartMeterAc.setFundamentalActivePowerOffsetCalib =
            _regCalibStatusSelector(regCalibStatus2, 7);

        modelSmartMeterAc.setReactivePowerOffsetCalib =
            _regCalibStatusSelector(regCalibStatus2, 6);

        modelSmartMeterAc.setFundamentalReactivePowerOffsetCalib =
            _regCalibStatusSelector(regCalibStatus2, 5);

        Get.find<SmartMeterAcTabController>()
            .updateSmartMeterAcSetCalibStatusRegCard();
        break;

      case SMART_METER_AC_CMDS.GET_RMS_REG:
        modelSmartMeterAc.getRmsRegValue =
            '0x' + hexaToAscii(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)));
        ptr += 4;
        break;

      default:
        log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
        cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
    }
  }
  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}

String _getPowerFactor(List<int> bytes) {
  int integer = getSignedNumber(listIntLsbToMsb(bytes));
  return (integer * pow(2, -27)).toStringAsFixed(2);
}

String _getPower(List<int> bytes) {
  int integer = getSignedNumber(listIntLsbToMsb(bytes.sublist(0, 4)));
  int decimal = bytes[4];

  return '$integer.$decimal';
}

String _getEnergy(List<int> bytes) {
  int integer = getSignedNumber(listIntLsbToMsb(bytes.sublist(0, 4)));
  int decimal = getSignedNumber16(listIntLsbToMsb(bytes.sublist(4)));
  bool isNegative = false;

  if (integer < 0) {
    isNegative = true;
    integer = integer * (-1);
  }

  if (decimal < 0) {
    isNegative = true;
    decimal = decimal * (-1);
  }

  String realDecimal = decimal.toString();

  while (realDecimal.length < 4) {
    realDecimal = '0$realDecimal';
  }

  return '${isNegative ? '-' : ''}$integer.$realDecimal';
}

String _getNtcTemperature(int measure, {int digits = 2}) {
  if (measure < 0xFF0) {
    return (adcToTemperature(
      measure,
      SMART_METER_AC_CONSTANTS.ADC_RESOLUTION,
      SMART_METER_AC_CONSTANTS.NTC_RO,
      SMART_METER_AC_CONSTANTS.NTC_RF,
      SMART_METER_AC_CONSTANTS.NTC_EXTERNAL_B,
    )).toStringAsFixed(digits);
  } else
    return 'sensor_disconnected'.tr;
}

bool _regCalibStatusSelector(selector, bit) {
  return ((selector >> (bit - 1)) & 0x01 == 1) ? true : false;
}

String getRmsData(
    List<int> bytes,
    int bitsIntHigh,
    int shiftIntHigh,
    int bitsIntLow,
    int shiftIntLow,
    int bitsDecHigh,
    int shiftDecHigh,
    int bitsDecLow,
    int shiftDecLow) {
  int integer = ((bytes[0] & bitsIntHigh) << shiftIntHigh) |
      ((bytes[1] >> shiftIntLow) & bitsIntLow);
  int decimal = ((bytes[1] & bitsDecHigh) << shiftDecHigh) |
      ((bytes[2] >> shiftDecLow) & bitsDecLow);

  return double.parse('$integer.$decimal').toStringAsFixed(2);
}

// Calculos de corriente y voltaje para SMAC V2
/*
String _getCurrent(List<int> value, String constant) {
  return (double.parse(constant) *
          listBytesToInt(listIntLsbToMsb(value)) *
          0.000001)
      .toStringAsFixed(5);
}

String _getVoltage(List<int> value, String constant) {
  return (double.parse(constant) *
          listBytesToInt(listIntLsbToMsb(value)) *
          0.000001)
      .toStringAsFixed(2);
}
*/

int _processGetParameter(
  int varType,
  List<int> data,
  ModelSmartMeterAc modelSmartMeterAc,
) {
  var bd = ByteData(4);
  int ptr = 0;

  switch (varType) {
    case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteCurrentPhaseA =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteCurrentPhaseB =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteCurrentPhaseC =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteCurrentNeutro =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      break;

    case SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE:
      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteVoltagePhaseA =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteVoltagePhaseB =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteVoltagePhaseC =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);
      break;

    /*case SMART_METER_AC_CONSTANTS.PHASE_VAR_TYPE_CODE:
      break;*/

    case SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE:
      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.ctePowerPhaseA =
          (bd.getFloat32(0) * 1000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.ctePowerPhaseB =
          (bd.getFloat32(0) * 1000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.ctePowerPhaseC =
          (bd.getFloat32(0) * 1000).toStringAsFixed(8);
      break;

    case SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE:
      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteEnergyPhaseA =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteEnergyPhaseB =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.cteEnergyPhaseC =
          (bd.getFloat32(0) * 1000000).toStringAsFixed(8);
      break;

    case SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE:
      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.voltageUpperThrPhaseA =
          (bd.getFloat32(0)).toStringAsFixed(2);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.voltageUpperThrPhaseB =
          (bd.getFloat32(0)).toStringAsFixed(2);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.voltageUpperThrPhaseC =
          (bd.getFloat32(0)).toStringAsFixed(2);
      break;

    case SMART_METER_AC_CONSTANTS.VOLTAGE_LOWER_THR_VAR_TYPE_CODE:
      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.voltageLowerThrPhaseA =
          (bd.getFloat32(0)).toStringAsFixed(2);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.voltageLowerThrPhaseB =
          (bd.getFloat32(0)).toStringAsFixed(2);

      bd.setInt32(
          0, listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4))));
      ptr += 4;

      modelSmartMeterAc.voltageLowerThrPhaseC =
          (bd.getFloat32(0)).toStringAsFixed(2);
      break;

    case SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE:
      modelSmartMeterAc.energyMeasureFreqPhaseAll =
          listBytesToInt(listIntLsbToMsb(data.sublist(ptr, ptr + 4)))
              .toStringAsFixed(0);
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE:
      modelSmartMeterAc.currentGainPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.currentGainPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.currentGainPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.currentGainNeutro =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.VOLTAGE_GAIN_VAR_TYPE_CODE:
      modelSmartMeterAc.voltageGainPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.voltageGainPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.voltageGainPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.POWER_GAIN_VAR_TYPE_CODE:
      modelSmartMeterAc.powerGainPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.powerGainPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.powerGainPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE:
      modelSmartMeterAc.currentOffsetPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.currentOffsetPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.currentOffsetPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.currentOffsetNeutro =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.VOLTAGE_OFFSET_VAR_TYPE_CODE:
      modelSmartMeterAc.voltageOffsetPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.voltageOffsetPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.voltageOffsetPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.ACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
      modelSmartMeterAc.activePowerOffsetPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.activePowerOffsetPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.activePowerOffsetPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    case SMART_METER_AC_CONSTANTS.REACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
      modelSmartMeterAc.reactivePowerOffsetPhaseA =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.reactivePowerOffsetPhaseB =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;

      modelSmartMeterAc.reactivePowerOffsetPhaseC =
          hexaToAscii(listIntLsbToMsb(data.sublist(ptr, ptr + 4)));
      ptr += 4;
      break;

    default:
  }

  return ptr;
}
