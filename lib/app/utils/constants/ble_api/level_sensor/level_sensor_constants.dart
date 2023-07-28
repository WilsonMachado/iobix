import './level_sensor_commands.dart';

//ignore: camel_case_types
class LEVEL_SENSOR_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const VOLTAGE_REFERENCE = 2.5;
  static const ADC_BATTERY_PARAM = 2.0;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 3.5;
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

  static const Map<int, String> GNSS_PERIODICITY_MAP = {
    0x00: 'Semanalmente',
    0x01: 'Mensualmente'
  };

  static const Map<int, String> CONSOLE = {
    LEVEL_SENSOR_CMDS.DATA_REPORT: 'Level sensor data',
    LEVEL_SENSOR_CMDS.GET_ALARM_PARAMETERS: 'Get alarm parameters',
    LEVEL_SENSOR_CMDS.SET_ALARM_PARAMETERS: 'Set alarm parameters',
    LEVEL_SENSOR_CMDS.SET_I2C_SENSOR: 'Set i2c sensor',
    LEVEL_SENSOR_CMDS.SET_GNSS_PERIODICITY: 'Set GNSS periodicity',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'Configuración de parámetros para alarmas de nivel'
  };
}
