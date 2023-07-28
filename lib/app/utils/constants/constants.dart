import './enums.dart';

class CONSTANTS {
  static final RegExp positiveIntegerFormat = RegExp(r"^[0-9]\d*$");
  static final RegExp hexadecimalFormat = RegExp(r"^[a-fA-F0-9]*$");

  static const APP_VERSION = 'v0.0.39a (alfa version)';
  static const API_BLE_VERSION = 'v0.0.4';
  static const DEVICE_LOGS_PATH = 'device_logs.txt';
  static const ANIMATION_DURATION = Duration(milliseconds: 200);
  static const BACKEND_API_BASEURL = 'http://52.205.100.186:1881/api/cini';

  static const Map<String, String> LANGUAGES = {
    'es_CO': 'spanish',
    'en_US': 'english'
  };

  static const COLBITS_NAME_PREFIX = 'CBS';
  static const Map<String, String> COLBITS_BLE_DEVICE_TYPE = {
    'VTG': 'ble_type_vtg',
    'TMP': 'ble_type_tmp',
    'SMAC': 'Medidor inteligente de AC',
    'MRS485': 'RS485 Multipropósito',
    'LS485': 'Logger RS485',
    'PM': 'Potencial Mátrico',
    'LVL': 'Medidor de nivel',
    'MT174': 'Medidor ISKRA MT174',
    'iRIS': 'Logger de estación iRIS 270',
    'SMDC': 'Medidor inteligente de DC',
    'SFD': 'Smart Fault Detector',
    'INCL': 'Sensor de Inclinación',
    'DLBP': 'Logger Botón de Pánico (Demo)',
  };

  static const Map<int, ColbitsCompatibleVersion> COLBITS_DEVICE_VERSION = {
    0x0102: ColbitsCompatibleVersion.temperatureLoggerV2,
    0x0202: ColbitsCompatibleVersion.temperatureLoggerV2,
    0x0103: ColbitsCompatibleVersion.temperatureLoggerV3,
    0x0301: ColbitsCompatibleVersion.levelSensorV1,
    0x0401: ColbitsCompatibleVersion.matricPotentialV1,
    0x0431: ColbitsCompatibleVersion.matricPotentialV3_1,
    0x0404: ColbitsCompatibleVersion.matricPotentialV4,
    0x0502: ColbitsCompatibleVersion.smartMeterAcV2,
    0x0503: ColbitsCompatibleVersion.smartMeterAcV3,
    0x0531: ColbitsCompatibleVersion.smartMeterAcV3_1,
    0x0602: ColbitsCompatibleVersion.smartMeterDcV2,
    0x0603: ColbitsCompatibleVersion.smartMeterDcV3,
    0x0702: ColbitsCompatibleVersion.vantageLoggerV2,
    0x0703: ColbitsCompatibleVersion.vantageLoggerV3,
    0x0801: ColbitsCompatibleVersion.multipurposeRS485V1,
    0x0901: ColbitsCompatibleVersion.iskraMt174V1,
    0x0B01: ColbitsCompatibleVersion.iRISLogger,
    0x0D01: ColbitsCompatibleVersion.loggerRS485,
    0xF101: ColbitsCompatibleVersion.tiltSensor,
    0xF201: ColbitsCompatibleVersion.smartFaultDetector,
    0xFC01: ColbitsCompatibleVersion.demoLoggerPanicButton,
  };

  static const Map<ColbitsCompatibleVersion, String> COLBITS_BLE_DEVICE_NAME = {
    ColbitsCompatibleVersion.temperatureLoggerV2: 'CBS_TMP_',
    ColbitsCompatibleVersion.temperatureLoggerV3: 'CBS_TMP_',
    ColbitsCompatibleVersion.smartMeterAcV2: 'CBS_SMAC_',
    ColbitsCompatibleVersion.smartMeterAcV3: 'CBS_SMAC_',
    ColbitsCompatibleVersion.smartMeterAcV3_1: 'CBS_SMAC_',
    ColbitsCompatibleVersion.vantageLoggerV2: 'CBS_VTG_',
    ColbitsCompatibleVersion.vantageLoggerV3: 'CBS_VTG_',
    ColbitsCompatibleVersion.multipurposeRS485V1: 'CBS_MRS485_',
    ColbitsCompatibleVersion.matricPotentialV1: 'CBS_PM_',
    ColbitsCompatibleVersion.matricPotentialV3_1: 'CBS_PM_',
    ColbitsCompatibleVersion.matricPotentialV4: 'CBS_PM_',
    ColbitsCompatibleVersion.levelSensorV1: 'CBS_LVL_',
    ColbitsCompatibleVersion.iskraMt174V1: 'CBS_MT174_',
    ColbitsCompatibleVersion.iRISLogger: 'CBS_iRIS_',
    ColbitsCompatibleVersion.loggerRS485: 'CBS_LS485_',
    ColbitsCompatibleVersion.smartMeterDcV2: 'CBS_SMDC_',
    ColbitsCompatibleVersion.smartMeterDcV3: 'CBS_SMDC_',
    ColbitsCompatibleVersion.smartFaultDetector: 'CBS_SFD_',
    ColbitsCompatibleVersion.tiltSensor: 'CBS_INCL_',
    ColbitsCompatibleVersion.demoLoggerPanicButton: 'CBS_DLBP_',
  };
}
