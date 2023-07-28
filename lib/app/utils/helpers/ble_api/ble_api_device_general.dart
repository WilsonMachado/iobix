import 'package:get/instance_manager.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/helpers.dart';
import '../../constants/ble_api/ble_general_commands.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../../data/models/local/model_device_general.dart';
import '../../../data/models/local/model_device_type_parameters.dart';
import '../../../modules/device/widgets/lorawan_tab/lorawan_tab_controller.dart';

ModelLogConsole bleApiDeviceGeneral(
  List<int> frame,
  ModelDeviceGeneral modelDeviceGeneral,
  ModelDeviceTypeParameters modelDeviceTypeParameters,
) {
  final int cmd = frame[0], status = frame[1];
  int ptr = 2;
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;

    // Automatic Config for RAK
    if (Get.find<LorawanTabController>().isAutomaticConfig) {
      switch (cmd) {
        case BLE_GENERAL_CMDS.TX_TIME:
          Get.find<LorawanTabController>().resetAutomaticConfig(
              msg:
                  '¡Ups!, hubo un problema procesando el último comando (Consola), ¿Vamos nuevamente?');
          break;
        default:
      }
    }
  } else {
    switch (cmd) {
      case BLE_GENERAL_CMDS.MCU_RESET:
      case BLE_GENERAL_CMDS.BUZZER:
      case BLE_GENERAL_CMDS.MEASURE_TIME:
      case BLE_GENERAL_CMDS.TX_TIME:
      case BLE_GENERAL_CMDS.SEND_TEST_DATA:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];

        // Automatic Config For RAK
        if (Get.find<LorawanTabController>().isAutomaticConfig &&
            cmd == BLE_GENERAL_CMDS.TX_TIME) {
          Get.find<LorawanTabController>().automaticConfig(9);
        }
        break;

      case BLE_GENERAL_CMDS.GPS_SYNC:
        modelDeviceGeneral.gpsSyncStatus = frame[ptr];
        ptr++;

        log +=
            '${BLE_GENERAL_CONSTANTS.STATUS[status]}, GPS: ${BLE_GENERAL_CONSTANTS.GPS_SYNC_STATUS[modelDeviceGeneral.gpsSyncStatus]}';

        if (modelDeviceGeneral.gpsSyncStatus ==
                BLE_GENERAL_CONSTANTS.GPS_SYNC_OK ||
            modelDeviceGeneral.gpsSyncStatus ==
                BLE_GENERAL_CONSTANTS.GPS_SYNC_GPS_DISABLED ||
            modelDeviceGeneral.gpsSyncStatus ==
                BLE_GENERAL_CONSTANTS.GPS_SYNC_GPS_TIMEOUT)
          modelDeviceGeneral.isGpsSync = false;
        else if (modelDeviceGeneral.gpsSyncStatus ==
            BLE_GENERAL_CONSTANTS.GPS_SYNC_INIT)
          modelDeviceGeneral.isGpsSync = true;

        if (modelDeviceGeneral.gpsSyncStatus ==
            BLE_GENERAL_CONSTANTS.GPS_SYNC_OK) {
          modelDeviceGeneral.gpsLatitude =
              gnssCoordProcess(frame.sublist(ptr, ptr + 10));
          ptr += 10;
          modelDeviceGeneral.gpsLongitude =
              gnssCoordProcess(frame.sublist(ptr, ptr + 11));
          ptr += 11;

          // Log
          log +=
              ', Latitude: ${modelDeviceGeneral.gpsLatitude} - Longitude: ${modelDeviceGeneral.gpsLongitude}';

          // Add to Google map
          LatLng coor = LatLng(
              modelDeviceGeneral.gpsLatitude, modelDeviceGeneral.gpsLongitude);
          MarkerId markerId = MarkerId('sync');
          Marker marker = Marker(
              markerId: markerId,
              position: coor,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure));
          modelDeviceGeneral.markersGoogleMap[markerId] = marker;
          modelDeviceGeneral.googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            bearing: 0.0,
            target: coor,
            tilt: 30.0,
            zoom: 17,
          )));
        }

        break;

      case BLE_GENERAL_CMDS.SET_RTC:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];

        if (status == BLE_GENERAL_CONSTANTS.STATUS_OK) {
          int year = listBytesToInt(frame.sublist(2, 4));
          int month = frame[4];
          int day = frame[5];
          int hour = frame[6];
          int minute = frame[7];

          modelDeviceGeneral.getRtcDate =
              DateTime.utc(year, month, day, hour, minute).toLocal();
          modelDeviceGeneral.getRtcTime = TimeOfDay(
              hour: modelDeviceGeneral.getRtcDate.hour,
              minute: modelDeviceGeneral.getRtcDate.minute);
        }

        break;

      case BLE_GENERAL_CMDS.LEDS:
      case BLE_GENERAL_CMDS.ACELEROMETER:
      case BLE_GENERAL_CMDS.GNSS:
      case BLE_GENERAL_CMDS.MAINTENANCE_MODE:
      case BLE_GENERAL_CMDS.CONFIRMED_MESSAGES:
        {
          switch (cmd) {
            case BLE_GENERAL_CMDS.LEDS:
              modelDeviceGeneral.leds = frame[2] == 0x01 ? true : false;
              break;
            case BLE_GENERAL_CMDS.ACELEROMETER:
              modelDeviceGeneral.acelerometer = frame[2] == 0x01 ? true : false;
              break;
            case BLE_GENERAL_CMDS.GNSS:
              modelDeviceGeneral.gnss = frame[2] == 0x01 ? true : false;
              if (!modelDeviceGeneral.gnss) {
                modelDeviceGeneral.isGpsSync = false;
              }
              break;
            case BLE_GENERAL_CMDS.MAINTENANCE_MODE:
              modelDeviceGeneral.maintenance = frame[2] == 0x01 ? true : false;
              break;
            case BLE_GENERAL_CMDS.CONFIRMED_MESSAGES:
              modelDeviceGeneral.confirmedMessages =
                  frame[2] == 0x01 ? true : false;
              break;
          }
          log += BLE_GENERAL_CONSTANTS.CONFIGURED[frame[2]][0].toUpperCase() +
              BLE_GENERAL_CONSTANTS.CONFIGURED[frame[2]].substring(1);
        }
        break;

      case BLE_GENERAL_CMDS.G_HEALTHY_REPORT:
        int ptr = 2;

        modelDeviceGeneral.leds = frame[ptr] == 0x01 ? true : false;
        ptr++;

        _acelerometerByteProcess(frame[ptr], modelDeviceGeneral);
        ptr++;

        modelDeviceGeneral.gnss = frame[ptr] == 0x01 ? true : false;
        ptr++;

        modelDeviceGeneral.getMeasureTime =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
                .toString();
        ptr += 4;

        modelDeviceGeneral.getTxTime =
            listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + 4)))
                .toString();
        ptr += 4;

        modelDeviceGeneral.maintenance = frame[ptr] == 0x01 ? true : false;
        ptr++;

        int adcBattery = listBytesToInt(frame.sublist(ptr, ptr + 2));
        ptr += 2;
        modelDeviceGeneral.batteryValue =
            modelDeviceTypeParameters.adcBatteryParam *
                adcToValue(adcBattery, modelDeviceTypeParameters.adcResolution,
                    modelDeviceTypeParameters.voltageReference);
        modelDeviceGeneral.batteryPercentage = batteryToPercentage(
            modelDeviceTypeParameters.nominalBatteryMax,
            modelDeviceTypeParameters.nominalBatteryMin,
            modelDeviceGeneral.batteryValue);

        modelDeviceGeneral.supply = modelDeviceTypeParameters.adcVauxParam *
            adcToValue(
                listBytesToInt(frame.sublist(ptr, ptr + 2)),
                modelDeviceTypeParameters.adcResolution,
                modelDeviceTypeParameters.voltageReference);
        ptr += 2;

        modelDeviceGeneral.solarPanel =
            modelDeviceTypeParameters.adcVpanelParam *
                adcToValue(
                    listBytesToInt(frame.sublist(ptr, ptr + 2)),
                    modelDeviceTypeParameters.adcResolution,
                    modelDeviceTypeParameters.vpanelVoltageReference);

        ptr += 2;
        modelDeviceGeneral.confirmedMessages =
            frame[ptr] == 0x01 ? true : false;
        ptr++;

        int year = listBytesToInt(frame.sublist(ptr, ptr + 2));
        ptr += 2;
        int month = frame[ptr];
        ptr++;
        int day = frame[ptr];
        ptr++;
        int hour = frame[ptr];
        ptr++;
        int minute = frame[ptr];
        ptr++;

        modelDeviceGeneral.getRtcDate =
            DateTime.utc(year, month, day, hour, minute).toLocal();
        modelDeviceGeneral.getRtcTime = TimeOfDay(
            hour: modelDeviceGeneral.getRtcDate.hour,
            minute: modelDeviceGeneral.getRtcDate.minute);

        modelDeviceGeneral.temperature =
            (listBytesToInt(frame.sublist(ptr, ptr + 2)) < 0xFFF)
                ? adcToTemperature(
                    listBytesToInt(frame.sublist(ptr, ptr + 2)),
                    modelDeviceTypeParameters.adcResolution,
                    modelDeviceTypeParameters.ro,
                    modelDeviceTypeParameters.rf,
                    modelDeviceTypeParameters.internalB,
                  )
                : 0;
        ptr += 2;

        modelDeviceGeneral.tampering =
            BLE_GENERAL_CONSTANTS.TAMPERING_STATUS.containsKey(frame[ptr])
                ? BLE_GENERAL_CONSTANTS.TAMPERING_STATUS[frame[ptr]]
                : 'Error';
        ptr++;

        if (frame.length > ptr) {
          modelDeviceGeneral.gpsSyncStatus = frame[ptr];
          ptr++;

          if (modelDeviceGeneral.gpsSyncStatus ==
              BLE_GENERAL_CONSTANTS.GPS_SYNC_INIT)
            modelDeviceGeneral.isGpsSync = true;
        }

        log += 'Ok';
        break;

      default:
        log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
        cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
    }
  }

  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}

void _acelerometerByteProcess(int byte, ModelDeviceGeneral modelDeviceGeneral) {
  // Orientation
  int orientationBit = (byte >> 2) & 0x03;
  modelDeviceGeneral.acelerometerOrientation =
      BLE_GENERAL_CONSTANTS.ACELEROMETER_ORIENTATION.containsKey(orientationBit)
          ? BLE_GENERAL_CONSTANTS.ACELEROMETER_ORIENTATION[orientationBit]
          : 'Error';

  // Fall alarm
  modelDeviceGeneral.acelerometerFallAlarm =
      (byte >> 1) & 0x01 == 1 ? true : false;

  // Acelerometer state
  modelDeviceGeneral.acelerometer = (byte) & 0x01 == 0x01 ? true : false;
}
