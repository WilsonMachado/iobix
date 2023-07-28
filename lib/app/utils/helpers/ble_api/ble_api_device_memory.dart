import 'package:get/instance_manager.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../constants/constants.dart';
import '../../constants/ble_api/ble_general_commands.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../../data/models/local/model_log_console.dart';
import '../helpers.dart';
import '../../../data/models/local/model_device_memory.dart';
import '../storage.dart';
import '../../../modules/device/widgets/lorawan_tab/lorawan_tab_controller.dart';

ModelLogConsole bleApiMemory(
    BuildContext context,
    List<int> frame,
    ModelDeviceMemory modeldeviceMemory,
    List<String> deviceVersion,
    String developer,
    String firmwareVersion,
    String deviceId,
    Map<int, String> memoryDataTypeLogApp,
    Map<int, String> memoryDataTypeLogSys) {
  final int cmd = frame[0], status = frame[1];
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
    modeldeviceMemory.isReadData = false;
    modeldeviceMemory.isDataNotFound = true;

    // Automatic Config for RAK
    if (Get.find<LorawanTabController>().isAutomaticConfig) {
      switch (cmd) {
        case BLE_GENERAL_CMDS.CLEAR_LOGAPP:
        case BLE_GENERAL_CMDS.CLEAR_LOGSYS:
          Get.find<LorawanTabController>().resetAutomaticConfig(
              msg:
                  '¡Ups!, hubo un problema procesando el último comando (Consola), ¿Vamos nuevamente?');
          break;
        default:
      }
    }
  } else {
    switch (cmd) {
      case BLE_GENERAL_CMDS.READ_LOGAPP:
      case BLE_GENERAL_CMDS.READ_LOGSYS:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        modeldeviceMemory.logsExtracted.add(frame.sublist(2));
        modeldeviceMemory.counterFrames++;
        log += ', data found # ${modeldeviceMemory.counterFrames}';
        break;

      case BLE_GENERAL_CMDS.UNSUCESS_FINISH_READ:
        modeldeviceMemory.isReadData = false;
        modeldeviceMemory.isDataNotFound = true;
        log += 'The requested data was not found';
        break;

      case BLE_GENERAL_CMDS.SUCESS_FINISH_READ:
        bool isLogSys =
            modeldeviceMemory.logType == BLE_GENERAL_CMDS.READ_LOGSYS;

        String document = '${'device_info'.tr}\n\n';
        document += '${'device'.tr}: ${deviceVersion[0]}\n';
        document += '${'version'.tr}: ${deviceVersion[1]}\n';
        document += '${'developer'.tr}: $developer\n';
        document += '${'firmware_version'.tr}: $firmwareVersion\n';
        document += '${'ble_api_version'.tr}: v0.0.1\n';
        document += '${'device_id'.tr}: $deviceId\n';
        document += '${'app_version'.tr}: ${CONSTANTS.APP_VERSION}\n\n';

        document += '${'req_info'.tr}\n\n';
        document +=
            '${'data_extr_date'.tr}: ${DateFormat.yMMMd().format(modeldeviceMemory.logsGetDate)} ${TimeOfDay(hour: modeldeviceMemory.logsGetDate.hour, minute: modeldeviceMemory.logsGetDate.minute).format(context)}\n';
        document +=
            '${'init_read_date'.tr}: ${DateFormat.yMMMd().format(modeldeviceMemory.readInitDate)} ${TimeOfDay(hour: 0, minute: 0).format(context)}\n';
        document +=
            '${'final_read_date'.tr}: ${DateFormat.yMMMd().format(modeldeviceMemory.readFinishDate)} ${TimeOfDay(hour: 23, minute: 59).format(context)}\n';
        document +=
            '${'memory_block'.tr}: ${BLE_GENERAL_CONSTANTS.MEMORY_LOG_TYPE[modeldeviceMemory.logType].tr}\n\n';

        document += '${'frame_format'.tr}\n\n';
        document += isLogSys
            ? '${'frame_format_logsys'.tr}\n\n'
            : '${'frame_format_logapp'.tr}\n\n';

        document += '${'data'.tr}\n\n';

        for (List<int> frame in modeldeviceMemory.logsExtracted) {
          List<String> date = getMemoryDateFormat(frame.sublist(0, 5), context);

          String eventType = (isLogSys
                  ? BLE_GENERAL_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS[frame[2] >> 4]
                  : memoryDataTypeLogApp[frame[2] >> 4])
              .tr;

          String msgId = isLogSys ? '' : ' - ${frame[5].toString()}';
          String eventSubType = ' - ';

          int eventSubTypeCode = (5 + (isLogSys ? 0 : 1));

          if (isLogSys && frame.length > eventSubTypeCode) {
            switch (frame[2] >> 4) {
              case BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_GENERAL_SYSTEM_CODE:
                eventSubType += BLE_GENERAL_CONSTANTS
                        .MEMORY_LOGSYS_GENERAL_SYSTEM_MAP
                        .containsKey(frame[eventSubTypeCode])
                    ? BLE_GENERAL_CONSTANTS
                        .MEMORY_LOGSYS_GENERAL_SYSTEM_MAP[
                            frame[eventSubTypeCode]]
                        .tr
                    : 'code_error'.tr;
                break;

              case BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_BLUETOOTH_CODE:
                eventSubType += BLE_GENERAL_CONSTANTS
                        .MEMORY_LOGSYS_BLUETOOTH_MAP
                        .containsKey(frame[eventSubTypeCode])
                    ? BLE_GENERAL_CONSTANTS
                        .MEMORY_LOGSYS_BLUETOOTH_MAP[frame[eventSubTypeCode]].tr
                    : 'code_error'.tr;
                break;

              case BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_LORA_CODE:
                eventSubType += BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_LORA_MAP
                        .containsKey(frame[eventSubTypeCode])
                    ? BLE_GENERAL_CONSTANTS
                        .MEMORY_LOGSYS_LORA_MAP[frame[eventSubTypeCode]].tr
                    : 'code_error'.tr;
                break;

              case BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_GNSS_CODE:
                eventSubType += BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_GNSS_MAP
                        .containsKey(frame[eventSubTypeCode])
                    ? BLE_GENERAL_CONSTANTS
                        .MEMORY_LOGSYS_GNSS_MAP[frame[eventSubTypeCode]].tr
                    : 'code_error'.tr;
                break;

              case BLE_GENERAL_CONSTANTS.MEMORY_LOGSYS_SPECIFIC_DEVICE_CODE:
                eventSubType +=
                    memoryDataTypeLogSys.containsKey(frame[eventSubTypeCode])
                        ? memoryDataTypeLogSys[frame[eventSubTypeCode]].tr
                        : 'code_error'.tr;
                break;

              default:
                eventSubType += 'subtype_error'.tr;
            }
          }

          String payload = frame.length > (eventSubTypeCode + 1)
              ? ' - ${hexaToAscii(frame.sublist(6)).toUpperCase()}'
              : '';
          document +=
              '${date[0]} ${date[1]}$msgId - $eventType$eventSubType$payload\n';
        }

        modeldeviceMemory.isReadData = false;
        modeldeviceMemory.isDataFound = true;
        log +=
            'Read completed, total data found: ${modeldeviceMemory.counterFrames} frame(s)';
        Storage.writeData(document);
        break;

      case BLE_GENERAL_CMDS.CLEAR_LOGAPP:
      case BLE_GENERAL_CMDS.CLEAR_LOGSYS:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        // Automatic Config For RAK
        if (Get.find<LorawanTabController>().isAutomaticConfig) {
          switch (cmd) {
            case BLE_GENERAL_CMDS.CLEAR_LOGAPP:
              Get.find<LorawanTabController>().automaticConfig(10);
              break;

            case BLE_GENERAL_CMDS.CLEAR_LOGSYS:
              Get.find<LorawanTabController>().automaticConfig(11);
              break;

            default:
          }
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

List<int> setMemoryDateRangeFormat(
    int dataType, DateTime init, DateTime finish) {
  init = init.toUtc();
  finish = finish.toUtc();

  return [
    ...divideIntInNBytes(init.year, 2),
    (dataType << 4) | init.month,
    (init.day << 3) | (0 >> 2),
    ((0 & 0x03) << 6) | 0,
    0x00,
    ...divideIntInNBytes(finish.year, 2),
    (finish.month & 0x0F),
    (finish.day << 3) | (23 >> 2),
    ((23 & 0x03) << 6) | 59,
    0xFF
  ];
}

List<String> getMemoryDateFormat(List<int> data, BuildContext context) {
  DateTime local = DateTime.utc(
          listBytesToInt(data.sublist(0, 2)),
          (data[2] & 0x0F),
          (data[3] >> 3),
          ((data[3] & 0x07) << 2) | (data[4] >> 6),
          data[4] & 0x3F)
      .toLocal();

  return [
    DateFormat.yMMMd().format(local),
    '${TimeOfDay(hour: local.hour, minute: local.minute).format(context)}'
  ];
}

void memoryReadInitialization(ModelDeviceMemory modelDeviceMemory) {
  modelDeviceMemory.logsExtracted.clear();
  modelDeviceMemory.isReadData = false;
  modelDeviceMemory.isDataNotFound = false;
  modelDeviceMemory.isDataFound = false;
  modelDeviceMemory.counterFrames = 0;
  modelDeviceMemory.logsGetDate = DateTime.now();
}
