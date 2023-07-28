import './temperature_logger_commands.dart';

// ignore: camel_case_types
class TEMPERATURE_LOGGER_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 1.5;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 2.7;
  static const VOLTAGE_REFERENCE = 2.5;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const I2C_NOT_SENSOR = 0x00;
  static const I2C_BME280_SENSOR = 0x01;
  static const I2C_SHT31_SENSOR = 0x02;
  static const Map<int, String> I2C_SENSOR_MAP = {
    I2C_NOT_SENSOR: 'None',
    I2C_BME280_SENSOR: 'BME280',
    I2C_SHT31_SENSOR: 'SHT31',
  };

  static const Map<int, String> ABP_SENSOR_STATUS = {
    0: 'Ok',
    1: 'Modo de comando',
    2: 'Stale data',
    3: 'Condición de diagnóstico'
  };

  static const Map<int, String> CONSOLE = {
    TEMPERATURE_LOGGER_CMDS.DATA_REPORT: 'Temperature Logger data',
    TEMPERATURE_LOGGER_CMDS.GET_ALARM_PARAMETERS: 'Get alarm parameters',
    TEMPERATURE_LOGGER_CMDS.SET_ALARM_PARAMETERS: 'Set alarm parameters',
    TEMPERATURE_LOGGER_CMDS.SET_I2C_SENSOR: 'Set i2c sensor'
  };

  static const Map<int, String> SNACKBAR_REQ_TYPE = {
    TEMPERATURE_LOGGER_CMDS.GET_ALARM_PARAMETERS:
        'snackbar_get_temp_alarm_param',
    TEMPERATURE_LOGGER_CMDS.SET_ALARM_PARAMETERS:
        'snackbar_set_temp_alarm_param',
    TEMPERATURE_LOGGER_CMDS.SET_I2C_SENSOR: 'snackbar_set_digital_sensor'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'alarm_temperature_config'
  };
}
