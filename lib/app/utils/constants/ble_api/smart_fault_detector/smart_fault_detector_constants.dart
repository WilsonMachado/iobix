import 'smart_fault_detector_commands.dart';

// ignore: camel_case_types
class SMART_FAULT_DETECTOR_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.5;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 2.7;
  static const VOLTAGE_REFERENCE = 2.5;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> ABP_SENSOR_STATUS = {
    0: 'Ok',
    1: 'Modo de comando',
    2: 'Stale data',
    3: 'Condición de diagnóstico'
  };

  static const Map<int, String> CONSOLE = {
    SMART_FAULT_DETECTOR_CMDS.DATA_REPORT: 'Getting data report',
    SMART_FAULT_DETECTOR_CMDS.SET_TICKS_PERMANENT_ALARM:
        'Setting ticks alarm permanent',
    SMART_FAULT_DETECTOR_CMDS.SET_TICKS_TRANSITORY_ALARM:
        'Setting ticks alarm transitory',
    SMART_FAULT_DETECTOR_CMDS.SET_TIME_REPORT_CHANGING_IN_ALARM_MODE:
        'Changing alarm mode',
    SMART_FAULT_DETECTOR_CMDS.SET_TIME_TO_REPORT_FAULT:
        'Setting time to report in fault state',
    SMART_FAULT_DETECTOR_CMDS.TIME_TO_FAULT_TIME_OUT:
        'Setting fault state timeout',
    SMART_FAULT_DETECTOR_CMDS.CLEAR_ALARMS: 'Clearing alarm states',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'alarm_temperature_config'
  };
}
