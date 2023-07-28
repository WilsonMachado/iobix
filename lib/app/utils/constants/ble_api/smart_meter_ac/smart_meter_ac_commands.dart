// ignore: camel_case_types
class SMART_METER_AC_CMDS {
  static const RANGE_MIN = 0xF0;
  static const RANGE_MAX = 0xFA;

  static const WRITE_REGISTER = 0xF0;
  static const WRITE_PARAMETER = 0xF1;
  static const GET_PARAMETER = 0xF2;
  static const DATA_REPORT = 0xF3;
  static const SET_CALIB_STATUS_REG = 0xF4;
  static const ENERGY_DATA_REPORT = 0xF5;
  static const RESET_ENERGY_ACCUMULATION = 0xF6;
  static const POWER_REPORT = 0xF7;
  static const DEBUG_READ = 0xF8;
  static const GET_CALIB_STATUS_REG = 0xF9;
  static const GET_RMS_REG = 0xFA;
}
