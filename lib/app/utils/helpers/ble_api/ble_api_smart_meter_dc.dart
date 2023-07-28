import 'dart:math' as Math;

import 'package:get/get_utils/get_utils.dart';

import '../../helpers/helpers.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_smart_meter_dc.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/smart_meter_dc/smart_meter_dc_commands.dart';
import '../../constants/ble_api/smart_meter_dc/smart_meter_dc_constants.dart';

ModelLogConsole bleApiSmartMeterDc(
    List<int> frame, ModelSmartMeterDc modelSmartMeterDc) {
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
      case SMART_METER_DC_CMDS.SET_ALARM_PARAMETERS:
      case SMART_METER_DC_CMDS.SET_CURRENT_RANGE:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case SMART_METER_DC_CMDS.DATA_REPORT:
        modelSmartMeterDc.vdc1 = _getVoltage(
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
            modelSmartMeterDc.deviceVersion);
        ptr += 2;

        modelSmartMeterDc.vdc2 = _getVoltage(
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
            modelSmartMeterDc.deviceVersion);
        ptr += 2;

        modelSmartMeterDc.getCurrentRange =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));
        ptr += 2;

        modelSmartMeterDc.idc1 = _getCurrent(
          listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
          modelSmartMeterDc.getCurrentRange,
        );
        ptr += 2;

        modelSmartMeterDc.idc2 = _getCurrent(
          listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))),
          modelSmartMeterDc.getCurrentRange,
        );
        ptr += 2;

        modelSmartMeterDc.dcdcReading =
            (listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2))) *
                    SMART_METER_DC_CONSTANTS.ADC_DCDC_PARAM)
                .toStringAsFixed(2);
        ptr += 2;

        int adcExternalTemperature =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 2)));

        modelSmartMeterDc.externalTemperature =
            _getNtcTemperature(adcExternalTemperature);
        ptr += 2;

        modelSmartMeterDc.externalSupplyStatus =
            'Adaptador ' + (frame[ptr] == 0 ? 'desconectado' : 'conectado');
        ptr++;

        break;

      case SMART_METER_DC_CMDS.GET_ALARM_PARAMETERS:
        modelSmartMeterDc.delta1 = _getVoltage(
            listBytesToInt(frame.sublist(ptr, ptr + 2)),
            modelSmartMeterDc.deviceVersion,
            digits: 0);
        ptr += 2;

        modelSmartMeterDc.min1 = _getVoltage(
            listBytesToInt(frame.sublist(ptr, ptr + 2)),
            modelSmartMeterDc.deviceVersion,
            digits: 0);
        ptr += 2;

        modelSmartMeterDc.max1 = _getVoltage(
            listBytesToInt(frame.sublist(ptr, ptr + 2)),
            modelSmartMeterDc.deviceVersion,
            digits: 0);
        ptr += 2;

        modelSmartMeterDc.delta2 = _getVoltage(
            listBytesToInt(frame.sublist(ptr, ptr + 2)),
            modelSmartMeterDc.deviceVersion,
            digits: 0);
        ptr += 2;

        modelSmartMeterDc.min2 = _getVoltage(
            listBytesToInt(frame.sublist(ptr, ptr + 2)),
            modelSmartMeterDc.deviceVersion,
            digits: 0);
        ptr += 2;

        modelSmartMeterDc.max2 = _getVoltage(
            listBytesToInt(frame.sublist(ptr, ptr + 2)),
            modelSmartMeterDc.deviceVersion,
            digits: 0);
        ptr += 2;
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
      SMART_METER_DC_CONSTANTS.ADC_RESOLUTION,
      SMART_METER_DC_CONSTANTS.NTC_RO,
      SMART_METER_DC_CONSTANTS.NTC_RF,
      SMART_METER_DC_CONSTANTS.NTC_EXTERNAL_B,
    )).toStringAsFixed(digits);
  } else
    return 'sensor_disconnected'.tr;
}

String _getVoltage(int vAdc, double deviceVersion, {int digits = 2}) {
  double voltage = (0.01471 * vAdc) +
      (0.14701 * (Math.log(vAdc) / Math.log(Math.e))) -

      ///TODO: Sospechoso! Revisar en Confluence
      0.20095;

  return (voltage < ((deviceVersion == 2.0) ? 0 : 0.2))
      ? 'disconnected'.tr
      : voltage.toStringAsFixed(digits);
}

int getAdcVoltage(int vin) {
  return ((67.9936 * vin) -
          (8.92212 * (Math.log(vin) / Math.log(Math.e))) -
          29.70332)
      .round();
}

String _getCurrent(int iAdc, int range) {
  /*
  double current = range * ((iAdc - 2443.21485) / 1572.864);
  return (current < 0) ? 'disconnected'.tr : current.toStringAsFixed(2);*/

  double vina = (iAdc - 0.5) * 2.5 / 4096;
  double io = (vina - 1.25) / 60;

  //Umbral para lectura de 0A (sensor conectado sin carga)
  if ((vina > 1.475 && vina < 1.50) || (vina > 1.00 && vina < 1.02))
    return '0.00';
  //Lectura de corrientes negativas
  else if (vina <= 1.00)
    return ((io + 0.004) * range / (0.016)).toStringAsFixed(2);
  //Lectura de corrientes positivas
  else if (vina >= 1.50)
    return ((io - 0.004) * range / (0.016)).toStringAsFixed(2);
  //No hay sensor conectado
  else
    return 'disconnected'.tr;
}
