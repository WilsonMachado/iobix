// ignore: camel_case_types
import './vantage_logger_commands.dart';

// ignore: camel_case_types
class VANTAGE_LOGGER_CONSTANTS_V2 {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.5;
  static const NOMINAL_BATTERY_MAX = 4.2;
  static const NOMINAL_BATTERY_MIN = 3.4;
  static const VOLTAGE_REFERENCE = 3.0;
  static const ADC_VPANEL_PARAM = 12.0;
  static const ADC_VAUX_PARAM = 4.0;

  static const Map<int, String> CONSOLE = {
    VANTAGE_LOGGER_CMDS_V2.DATA_REPORT: 'Vantage Logger data'
  };

  static const Map<int, String> SNACKBAR_REQ_TYPE = {};

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'rain_gauge_alarm'
  };
}

// ignore: camel_case_types
class VANTAGE_LOGGER_CONSTANTS_V3 {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 2.0;
  static const NOMINAL_BATTERY_MAX = 4.2;
  static const NOMINAL_BATTERY_MIN = 3.0;
  static const VOLTAGE_REFERENCE = 3.0;
  static const ADC_VPANEL_PARAM = 12.8181;
  static const ADC_VAUX_PARAM = 12.8181;
  //TODO: Verificar si es necesario usar la constante del NTC para el reporte de salud del dispositivo (temperatura interna del device)

  static const Map<int, String> CONSOLE = {
    //VANTAGE_LOGGER_CMDS_V3.DATA_REPORT: 'Vantage Logger data'
    VANTAGE_LOGGER_CMDS_V3.GET_PERIODIC_MEASURE:
        'Getting instantaneous measurement', // 0xF0
    VANTAGE_LOGGER_CMDS_V3.GET_CURRENT_CONFIGURATIONS:
        'Getting Current Configurations', // 0xF0
    VANTAGE_LOGGER_CMDS_V3.SET_RS485_DEVICES: 'Setting RS485 devices', // 0xF2
    VANTAGE_LOGGER_CMDS_V3.SET_SPECIFIC_SENSOR_POWER_BEHAVIOUR:
        'Setting specific sensor power behaviour', //0xF3
    VANTAGE_LOGGER_CMDS_V3.GET_SENSOR_POWER_BEHAVIOUR:
        'Getting sensors power behaviour', // 0xF4
    VANTAGE_LOGGER_CMDS_V3.SET_SENSOR_RS485_MISMATCH:
        'Setting Sensors RS485 mismatch', // 0xF5
    VANTAGE_LOGGER_CMDS_V3.GET_DAVIS_STATS_DATA:
        'Getting Davis stats data', // 0xF6
    VANTAGE_LOGGER_CMDS_V3.GET_AIR_Q_STATS_DATA:
        'Getting air quality sensor stats data', // 0xF7
    VANTAGE_LOGGER_CMDS_V3.GET_RS485_STATS_DATA:
        'Getting RS485 sensors stats data', // 0xF8
    VANTAGE_LOGGER_CMDS_V3.SET_HOUR_TO_CLEAN_FAN:
        'Setting hours to clean FAN', // 0xFA
    VANTAGE_LOGGER_CMDS_V3.CLEAN_FAN: 'Cleaning FAN', // 0xFB
  };

  static const Map<int, String> RS485_SENSOR_MAP = {
    1: 'Sensor de ruido Rika',
    2: 'Sensor de ruido GEMHO',
    3: 'Sensor de ruido PR300',
    4: 'Sensor de ruido Renke',
  };

  static const Map<int, String> SENSOR_TYPE_MAP = {
    1: 'Estación Davis',
    2: 'Sensor de calidad de aire',
    3: 'Sensor de ruido',
  };

  static const Map<int, String> SENSOR_ENERGY_OPTIONS_MAP = {
    1: 'Energizado durante la medición',
    2: 'Energizado permanentemente',
  };

  static const Map<int, String> SNACKBAR_REQ_TYPE = {};

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'rain_gauge_alarm'
  };
}
