// ignore: camel_case_types
class LORAWAN_CONSTANTS {
  static const MODE_OTAA = 0x00;
  static const MODE_ABP = 0x01;
  static const Map<int, String> MODE_ACTIVATION = {
    MODE_OTAA: 'OTAA',
    MODE_ABP: 'ABP',
    0x02: 'inactive'
  };

  static const MODULE_IMST = 0x00;
  static const MODULE_RAK = 0x01;
  static const Map<int, String> MODULE_MAP = {
    MODULE_IMST: 'IMST',
    MODULE_RAK: 'RAK'
  };

  static const Map<int, String> OPERATION_MODE = {
    0x00: 'default',
    //0x01: 'Reserved',
    //0x02: 'Reserved',
    0x03: 'customer'
  };

  static const Map<int, String> IMST_BAND_INDEX = {0x29: 'AU915'};

  static const Map<int, String> RAK_BAND_INDEX = {
    //0x01: 'EU433',
    // 0x02: 'CN470',
    // 0x03: 'IN865',
    //0x04: 'EU868',
    // 0x05: 'US915',
    0x06: 'AU915',
    // 0x07: 'KR920',
    // 0x08: 'AS923',
  };

  static const Map<int, String> AU915_SUB_BAND_1 = {
    0x01: '915.2 - 916.6 MHz',
    0x02: '916.8 - 918.2 MHz',
    0x04: '918.4 - 919.8 MHz',
    0x08: '920.0 - 921.4 MHz',
    0x10: '921.6 - 923.0 MHz',
    0x20: '923.2 - 924.6 MHz',
    0x40: '924.8 - 926.2 MHz',
    0x80: '926.4 - 927.8 MHz'
  };

  static const Map<int, String> AU915_SUB_BAND_2 = {
    0x01: '915.9 MHz',
    0x02: '917.5 MHz',
    0x04: '919.1 MHz',
    0x08: '920.7 MHz',
    0x10: '922.3 MHz',
    0x20: '923.9 MHz',
    0x40: '925.5 MHz',
    0x80: '927.1 MHz',
  };

  static const Map<int, String> SPREADING_FACTOR = {
    0x00: 'LoRa / SF12 (BW: 125 KHz)',
    0x01: 'LoRa / SF11 (BW: 125 KHz)',
    0x02: 'LoRa / SF10 (BW: 125 KHz)',
    0x03: 'LoRa / SF9 (BW: 125 KHz)',
    0x04: 'LoRa / SF8 (BW: 125 KHz)',
    0x05: 'LoRa / SF7 (BW: 125 KHz)',
    0x06: 'LoRa / SF8 (BW: 500 KHz)',
    0x08: 'LoRa / SF12 (BW: 500 KHz)',
    0x09: 'LoRa / SF11 (BW: 500 KHz)',
    0x0A: 'LoRa / SF10 (BW: 500 KHz)',
    0x0B: 'LoRa / SF9 (BW: 500 KHz)',
    0x0C: 'LoRa / SF8 (BW: 500 KHz)',
    0x0D: 'LoRa / SF7 (BW: 500 KHz)'
  };

  static const Map<int, String> IMST_CLASS = {0x00: 'A', 0x01: 'C'};
  static const Map<int, String> RAK_CLASS = {
    0x00: 'A',
    //0x01: 'Clase B',
    0x02: 'C'
  };

  static const IMST_STATUS_OK = 0x00;
  static const Map<int, String> IMST_STATUS = {
    0x00: 'IMST Ok',
    0x01: 'IMST Error',
    0x02: 'IMST Command not supported',
    0x03: 'IMST Wrong message',
    0x04: 'IMST Command error'
  };

  static const RAK_STATUS_OK = 0x01;
  static const RAK_ERROR = 0x03;
  static const RAK_BUG = 0x05;
  static const Map<int, String> RAK_STATUS = {
    0x00: 'RAK Reserved',
    RAK_STATUS_OK: 'RAK Ok',
    0x02: 'RAK Timeout',
    RAK_ERROR: 'RAK Error',
    0x04: 'RAK Busy',
    RAK_BUG: 'RAK Delayed, please wait some seconds',
    0x06: 'RAK Failed Wake Up'
  };

  static const RAK_MAX_EIRP = 30;

  static const Map<String, String> RAK_ERROR_CODE = {
    '1': 'The last command received is an unsupported AT command',
    '2': 'Invalid parameter in the AT command',
    '3': 'There is an error when reading or writing the flash memory',
    '5': 'There is an error when sending data through the UART port',
    '41': 'The BLE felt into an invalid state, could not applied the command',
    '80': 'The LoRa transceiver is busy, could not process a new command',
    '81':
        'LoRa service is unknown. Unknown MAC command received by node. Execute commands that are not supported in the current state, such as sending "adjoin" command in P2P mode',
    '82': 'The LoRa parameters are invalid',
    '83': 'The LoRa frequency is invalid',
    '84': 'The LoRa data rate (DR) is invalid',
    '85': 'The LoRa frequency and data rate are invalid',
    '86': 'The device hasn’t joined into a LoRa network',
    '87':
        'The length of the packet exceeded that maximum allowed by the LoRa protocol',
    '88':
        'Service is closed by the server. Due to the limitation of duty cycle, the server will send " SRV_MAC_DUTY_CYCLE_REQ" MAC command to close the service',
    '89': 'This is an unsupported region code',
    '90':
        'Duty cycle is restricted. Due to duty cycle, data cannot be sent at this time until the time limit is removed',
    '91': 'No valid LoRa channel could be found',
    '92': 'No available LoRa channel could be found',
    '93':
        'Internal state error. Generally, the internal state of the protocol stack is wrong',
    '94':
        'Time out reached while sending the packet through the LoRa transceiver',
    '95': 'Time out reached while waiting for a packet in the LoRa RX1 window',
    '96': 'Time out reached while waiting for a packet in the LoRa RX2 window',
    '97':
        'There is an error while receiving a packet during the LoRa RX1 window',
    '98':
        'There is an error while receiving a packet during the LoRa RX2 window',
    '99': 'Failed to join into a LoRa network',
    '100':
        'Duplicate downlink message is detected. A message with an invalid downlink count is received',
    '101': 'Payload size is not valid for the current data rate (DR)',
    '102': 'Many downlink packets are lost',
    '103':
        'Address fail. The address of the received packet does not match the address of the current node',
    '104': 'Invalid MIC is detected in the LoRa message',
  };
}
