import '../../../data/models/local/model_device_information.dart';
import '../../constants/ble_api/ble_general_commands.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../helpers.dart';

ModelLogConsole bleApiDeviceInformation(
    List<int> frame, ModelDeviceInformation modelDeviceInformation) {
  final int cmd = frame[0], status = frame[1];
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    switch (cmd) {
      case BLE_GENERAL_CMDS.DEVELOPER:
        modelDeviceInformation.developer =
            String.fromCharCodes(frame.sublist(2));
        log += modelDeviceInformation.developer;
        break;

      case BLE_GENERAL_CMDS.DEVICE_INFO:
        modelDeviceInformation.info = String.fromCharCodes(frame.sublist(2));
        log += modelDeviceInformation.info;
        break;

      case BLE_GENERAL_CMDS.FIRMWARE_VERSION:
        modelDeviceInformation.firmware =
            'v${(frame[2] & 0x0F).toString()}.${((frame[3] & 0xF0) >> 4 ).toString()}.${(frame[3] & 0x0F).toString()}';
        log += modelDeviceInformation.firmware;
        break;

      case BLE_GENERAL_CMDS.GET_HARDWARE_ID:
        modelDeviceInformation.getId = hexaToAscii(frame.sublist(2));
        log += modelDeviceInformation.getId;
        break;

      case BLE_GENERAL_CMDS.SET_HARDWARE_ID:
        log += BLE_GENERAL_CONSTANTS.STATUS[status];
        break;

      case BLE_GENERAL_CMDS.API_BLE_VERSION:
        modelDeviceInformation.apiBleVersion =
            'v${(frame[2] & 0x0F).toString()}.${((frame[3] & 0xF0) >> 4 ).toString()}.${(frame[3] & 0x0F).toString()}';
        log += modelDeviceInformation.apiBleVersion;
        break;

      default:
        log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
        cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
    }
  }

  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}
