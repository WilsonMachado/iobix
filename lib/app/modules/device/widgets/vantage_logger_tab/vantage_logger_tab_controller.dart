import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';
import 'package:iobix/app/utils/constants/ble_api/vantage_logger/vantage_logger_commands.dart';
import 'package:iobix/app/utils/constants/constants.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

import '../../../../data/models/local/model_vantage_logger.dart';
import '../../device_controller.dart';

class VantageLoggerTabController extends GetxController {
  ModelVantageLogger modelVantageLogger = ModelVantageLogger();

  RxBool _isPrecipitationVariable = true.obs;
  bool get isPrecipitationVariable => _isPrecipitationVariable.value;

  RxString _precipitationVariableUnit = 'in'.obs;
  String get precipitationVariableUnit => _precipitationVariableUnit.value;

  //? Para bloquear el botón de limpieza de FAN

  RxBool _isCleaningFAN = false.obs;
  bool get isCleaningFAN => _isCleaningFAN.value;
  set isCleaningFAN(bool v) => _isCleaningFAN.value = v;

  ///* Verificaciones de versión de FW

  bool get isFwHigherOrEqual1_0_15 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.0.15',
      );

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> getInstantValues() async {
    //0xF0
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.GET_PERIODIC_MEASURE]);
    await getCurrentSettings();
  }

  Future<void> getCurrentSettings() async {
    //0xF1
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.GET_CURRENT_CONFIGURATIONS]);
  }

  Future<void> setRS485Devices(int v) async {
    //0xF2
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.SET_RS485_DEVICES, v]);
    await getCurrentSettings();
  }

  Future<void> setSpecificSensorPowerBehaviour(
      int sensorType, int powerBehaviour) async {
    //0xF3
    await sendDataToDevice([
      VANTAGE_LOGGER_CMDS_V3.SET_SPECIFIC_SENSOR_POWER_BEHAVIOUR,
      sensorType,
      powerBehaviour
    ]);
  }

  Future<void> getSensorPowerBehaviour() async {
    //0xF4
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.GET_SENSOR_POWER_BEHAVIOUR]);
  }

  Future<void> setRs485SensorMismatch() async {
    await sendDataToDevice([]);
  }

  Future<void> setSensorRS485Mismatch() async {
    //0xF5

    bool error = false;
    int value = modelVantageLogger.sensorRS485Mismatch;

    if (modelVantageLogger.sensorRS485Mismatch >= 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelVantageLogger.sensorRS485Mismatch.toString())) {
        value = modelVantageLogger.sensorRS485Mismatch;
        if (value > 840 || value < 0) {
          modelVantageLogger.errorSetSensorRS485Mismatch =
              'range_error'.trArgs(['0 - 840 s']);
          error = true;
        }
      } else {
        modelVantageLogger.errorSetSensorRS485Mismatch = 'format_error'.tr;
        error = true;
      }
    } else {
      modelVantageLogger.errorSetSensorRS485Mismatch = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            VANTAGE_LOGGER_CMDS_V3.SET_SENSOR_RS485_MISMATCH,
            ...listIntLsbToMsb(divideIntInNBytes(value, 2))
          ]),
          log: 'Desfase entre transmisiones LoRaWAN: $value segundos');
    }
  }

  Future<void> setHourToCleanFan() async {
    //0xF5

    bool error = false;
    int value;

    if (modelVantageLogger.setHourToCleanFan.length >= 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelVantageLogger.setHourToCleanFan)) {
        value = int.parse(modelVantageLogger.setHourToCleanFan);
        if (value > 730 || value < 1) {
          modelVantageLogger.errorHourToCleanFan =
              'range_error'.trArgs(['1 - 730 h']);
          error = true;
        }
      } else {
        modelVantageLogger.errorHourToCleanFan = 'format_error'.tr;
        error = true;
      }
    } else {
      modelVantageLogger.errorHourToCleanFan = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            VANTAGE_LOGGER_CMDS_V3.SET_HOUR_TO_CLEAN_FAN,
            ...listIntLsbToMsb(divideIntInNBytes(value, 4))
          ]),
          log: 'Se limpiará el FAN cada $value h');

      await getCurrentSettings();
    }
  }

  Future<void> getDavisStats() async {
    // 0xF6
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.GET_DAVIS_STATS_DATA]);
  }

  Future<void> getAirQualitySensorStats() async {
    //0xF7
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.GET_AIR_Q_STATS_DATA]);
  }

  Future<void> getRS485SensorStats() async {
    //0xF8
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.GET_RS485_STATS_DATA]);
  }

  Future<void> cleanFAN() async {
    //0xFA
    await sendDataToDevice([VANTAGE_LOGGER_CMDS_V3.CLEAN_FAN]);
    _isCleaningFAN.value = true;
    await Future.delayed(Duration(seconds: 20));
    _isCleaningFAN.value = false;
  }

  void onChangedSetHourToCleanFan(String text) {
    modelVantageLogger.setHourToCleanFan = text;
    if (modelVantageLogger.errorHourToCleanFan != null) {
      modelVantageLogger.errorHourToCleanFan = null;
    }
  }

  void onChangedSetSensorRS485Mismatch(String text) {
    modelVantageLogger.sensorRS485Mismatch = (text != '') ? int.parse(text) : 0;
    if (modelVantageLogger.errorSetSensorRS485Mismatch != null) {
      modelVantageLogger.errorSetSensorRS485Mismatch = null;
    }
  }

  void changeMgVariable() {
    if (isPrecipitationVariable) {
      _precipitationVariableUnit.value = 'mm';
      _isPrecipitationVariable.value = false;
    } else {
      _precipitationVariableUnit.value = 'in';
      _isPrecipitationVariable.value = true;
    }
  }
}
