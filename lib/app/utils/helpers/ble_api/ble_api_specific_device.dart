import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/iris_logger/iris_logger_tab_controller.dart';
import 'package:iobix/app/modules/device/widgets/smart_fault_detector/smart_fault_detector_tab_controller.dart';
import 'package:iobix/app/modules/device/widgets/tilt_sensor/tilt_sensor_tab_controller.dart';
import 'package:iobix/app/utils/constants/ble_api/iris_logger/iris_logger_commands.dart';
import 'package:iobix/app/utils/constants/ble_api/iris_logger/iris_logger_constants.dart';
import 'package:iobix/app/utils/constants/ble_api/logger_rs485/logger_rs485_commands.dart';
import 'package:iobix/app/utils/constants/ble_api/logger_rs485/logger_rs485_constants.dart';
import 'package:iobix/app/utils/constants/ble_api/smart_fault_detector/smart_fault_detector_commands.dart';
import 'package:iobix/app/utils/constants/ble_api/smart_fault_detector/smart_fault_detector_constants.dart';
import 'package:iobix/app/utils/constants/ble_api/tilt_sensor/tilt_sensor_commands.dart';
import 'package:iobix/app/utils/constants/ble_api/tilt_sensor/tilt_sensor_constants.dart';
import 'package:iobix/app/utils/helpers/ble_api/ble_api_iris_logger.dart';
import 'package:iobix/app/utils/helpers/ble_api/ble_api_smart_fault_detector.dart';
import 'package:iobix/app/utils/helpers/ble_api/ble_api_tilt_sensor.dart';
import '../../../data/models/local/model_log_console.dart';
import '../../constants/ble_api/vantage_logger/vantage_logger_commands.dart';
import 'ble_api_vantage_logger.dart';
import '../../../data/models/local/model_device_type_parameters.dart';
import '../../constants/enums.dart';
import '../../constants/ble_api/vantage_logger/vantage_logger_constants.dart';
import '../../../modules/device/widgets/vantage_logger_tab/vantage_logger_tab_controller.dart';
import '../../../modules/device/widgets/temperature_logger_tab/temperature_logger_tab_controller.dart';
import '../../constants/ble_api/temperature_logger/temperature_logger_constants.dart';
import '../../constants/ble_api/temperature_logger/temperature_logger_commands.dart';
import './ble_api_temperature_logger.dart';
import '../../constants/ble_api/ble_general_constants.dart';
import '../../constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';
import '../../constants/ble_api/smart_meter_ac/smart_meter_ac_commands.dart';
import '../../../modules/device/widgets/smart_meter_ac_tab/smart_meter_ac_tab_controller.dart';
import './ble_api_smart_meter_ac.dart';
import './ble_api_multipurpose_rs485_.dart';
import '../../../modules/device/widgets/multipurpose_rs485/multipurpose_rs485_tab_controller.dart';
import '../../constants/ble_api/multipurpose_rs485/multipurpose_rs485_constants.dart';
import '../../constants/ble_api/multipurpose_rs485/multipurpose_rs485_commands.dart';
import '../../constants/ble_api/matric_potential/matric_potential_commands.dart';
import '../../constants/ble_api/matric_potential/matric_potential_constants.dart';
import '../../../utils/helpers/ble_api/ble_api_matric_potential.dart';
import '../../../modules/device/widgets/matric_potential/matric_potential_tab_controller.dart';
import '../../../modules/device/widgets/level_sensor/level_sensor_tab_controller.dart';
import '../../../utils/constants/ble_api/level_sensor/level_sensor_commands.dart';
import '../../../utils/constants/ble_api/level_sensor/level_sensor_constants.dart';
import '../../../utils/helpers/ble_api/ble_api_level_sensor.dart';
import './ble_api_iskra_mt174.dart';
import '../../constants/ble_api/iskra_mt174/iskra_mt174_constants.dart';
import '../../constants/ble_api/iskra_mt174/iskra_mt174_commands.dart';
import '../../../modules/device/widgets/iskra_mt174/iskra_mt174_tab_controller.dart';
import '../../../modules/device/widgets/smart_meter_dc/smart_meter_dc_tab_controller.dart';
import '../../../utils/constants/ble_api/smart_meter_dc/smart_meter_dc_commands.dart';
import '../../../utils/constants/ble_api/smart_meter_dc/smart_meter_dc_constants.dart';
import '../../../utils/helpers/ble_api/ble_api_smart_meter_dc.dart';

List<String> specificDeviceInitialization(
    ModelDeviceTypeParameters modelDeviceTypeParameters,
    ColbitsCompatibleVersion colbitsCompatibleVersion) {
  switch (colbitsCompatibleVersion) {
    case ColbitsCompatibleVersion.vantageLoggerV2:
    case ColbitsCompatibleVersion.vantageLoggerV3:
      String _v = '0';
      switch (colbitsCompatibleVersion) {
        case ColbitsCompatibleVersion.vantageLoggerV2:
          Get.put(VantageLoggerTabController());
          Get.find<VantageLoggerTabController>()
              .modelVantageLogger
              .deviceVersion = 2.0;
          _v = '2';
          break;
        case ColbitsCompatibleVersion.vantageLoggerV3:
          Get.put(VantageLoggerTabController());
          Get.find<VantageLoggerTabController>()
              .modelVantageLogger
              .deviceVersion = 3.0;
          _v = '3';
          break;
        default:
      }
      //Get.put(VantageLoggerTabController());
      switch (colbitsCompatibleVersion) {
        case ColbitsCompatibleVersion
            .vantageLoggerV2: //! Usar los parámetros del Vantage Logger V2
          modelDeviceTypeParameters.adcResolution =
              VANTAGE_LOGGER_CONSTANTS_V2.ADC_RESOLUTION;
          modelDeviceTypeParameters.adcBatteryParam =
              VANTAGE_LOGGER_CONSTANTS_V2.ADC_BATTERY_PARAM;
          modelDeviceTypeParameters.adcVpanelParam =
              VANTAGE_LOGGER_CONSTANTS_V2.ADC_VPANEL_PARAM;
          modelDeviceTypeParameters.adcVauxParam =
              VANTAGE_LOGGER_CONSTANTS_V2.ADC_VAUX_PARAM;
          modelDeviceTypeParameters.voltageReference =
              VANTAGE_LOGGER_CONSTANTS_V2.VOLTAGE_REFERENCE;
          modelDeviceTypeParameters.vpanelVoltageReference =
              VANTAGE_LOGGER_CONSTANTS_V2.VOLTAGE_REFERENCE;
          modelDeviceTypeParameters.nominalBatteryMax =
              VANTAGE_LOGGER_CONSTANTS_V2.NOMINAL_BATTERY_MAX;
          modelDeviceTypeParameters.nominalBatteryMin =
              VANTAGE_LOGGER_CONSTANTS_V2.NOMINAL_BATTERY_MIN;
          modelDeviceTypeParameters.memoryDataTypeLogApp =
              VANTAGE_LOGGER_CONSTANTS_V2.MEMORY_DATA_TYPE_LOGAPP;
          modelDeviceTypeParameters.memoryDataTypeLogSys =
              VANTAGE_LOGGER_CONSTANTS_V2.MEMORY_DATA_TYPE_LOGSYS;

          break;

        case ColbitsCompatibleVersion
            .vantageLoggerV3: //! Usar los parámetros del Vantage Logger V3
          modelDeviceTypeParameters.adcResolution =
              VANTAGE_LOGGER_CONSTANTS_V3.ADC_RESOLUTION;
          modelDeviceTypeParameters.adcBatteryParam =
              VANTAGE_LOGGER_CONSTANTS_V3.ADC_BATTERY_PARAM;
          modelDeviceTypeParameters.adcVpanelParam =
              VANTAGE_LOGGER_CONSTANTS_V3.ADC_VPANEL_PARAM;
          modelDeviceTypeParameters.adcVauxParam =
              VANTAGE_LOGGER_CONSTANTS_V3.ADC_VAUX_PARAM;
          modelDeviceTypeParameters.voltageReference =
              VANTAGE_LOGGER_CONSTANTS_V3.VOLTAGE_REFERENCE;
          modelDeviceTypeParameters.vpanelVoltageReference =
              VANTAGE_LOGGER_CONSTANTS_V3.VOLTAGE_REFERENCE;
          modelDeviceTypeParameters.nominalBatteryMax =
              VANTAGE_LOGGER_CONSTANTS_V3.NOMINAL_BATTERY_MAX;
          modelDeviceTypeParameters.nominalBatteryMin =
              VANTAGE_LOGGER_CONSTANTS_V3.NOMINAL_BATTERY_MIN;
          modelDeviceTypeParameters.memoryDataTypeLogApp =
              VANTAGE_LOGGER_CONSTANTS_V3.MEMORY_DATA_TYPE_LOGAPP;
          modelDeviceTypeParameters.memoryDataTypeLogSys =
              VANTAGE_LOGGER_CONSTANTS_V3.MEMORY_DATA_TYPE_LOGSYS;

          break;

        default:
          break;
      }
      return ['ble_type_vtg'.tr, _v];

    case ColbitsCompatibleVersion.temperatureLoggerV2:
    case ColbitsCompatibleVersion.temperatureLoggerV3:
    case ColbitsCompatibleVersion.smartFaultDetector:
    case ColbitsCompatibleVersion.tiltSensor:
      String _v = '0';
      switch (colbitsCompatibleVersion) {
        case ColbitsCompatibleVersion.smartFaultDetector:
          Get.put(SmartFaultDetectorTabController());
          _v = '1';
          break;

        case ColbitsCompatibleVersion.tiltSensor:
          Get.put(TiltSensorTabController());
          _v = '1';
          break;

        case ColbitsCompatibleVersion.temperatureLoggerV2:
          Get.put(TemperatureLoggerTabController());
          Get.find<TemperatureLoggerTabController>()
              .modelTemperatureLogger
              .deviceVersion = 2.0;
          _v = '2';
          break;
        case ColbitsCompatibleVersion.temperatureLoggerV3:
          Get.put(TemperatureLoggerTabController());
          Get.find<TemperatureLoggerTabController>()
              .modelTemperatureLogger
              .deviceVersion = 3.0;
          _v = '3';
          break;
        default:
      }

      modelDeviceTypeParameters.adcResolution =
          TEMPERATURE_LOGGER_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          TEMPERATURE_LOGGER_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          TEMPERATURE_LOGGER_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          TEMPERATURE_LOGGER_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.nominalBatteryMax =
          TEMPERATURE_LOGGER_CONSTANTS.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          TEMPERATURE_LOGGER_CONSTANTS.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          TEMPERATURE_LOGGER_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          TEMPERATURE_LOGGER_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS;
      modelDeviceTypeParameters.ro = TEMPERATURE_LOGGER_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = TEMPERATURE_LOGGER_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          TEMPERATURE_LOGGER_CONSTANTS.NTC_EXTERNAL_B;

      switch (colbitsCompatibleVersion) {
        case ColbitsCompatibleVersion.smartFaultDetector:
          return ['Smart Fault Detector'.tr, _v];
          break;
        case ColbitsCompatibleVersion.tiltSensor:
          return ['Sensor de inclinación'.tr, _v];
          break;
        default:
          return ['ble_type_tmp'.tr, _v];
          break;
      }
      break;

    case ColbitsCompatibleVersion.smartMeterAcV2:
    case ColbitsCompatibleVersion.smartMeterAcV3:
    case ColbitsCompatibleVersion.smartMeterAcV3_1:
      String _v = '0';
      Get.put(SmartMeterAcTabController());
      switch (colbitsCompatibleVersion) {
        case ColbitsCompatibleVersion.smartMeterAcV2:
          Get.find<SmartMeterAcTabController>()
              .modelSmartMeterAc
              .deviceVersion = 2.0;
          _v = '2';
          break;
        case ColbitsCompatibleVersion.smartMeterAcV3:
          Get.find<SmartMeterAcTabController>()
              .modelSmartMeterAc
              .deviceVersion = 3.0;
          _v = '3';
          break;
        case ColbitsCompatibleVersion.smartMeterAcV3_1:
          Get.find<SmartMeterAcTabController>()
              .modelSmartMeterAc
              .deviceVersion = 3.1;
          _v = '3.1';
          break;
        default:
      }

      switch (colbitsCompatibleVersion) {
        case ColbitsCompatibleVersion.smartMeterAcV2:
        case ColbitsCompatibleVersion.smartMeterAcV3:
          modelDeviceTypeParameters.adcVauxParam =
              SMART_METER_AC_CONSTANTS.ADC_VAUX_PARAM;
          modelDeviceTypeParameters.nominalBatteryMax =
              SMART_METER_AC_CONSTANTS.NOMINAL_BATTERY_MAX;
          modelDeviceTypeParameters.nominalBatteryMin =
              SMART_METER_AC_CONSTANTS.NOMINAL_BATTERY_MIN;
          break;

        case ColbitsCompatibleVersion.smartMeterAcV3_1:
          modelDeviceTypeParameters.adcVauxParam =
              SMART_METER_AC_CONSTANTS.V3_1_ADC_VAUX_PARAM;
          modelDeviceTypeParameters.nominalBatteryMax =
              SMART_METER_AC_CONSTANTS.V3_1_NOMINAL_BATTERY_MAX;
          modelDeviceTypeParameters.nominalBatteryMin =
              SMART_METER_AC_CONSTANTS.V3_1_NOMINAL_BATTERY_MIN;

          break;
        default:
      }

      modelDeviceTypeParameters.adcResolution =
          SMART_METER_AC_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          SMART_METER_AC_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          SMART_METER_AC_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          SMART_METER_AC_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          SMART_METER_AC_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.ro = SMART_METER_AC_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = SMART_METER_AC_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          SMART_METER_AC_CONSTANTS.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.internalB =
          SMART_METER_AC_CONSTANTS.NTC_INTERNAL_B;
      return ['Medidor inteligente de AC', _v];

    case ColbitsCompatibleVersion.multipurposeRS485V1:
      Get.put(MultipurposeRS485TabController());
      modelDeviceTypeParameters.adcResolution =
          MULTIPURPOSE_RS485_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          MULTIPURPOSE_RS485_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          MULTIPURPOSE_RS485_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          MULTIPURPOSE_RS485_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.nominalBatteryMax =
          MULTIPURPOSE_RS485_CONSTANTS.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          MULTIPURPOSE_RS485_CONSTANTS.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          MULTIPURPOSE_RS485_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.ro = MULTIPURPOSE_RS485_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = MULTIPURPOSE_RS485_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          MULTIPURPOSE_RS485_CONSTANTS.NTC_EXTERNAL_B;
      return ['RS485 Multipropósito', '1'];

    case ColbitsCompatibleVersion.matricPotentialV1:
    case ColbitsCompatibleVersion.demoLoggerPanicButton:
      if (colbitsCompatibleVersion ==
          ColbitsCompatibleVersion.matricPotentialV1)
        Get.put(MatricPotentialTabController());
      modelDeviceTypeParameters.adcResolution =
          MATRIC_POTENTIAL_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          MATRIC_POTENTIAL_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.nominalBatteryMax =
          MATRIC_POTENTIAL_CONSTANTS.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          MATRIC_POTENTIAL_CONSTANTS.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.voltageReference =
          MATRIC_POTENTIAL_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          MATRIC_POTENTIAL_CONSTANTS.VPANEL_VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.adcVpanelParam =
          MATRIC_POTENTIAL_CONSTANTS.ADC_VPANEL_PARAM;
      modelDeviceTypeParameters.ro = MATRIC_POTENTIAL_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = MATRIC_POTENTIAL_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          MATRIC_POTENTIAL_CONSTANTS.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          MATRIC_POTENTIAL_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          MATRIC_POTENTIAL_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS;
      return [
        (colbitsCompatibleVersion == ColbitsCompatibleVersion.matricPotentialV1)
            ? 'Potencial Mátrico'
            : 'Logger Botón de Pánico',
        '1'
      ];

    case ColbitsCompatibleVersion.matricPotentialV3_1:
      Get.put(MatricPotentialTabController());
      modelDeviceTypeParameters.adcResolution =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.nominalBatteryMax =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.voltageReference =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.VPANEL_VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.adcVpanelParam =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.ADC_VPANEL_PARAM;
      modelDeviceTypeParameters.ro = MATRIC_POTENTIAL_CONSTANTS_V3_1.NTC_RO;
      modelDeviceTypeParameters.rf = MATRIC_POTENTIAL_CONSTANTS_V3_1.NTC_RF;
      modelDeviceTypeParameters.externalB =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          MATRIC_POTENTIAL_CONSTANTS_V3_1.MEMORY_DATA_TYPE_LOGSYS;
      return ['Potencial Mátrico', '3.1'];

    case ColbitsCompatibleVersion.matricPotentialV4:
      Get.put(MatricPotentialTabController());
      modelDeviceTypeParameters.adcResolution =
          MATRIC_POTENTIAL_CONSTANTS_V4.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          MATRIC_POTENTIAL_CONSTANTS_V4.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          MATRIC_POTENTIAL_CONSTANTS_V4.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          MATRIC_POTENTIAL_CONSTANTS_V4.VPANEL_VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.adcVpanelParam =
          MATRIC_POTENTIAL_CONSTANTS_V4.ADC_VPANEL_PARAM;
      modelDeviceTypeParameters.ro = MATRIC_POTENTIAL_CONSTANTS_V4.NTC_RO;
      modelDeviceTypeParameters.rf = MATRIC_POTENTIAL_CONSTANTS_V4.NTC_RF;
      modelDeviceTypeParameters.externalB =
          MATRIC_POTENTIAL_CONSTANTS_V4.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          MATRIC_POTENTIAL_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          MATRIC_POTENTIAL_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS;
      return ['Potencial Mátrico', '4'];

    case ColbitsCompatibleVersion.levelSensorV1:
      Get.put(LevelSensorTabController());
      modelDeviceTypeParameters.adcResolution =
          LEVEL_SENSOR_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          LEVEL_SENSOR_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          LEVEL_SENSOR_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          LEVEL_SENSOR_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.nominalBatteryMax =
          LEVEL_SENSOR_CONSTANTS.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          LEVEL_SENSOR_CONSTANTS.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          LEVEL_SENSOR_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          LEVEL_SENSOR_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS;
      modelDeviceTypeParameters.ro = LEVEL_SENSOR_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = LEVEL_SENSOR_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.internalB =
          LEVEL_SENSOR_CONSTANTS.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.externalB =
          LEVEL_SENSOR_CONSTANTS.NTC_EXTERNAL_B;
      return ['Sensor de Nivel'.tr, '1'];

    case ColbitsCompatibleVersion.iskraMt174V1:
      Get.put(IskraMt174TabController());
      modelDeviceTypeParameters.adcResolution =
          ISKRA_MT174_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          ISKRA_MT174_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          ISKRA_MT174_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          ISKRA_MT174_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.nominalBatteryMax =
          ISKRA_MT174_CONSTANTS.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          ISKRA_MT174_CONSTANTS.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          ISKRA_MT174_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.ro = ISKRA_MT174_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = ISKRA_MT174_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          ISKRA_MT174_CONSTANTS.NTC_EXTERNAL_B;
      return ['ISKRA MT174', '1'];

    case ColbitsCompatibleVersion
        .iRISLogger: //! Parámetros para el cálculo de batería, cargador, etc, del iRIS logger

      Get.put(IrisLoggerTabController());

      modelDeviceTypeParameters.adcResolution =
          IRIS_LOGGER_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          IRIS_LOGGER_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          IRIS_LOGGER_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          IRIS_LOGGER_CONSTANTS.VPANEL_VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.adcVpanelParam =
          IRIS_LOGGER_CONSTANTS.ADC_VPANEL_PARAM;
      modelDeviceTypeParameters.ro = IRIS_LOGGER_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = IRIS_LOGGER_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          IRIS_LOGGER_CONSTANTS.NTC_EXTERNAL_B;

      return ['iRIS Logger', '1.0'];

    case ColbitsCompatibleVersion
        .iRISLogger: //! Parámetros para el cálculo de batería, cargador, etc, del iRIS logger

      Get.put(IrisLoggerTabController());

      modelDeviceTypeParameters.adcResolution =
          IRIS_LOGGER_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          IRIS_LOGGER_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          IRIS_LOGGER_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          IRIS_LOGGER_CONSTANTS.VPANEL_VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.adcVpanelParam =
          IRIS_LOGGER_CONSTANTS.ADC_VPANEL_PARAM;
      modelDeviceTypeParameters.ro = IRIS_LOGGER_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = IRIS_LOGGER_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          IRIS_LOGGER_CONSTANTS.NTC_EXTERNAL_B;

      return ['iRIS Logger', '1.0'];

    case ColbitsCompatibleVersion
        .loggerRS485: //! Parámetros para el cálculo de batería, cargador, etc, del Logger RS485

      //!Get.put(IrisLoggerTabController());

      modelDeviceTypeParameters.adcResolution =
          LOGGER_RS485_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          LOGGER_RS485_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          LOGGER_RS485_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          LOGGER_RS485_CONSTANTS.VPANEL_VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.adcVpanelParam =
          LOGGER_RS485_CONSTANTS.ADC_VPANEL_PARAM;
      modelDeviceTypeParameters.adcVauxParam =
          LOGGER_RS485_CONSTANTS.ADC_VAUX_PARAM;
      modelDeviceTypeParameters.ro = LOGGER_RS485_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = LOGGER_RS485_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          LOGGER_RS485_CONSTANTS.NTC_EXTERNAL_B;

      return ['Logger RS485', '1.0'];

    case ColbitsCompatibleVersion.smartMeterDcV2:
      Get.put(SmartMeterDcTabController());
      Get.find<SmartMeterDcTabController>().modelSmartMeterDc.deviceVersion =
          2.0;
      modelDeviceTypeParameters.adcResolution =
          SMART_METER_DC_CONSTANTS.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          SMART_METER_DC_CONSTANTS.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          SMART_METER_DC_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          SMART_METER_DC_CONSTANTS.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.nominalBatteryMax =
          SMART_METER_DC_CONSTANTS.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          SMART_METER_DC_CONSTANTS.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          SMART_METER_DC_CONSTANTS.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.ro = SMART_METER_DC_CONSTANTS.NTC_RO;
      modelDeviceTypeParameters.rf = SMART_METER_DC_CONSTANTS.NTC_RF;
      modelDeviceTypeParameters.externalB =
          SMART_METER_DC_CONSTANTS.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          SMART_METER_DC_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS;
      return ['Medidor inteligente de DC', '2'];

    case ColbitsCompatibleVersion.smartMeterDcV3:
      Get.put(SmartMeterDcTabController());
      Get.find<SmartMeterDcTabController>().modelSmartMeterDc.deviceVersion =
          3.0;
      modelDeviceTypeParameters.adcResolution =
          SMART_METER_DC_CONSTANTS_V3.ADC_RESOLUTION;
      modelDeviceTypeParameters.adcBatteryParam =
          SMART_METER_DC_CONSTANTS_V3.ADC_BATTERY_PARAM;
      modelDeviceTypeParameters.voltageReference =
          SMART_METER_DC_CONSTANTS_V3.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.vpanelVoltageReference =
          SMART_METER_DC_CONSTANTS_V3.VOLTAGE_REFERENCE;
      modelDeviceTypeParameters.nominalBatteryMax =
          SMART_METER_DC_CONSTANTS_V3.NOMINAL_BATTERY_MAX;
      modelDeviceTypeParameters.nominalBatteryMin =
          SMART_METER_DC_CONSTANTS_V3.NOMINAL_BATTERY_MIN;
      modelDeviceTypeParameters.memoryDataTypeLogApp =
          SMART_METER_DC_CONSTANTS_V3.MEMORY_DATA_TYPE_LOGAPP;
      modelDeviceTypeParameters.ro = SMART_METER_DC_CONSTANTS_V3.NTC_RO;
      modelDeviceTypeParameters.rf = SMART_METER_DC_CONSTANTS_V3.NTC_RF;
      modelDeviceTypeParameters.externalB =
          SMART_METER_DC_CONSTANTS_V3.NTC_EXTERNAL_B;
      modelDeviceTypeParameters.memoryDataTypeLogSys =
          SMART_METER_DC_CONSTANTS_V3.MEMORY_DATA_TYPE_LOGSYS;
      return ['Medidor inteligente de DC', '3'];

    default:
      return ['Error', 'Error'];
  }
}

String specificDeviceConsoleCmdText(
    int cmd, ColbitsCompatibleVersion colbitsCompatibleVersion) {
  switch (colbitsCompatibleVersion) {
    case ColbitsCompatibleVersion.vantageLoggerV2:
      return VANTAGE_LOGGER_CONSTANTS_V2.CONSOLE.containsKey(cmd)
          ? VANTAGE_LOGGER_CONSTANTS_V2.CONSOLE[cmd]
          : 'Error';
    case ColbitsCompatibleVersion.vantageLoggerV3:
      return VANTAGE_LOGGER_CONSTANTS_V3.CONSOLE.containsKey(cmd)
          ? VANTAGE_LOGGER_CONSTANTS_V3.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.temperatureLoggerV2:
    case ColbitsCompatibleVersion.temperatureLoggerV3:
      return TEMPERATURE_LOGGER_CONSTANTS.CONSOLE.containsKey(cmd)
          ? TEMPERATURE_LOGGER_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.smartFaultDetector:
      return SMART_FAULT_DETECTOR_CONSTANTS.CONSOLE.containsKey(cmd)
          ? SMART_FAULT_DETECTOR_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.tiltSensor:
      return TILT_SENSOR_CONSTANTS.CONSOLE.containsKey(cmd)
          ? TILT_SENSOR_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.smartMeterAcV2:
    case ColbitsCompatibleVersion.smartMeterAcV3:
    case ColbitsCompatibleVersion.smartMeterAcV3_1:
      return SMART_METER_AC_CONSTANTS.CONSOLE.containsKey(cmd)
          ? SMART_METER_AC_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.multipurposeRS485V1:
      return MULTIPURPOSE_RS485_CONSTANTS.CONSOLE.containsKey(cmd)
          ? MULTIPURPOSE_RS485_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.matricPotentialV1:
    case ColbitsCompatibleVersion.matricPotentialV4:
      return MATRIC_POTENTIAL_CONSTANTS.CONSOLE.containsKey(cmd)
          ? MATRIC_POTENTIAL_CONSTANTS.CONSOLE[cmd]
          : 'Error';
    case ColbitsCompatibleVersion.matricPotentialV3_1:
      return MATRIC_POTENTIAL_CONSTANTS_V3_1.CONSOLE.containsKey(cmd)
          ? MATRIC_POTENTIAL_CONSTANTS_V3_1.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.levelSensorV1:
      return LEVEL_SENSOR_CONSTANTS.CONSOLE.containsKey(cmd)
          ? LEVEL_SENSOR_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.iskraMt174V1:
      return ISKRA_MT174_CONSTANTS.CONSOLE.containsKey(cmd)
          ? ISKRA_MT174_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.iRISLogger:
      return IRIS_LOGGER_CONSTANTS.CONSOLE.containsKey(cmd)
          ? IRIS_LOGGER_CONSTANTS.CONSOLE[cmd]
          : 'Error';

    case ColbitsCompatibleVersion.smartMeterDcV2:
      return SMART_METER_DC_CONSTANTS.CONSOLE.containsKey(cmd)
          ? SMART_METER_DC_CONSTANTS.CONSOLE[cmd]
          : 'Error';
    case ColbitsCompatibleVersion.smartMeterDcV3:
      return SMART_METER_DC_CONSTANTS_V3.CONSOLE.containsKey(cmd)
          ? SMART_METER_DC_CONSTANTS_V3.CONSOLE[cmd]
          : 'Error';

    default:
      return 'Error';
  }
}

bool specificDeviceContainSnackBarRequestType(
    int cmd, ColbitsCompatibleVersion colbitsCompatibleVersion) {
  switch (colbitsCompatibleVersion) {
    case ColbitsCompatibleVersion.vantageLoggerV2:
      return VANTAGE_LOGGER_CONSTANTS_V2.SNACKBAR_REQ_TYPE.containsKey(cmd);
    case ColbitsCompatibleVersion.vantageLoggerV3:
      return VANTAGE_LOGGER_CONSTANTS_V3.SNACKBAR_REQ_TYPE.containsKey(cmd);

    case ColbitsCompatibleVersion.temperatureLoggerV2:
    case ColbitsCompatibleVersion.temperatureLoggerV3:
      return TEMPERATURE_LOGGER_CONSTANTS.SNACKBAR_REQ_TYPE.containsKey(cmd);

    default:
      return false;
  }
}

String specificDeviceSnackBarRequestType(
    int cmd, ColbitsCompatibleVersion colbitsCompatibleVersion) {
  switch (colbitsCompatibleVersion) {
    case ColbitsCompatibleVersion.vantageLoggerV2:
      return VANTAGE_LOGGER_CONSTANTS_V2.SNACKBAR_REQ_TYPE[cmd];
    case ColbitsCompatibleVersion.vantageLoggerV3:
      return VANTAGE_LOGGER_CONSTANTS_V3.SNACKBAR_REQ_TYPE[cmd];

    case ColbitsCompatibleVersion.temperatureLoggerV2:
    case ColbitsCompatibleVersion.temperatureLoggerV3:
      return TEMPERATURE_LOGGER_CONSTANTS.SNACKBAR_REQ_TYPE[cmd];

    default:
      return 'Error';
  }
}

ModelLogConsole bleApiSpecificDevice(
    List<int> frame, ColbitsCompatibleVersion colbitsCompatibleVersion) {
  final int cmd = frame[0];
  String errorLog = BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;

  switch (colbitsCompatibleVersion) {
    case ColbitsCompatibleVersion.vantageLoggerV2:
      return (cmd >= VANTAGE_LOGGER_CMDS_V2.RANGE_MIN &&
              cmd <= VANTAGE_LOGGER_CMDS_V2.RANGE_MAX)
          ? bleApiVantageLogger(
              frame, Get.find<VantageLoggerTabController>().modelVantageLogger)
          : ModelLogConsole(cmd: cmd, log: errorLog);
    case ColbitsCompatibleVersion.vantageLoggerV3:
      return (cmd >= VANTAGE_LOGGER_CMDS_V3.RANGE_MIN &&
              cmd <= VANTAGE_LOGGER_CMDS_V3.RANGE_MAX)
          ? bleApiVantageLogger(
              frame, Get.find<VantageLoggerTabController>().modelVantageLogger)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.tiltSensor:
      return (cmd >= TILT_SENSOR_CMDS.RANGE_MIN &&
              cmd <= TILT_SENSOR_CMDS.RANGE_MAX)
          ? bleApiTiltSensor(
              frame, Get.find<TiltSensorTabController>().modelTiltSensor)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.smartFaultDetector:
      return (cmd >= SMART_FAULT_DETECTOR_CMDS.RANGE_MIN &&
              cmd <= SMART_FAULT_DETECTOR_CMDS.RANGE_MAX)
          ? bleApiSmartFaultDetector(
              frame,
              Get.find<SmartFaultDetectorTabController>()
                  .modelSmartFaultDetector)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.temperatureLoggerV2:
    case ColbitsCompatibleVersion.temperatureLoggerV3:
      return (cmd >= TEMPERATURE_LOGGER_CMDS.RANGE_MIN &&
              cmd <= TEMPERATURE_LOGGER_CMDS.RANGE_MAX)
          ? bleApiTemperatureLogger(frame,
              Get.find<TemperatureLoggerTabController>().modelTemperatureLogger)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.smartMeterAcV2:
    case ColbitsCompatibleVersion.smartMeterAcV3:
    case ColbitsCompatibleVersion.smartMeterAcV3_1:
      return (cmd >= SMART_METER_AC_CMDS.RANGE_MIN &&
              cmd <= SMART_METER_AC_CMDS.RANGE_MAX)
          ? bleApiSmartMeterAc(
              frame, Get.find<SmartMeterAcTabController>().modelSmartMeterAc)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.multipurposeRS485V1:
      return (cmd >= MULTIPURPOSE_RS485_CMDS.RANGE_MIN &&
              cmd <= MULTIPURPOSE_RS485_CMDS.RANGE_MAX)
          ? bleApiMultipurposeRS485(frame,
              Get.find<MultipurposeRS485TabController>().modelMultipurposeRS485)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.matricPotentialV1:
    case ColbitsCompatibleVersion.matricPotentialV3_1:
    case ColbitsCompatibleVersion.matricPotentialV4:
      return (cmd >= MATRIC_POTENTIAL_CMDS.RANGE_MIN &&
              cmd <= MATRIC_POTENTIAL_CMDS.RANGE_MAX)
          ? bleApiMatricPotential(frame,
              Get.find<MatricPotentialTabController>().modelMatricPotential)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.levelSensorV1:
      return (cmd >= LEVEL_SENSOR_CMDS.RANGE_MIN &&
              cmd <= LEVEL_SENSOR_CMDS.RANGE_MAX)
          ? bleApiLevelSensor(
              frame, Get.find<LevelSensorTabController>().modelLevelSensor)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.iskraMt174V1:
      return (cmd >= ISKRA_MT174_CMDS.RANGE_MIN &&
              cmd <= ISKRA_MT174_CMDS.RANGE_MAX)
          ? bleApiIskraMt174(
              frame, Get.find<IskraMt174TabController>().modelIskraMt174)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.iRISLogger:
      return (cmd >= IRIS_LOGGER_CMDS.RANGE_MIN &&
              cmd <= IRIS_LOGGER_CMDS.RANGE_MAX)
          ? bleApiIrisLogger(
              frame, Get.find<IrisLoggerTabController>().modelIrisLogger)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    case ColbitsCompatibleVersion.smartMeterDcV2:
    case ColbitsCompatibleVersion.smartMeterDcV3:
      return (cmd >= SMART_METER_DC_CMDS.RANGE_MIN &&
              cmd <= SMART_METER_DC_CMDS.RANGE_MAX)
          ? bleApiSmartMeterDc(
              frame, Get.find<SmartMeterDcTabController>().modelSmartMeterDc)
          : ModelLogConsole(cmd: cmd, log: errorLog);

    default:
      return ModelLogConsole(cmd: cmd, log: errorLog);
  }
}

Future<void> onReadyApiLoginSpecificDevice(
    ColbitsCompatibleVersion colbitsCompatibleVersion) async {
  switch (colbitsCompatibleVersion) {
    case ColbitsCompatibleVersion.multipurposeRS485V1:
      await Get.find<MultipurposeRS485TabController>().bleApiDataReport();
      break;

    case ColbitsCompatibleVersion.matricPotentialV1:
    case ColbitsCompatibleVersion.matricPotentialV3_1:
    case ColbitsCompatibleVersion.matricPotentialV4:
      await Get.find<MatricPotentialTabController>().bleApiReloadView();
      break;

    case ColbitsCompatibleVersion.levelSensorV1:
      await Get.find<LevelSensorTabController>().bleApiReloadView();
      break;

    case ColbitsCompatibleVersion.smartMeterAcV3:
    case ColbitsCompatibleVersion.smartMeterAcV3_1:
      await Get.find<SmartMeterAcTabController>().bleApiGetCalibStatusReg();
      Future.delayed(Duration(milliseconds: 100));
      await Get.find<SmartMeterAcTabController>().bleApiDataReport();
      break;

    case ColbitsCompatibleVersion.smartMeterDcV2:
    case ColbitsCompatibleVersion.smartMeterDcV3:
      await Get.find<SmartMeterDcTabController>().bleApiDataReport();
      break;

    case ColbitsCompatibleVersion.vantageLoggerV3:
      await Get.find<VantageLoggerTabController>().getCurrentSettings();
      break;

    default:
  }

  return null;
}
