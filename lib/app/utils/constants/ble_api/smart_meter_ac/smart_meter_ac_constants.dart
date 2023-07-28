import './smart_meter_ac_commands.dart';

// ignore: camel_case_types
class SMART_METER_AC_CONSTANTS {
  static const ADC_RESOLUTION = 4095; // 12 bits
  static const ADC_BATTERY_PARAM = 2.0;
  static const NOMINAL_BATTERY_MAX = 3.6;
  static const NOMINAL_BATTERY_MIN = 2.7;
  static const V3_1_NOMINAL_BATTERY_MAX = 4.2;
  static const V3_1_NOMINAL_BATTERY_MIN = 3.0;
  static const VOLTAGE_REFERENCE = 2.5;
  // Este VAUX se debe interpretar como la salida del AC/DC
  static const ADC_VAUX_PARAM = 2.0;
  static const V3_1_ADC_VAUX_PARAM = 2.1538;
  static const NTC_RO = 10000;
  static const NTC_RF = 10000;
  static const NTC_EXTERNAL_B = 3950;
  static const NTC_INTERNAL_B = 3435;

  static const CURRENT_VAR_TYPE_CODE = 0x01;
  static const VOLTAGE_VAR_TYPE_CODE = 0x02;
  //static const PHASE_VAR_TYPE_CODE = 0x03;
  static const POWER_VAR_TYPE_CODE = 0x04;
  static const ENERGY_VAR_TYPE_CODE = 0x05;
  static const VOLTAGE_UPPER_THR_VAR_TYPE_CODE = 0x06;
  static const VOLTAGE_LOWER_THR_VAR_TYPE_CODE = 0x07;
  static const ENERGY_MEASURE_FREQ_VAR_TYPE_CODE = 0x08;
  static const CURRENT_GAIN_VAR_TYPE_CODE = 0x09;
  static const VOLTAGE_GAIN_VAR_TYPE_CODE = 0x0A;
  static const POWER_GAIN_VAR_TYPE_CODE = 0x0B;
  static const CURRENT_OFFSET_VAR_TYPE_CODE = 0x0C;
  static const VOLTAGE_OFFSET_VAR_TYPE_CODE = 0x0D;
  static const ACTIVE_POWER_OFFSET_VAR_TYPE_CODE = 0x0E;
  static const REACTIVE_POWER_OFFSET_VAR_TYPE_CODE = 0x0F;

  static const Map<int, String> VAR_TYPE_MAP = {
    CURRENT_VAR_TYPE_CODE: 'Constante de Corriente',
    VOLTAGE_VAR_TYPE_CODE: 'Constante de Voltaje',
    //PHASE_VAR_TYPE_CODE: 'Constante de Fase (Ángulo)',
    POWER_VAR_TYPE_CODE: 'Constante de Potencia',
    ENERGY_VAR_TYPE_CODE: 'Constante de Energía',
    VOLTAGE_UPPER_THR_VAR_TYPE_CODE: 'Umbral superior de alarma de voltaje',
    VOLTAGE_LOWER_THR_VAR_TYPE_CODE: 'Umbral inferior de alarma de voltaje',
    ENERGY_MEASURE_FREQ_VAR_TYPE_CODE: 'Periodicidad de medición de energías',
    CURRENT_GAIN_VAR_TYPE_CODE: 'Ganancia de Corriente',
    VOLTAGE_GAIN_VAR_TYPE_CODE: 'Ganancia de Voltaje',
    POWER_GAIN_VAR_TYPE_CODE: 'Ganancia de Potencia',
    CURRENT_OFFSET_VAR_TYPE_CODE: 'Offset de Corriente',
    VOLTAGE_OFFSET_VAR_TYPE_CODE: 'Offset de Voltaje',
    ACTIVE_POWER_OFFSET_VAR_TYPE_CODE: 'Offset de Potencia Activa',
    REACTIVE_POWER_OFFSET_VAR_TYPE_CODE: 'Offset de Potencia Reactiva',
  };

  static const Map<int, String> VAR_TYPE_UNIT_MAP = {
    CURRENT_VAR_TYPE_CODE: 'uArms',
    VOLTAGE_VAR_TYPE_CODE: 'uVrms',
    //PHASE_VAR_TYPE_CODE: 'Undefined',
    POWER_VAR_TYPE_CODE: 'm(Watt - VAr - VA)',
    ENERGY_VAR_TYPE_CODE: 'u(Watt - VAr - VA)',
    VOLTAGE_UPPER_THR_VAR_TYPE_CODE: 'Volts',
    VOLTAGE_LOWER_THR_VAR_TYPE_CODE: 'Volts',
    ENERGY_MEASURE_FREQ_VAR_TYPE_CODE: 'Segundos',
    CURRENT_GAIN_VAR_TYPE_CODE: 'Hexadecimal',
    VOLTAGE_GAIN_VAR_TYPE_CODE: 'Hexadecimal',
    POWER_GAIN_VAR_TYPE_CODE: 'Hexadecimal',
    CURRENT_OFFSET_VAR_TYPE_CODE: 'Hexadecimal',
    VOLTAGE_OFFSET_VAR_TYPE_CODE: 'Hexadecimal',
    ACTIVE_POWER_OFFSET_VAR_TYPE_CODE: 'Hexadecimal',
    REACTIVE_POWER_OFFSET_VAR_TYPE_CODE: 'Hexadecimal',
  };

  static const ONLY_ALL_PHASE_INDEX = 0x00;
  static const Map<int, String> ONLY_ALL_PHASE_INDEX_MAP = {
    ONLY_ALL_PHASE_INDEX: 'Aplicar a todas las fases',
  };

  static const Map<int, String> PHASE_INDEX_MAP = {
    ...ONLY_ALL_PHASE_INDEX_MAP,
    0x01: 'A',
    0x02: 'B',
    0x03: 'C',
  };

  static const Map<int, String> CURRENT_PHASE_INDEX_MAP = {
    ...PHASE_INDEX_MAP,
    0x04: 'Neutro',
  };

  static const Map<int, String> PHASE_CARD_TITLE_MAP = {
    0x01: 'Fase R',
    0x02: 'Fase S',
    0x03: 'Fase T',
  };

  static const Map<int, String> CURRENT_PHASE_CARD_TITLE_MAP = {
    ...PHASE_CARD_TITLE_MAP,
    0x04: 'Neutro',
  };

  static const Map<int, String> ADE_TYPE_MAP = {
    0x00: 'unknown',
    0x01: 'ADE9000',
    0x02: 'ADE9078'
  };

  static const Map<int, String> RMS_REG_ADDRESS = {
    0x020C: 'IRMS de Fase R',
    0x022C: 'IRMS de Fase S',
    0x024C: 'IRMS de Fase T',
    0x020D: 'VRMS de Fase R',
    0x022D: 'VRMS de Fase S',
    0x024D: 'VRMS de Fase T',
  };

  /*
  static const CURRENT_REG_TYPE_CODE = 0x01;
  static const VOLTAGE_REG_TYPE_CODE = 0x02;
  static const PHASE_REG_TYPE_CODE = 0x03;
  static const POWER_REG_TYPE_CODE = 0x04;
  static const Map<int, String> REG_TYPE_MAP = {
    CURRENT_REG_TYPE_CODE: 'Corriente',
    VOLTAGE_REG_TYPE_CODE: 'Voltaje',
    PHASE_REG_TYPE_CODE: 'Fase',
    POWER_REG_TYPE_CODE: 'Potencia',
  };

  static const RMS_GAIN_CURRENT_REG_SUBTYPE_CODE = 0x01;
  static const RMS_OFFSET_CURRENT_REG_SUBTYPE_CODE = 0x02;
  static const RMS_FUNDAMENTAL_OFFSET_CURRENT_REG_SUBTYPE_CODE = 0x03;
  static const Map<int, String> CURRENT_REG_SUBTYPE_MAP = {
    RMS_GAIN_CURRENT_REG_SUBTYPE_CODE: 'Ganancia de corriente RMS',
    RMS_OFFSET_CURRENT_REG_SUBTYPE_CODE: 'Offset de corriente RMS',
    RMS_FUNDAMENTAL_OFFSET_CURRENT_REG_SUBTYPE_CODE:
        'Offset de corriente fundamental RMS',
  };
  static const Map<int, String> RMS_CURRENT_GAIN_REG_ADDRESS_MAP = {
    0x01: 'AIGAIN',
    0x02: 'BIGAIN',
    0x03: 'CIGAIN',
    0x04: 'NIGAIN'
  };
  static const Map<int, String> RMS_CURRENT_OFFSET_REG_ADDRESS_MAP = {
    0x01: 'AIRMSOS',
    0x02: 'BIRMSOS',
    0x03: 'CIRMSOS',
    0x04: 'NIRMSOS'
  };
  static const Map<int, String> RMS_FUNDAMENTAL_CURRENT_OFFSET_REG_ADDRESS_MAP =
      {0x01: 'AIFRMSOS', 0x02: 'BIFRMSOS', 0x03: 'CIFRMSOS'};

  static const RMS_GAIN_VOLTAGE_REG_SUBTYPE_CODE = 0x01;
  static const RMS_OFFSET_VOLTAGE_REG_SUBTYPE_CODE = 0x02;
  static const RMS_FUNDAMENTAL_OFFSET_VOLTAGE_REG_SUBTYPE_CODE = 0x03;
  static const Map<int, String> VOLTAGE_REG_SUBTYPE_MAP = {
    RMS_GAIN_VOLTAGE_REG_SUBTYPE_CODE: 'Ganancia de voltaje RMS',
    RMS_OFFSET_VOLTAGE_REG_SUBTYPE_CODE: 'Offset de voltaje RMS',
    RMS_FUNDAMENTAL_OFFSET_VOLTAGE_REG_SUBTYPE_CODE:
        'Offset de voltaje fundamental RMS',
  };
  static const Map<int, String> RMS_VOLTAGE_GAIN_REG_ADDRESS_MAP = {
    0x01: 'AVGAIN',
    0x02: 'BVGAIN',
    0x03: 'CVGAIN'
  };
  static const Map<int, String> RMS_VOLTAGE_OFFSET_REG_ADDRESS_MAP = {
    0x01: 'AVRMSOS',
    0x02: 'BVRMSOS',
    0x03: 'CVRMSOS'
  };
  static const Map<int, String> RMS_FUNDAMENTAL_VOLTAGE_OFFSET_REG_ADDRESS_MAP =
      {0x01: 'AVFRMSOS', 0x02: 'BVFRMSOS', 0x03: 'CVFRMSOS'};

  static const Map<int, String> PHASE_REG_ADDRESS_MAP = {
    0x01: 'APHCAL',
    0x02: 'BPHCAL',
    0x03: 'CPHCAL',
    0x04: 'NPHCAL',
  };

  static const RMS_GAIN_POWER_REG_SUBTYPE_CODE = 0x01;
  static const RMS_ACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE = 0x02;
  static const RMS_ACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE = 0x03;
  static const RMS_REACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE = 0x04;
  static const RMS_REACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE = 0x05;
  static const Map<int, String> POWER_REG_SUBTYPE_MAP = {
    RMS_GAIN_POWER_REG_SUBTYPE_CODE: 'Ganancia de potencia',
    RMS_ACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE: 'Offset de potencia activa',
    RMS_ACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE:
        'Offset de potencia activa fundamental',
    RMS_REACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE: 'Offset de potencia reactiva',
    RMS_REACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE:
        'Offset de potencia reactiva fundamental',
  };
  static const Map<int, String> RMS_POWER_GAIN_REG_ADDRESS_MAP = {
    0x01: 'APGAIN',
    0x02: 'BPGAIN',
    0x03: 'CPGAIN'
  };
  static const Map<int, String> ACTIVE_POWER_OFFSET_REG_ADDRESS_MAP = {
    0x01: 'AWATTOS',
    0x02: 'BWATTOS',
    0x03: 'CWATTOS',
  };
  static const Map<int, String>
      FUNDAMENTAL_ACTIVE_POWER_OFFSET_REG_ADDRESS_MAP = {
    0x01: 'AFWATTOS',
    0x02: 'BFWATTOS',
    0x03: 'CFWATTOS',
  };
  static const Map<int, String> REACTIVE_POWER_OFFSET_REG_ADDRESS_MAP = {
    0x01: 'AVAROS',
    0x02: 'BVAROS',
    0x03: 'CVAROS',
  };
  static const Map<int, String>
      FUNDAMENTAL_REACTIVE_POWER_OFFSET_REG_ADDRESS_MAP = {
    0x01: 'AFVAROS',
    0x02: 'BFVAROS',
    0x03: 'CFVAROS',
  };
  */

  static const Map<int, String> CONSOLE = {
    SMART_METER_AC_CMDS.WRITE_REGISTER: 'Write register',
    SMART_METER_AC_CMDS.WRITE_PARAMETER: 'Write parameter',
    SMART_METER_AC_CMDS.GET_PARAMETER: 'Get parameter',
    SMART_METER_AC_CMDS.DATA_REPORT: 'Get Smart Meter AC Data',
    SMART_METER_AC_CMDS.SET_CALIB_STATUS_REG: 'Set Calibration status register',
    SMART_METER_AC_CMDS.ENERGY_DATA_REPORT: 'Get Energy Data',
    SMART_METER_AC_CMDS.RESET_ENERGY_ACCUMULATION: 'Reset energy accumulation',
    SMART_METER_AC_CMDS.POWER_REPORT: 'Get Smart Meter Ac Power Data',
    SMART_METER_AC_CMDS.DEBUG_READ: 'Get Processes',
    SMART_METER_AC_CMDS.GET_CALIB_STATUS_REG: 'Get Calibration status register',
    SMART_METER_AC_CMDS.GET_RMS_REG: 'Get RMS Register',
  };

  static const Map<int, String> MEMORY_DATA_TYPE_LOGAPP = {
    0x01: 'raw_app_data'
  };
}
