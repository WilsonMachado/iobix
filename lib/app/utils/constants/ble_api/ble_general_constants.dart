import 'ble_general_commands.dart';

// ignore: camel_case_types
class BLE_GENERAL_CONSTANTS {
  static const Map<int, String> SET = {0x00: 'Disable', 0x01: 'Enable'};

  static const Map<int, String> CONFIGURED = {
    0x00: 'disabled',
    0x01: 'enabled'
  };

  static const STATUS_OK = 0x00;
  static const CMD_UNSUPPORTED = 'Command unsupported by the mobile app';
  static const Map<int, String> STATUS = {
    0x00: 'Ok',
    0x01: 'Busy',
    0x02: 'Processing error',
    0x03: 'Payload size error',
    0x04: 'Command not found',
    0x05: 'Timeout',
    0x06: 'Command unsupported',
    0x07: 'Unauthorized'
  };

  static const SNACKBAR_ERROR_APP = -1;
  static const SNACKBAR_ERROR_RAK_BUG = -2;
  static const SNACKBAR_ERROR_SET_RTC = -3;
  static const Map<int, String> SNACKBAR_ERROR = {
    0x01: 'res_snackbar_err_msg_0x01',
    0x02: 'res_snackbar_err_msg_common',
    0x04: 'res_snackbar_err_msg_0x04',
    0x05: 'res_snackbar_err_msg_0x05',
    0x06: 'res_snackbar_err_msg_0x06',
    SNACKBAR_ERROR_APP: 'res_snackbar_err_msg_app',
    SNACKBAR_ERROR_RAK_BUG: 'res_snackbar_err_msg_rak_bug',
    SNACKBAR_ERROR_SET_RTC: 'res_snackbar_err_msg_set_rtc'
  };

  static const Map<int, String> ACELEROMETER_ORIENTATION = {
    0x00: 'Vertical',
    0x01: 'Horizontal',
    0x02: 'unknown',
    0x03: 'Failing',
  };

  static const GPS_SYNC_OK = 0x00;
  static const GPS_SYNC_INIT = 0x01;
  static const GPS_SYNC_GPS_DISABLED = 0x02;
  static const GPS_SYNC_GPS_TIMEOUT = 0x05;
  static const Map<int, String> GPS_SYNC_STATUS = {
    GPS_SYNC_OK: 'Ok',
    GPS_SYNC_INIT: 'Synchronization started',
    GPS_SYNC_GPS_DISABLED: 'GPS disabled',
    GPS_SYNC_GPS_TIMEOUT: 'Timeout'
  };

  static const Map<int, String> TAMPERING_STATUS = {
    0x00: 'unsupported',
    0x01: 'closed_device',
    0x02: 'open_device'
  };

  static const Map<int, String> MEMORY_LOG_TYPE = {
    BLE_GENERAL_CMDS.READ_LOGAPP: 'device_data',
    BLE_GENERAL_CMDS.READ_LOGSYS: 'system_data'
  };

  static const MEMORY_LOGSYS_GENERAL_SYSTEM_CODE = 0x01;
  static const MEMORY_LOGSYS_BLUETOOTH_CODE = 0x02;
  static const MEMORY_LOGSYS_MEMORY_CODE = 0x03;
  static const MEMORY_LOGSYS_LORA_CODE = 0x04;
  static const MEMORY_LOGSYS_GNSS_CODE = 0x05;
  static const MEMORY_LOGSYS_SPECIFIC_DEVICE_CODE = 0x06;
  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'all_events',
    MEMORY_LOGSYS_GENERAL_SYSTEM_CODE: 'general_system_event',
    MEMORY_LOGSYS_BLUETOOTH_CODE: 'ble_event',
    //MEMORY_LOGSYS_MEMORY_CODE: 'memory_event',
    MEMORY_LOGSYS_LORA_CODE: 'lora_event',
    MEMORY_LOGSYS_GNSS_CODE: 'gnss_event',
    MEMORY_LOGSYS_SPECIFIC_DEVICE_CODE: 'specific_device_event'
  };
  static const Map<int, String> MEMORY_LOGSYS_GENERAL_SYSTEM_MAP = {
    0x00: 'reset',
    0x01: 'set_measure_time',
    0x02: 'set_tx_time',
    0x03: 'set_hw_id',
    0x04: 'set_rtc',
    0x05: 'fall_alarm',
    0x06: 'device_tampering',
    0x07: 'Configuración de LEDs',
    0x08: 'Configuración de confirmación de mensajes LoRaWAN',
  };

  static const Map<int, String> MEMORY_LOGSYS_BLUETOOTH_MAP = {
    0x00: 'activation',
    0x01: 'set_ble_name',
    0x02: 'failed_loginapi',
    0x03: 'password_modifiy',
    0x04: 'admin_password_modify',
  };

  static const Map<int, String> MEMORY_LOGSYS_LORA_MAP = {
    0x00: 'activation',
    0x01: 'lora_config',
    0x02: 'tx_error',
    0x03: 'set_rtc_server',
    0x04: 'req_tx_test'
  };

  static const Map<int, String> MEMORY_LOGSYS_GNSS_MAP = {
    0x00: 'synchronization'
  };

  static const Map<int, String> CONSOLE = {
    BLE_GENERAL_CMDS.ACELEROMETER: 'Set Acelerometer',
    BLE_GENERAL_CMDS.API_BLE_VERSION: 'Get API BLE Version',
    BLE_GENERAL_CMDS.BUZZER: 'Buzzer',
    BLE_GENERAL_CMDS.CLEAR_LOGAPP: 'Clear application logs',
    BLE_GENERAL_CMDS.CLEAR_LOGSYS: 'Clear system logs',
    BLE_GENERAL_CMDS.CONFIRMED_MESSAGES: 'Set confirmed messages',
    BLE_GENERAL_CMDS.DEBUG_MESSAGE: 'Debug frame',
    BLE_GENERAL_CMDS.DEVELOPER: 'Get Developer',
    BLE_GENERAL_CMDS.DEVICE_INFO: 'Get info',
    BLE_GENERAL_CMDS.DISCONNECT_DEVICE: 'Disconnect device',
    BLE_GENERAL_CMDS.FIRMWARE_VERSION: 'Get Firmware',
    BLE_GENERAL_CMDS.G_HEALTHY_REPORT: 'General report',
    BLE_GENERAL_CMDS.GET_CONNECTION_MODE: 'Get lora mode',
    BLE_GENERAL_CMDS.GET_DEVICE_NAME: 'Get bluetooth name',
    BLE_GENERAL_CMDS.GET_HARDWARE_ID: 'Get ID',
    BLE_GENERAL_CMDS.GET_LORA_ABP_PARAMS: 'Get ABP parameters',
    BLE_GENERAL_CMDS.GET_LORA_ADR: 'Get adr',
    BLE_GENERAL_CMDS.GET_LORA_BAND: 'Get band',
    BLE_GENERAL_CMDS.GET_LORA_CLASS: 'Get lora class',
    BLE_GENERAL_CMDS.GET_LORA_DATA_RATE: 'Get data rate',
    BLE_GENERAL_CMDS.GET_LORA_DUTY_CYCLE: 'Get duty cycle',
    BLE_GENERAL_CMDS.GET_LORA_HARDWARE: 'Get lora hardware',
    BLE_GENERAL_CMDS.GET_LORA_OPERATION_MODE: 'Get operation mode',
    BLE_GENERAL_CMDS.GET_LORA_OTAA_PARAMS: 'Get OTAA parameters',
    BLE_GENERAL_CMDS.GET_LORA_RAK_INFO_OR_RADIOSTACK:
        'Get RAK information  | Radiostack',
    BLE_GENERAL_CMDS.GET_LORA_SUB_BANDS: 'Get sub bands',
    BLE_GENERAL_CMDS.GET_LORA_TX_POWER: 'Get tx power',
    BLE_GENERAL_CMDS.GNSS: 'Set gnss',
    BLE_GENERAL_CMDS.GPS_SYNC: 'GPS synchronization',
    BLE_GENERAL_CMDS.JOIN_OTAA: 'Join OTAA',
    BLE_GENERAL_CMDS.LEDS: 'Set Leds',
    BLE_GENERAL_CMDS.LORA_ACTIVE: 'Lora active',
    BLE_GENERAL_CMDS.MAINTENANCE_MODE: 'Set maintenance',
    BLE_GENERAL_CMDS.MCU_RESET: 'Reset MCU',
    BLE_GENERAL_CMDS.MEASURE_TIME: 'Set measure time',
    BLE_GENERAL_CMDS.PASSWORD_API: 'Password API',
    BLE_GENERAL_CMDS.READ_LOGAPP: 'Read application logs',
    BLE_GENERAL_CMDS.READ_LOGSYS: 'Read system logs',
    BLE_GENERAL_CMDS.SEND_TEST_DATA: 'Send test data',
    BLE_GENERAL_CMDS.SET_ADMIN_PASSWORD_API: 'Set admin password API',
    BLE_GENERAL_CMDS.SET_DEVICE_NAME: 'Set bluetooth name',
    BLE_GENERAL_CMDS.SET_HARDWARE_ID: 'Set ID',
    BLE_GENERAL_CMDS.SET_LORA_ADR: 'Set adr',
    BLE_GENERAL_CMDS.SET_LORA_BAND: 'Set band',
    BLE_GENERAL_CMDS.SET_LORA_CLASS: 'Set lora class',
    BLE_GENERAL_CMDS.SET_LORA_DATA_RATE: 'Set data rate',
    BLE_GENERAL_CMDS.SET_LORA_DUTY_CYCLE: 'Set duty cycle',
    BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK:
        'Set retransmissions | Radiostack',
    BLE_GENERAL_CMDS.SET_LORA_OPERATION_MODE: 'Set operation mode',
    BLE_GENERAL_CMDS.SET_LORA_SUB_BANDS: 'Set sub bands',
    BLE_GENERAL_CMDS.SET_LORA_TX_POWER: 'Set tx power',
    BLE_GENERAL_CMDS.SET_PASSWORD_API: 'Set password API',
    BLE_GENERAL_CMDS.SET_RTC: 'Set rtc',
    BLE_GENERAL_CMDS.SUCESS_FINISH_READ: 'Sucess finish read',
    BLE_GENERAL_CMDS.TEST_TX_LORA: 'Test tx lora',
    BLE_GENERAL_CMDS.TURN_OFF_BLE: 'Turn off',
    BLE_GENERAL_CMDS.TX_LORA: 'Tx lora',
    BLE_GENERAL_CMDS.TX_TIME: 'Set tx time',
    BLE_GENERAL_CMDS.UNSUCESS_FINISH_READ: 'Unsucess finish read',
    BLE_GENERAL_CMDS.WRITE_LOGAPP: 'Write in application logs',
    BLE_GENERAL_CMDS.WRITE_LOGSYS: 'Write in system logs',
  };

  static const Map<int, String> SNACKBAR_REQ_TYPE = {
    //BLE_GENERAL_CMDS.GET_LORA_SUB_BANDS: 'snackbar_get_lora_sub_bands',
    BLE_GENERAL_CMDS.ACELEROMETER: 'snackbar_acel',
    BLE_GENERAL_CMDS.BUZZER: 'snackbar_buzzer',
    BLE_GENERAL_CMDS.CLEAR_LOGAPP: 'snackbar_clear_logapp',
    BLE_GENERAL_CMDS.CLEAR_LOGSYS: 'snackbar_clear_logsys',
    BLE_GENERAL_CMDS.CONFIRMED_MESSAGES: 'snackbar_confirmed_msgs',
    BLE_GENERAL_CMDS.G_HEALTHY_REPORT: 'snackbar_healthy_report',
    BLE_GENERAL_CMDS.GET_LORA_ADR: 'snackbar_get_lora_adr',
    BLE_GENERAL_CMDS.GET_LORA_BAND: 'snackbar_get_lora_band',
    BLE_GENERAL_CMDS.GET_LORA_CLASS: 'snackbar_get_lora_class',
    BLE_GENERAL_CMDS.GET_LORA_DATA_RATE: 'snackbar_get_lora_data_rate',
    BLE_GENERAL_CMDS.GET_LORA_DUTY_CYCLE: 'snackbar_get_lora_duty_cycle',
    BLE_GENERAL_CMDS.GET_LORA_OPERATION_MODE: 'snackbar_get_lora_oper_mode',
    BLE_GENERAL_CMDS.GET_LORA_RAK_INFO_OR_RADIOSTACK:
        'snackbar_get_lora_rak_info',
    BLE_GENERAL_CMDS.GET_LORA_TX_POWER: 'snackbar_get_lora_tx_power',
    BLE_GENERAL_CMDS.GNSS: 'snackbar_gnss',
    BLE_GENERAL_CMDS.LEDS: 'snackbar_leds',
    BLE_GENERAL_CMDS.MCU_RESET: 'snackbar_reset',
    BLE_GENERAL_CMDS.MEASURE_TIME: 'snackbar_measure_time',
    BLE_GENERAL_CMDS.SET_LORA_ADR: 'snackbar_set_lora_adr',
    BLE_GENERAL_CMDS.SET_LORA_BAND: 'snackbar_set_lora_band',
    BLE_GENERAL_CMDS.SET_LORA_CLASS: 'snackbar_set_lora_class',
    BLE_GENERAL_CMDS.SET_LORA_DATA_RATE: 'snackbar_set_lora_data_rate',
    BLE_GENERAL_CMDS.SET_LORA_DUTY_CYCLE: 'snackbar_set_lora_duty_cycle',
    BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK: '',
    BLE_GENERAL_CMDS.SET_LORA_OPERATION_MODE: 'snackbar_set_lora_oper_mode',
    BLE_GENERAL_CMDS.SET_LORA_SUB_BANDS: 'snackbar_set_lora_sub_bands',
    BLE_GENERAL_CMDS.SET_LORA_TX_POWER: 'snackbar_set_lora_tx_power',
    BLE_GENERAL_CMDS.SET_PASSWORD_API: 'snackbar_set_password',
    BLE_GENERAL_CMDS.SET_RTC: 'snackbar_set_rtc',
    BLE_GENERAL_CMDS.TEST_TX_LORA: 'snackbar_test_tx_lora',
    BLE_GENERAL_CMDS.TX_TIME: 'snackbar_tx_time',
  };

  static const I2C_BME280_STATUS_OK = 0x00;
  static const Map<int, String> I2C_BME280_STATUS = {
    0x00: 'BME280 Ok',
    0xFA: 'BME280 Nvm copy file',
    0xFB: 'BME280 Sleep mode fail',
    0xFC: 'BME280 Comm fail',
    0xFD: 'BME280 Invalid len',
    0xFE: 'BME280 Dev not found',
    0xFF: 'BME280 Null ptr',
  };
}
