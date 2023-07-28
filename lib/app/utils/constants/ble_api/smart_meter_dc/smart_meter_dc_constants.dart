import './smart_meter_dc_commands.dart';

// ignore: camel_case_types
class SMART_METER_DC_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.5;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 2.7;
  static const VOLTAGE_REFERENCE = 2.5;
  static const ADC_DCDC_PARAM = 0.003065843;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> CONSOLE = {
    SMART_METER_DC_CMDS.DATA_REPORT: 'Get Smart Meter DC Data',
    SMART_METER_DC_CMDS.GET_ALARM_PARAMETERS: 'Get Alarm Parameters',
    SMART_METER_DC_CMDS.SET_ALARM_PARAMETERS: 'Set Alarm Parameters',
    SMART_METER_DC_CMDS.SET_CURRENT_RANGE: 'Set Current Range'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'Configuración de parámetros para alarmas de nivel DC'
  };
}

// ignore: camel_case_types
class SMART_METER_DC_CONSTANTS_V3 {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.75;
  static const NOMINAL_BATTERY_MAX = 4.2;
  static const NOMINAL_BATTERY_MIN = 3.0;
  static const VOLTAGE_REFERENCE = 2.5;
  static const ADC_DCDC_PARAM = 0.003065843;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> CONSOLE = {
    SMART_METER_DC_CMDS.DATA_REPORT: 'Get Smart Meter DC Data',
    SMART_METER_DC_CMDS.GET_ALARM_PARAMETERS: 'Get Alarm Parameters',
    SMART_METER_DC_CMDS.SET_ALARM_PARAMETERS: 'Set Alarm Parameters',
    SMART_METER_DC_CMDS.SET_CURRENT_RANGE: 'Set Current Range'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'Configuración de parámetros para alarmas de nivel DC'
  };
}
