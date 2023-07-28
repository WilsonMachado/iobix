// ignore: camel_case_types
class BLE_GENERAL_CMDS {
  static const INFORMATION_RANGE_MIN = 0x00;
  static const INFORMATION_RANGE_MAX = 0x0F;

  static const DEVELOPER = 0x00;
  static const DEVICE_INFO = 0x01;
  static const FIRMWARE_VERSION = 0x02;
  static const GET_HARDWARE_ID = 0x03;
  static const SET_HARDWARE_ID = 0x04;
  static const API_BLE_VERSION = 0x05;

  static const GENERAL_RANGE_MIN = 0x10;
  static const GENERAL_RANGE_MAX = 0x1F;

  static const MCU_RESET = 0x10;
  static const BUZZER = 0x11;
  static const LEDS = 0x12;
  static const ACELEROMETER = 0x13;
  static const GNSS = 0x14;
  static const MEASURE_TIME = 0x15;
  static const TX_TIME = 0x16;
  static const MAINTENANCE_MODE = 0x17;
  static const G_HEALTHY_REPORT = 0x18;
  static const SET_RTC = 0x19;
  static const CONFIRMED_MESSAGES = 0x1A;
  static const GPS_SYNC = 0x1B;
  static const SEND_TEST_DATA = 0x1C;
  static const DEBUG_MESSAGE = 0x1D;

  static const BLUETOOTH_RANGE_MIN = 0x20;
  static const BLUETOOTH_RANGE_MAX = 0x2F;

  static const TURN_OFF_BLE = 0x20;
  static const GET_DEVICE_NAME = 0x21;
  static const SET_DEVICE_NAME = 0x22;
  static const PASSWORD_API = 0x23;
  static const SET_PASSWORD_API = 0x24;
  static const SET_ADMIN_PASSWORD_API = 0x25;
  static const DISCONNECT_DEVICE = 0x26;

  static const MEMORY_RANGE_MIN = 0x30;
  static const MEMORY_RANGE_MAX = 0x3F;

  static const READ_LOGAPP = 0x30;
  static const READ_LOGSYS = 0x31;
  static const WRITE_LOGAPP = 0x32;
  static const WRITE_LOGSYS = 0x33;
  static const CLEAR_LOGAPP = 0x34;
  static const CLEAR_LOGSYS = 0x35;
  static const UNSUCESS_FINISH_READ = 0x36;
  static const SUCESS_FINISH_READ = 0x37;

  static const LORAWAN_RANGE_MIN = 0x40;
  static const LORAWAN_RANGE_MAX = 0x5F;

  static const LORA_ACTIVE = 0x40;
  static const GET_LORA_OTAA_PARAMS = 0x41;
  static const GET_LORA_ABP_PARAMS = 0x42;
  //  reserved 0x43;
  //  reserved 0x44;
  static const TX_LORA = 0x45;
  static const TEST_TX_LORA = 0x46;
  static const GET_LORA_HARDWARE = 0x47;
  static const GET_CONNECTION_MODE = 0x48;
  static const JOIN_OTAA = 0x49;
  static const SET_LORA_FORWARDING_N_OR_RADIOSTACK = 0x4A;
  static const SET_LORA_SUB_BANDS = 0x4B;
  static const SET_LORA_DATA_RATE = 0x4C;
  static const SET_LORA_TX_POWER = 0x4D;
  static const SET_LORA_ADR = 0x4E;
  static const SET_LORA_DUTY_CYCLE = 0x4F;
  static const SET_LORA_CLASS = 0x50;
  static const SET_LORA_BAND = 0x51;
  static const SET_LORA_OPERATION_MODE = 0x52;
  static const GET_LORA_RAK_INFO_OR_RADIOSTACK = 0x53;
  static const GET_LORA_SUB_BANDS = 0x54;
  static const GET_LORA_DATA_RATE = 0x55;
  static const GET_LORA_TX_POWER = 0x56;
  static const GET_LORA_ADR = 0x57;
  static const GET_LORA_DUTY_CYCLE = 0x58;
  static const GET_LORA_CLASS = 0x59;
  static const GET_LORA_BAND = 0x5A;
  static const GET_LORA_OPERATION_MODE = 0x5B;

  static const SPECIFIC_DEVICE_RANGE_MIN = 0xF0;
  static const SPECIFIC_DEVICE_RANGE_MAX = 0xFF;
}
