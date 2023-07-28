// ignore: camel_case_types
class MATRIC_POTENTIAL_CMDS {
  static const RANGE_MIN = 0xF0;
  static const RANGE_MAX = 0xFC;

  static const DATA_REPORT = 0xF0;
  static const RESISTANCE_CALIBRATION = 0xF1;
  static const GET_IRRIGATION_PARAMS = 0xF2;
  static const CONFIG_DIGITAL_TEMP_SENSOR = 0xF2;
  static const SET_IRRIGATION_STATUS = 0xF3;
  static const SET_RTC_OFFSET = 0xF3;
  static const SET_IRRIGATION_TIME = 0xF4;
  static const SET_RTC_CLKOUT = 0xF4;
  static const GET_RTC_CONFIG = 0xF5; // Para el 0431
  static const SET_IRRIGATION_WAIT_TIME = 0xF5; // Para el 0401
  static const START_IRRIGATION_MANUAL = 0xF5; // Para el 0404
  static const SET_PV_TO_START_IRRIGATION = 0xF6;
  static const SET_PV_TO_STOP_IRRIGATION = 0xF7;
  static const SET_GEMHO_SOIL_SENSOR = 0xF7; // Para el 0404
  static const SET_ELECTROVALVE_CONTROL = 0xF8;
  static const GET_DATA_FROM_GEMHO_SOIL_SENSOR = 0xF8; // Para el 0404
  static const SET_GM_IRRIGATION_CONTROL = 0xF9;
  static const GET_IRRIGATION_CYCLE_STATUS = 0xFA;
  static const SET_RTC_CALIBRATION_DATA = 0xFB;
  static const GET_RTC_CALIBRATION_DATA = 0xFC;
}
