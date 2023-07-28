import 'dart:typed_data';

import 'package:iobix/app/data/models/local/model_iris_logger.dart';
import 'package:iobix/app/data/models/local/model_log_console.dart';
import 'package:iobix/app/utils/constants/ble_api/ble_general_constants.dart';
import 'package:iobix/app/utils/constants/ble_api/iris_logger/iris_logger_commands.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

ModelLogConsole bleApiIrisLogger(
    List<int> frame, ModelIrisLogger modelIrisLogger) {
  final int cmd = frame[0], status = frame[1];

  int ptr = 2, cmdError = 0x00;
  String log = '';
  bool isResponseOk = true;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    switch (cmd) {
      case IRIS_LOGGER_CMDS.DATA_REPORT:
        if (frame[ptr] != 0x00) {
          modelIrisLogger.communicationStatus = 'Error';
          log += ' Ocurrió un error al intentar leer la estación iRIS';
        } else {
          modelIrisLogger.communicationStatus = 'Ok';
          ptr += 1;
          //! Variables current

          modelIrisLogger.tempCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.wsCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.wdCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.humCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.pressCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.rainMP600Current =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.evaporationCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.rainCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.batteryCurrent =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          //! Variables logged

          modelIrisLogger.tempLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.wsLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.wdLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.humLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.pressLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.rainMP600Logged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.evaporationLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.rainLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          modelIrisLogger.batteryLogged =
              _listToFloat32(frame.sublist(ptr, ptr + 4));
          ptr += 4;

          log += ' Ok';
        }
        break;
    }
  }
  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}

double _listToFloat32(List<int> subList) {
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, listBytesToInt(subList));

  return double.parse(byteData.getFloat32(0).toStringAsFixed(2));
}
