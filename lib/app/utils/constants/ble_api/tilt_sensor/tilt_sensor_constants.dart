
import 'package:iobix/app/utils/constants/ble_api/tilt_sensor/tilt_sensor_commands.dart';
// ignore: camel_case_types
class TILT_SENSOR_CONSTANTS {
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
    TILT_SENSOR_CMDS.DATA_REPORT: 'Getting data report',
    TILT_SENSOR_CMDS.ALARM_CONFIG: 'Setting alarm configuration',
    TILT_SENSOR_CMDS.ALARM_TRANSMITION_PERIOD_CONFIG: 'Setting alarm transmition period',
    TILT_SENSOR_CMDS.ALARM_MODE_CONFIG: 'Setting alarm mode',
  };
 
  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'alarm_temperature_config'
  };
}