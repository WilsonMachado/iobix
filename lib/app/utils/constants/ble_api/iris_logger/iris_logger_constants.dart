import 'package:iobix/app/utils/constants/ble_api/iris_logger/iris_logger_commands.dart';

//ignore: camel_case_types
class IRIS_LOGGER_CONSTANTS {
  
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 2.0;
  static const VOLTAGE_REFERENCE = 2.5;
  static const ADC_VPANEL_PARAM = 12.81;
  static const VPANEL_VOLTAGE_REFERENCE = 2.5;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const PRESSURE_STATUS_OK = 0x00;
  static const PRESSURE_STATUS_DISCONNECT = 0x04;
  static const PRESSURE_STATUS_SENSOR = {
    PRESSURE_STATUS_OK: 'Ok',
    1: 'Modo de comando',
    2: 'Stale data',
    3: 'Condición de diagnóstico',
    PRESSURE_STATUS_DISCONNECT: 'Desconectado'
  };

  static const Map<int, String> CONSOLE = {
    IRIS_LOGGER_CMDS.DATA_REPORT: 'Getting data report',
  };
  
}