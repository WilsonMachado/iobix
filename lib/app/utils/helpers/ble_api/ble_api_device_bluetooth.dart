import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/ble_general_commands.dart';
import '../../../data/models/local/model_log_console.dart';

ModelLogConsole bleApiDeviceBluetooth(List<int> frame) {
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
      case BLE_GENERAL_CMDS.SET_DEVICE_NAME:
      case BLE_GENERAL_CMDS.PASSWORD_API:
      case BLE_GENERAL_CMDS.SET_PASSWORD_API:
      case BLE_GENERAL_CMDS.SET_ADMIN_PASSWORD_API:
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
