import 'dart:async';

import 'package:get/get.dart';

import '../../../../data/models/local/model_matric_potential.dart';
import '../../../../utils/constants/ble_api/matric_potential/matric_potential_commands.dart';
import '../../../../utils/constants/ble_api/matric_potential/matric_potential_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../../utils/constants/enums.dart';
import '../../device_controller.dart';
import '../system_tab/system_tab_controller.dart';

class MatricPotentialTabController extends GetxController {
  ModelMatricPotential modelMatricPotential = ModelMatricPotential();

  RxBool _isMgVariableRes = true.obs;
  bool get isMgVariableRes => _isMgVariableRes.value;

  RxString _mgVariable = 'Resistencia'.obs;
  String get mgVariable => _mgVariable.value;

  RxString _mgVariableUnit = 'Ω'.obs;
  String get mgVariableUnit => _mgVariableUnit.value;

  Timer _timer;
  RxBool _isWorkElectrovalve = false.obs;
  bool get isWorkElectovalve => _isWorkElectrovalve.value;

  ///* Verificaciones de versión de FW

  bool get isFwHigherOrEqual1_0_8 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.0.8',
      );

  bool get isFwHigherOrEqual1_2_0 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.2.0',
      );

  bool get isFwHigherOrEqual1_0_15 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.0.15',
      );

  @override
  void onReady() {
    switch (Get.find<DeviceController>().currentDeviceConnect) {
      case ColbitsCompatibleVersion.matricPotentialV4:
        modelMatricPotential.deviceVersion = 4;
        break;

      case ColbitsCompatibleVersion.matricPotentialV3_1:
        modelMatricPotential.deviceVersion = 3.1;
        break;

      default:
    }
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
  }

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> sendSetRequest(int cmd, bool v) async {
    await Get.find<DeviceController>().sendSetRequest(cmd, v);
  }

  Future<void> bleApiReloadView() async {
    await sendDataToDevice([MATRIC_POTENTIAL_CMDS.DATA_REPORT]);

    if (!(modelMatricPotential.deviceVersion == 3.1) &&
        modelMatricPotential.deviceVersion != 4.0) {
      await sendDataToDevice([MATRIC_POTENTIAL_CMDS.GET_IRRIGATION_PARAMS]);
    }

    if (modelMatricPotential.deviceVersion == 3.1) {
      await sendDataToDevice([MATRIC_POTENTIAL_CMDS.GET_RTC_CONFIG]);
    }

    if (modelMatricPotential.deviceVersion == 4.0 &&
        modelMatricPotential.deviceVariation == 0.0) {
      await sendDataToDevice([MATRIC_POTENTIAL_CMDS.GET_RTC_CALIBRATION_DATA]);
    }

    if ((modelMatricPotential.deviceVersion == 4 &&
        (modelMatricPotential.deviceVariation == 1))) {
      await Future.delayed(Duration(seconds: 1));
      await sendDataToDevice(
          [MATRIC_POTENTIAL_CMDS.SET_GEMHO_SOIL_SENSOR, 0x10]);
    }
  }

  Future<void> bleApiStartIrrigation() async {
    // GET_IRRIGATION_PARAMS | START_IRRIGATION_MANUAL
    await sendDataToDevice([MATRIC_POTENTIAL_CMDS.START_IRRIGATION_MANUAL],
        log: 'Starting');
  }

  void changeMgVariable() {
    if (isMgVariableRes) {
      _mgVariable.value = 'Presión';
      _mgVariableUnit.value = 'kPa';
      _isMgVariableRes.value = false;
    } else {
      _mgVariable.value = 'Resistencia';
      _mgVariableUnit.value = 'Ω';
      _isMgVariableRes.value = true;
    }
  }

  void onChangedSetResistanceCalibValue(String text) {
    modelMatricPotential.setResistanceCalibValue = text;
    if (modelMatricPotential.errorSetResistanceCalibValue != null) {
      modelMatricPotential.errorSetResistanceCalibValue = null;
    }
  }

  void onChangedRTCOffset(String text) {
    modelMatricPotential.setRtcOffset = text;
    if (modelMatricPotential.errorRTCOffset != null) {
      modelMatricPotential.errorRTCOffset = null;
    }
  }

  Future<void> bleApiSetRTCOffsetData() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setRtcOffset.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setRtcOffset)) {
        value = int.parse(modelMatricPotential.setRtcOffset);
        if (value > 240 || value < 0) {
          modelMatricPotential.errorRTCOffset =
              'range_error'.trArgs(['0 - 240']);
          error = true;
        }
      } else {
        modelMatricPotential.errorRTCOffset = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorRTCOffset = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            MATRIC_POTENTIAL_CMDS.SET_RTC_CALIBRATION_DATA,
            value,
            (modelMatricPotential.setRtcOffsetSign == '+') ? 0x80 : 0x00,
          ]),
          log:
              'RTC Offset: ${modelMatricPotential.setRtcOffsetSign}$value ppm');
      await sendDataToDevice([MATRIC_POTENTIAL_CMDS.GET_RTC_CALIBRATION_DATA]);
    }
  }

  Future<void> bleApiSetResistanceCalibData() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setResistanceCalibValue.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setResistanceCalibValue)) {
        value = int.parse(modelMatricPotential.setResistanceCalibValue);
        if (value > 80000 || value < 0) {
          modelMatricPotential.errorSetResistanceCalibValue =
              'range_error'.trArgs(['0 - 8kΩ']);
          error = true;
        }
      } else {
        modelMatricPotential.errorSetResistanceCalibValue = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorSetResistanceCalibValue = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            MATRIC_POTENTIAL_CMDS.RESISTANCE_CALIBRATION,
            ...listIntLsbToMsb(
                divideIntInNBytes(value, (isFwHigherOrEqual1_0_8 ? 4 : 2)))
          ]),
          log: 'Resistance value: $value Ω');
    }
  }

  Future<void> bleApiSetSensorForIrrgation() async {
    String bytes =
        modelMatricPotential.setSensorsForIrrigation.toRadixString(2);
    String sensors = '';
    int count = bytes.length - 1;
    while (count >= 0) {
      if (bytes[count] == '1') {
        if (sensors.length > 0) {
          sensors = sensors + ' y ';
        }
        sensors = sensors + (bytes.length - count).toString();
      }
      count--;
    }
    modelMatricPotential.gmIrrigationControlSensors = sensors;
    await sendDataToDevice([
      MATRIC_POTENTIAL_CMDS.SET_PV_TO_START_IRRIGATION,
      modelMatricPotential.setSensorsForIrrigation
    ],
        log: ('Sensores establecidos para el riego: ' +
            modelMatricPotential.gmIrrigationControlSensors));
  }

  Future<void> bleApiSetIrrigationAlarm() async {
    // ? Para saber la hora de riego configurada. El proceso del DateTime es necesario para no tener problema con las operaciones al cambiar la zona horaria (UTC)

    DateTime alarm = DateTime(
      DateTime.now().year, // No se usa, pero es obligatorio

      DateTime.now().month, // No se usa, pero es obligatorio

      DateTime.now().day, // No se usa, pero es obligatorio

      int.parse(modelMatricPotential.hoursIrrigationTime), //* Hora

      int.parse(modelMatricPotential.minutesIrrigationTime), //* Minutos
    ).add(
      Duration(hours: 5), //! Se suman 5 horas para no tener conflicto con UTC
    );

    //! Obtener las decenas y unidades de la hora y los minutos.

    int hour = ((((0x80 | ((alarm.hour % 100 - alarm.hour % 10) ~/ 10) << 4)) |
        (alarm.hour % 10)));
    int minute = alarm.minute > 0
        ? ((((0x80 | ((alarm.minute % 100 - alarm.minute % 10) ~/ 10) << 4)) |
            (alarm.minute % 10)))
        : ((((0x7F & ((alarm.minute % 100 - alarm.minute % 10) ~/ 10) << 4)) |
            (alarm.minute % 10)));

    //print( (( (( 0x80 | ((alarm.hour%100 - alarm.hour%10) ~/ 10)<<4)) |  (alarm.hour % 10))).toRadixString(2) + ':' +
    //         (( (( 0x80 | ((alarm.minute%100 - alarm.minute%10) ~/ 10)<<4)) |  (alarm.minute % 10))).toRadixString(2)
    //);
    print((hour).toRadixString(2) + ':' + (minute).toRadixString(2));

    modelMatricPotential.getIrrigationTime =
        modelMatricPotential.hoursIrrigationTime +
            ':' +
            modelMatricPotential.minutesIrrigationTime;

    await sendDataToDevice(
        [MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_TIME, minute, hour, 0x00, 0x00],
        log: ('Establecer la hora para inicio de riego automático a las: ' +
            modelMatricPotential.hoursIrrigationTime +
            ':' +
            modelMatricPotential.minutesIrrigationTime));
  }

  Future<void> bleApiSetIrrigationStatus(bool v) async {
    await sendSetRequest(MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_STATUS, v);
  }

  Future<void> bleApiSetRTCCalibrationOffset(int v) async {
    await sendDataToDevice([MATRIC_POTENTIAL_CMDS.SET_RTC_OFFSET, v]);
  }

  Future<void> bleApiSetRTCCLKOUT(int v) async {
    await sendDataToDevice([MATRIC_POTENTIAL_CMDS.SET_RTC_CLKOUT, v]);
  }

  Future<void> bleApiSetIrrigationThreshold() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setIrrigationThreshold.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setIrrigationThreshold)) {
        value = int.parse(modelMatricPotential.setIrrigationThreshold);
        if (value > 255 || value < 0) {
          modelMatricPotential.errorSetIrrigationThreshold =
              'range_error'.trArgs(['0 - 255']);
          error = true;
          print('Valor fuera del rango');
        }
      } else {
        modelMatricPotential.errorSetIrrigationThreshold = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorSetIrrigationThreshold = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice([
        MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_STATUS,
        value
      ], log: 'Establecer el umbral para inicio de riego automático en $value kPa');
    }
  }

  Future<void> bleApiSetElectrovalveControl() async {
    _isWorkElectrovalve.value = true;

    _timer = Timer(Duration(seconds: 10), () {
      _isWorkElectrovalve.value = false;
    });

    await sendSetRequest(MATRIC_POTENTIAL_CMDS.SET_ELECTROVALVE_CONTROL,
        !modelMatricPotential.electrovalveStatus);
  }

  void onChangedSetIrrigationTime(String text) {
    modelMatricPotential.setIrrigationTime = text;
    if (modelMatricPotential.errorSetIrrigationTime != null) {
      modelMatricPotential.errorSetIrrigationTime = null;
    }
  }

  void onChangedSetIrrigationThreshold(String text) {
    modelMatricPotential.setIrrigationThreshold = text;
    if (modelMatricPotential.errorSetIrrigationThreshold != null) {
      modelMatricPotential.errorSetIrrigationThreshold = null;
    }
  }

  Future<void> bleApiSetIrrigationTime() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setIrrigationTime.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setIrrigationTime)) {
        value = int.parse(modelMatricPotential.setIrrigationTime);
        if (value > 9999 || value < 0) {
          modelMatricPotential.errorSetIrrigationTime =
              'range_error'.trArgs(['0 - 9999']);
          error = true;
        }
      } else {
        modelMatricPotential.errorSetIrrigationTime = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorSetIrrigationTime = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_TIME,
            ...listIntLsbToMsb(divideIntInNBytes(value, 4))
          ]),
          log: 'Irrigation time: $value minutes');
    }
  }

  void onChangedSetIrrigationWaitTime(String text) {
    modelMatricPotential.setIrrigationWaitTime = text;
    if (modelMatricPotential.errorSetIrrigationWaitTime != null) {
      modelMatricPotential.errorSetIrrigationWaitTime = null;
    }
  }

  Future<void> bleApiSetIrrigationWaitTime() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setIrrigationWaitTime.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setIrrigationWaitTime)) {
        value = int.parse(modelMatricPotential.setIrrigationWaitTime);
        if (value > 9999 || value < 0) {
          modelMatricPotential.errorSetIrrigationWaitTime =
              'range_error'.trArgs(['0 - 9999']);
          error = true;
        }
      } else {
        modelMatricPotential.errorSetIrrigationWaitTime = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorSetIrrigationWaitTime = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            MATRIC_POTENTIAL_CMDS.SET_IRRIGATION_WAIT_TIME,
            ...listIntLsbToMsb(divideIntInNBytes(value, 4))
          ]),
          log: 'Irrigation wait time: $value minutes');
    }
  }

  void onChangedSetPvToStartIrrigation(String text) {
    modelMatricPotential.setPvToStartIrrigation = text;
    if (modelMatricPotential.errorSetPvToStartIrrigation != null) {
      modelMatricPotential.errorSetPvToStartIrrigation = null;
    }
  }

  Future<void> bleApiSetPvToStartIrrigation() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setPvToStartIrrigation.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setPvToStartIrrigation)) {
        value = int.parse(modelMatricPotential.setPvToStartIrrigation);

        if (value > 255 || value < 0) {
          modelMatricPotential.errorSetPvToStartIrrigation =
              'range_error'.trArgs(['0 - 255']);
          error = true;
          print('Valor fuera del rango');
        }
      } else {
        modelMatricPotential.errorSetPvToStartIrrigation = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorSetPvToStartIrrigation = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            MATRIC_POTENTIAL_CMDS.SET_PV_TO_START_IRRIGATION,
            ...listIntLsbToMsb(divideIntInNBytes(value, 4))
          ]),
          log: 'Pressure to start irrigation: $value kPa');
    }
  }

  void onChangedSetPvToStopIrrigation(String text) {
    modelMatricPotential.setPvToStopIrrigation = text;
    if (modelMatricPotential.errorSetPvToStopIrrigation != null) {
      modelMatricPotential.errorSetPvToStopIrrigation = null;
    }
  }

  Future<void> bleApiSetPvToStopIrrigation() async {
    bool error = false;
    int value;

    if (modelMatricPotential.setPvToStopIrrigation.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelMatricPotential.setPvToStopIrrigation)) {
        value = int.parse(modelMatricPotential.setPvToStopIrrigation);
        if (value > 255 || value < 0) {
          modelMatricPotential.errorSetPvToStopIrrigation =
              'range_error'.trArgs(['0 - 255']);
          error = true;
        }
      } else {
        modelMatricPotential.errorSetPvToStopIrrigation = 'format_error'.tr;
        error = true;
      }
    } else {
      modelMatricPotential.errorSetPvToStopIrrigation = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([
            MATRIC_POTENTIAL_CMDS.SET_PV_TO_STOP_IRRIGATION,
            ...listIntLsbToMsb(divideIntInNBytes(value, 4))
          ]),
          log: 'Pressure to stop irrigation: $value kPa');
    }
  }

  void onChangedSetGmIrrigationControl(int k) {
    modelMatricPotential.setGmIrrigationControl = k;
    if (modelMatricPotential.errorSetGmIrrigationControl != null)
      modelMatricPotential.errorSetGmIrrigationControl = null;
  }

  Future<void> bleApiSetGmIrrigationControl() async {
    if (MATRIC_POTENTIAL_CONSTANTS.GM_SENSOR_MAP
        .containsKey(modelMatricPotential.setGmIrrigationControl)) {
      await sendDataToDevice([
        MATRIC_POTENTIAL_CMDS.SET_GM_IRRIGATION_CONTROL,
        modelMatricPotential.setGmIrrigationControl
      ], log: 'Selected: ${MATRIC_POTENTIAL_CONSTANTS.GM_SENSOR_MAP[modelMatricPotential.setGmIrrigationControl]}');
    } else
      modelMatricPotential.errorSetGmIrrigationControl = 'select_error'.tr;
  }
}
