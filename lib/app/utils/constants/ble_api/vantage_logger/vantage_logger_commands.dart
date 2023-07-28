// ignore: camel_case_types
class VANTAGE_LOGGER_CMDS_V2 {
  static const RANGE_MIN = 0xF0;
  static const RANGE_MAX = 0xF0;

  static const DATA_REPORT = 0xF0;
}

// ignore: camel_case_types
class VANTAGE_LOGGER_CMDS_V3 {
  static const RANGE_MIN = 0xF0;
  static const RANGE_MAX = 0xFB;

  static const GET_PERIODIC_MEASURE = 0xF0;
  static const GET_CURRENT_CONFIGURATIONS = 0xF1;
  static const SET_RS485_DEVICES = 0xF2;
  static const SET_SPECIFIC_SENSOR_POWER_BEHAVIOUR = 0xF3;
  static const GET_SENSOR_POWER_BEHAVIOUR = 0xF4;
  static const SET_SENSOR_RS485_MISMATCH = 0xF5;
  static const GET_DAVIS_STATS_DATA = 0xF6;
  static const GET_AIR_Q_STATS_DATA = 0xF7;
  static const GET_RS485_STATS_DATA = 0xF8;
  static const SET_HOUR_TO_CLEAN_FAN = 0xFA;
  static const CLEAN_FAN = 0xFB;
}
