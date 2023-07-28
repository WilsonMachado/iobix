import './matric_potential_commands.dart';

//ignore: camel_case_types
class MATRIC_POTENTIAL_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 2.0;
  static const NOMINAL_BATTERY_MAX = 4.2;
  static const NOMINAL_BATTERY_MIN = 3.3;
  static const VOLTAGE_REFERENCE = 2.5;
  static const ADC_VPANEL_PARAM = 10.09;
  static const VPANEL_VOLTAGE_REFERENCE = 3.3;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const Map<int, String> GM_SENSOR_MAP = {
    1: 'Sensor 1',
    2: 'Sensor 2',
    3: 'Sensor 3',
    4: 'Sensor 4',
    5: 'Sensor 5',
    6: 'Sensor 6',
  };

  static const Map<int, String> ELECTROVALVE_CONTROL_MAP = {
    0: 'Automático',
    1: 'Manual',
  };

  static const Map<int, String> IRRIGATION_CYCLE_MAP = {
    0: 'Proceso de riego finalizado',
    1: 'Proceso de riego iniciado',
  };

  static const List<String> hours = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23'
  ];

  static const List<String> minutes = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59'
  ];

  static const Map<int, String> RESISTANCE_CALIB_STATUS = {
    0: 'Ok',
    1: 'El valor resistivo a calibrar es mayor que el medido en el sensor 1',
    2: 'No se detecta ningún valor resistivo en el sensor 1'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x00: 'Configuración del tiempo de riego',
    0x01: 'Configuración del tiempo de espera de riego',
    0x02: 'Configuración del valor de potencial mátrico para iniciar riego',
    0x03: 'Configuración del valor de potencial mátrico para finalizar riego',
    0x04: 'Configuración del control de riego',
    0x05: 'Evento de activación/desactivación de riego',
    0x06: 'Configuración del sensor que controlará el riego',
    0x07: 'Evento de inicio/finalización de riego',
    0x08: 'Evento de calibración',
  };

  static const Map<int, String> CONSOLE = {
    MATRIC_POTENTIAL_CMDS.DATA_REPORT: 'Matric Potential data',
    MATRIC_POTENTIAL_CMDS.RESISTANCE_CALIBRATION: 'Resistance calibration',
    MATRIC_POTENTIAL_CMDS.GET_IRRIGATION_PARAMS: 'Get irrigation parameters',
    MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_STATUS: 'Set irrigation threshold',
    MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_TIME: 'Set irrigation time',
    MATRIC_POTENTIAL_CMDS.START_IRRIGATION_MANUAL: 'Irrigation manual',
    MATRIC_POTENTIAL_CMDS.SET_PV_TO_START_IRRIGATION:
        'Set sensors to start irrigation',
    //MATRIC_POTENTIAL_CMDS.SET_PV_TO_STOP_IRRIGATION: 'Set pressure value to stop irrigation',

    //MATRIC_POTENTIAL_CMDS.SET_ELECTROVALVE_CONTROL: 'Set electrovalve control',
    MATRIC_POTENTIAL_CMDS.SET_GEMHO_SOIL_SENSOR: 'Set soil sensor',
    MATRIC_POTENTIAL_CMDS.GET_DATA_FROM_GEMHO_SOIL_SENSOR:
        'Get data from soil sensor',
    MATRIC_POTENTIAL_CMDS.SET_GM_IRRIGATION_CONTROL:
        'Set granual matrix index for irrigation control',
    MATRIC_POTENTIAL_CMDS.GET_IRRIGATION_CYCLE_STATUS:
        'Get irrigation cycle status',
    MATRIC_POTENTIAL_CMDS.GET_RTC_CALIBRATION_DATA:
        'Getting RTC Calibration Data',
    MATRIC_POTENTIAL_CMDS.SET_RTC_CALIBRATION_DATA:
        'Setting RTC Calibration Data',
  };
}

//ignore: camel_case_types
class MATRIC_POTENTIAL_CONSTANTS_V3_1 {
  static const ADC_RESOLUTION = 4095; //  Resolución del ADC 12 bits
  static const ADC_BATTERY_PARAM =
      2.0; // Factor de medición de voltaje de batería
  static const NOMINAL_BATTERY_MAX = 4.2; // Valor nominal de batería máximo
  static const NOMINAL_BATTERY_MIN = 3.0; // Valor nominal de bateria mínimo
  static const VOLTAGE_REFERENCE = 2.5; // Referencia de medición de batería
  static const ADC_VPANEL_PARAM = 12.83; // Factor de medición del panel solar
  static const VPANEL_VOLTAGE_REFERENCE =
      2.5; // Referencia de medición del panel solar
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const PRESSURE_STATUS_OK = 0x00;
  static const PRESSURE_STATUS_DISCONNECT = 0x04;
  static const PRESSURE_STATUS_SENSOR = {
    PRESSURE_STATUS_OK: 'Ok',
    1: 'Modo de comando',
    2: 'Stale data',
    3: 'Condición de diagnóstico',
    PRESSURE_STATUS_DISCONNECT: 'Desconectado'
  };

  static const Map<int, String> RTC_OFFSET_VALUE = {
    0x00: '+8 ppm',
    0x01: '+7 ppm',
    0x02: '+6 ppm',
    0x03: '+5 ppm',
    0x04: '+4 ppm',
    0x05: '+3 ppm',
    0x06: '+2 ppm',
    0x07: '+1 ppm',
    0x08: '0 ppm',
    0x09: '-1 ppm',
    0x0A: '-2 ppm',
    0x0B: '-3 ppm',
    0x0C: '-4 ppm',
    0x0D: '-5 ppm',
    0x0E: '-6 ppm',
    0x0F: '-7 ppm',
  };

  static const Map<int, String> RTC_CLKOUT_CONFIG = {
    0x00: '32768 Hz',
    0x01: '16384 Hz',
    0x02: '8192 Hz',
    0x03: '4096 Hz',
    0x04: '2048 Hz',
    0x05: '1024 Hz',
    0x06: '1 Hz',
    0x07: 'OFF',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGSYS = {
    0x08: 'Evento de calibración de lecturas de potencial mátrico',
    0x09: 'Evento de bloqueo de pluviómetro',
  };

  static const Map<int, String> CONSOLE = {
    MATRIC_POTENTIAL_CMDS.DATA_REPORT: 'Matric Potential data',
    MATRIC_POTENTIAL_CMDS.RESISTANCE_CALIBRATION: 'Resistance calibration',
    MATRIC_POTENTIAL_CMDS.CONFIG_DIGITAL_TEMP_SENSOR:
        'Configuring digital temperature sensor',
    MATRIC_POTENTIAL_CMDS.SET_RTC_OFFSET: 'Setting RTC offset',
    MATRIC_POTENTIAL_CMDS.SET_RTC_CLKOUT: 'Setting RTC CLKOUT Config',
    MATRIC_POTENTIAL_CMDS.GET_RTC_CONFIG: 'Getting RTC Config',
  };
}

//ignore: camel_case_types
class MATRIC_POTENTIAL_CONSTANTS_V4 {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 2.0;
  static const VOLTAGE_REFERENCE = 2.5;
  static const ADC_VPANEL_PARAM = 12.81;
  static const VPANEL_VOLTAGE_REFERENCE = 2.5;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;

  static const PRESSURE_STATUS_OK = 0x00;
  static const PRESSURE_STATUS_DISCONNECT = 0x04;
  static const PRESSURE_STATUS_SENSOR = {
    PRESSURE_STATUS_OK: 'Ok',
    1: 'Modo de comando',
    2: 'Stale data',
    3: 'Condición de diagnóstico',
    PRESSURE_STATUS_DISCONNECT: 'Desconectado'
  };

  static const List<String> RTC_OFSSET_SIGN = [
    '-',
    '+',
  ];
}
