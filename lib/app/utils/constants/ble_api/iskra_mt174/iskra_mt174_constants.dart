import './iskra_mt174_commands.dart';

// ignore: camel_case_types
class ISKRA_MT174_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.5;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 2.7;
  static const VOLTAGE_REFERENCE = 2.5;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> CONSOLE = {
    ISKRA_MT174_CMDS.DATA_REPORT: 'Data report',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const ACTIVE_ENERGY_PAYLOAD = 0x01;
  static const REACTIVE_ENERGY_PAYLOAD = 0x02;
  static const ELECTRICITY_NETWORK_QUALITY_PAYLOAD = 0x0A;
  static const MISCELLANEOUS_PAYLOAD = 0x0D;
}
