import './logger_rs485_commands.dart';

//ignore: camel_case_types
class LOGGER_RS485_CONSTANTS {
  static const ADC_RESOLUTION = 4095; //  Resolución del ADC 12 bits
  static const ADC_BATTERY_PARAM =
      2.0; // Factor de medición de voltaje de batería
  static const NOMINAL_BATTERY_MAX = 4.2; // Valor nominal de batería máximo
  static const NOMINAL_BATTERY_MIN = 3.0; // Valor nominal de bateria mínimo
  static const VOLTAGE_REFERENCE = 2.5; // Referencia de medición de batería
  static const ADC_VPANEL_PARAM = 9.67; // Factor de medición del panel solar
  static const VPANEL_VOLTAGE_REFERENCE =
      2.5; // Referencia de medición del panel solar
  static const ADC_VAUX_PARAM = 6.09;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> CONSOLE = {
    LOGGER_RS485_CMDS.DATA_REPORT: "Getting data report",
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {};
}
