import './multipurpose_rs485_commands.dart';

// ignore: camel_case_types
class MULTIPURPOSE_RS485_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.5;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 2.7;
  static const VOLTAGE_REFERENCE = 2.5;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> RS485_DEVICES = {
    0x01: 'Sensor de Ruido (RIKA)',
    0x02: 'Sensor de Ruido (GEMHO)',
    0x04: 'Sensor de Amoníaco (GEMHO)',
    0x08: 'Sensor de Temp/Hum/Ilum (GEMHO)',
    0x10: 'Sensor de Suelo (GEMHO)',
    0x20: 'Estación del clima (HONDE)',
    0x40: 'Sensor de partículas (RENKE)',
    0x80: 'Sensor de ruido (RENKE)',
  };

  static const Map<int, String> CONSOLE = {
    MULTIPURPOSE_RS485_CMDS.DATA_REPORT: 'Data report',
    MULTIPURPOSE_RS485_CMDS.SET_DEVICES: 'Set devices',
    MULTIPURPOSE_RS485_CMDS.DATA_REPORT_PRESSURE_SCOUT:
        'Data report Pressure Scout',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };
}
