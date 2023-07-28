import 'package:get/instance_manager.dart';

import '../../../modules/device/widgets/lorawan_tab/lorawan_tab_controller.dart';
import '../../helpers/helpers.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/lorawan_constants.dart';
import '../../constants/ble_api/ble_general_commands.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_device_lorawan.dart';

ModelLogConsole bleApiDeviceLorawan(
    List<int> frame, ModelDeviceLorawan modelDeviceLorawan) {
  final int cmd = frame[0], status = frame[1];
  String log = '';
  bool isResponseOk = true, showSnackBar = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;

    // Specific for JOIN OTAA
    if (cmd == BLE_GENERAL_CMDS.JOIN_OTAA) {
      modelDeviceLorawan.isTryJoin = false;
    }

    // Automatic Config for RAK
    if (Get.find<LorawanTabController>().isAutomaticConfig) {
      switch (cmd) {
        case BLE_GENERAL_CMDS.SET_LORA_BAND:
        case BLE_GENERAL_CMDS.SET_LORA_SUB_BANDS:
        case BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK:
        case BLE_GENERAL_CMDS.SET_LORA_DATA_RATE:
        case BLE_GENERAL_CMDS.SET_LORA_TX_POWER:
        case BLE_GENERAL_CMDS.SET_LORA_CLASS:
          Get.find<LorawanTabController>().resetAutomaticConfig(
              msg:
                  '¡Ups!, hubo un problema procesando el último comando (Consola), ¿Vamos nuevamente?');
          break;

        default:
      }
    }
  } else {
    switch (cmd) {
      case BLE_GENERAL_CMDS.LORA_ACTIVE:
        if (modelDeviceLorawan.module == LORAWAN_CONSTANTS.MODULE_RAK) {
          if (frame[2] != LORAWAN_CONSTANTS.RAK_STATUS_OK) {
            log += _checkRakStatus(frame[2], frame.sublist(3));
            isResponseOk = false;
            if (frame[2] == LORAWAN_CONSTANTS.RAK_BUG)
              cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG;
          } else {
            modelDeviceLorawan.connectionMode =
                LORAWAN_CONSTANTS.MODE_ACTIVATION[frame[3]];
          }
        } else {
          modelDeviceLorawan.connectionMode =
              LORAWAN_CONSTANTS.MODE_ACTIVATION[frame[2]];
        }

        log +=
            'Mode: ${modelDeviceLorawan.connectionMode[0].toUpperCase() + modelDeviceLorawan.connectionMode.substring(1)}';
        break;

      case BLE_GENERAL_CMDS.GET_LORA_OTAA_PARAMS:
        modelDeviceLorawan.getDevEui =
            hexaToAscii(listIntLsbToMsb(frame.sublist(2, 10)));
        modelDeviceLorawan.getAppEui = hexaToAscii(frame.sublist(10, 18));
        modelDeviceLorawan.getAppKey = hexaToAscii(frame.sublist(18, 34));
        log +=
            'Dev Eui: ${modelDeviceLorawan.getDevEui}, App Eui: ${modelDeviceLorawan.getAppEui}, App Key: ${modelDeviceLorawan.getAppKey}';

        break;

      case BLE_GENERAL_CMDS.GET_LORA_ABP_PARAMS:
        modelDeviceLorawan.getDeviceAddress = hexaToAscii(
            modelDeviceLorawan.module == LORAWAN_CONSTANTS.MODULE_IMST
                ? listIntLsbToMsb(frame.sublist(2, 6))
                : frame.sublist(2, 6));
        modelDeviceLorawan.getNwsKey = hexaToAscii(frame.sublist(6, 22));
        modelDeviceLorawan.getAppsKey = hexaToAscii(frame.sublist(22, 38));
        log +=
            'Device address: ${modelDeviceLorawan.getDeviceAddress}, Network session key: ${modelDeviceLorawan.getNwsKey}, App session key: ${modelDeviceLorawan.getAppsKey}';
        break;

      case BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK:
      case BLE_GENERAL_CMDS.SET_LORA_SUB_BANDS:
      case BLE_GENERAL_CMDS.SET_LORA_DATA_RATE:
      case BLE_GENERAL_CMDS.SET_LORA_TX_POWER:
      case BLE_GENERAL_CMDS.SET_LORA_CLASS:
      case BLE_GENERAL_CMDS.SET_LORA_BAND:
      case BLE_GENERAL_CMDS.JOIN_OTAA:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        if (modelDeviceLorawan.module == LORAWAN_CONSTANTS.MODULE_RAK) {
          log += ', ' + _checkRakStatus(frame[2], frame.sublist(3));

          // Specific for JOIN OTAA
          if (cmd == BLE_GENERAL_CMDS.JOIN_OTAA) {
            modelDeviceLorawan.isTryJoin = false;
          }

          if (frame[2] != LORAWAN_CONSTANTS.RAK_STATUS_OK) {
            isResponseOk = false;
            if (frame[2] == LORAWAN_CONSTANTS.RAK_BUG)
              cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG;
          }

          // Automatic Config for RAK
          if (Get.find<LorawanTabController>().isAutomaticConfig) {
            if (frame[2] == LORAWAN_CONSTANTS.RAK_STATUS_OK) {
              switch (cmd) {
                case BLE_GENERAL_CMDS.SET_LORA_BAND:
                  Get.find<LorawanTabController>().automaticConfig(1);
                  break;
                case BLE_GENERAL_CMDS.SET_LORA_SUB_BANDS:
                  Get.find<LorawanTabController>().automaticConfig(2);
                  break;
                case BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK:
                  Get.find<LorawanTabController>().automaticConfig(3);
                  break;
                case BLE_GENERAL_CMDS.SET_LORA_DATA_RATE:
                  Get.find<LorawanTabController>().automaticConfig(4);
                  break;
                case BLE_GENERAL_CMDS.SET_LORA_TX_POWER:
                  Get.find<LorawanTabController>().automaticConfig(5);
                  break;
                case BLE_GENERAL_CMDS.SET_LORA_CLASS:
                  Get.find<LorawanTabController>().automaticConfig(8);
                  break;

                default:
              }
            } else if (frame[2] != LORAWAN_CONSTANTS.RAK_BUG)
              Get.find<LorawanTabController>().resetAutomaticConfig(
                  msg:
                      '¡Ups!, el RAK no logro la configuración automática del último comando (Consola), ¿Vamos nuevamente?');
          }
        }
        break;

      case BLE_GENERAL_CMDS.TX_LORA:
        int port = frame[2];
        bool checkPort = true;

        log += BLE_GENERAL_CONSTANTS.STATUS[status] + ', Port: $port';
        if (modelDeviceLorawan.module == LORAWAN_CONSTANTS.MODULE_RAK) {
          log += ', ' + _checkRakStatus(frame[3], frame.sublist(4));
          if (frame[3] != LORAWAN_CONSTANTS.RAK_STATUS_OK) {
            checkPort = false;
            isResponseOk = false;
            if (frame[3] == LORAWAN_CONSTANTS.RAK_BUG)
              cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG;
          }
        }

        // Test TX Lora
        if (port == 12 &&
            checkPort &&
            modelDeviceLorawan.tryGetNetworkCoverage) {
          modelDeviceLorawan.currentStepGetNetworkCoverage = 1;
          modelDeviceLorawan.timerTestTx.cancel();
          Get.find<LorawanTabController>().getNetworkCoverage();
        }

        break;

      case BLE_GENERAL_CMDS.TEST_TX_LORA:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case BLE_GENERAL_CMDS.SET_LORA_ADR:
      case BLE_GENERAL_CMDS.SET_LORA_DUTY_CYCLE:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        if (frame[2] != LORAWAN_CONSTANTS.RAK_STATUS_OK) {
          log += ', ' + _checkRakStatus(frame[2], frame.sublist(3));
          isResponseOk = false;
          if (frame[2] == LORAWAN_CONSTANTS.RAK_BUG)
            cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG;
        } else {
          switch (cmd) {
            case BLE_GENERAL_CMDS.SET_LORA_ADR:
              modelDeviceLorawan.setAdr = frame[3] == 0x01 ? true : false;
              break;

            case BLE_GENERAL_CMDS.SET_LORA_DUTY_CYCLE:
              modelDeviceLorawan.setDutyCycle = frame[3] == 0x01 ? true : false;
              break;
          }

          log += ', ' +
              BLE_GENERAL_CONSTANTS.CONFIGURED[frame[3]][0].toUpperCase() +
              BLE_GENERAL_CONSTANTS.CONFIGURED[frame[3]].substring(1);
        }

        // Automatic Config for RAK
        if (Get.find<LorawanTabController>().isAutomaticConfig) {
          if (frame[2] == LORAWAN_CONSTANTS.RAK_STATUS_OK) {
            switch (cmd) {
              case BLE_GENERAL_CMDS.SET_LORA_ADR:
                Get.find<LorawanTabController>().automaticConfig(6);
                break;
              case BLE_GENERAL_CMDS.SET_LORA_DUTY_CYCLE:
                Get.find<LorawanTabController>().automaticConfig(7);
                break;
              default:
            }
          } else if (frame[2] != LORAWAN_CONSTANTS.RAK_BUG)
            Get.find<LorawanTabController>().resetAutomaticConfig(
                msg:
                    '¡Ups!, el RAK no logro la configuración automática del último comando (Consola), ¿Vamos nuevamente?');
        }
        break;

      case BLE_GENERAL_CMDS.GET_CONNECTION_MODE:
        modelDeviceLorawan.connectionMode =
            LORAWAN_CONSTANTS.MODE_ACTIVATION.containsKey(frame[2])
                ? LORAWAN_CONSTANTS.MODE_ACTIVATION[frame[2]]
                : 'Error';
        log += modelDeviceLorawan.connectionMode;
        break;

      case BLE_GENERAL_CMDS.SET_LORA_OPERATION_MODE:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];

        break;

      case BLE_GENERAL_CMDS.GET_LORA_HARDWARE:
        if (LORAWAN_CONSTANTS.MODULE_MAP.containsKey(frame[2])) {
          modelDeviceLorawan.module = frame[2];
          String module = LORAWAN_CONSTANTS.MODULE_MAP.containsKey(frame[2])
              ? LORAWAN_CONSTANTS.MODULE_MAP[frame[2]]
              : 'Error';
          log += module;
        } else
          log += 'Unknown';
        break;

      case BLE_GENERAL_CMDS.GET_LORA_RAK_INFO_OR_RADIOSTACK:
        if (modelDeviceLorawan.module == LORAWAN_CONSTANTS.MODULE_RAK) {
          if (frame[2] != LORAWAN_CONSTANTS.RAK_STATUS_OK) {
            log += _checkRakStatus(frame[2], frame.sublist(3));
            isResponseOk = false;
            if (frame[2] == LORAWAN_CONSTANTS.RAK_BUG)
              cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG;
          } else {
            List<String> split =
                String.fromCharCodes(frame.sublist(3)).split(':');
            String property = split[0];

            // Remove spaces
            String value = split[1].replaceAll(' ', '');

            // Avoid multiple snackbar
            showSnackBar = false;

            switch (property) {
              case 'DevEui':
                modelDeviceLorawan.getDevEui = value;
                log += 'Dev Eui: $value';
                break;

              case 'AppEui':
                modelDeviceLorawan.getAppEui = value;
                log += 'App Eui: $value';
                break;

              case 'AppKey':
                modelDeviceLorawan.getAppKey = value;
                log += 'App Key: $value';
                break;

              case 'DevAddr':
                modelDeviceLorawan.getDeviceAddress = value;
                log += 'Device Address: $value';
                break;

              case 'AppsKey':
                modelDeviceLorawan.getAppsKey = value;
                log += 'App session key: $value';
                break;

              case 'NwksKey':
                modelDeviceLorawan.getNwsKey = value;
                log += 'Network session key: $value';
                break;

              case 'Join_mode':
                modelDeviceLorawan.connectionMode = value;
                log += 'Join mode: $value';
                break;

              case 'Current Datarate':
                try {
                  modelDeviceLorawan.getSpreadingFactor =
                      LORAWAN_CONSTANTS.SPREADING_FACTOR[int.parse(value)];
                } catch (e) {
                  modelDeviceLorawan.getSpreadingFactor = 'unknown';
                }
                log += 'Datarate: ${modelDeviceLorawan.getSpreadingFactor}';

                break;

              case 'ChannelsTxPower':
                int txPower = int.parse(value);
                String txPowerStr;
                if (txPower >= 0 && txPower <= 4)
                  txPowerStr = '20';
                else
                  txPowerStr =
                      (LORAWAN_CONSTANTS.RAK_MAX_EIRP - 2 * txPower).toString();
                modelDeviceLorawan.getPotency = txPowerStr;
                log += 'Tx power (dbm): $txPowerStr';
                break;

              case 'AdrEnable':
                modelDeviceLorawan.getAdr =
                    (value == 'true' || value == 'false')
                        ? value == 'true'
                            ? BLE_GENERAL_CONSTANTS.CONFIGURED[1]
                            : BLE_GENERAL_CONSTANTS.CONFIGURED[0]
                        : 'unknown';

                // update switch in set view
                modelDeviceLorawan.setAdr = value == 'true' ? true : false;
                log += 'Adr: ${modelDeviceLorawan.getAdr}';
                break;

              case 'Class':
                modelDeviceLorawan.getClass = value;
                log += 'Class: $value';
                break;

              case 'Region':
                modelDeviceLorawan.getBand = value;
                log += 'Region: $value';
                break;

              case 'Send_repeat_cnt':
                modelDeviceLorawan.getRetransmissions = value;
                log += 'Retransmissions: $value';
                break;

              case 'Joined Network':
                modelDeviceLorawan.joinedNetwork =
                    (value == 'true' || value == 'false')
                        ? value == 'true'
                            ? 'yes'
                            : 'no'
                        : 'unknown';
                log += 'Joined Network?: ${modelDeviceLorawan.joinedNetwork}';
                break;

              default:
                // Asumiendo que esta propiedad siempre será la última en llegar
                if (property == 'DownLinkCounter') showSnackBar = true;
                log += 'Extra property - $property: $value';
            }
          }
        } else {
          if (frame[2] != LORAWAN_CONSTANTS.IMST_STATUS_OK) {
            log += LORAWAN_CONSTANTS.IMST_STATUS[frame[2]];
            isResponseOk = false;
          } else {
            List<int> radiostack = frame.sublist(2);

            modelDeviceLorawan.getSpreadingFactor = getMapValueByKey(
                LORAWAN_CONSTANTS.SPREADING_FACTOR, radiostack[1], 'unknown');

            modelDeviceLorawan.getPotency = radiostack[2].toString();

            modelDeviceLorawan.getAdr = getMapValueByKey(
                BLE_GENERAL_CONSTANTS.CONFIGURED,
                radiostack[3] & 0x01,
                'unknown');

            modelDeviceLorawan.getDutyCycle = BLE_GENERAL_CONSTANTS.CONFIGURED
                    .containsKey((radiostack[3] >> 1) & 0x01)
                ? BLE_GENERAL_CONSTANTS.CONFIGURED[(radiostack[3] >> 1) & 0x01]
                : 'unknown';
            modelDeviceLorawan.getClass = LORAWAN_CONSTANTS.IMST_CLASS
                    .containsKey((radiostack[3] >> 2) & 0x01)
                ? LORAWAN_CONSTANTS.IMST_CLASS[(radiostack[3] >> 2) & 0x01]
                : 'unknown';
            modelDeviceLorawan.getRetransmissions = radiostack[5].toString();
            modelDeviceLorawan.getBand =
                LORAWAN_CONSTANTS.IMST_BAND_INDEX.containsKey(radiostack[6])
                    ? LORAWAN_CONSTANTS.IMST_BAND_INDEX[radiostack[6]]
                    : 'unknown';
            modelDeviceLorawan.getSubBand1 =
                LORAWAN_CONSTANTS.AU915_SUB_BAND_1.containsKey(radiostack[8])
                    ? LORAWAN_CONSTANTS.AU915_SUB_BAND_1[radiostack[8]]
                    : 'unknown';

            modelDeviceLorawan.getSubBand2 =
                LORAWAN_CONSTANTS.AU915_SUB_BAND_2.containsKey(radiostack[9])
                    ? LORAWAN_CONSTANTS.AU915_SUB_BAND_2[radiostack[9]]
                    : 'unknown';
          }
        }

        break;

      case BLE_GENERAL_CMDS.GET_LORA_SUB_BANDS:
        if (frame[2] != LORAWAN_CONSTANTS.RAK_STATUS_OK) {
          log += _checkRakStatus(frame[2], frame.sublist(3));
          isResponseOk = false;
          if (frame[2] == LORAWAN_CONSTANTS.RAK_BUG)
            cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG;
        } else {
          bool channelOpen = String.fromCharCode(frame[3]) == '*';
          String channelStr = String.fromCharCodes(frame.sublist(4, 6));
          int channel = int.parse(channelStr);
          bool channelEnabled = frame[6] == 1;

          if (channelOpen) {
            // Sub-band 1
            if (channel >= 0 && channel <= 63) {
              int mask = _getSubBandMask(
                  int.parse((channel / 8.0).toStringAsFixed(2).split('.')[0]));
              modelDeviceLorawan.getSubBand1 =
                  LORAWAN_CONSTANTS.AU915_SUB_BAND_1.containsKey(mask)
                      ? LORAWAN_CONSTANTS.AU915_SUB_BAND_1[mask]
                      : 'unknown';
            }
            // Sub-band 2
            else {
              int mask = _getSubBandMask(channel - 64);
              modelDeviceLorawan.getSubBand2 =
                  LORAWAN_CONSTANTS.AU915_SUB_BAND_2.containsKey(mask)
                      ? LORAWAN_CONSTANTS.AU915_SUB_BAND_2[mask]
                      : 'unknown';
            }
          }

          log +=
              'RAK Channel: $channelStr, ${channelOpen ? 'Open' : 'Close'}, ${channelEnabled ? 'Enabled' : 'Disabled'}';
        }

        break;

      case BLE_GENERAL_CMDS.GET_LORA_DUTY_CYCLE:
        modelDeviceLorawan.getDutyCycle =
            BLE_GENERAL_CONSTANTS.CONFIGURED.containsKey(frame[2])
                ? BLE_GENERAL_CONSTANTS.CONFIGURED[frame[2]]
                : 'unknown';

        // update switch in set view
        modelDeviceLorawan.setDutyCycle = frame[2] == 1 ? true : false;
        log += modelDeviceLorawan.getDutyCycle;
        break;

      case BLE_GENERAL_CMDS.GET_LORA_OPERATION_MODE:
        if (frame[2] != LORAWAN_CONSTANTS.IMST_STATUS_OK) {
          log += LORAWAN_CONSTANTS.IMST_STATUS[frame[2]];
          isResponseOk = false;
        } else {
          modelDeviceLorawan.getOperationMode =
              LORAWAN_CONSTANTS.OPERATION_MODE.containsKey(frame[3])
                  ? LORAWAN_CONSTANTS.OPERATION_MODE[frame[3]]
                  : 'Error';
          log += modelDeviceLorawan.getOperationMode;
        }
        break;

      default:
        log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
        cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
    }
  }

  return ModelLogConsole(
      cmd: cmd,
      log: log,
      isResponseOk: isResponseOk,
      cmdError: cmdError,
      showSnackBar: showSnackBar);
}

String _checkRakStatus(int state, List<int> code) {
  String rakError = state == LORAWAN_CONSTANTS.RAK_ERROR
      ? ': ${LORAWAN_CONSTANTS.RAK_ERROR_CODE[String.fromCharCodes(code)]}'
      : '';
  return LORAWAN_CONSTANTS.RAK_STATUS[state] + rakError;
}

int _getSubBandMask(int bit) {
  return 0x01 << bit;
}
