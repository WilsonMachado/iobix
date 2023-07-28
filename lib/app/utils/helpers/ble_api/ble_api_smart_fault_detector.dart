import 'package:iobix/app/data/models/local/model_log_console.dart';
import 'package:iobix/app/data/models/local/model_smart_fault_detector.dart';
import 'package:iobix/app/utils/constants/ble_api/ble_general_constants.dart';
import 'package:iobix/app/utils/constants/ble_api/smart_fault_detector/smart_fault_detector_commands.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

ModelLogConsole bleApiSmartFaultDetector(
    List<int> frame, ModelSmartFaultDetector modelSmartFaultDetector) {
  final int cmd = frame[0], status = frame[1];
  String log = '';
  bool isResponseOk = true;
  int cmdError = 0x00;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    int ptr = 2;
    if (modelSmartFaultDetector.deviceVersion == 1.0) {
      switch (cmd) {
        case SMART_FAULT_DETECTOR_CMDS.DATA_REPORT:
          modelSmartFaultDetector.permanentFault =
              frame[ptr]; //! Falla permanente?
          ptr += 1;

          modelSmartFaultDetector.transitoryFault =
              frame[ptr]; //! Falla Transitoria?
          ptr += 1;

          modelSmartFaultDetector.getTicksToDetonatePermanentAlarm =
              frame[ptr]; //! Ticks que detonan la falla permanente
          ptr += 1;

          modelSmartFaultDetector.getTicksToDetonateTransitoryAlarm =
              frame[ptr]; //! Ticks que detonan la falla transitoria
          ptr += 1;

          modelSmartFaultDetector.isTimeReportChangingInAlarmMode = frame[
              ptr]; //! Se reconfigura el tiempo de transmisión en estado de alarma?
          ptr += 1;

          modelSmartFaultDetector.getTimeToReportFault = listBytesToInt(
              frame.sublist(
                  ptr,
                  ptr +
                      4)); //! Reconfiguración de tiempo de transmisión en estado de alarma
          ptr += 4;

          modelSmartFaultDetector.getTimeToFaultTimeOut =
              frame[ptr]; //! Timeout de falla para el clear
          log += ' Ok';
          break;

        case SMART_FAULT_DETECTOR_CMDS.SET_TICKS_PERMANENT_ALARM:
          modelSmartFaultDetector.getTicksToDetonatePermanentAlarm = frame[ptr];
          log += ' Ok';
          break;

        case SMART_FAULT_DETECTOR_CMDS.SET_TICKS_TRANSITORY_ALARM:
          modelSmartFaultDetector.getTicksToDetonateTransitoryAlarm =
              frame[ptr];
          log += ' Ok';
          break;

        case SMART_FAULT_DETECTOR_CMDS.SET_TIME_REPORT_CHANGING_IN_ALARM_MODE:
          modelSmartFaultDetector.isTimeReportChangingInAlarmMode = frame[ptr];
          log += ' Ok';
          break;

        case SMART_FAULT_DETECTOR_CMDS.SET_TIME_TO_REPORT_FAULT:
          modelSmartFaultDetector.getTimeToReportFault =
              listBytesToInt(frame.sublist(ptr, ptr + 4));
          log += ' Ok';
          break;

        case SMART_FAULT_DETECTOR_CMDS.TIME_TO_FAULT_TIME_OUT:
          modelSmartFaultDetector.getTimeToFaultTimeOut = frame[ptr];
          log += ' Ok';
          break;

        case SMART_FAULT_DETECTOR_CMDS.CLEAR_ALARMS:
          modelSmartFaultDetector.permanentFault =
              frame[ptr]; //! Falla permanente?
          ptr += 1;
          log += ' Ok';
          modelSmartFaultDetector.transitoryFault =
              frame[ptr]; //! Falla Transitoria?
          log += ' Ok';
          break;

        default:
          break;
      }
    }
  }
  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}
