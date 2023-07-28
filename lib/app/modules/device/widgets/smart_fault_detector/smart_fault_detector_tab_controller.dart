import 'package:get/get.dart';
import 'package:iobix/app/data/models/local/model_smart_fault_detector.dart';
import 'package:iobix/app/utils/constants/ble_api/smart_fault_detector/smart_fault_detector_commands.dart';
import 'package:iobix/app/utils/constants/constants.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

import '../../../../data/models/local/model_smart_fault_detector.dart';
import 'package:iobix/app/modules/device/device_controller.dart';

class SmartFaultDetectorTabController extends GetxController {
  ModelSmartFaultDetector modelSmartFaultDetector = ModelSmartFaultDetector();

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> dataReport() async {
    await sendDataToDevice([SMART_FAULT_DETECTOR_CMDS.DATA_REPORT]);
  }

  Future<void> updateAlarmMode(int v) async {
    await sendDataToDevice(
        [SMART_FAULT_DETECTOR_CMDS.SET_TIME_REPORT_CHANGING_IN_ALARM_MODE, v]);
  }

  Future<void> clearAlarms() async {
    await sendDataToDevice([SMART_FAULT_DETECTOR_CMDS.CLEAR_ALARMS]);
  }

  ///? Funciones auxiliares para obtener los parámetros

  void onChangedSetTicksPermanent(String text) {
    modelSmartFaultDetector.setTicksToDetonatePermanentAlarm = text;
    if (modelSmartFaultDetector.errorSetTicksToDetonatePermanentAlarm != null) {
      modelSmartFaultDetector.errorSetTicksToDetonatePermanentAlarm = null;
    }
  }

  void onChangedSetTicksTransitory(String text) {
    modelSmartFaultDetector.setTicksToDetonateTransitoryAlarm = text;
    if (modelSmartFaultDetector.errorSetTicksToDetonateTransitoryAlarm !=
        null) {
      modelSmartFaultDetector.errorSetTicksToDetonateTransitoryAlarm = null;
    }
  }

  void onChangedSetTimeToReportFault(String text) {
    modelSmartFaultDetector.setTimeToReportFault = text;
    if (modelSmartFaultDetector.errorSetTimeToReportFault != null) {
      modelSmartFaultDetector.errorSetTimeToReportFault = null;
    }
  }

  void onChangedSetTimeToFaultTimeOut(String text) {
    modelSmartFaultDetector.setTimeToFaultTimeOut = text;
    if (modelSmartFaultDetector.errorSetTimeToFaultTimeOut != null) {
      modelSmartFaultDetector.errorSetTimeToFaultTimeOut = null;
    }
  }

  ///? Funciones auxiliares para establecer los parámetros

  Future<void> bleApiSetTicksToDetonatePermanentAlarm() async {
    bool error = false;
    int value;

    if (modelSmartFaultDetector.setTicksToDetonatePermanentAlarm.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelSmartFaultDetector.setTicksToDetonatePermanentAlarm)) {
        value =
            int.parse(modelSmartFaultDetector.setTicksToDetonatePermanentAlarm);
        if (value > 255 || value < 1) {
          modelSmartFaultDetector.errorSetTicksToDetonatePermanentAlarm =
              'range_error'.trArgs(['1 - 255']);
          error = true;
        }
      } else {
        modelSmartFaultDetector.errorSetTicksToDetonatePermanentAlarm =
            'format_error'.tr;
        error = true;
      }
    } else {
      modelSmartFaultDetector.errorSetTicksToDetonatePermanentAlarm =
          'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([SMART_FAULT_DETECTOR_CMDS.SET_TICKS_PERMANENT_ALARM, value]));
    }
  }

  Future<void> bleApiSetTicksToDetonateTransitoryAlarm() async {
    bool error = false;
    int value;

    if (modelSmartFaultDetector.setTicksToDetonateTransitoryAlarm.length > 0) {
      if (CONSTANTS.positiveIntegerFormat.hasMatch(
          modelSmartFaultDetector.setTicksToDetonateTransitoryAlarm)) {
        value = int.parse(
            modelSmartFaultDetector.setTicksToDetonateTransitoryAlarm);
        if (value > 255 || value < 1) {
          modelSmartFaultDetector.errorSetTicksToDetonateTransitoryAlarm =
              'range_error'.trArgs(['1 - 255']);
          error = true;
        }
      } else {
        modelSmartFaultDetector.errorSetTicksToDetonateTransitoryAlarm =
            'format_error'.tr;
        error = true;
      }
    } else {
      modelSmartFaultDetector.errorSetTicksToDetonateTransitoryAlarm =
          'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([SMART_FAULT_DETECTOR_CMDS.SET_TICKS_TRANSITORY_ALARM, value]));
    }
  }

  Future<void> bleApiSetTimeToReportFault() async {
    ///! Este es especial porque son 4 bytes
    bool error = false;
    int value;

    if (modelSmartFaultDetector.setTimeToReportFault.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelSmartFaultDetector.setTimeToReportFault)) {
        value = int.parse(modelSmartFaultDetector.setTimeToReportFault);
        if (value > 120 || value < 0) {
          modelSmartFaultDetector.errorSetTimeToReportFault =
              'range_error'.trArgs(['1 - 120']);
          error = true;
        }
      } else {
        modelSmartFaultDetector.errorSetTimeToReportFault = 'format_error'.tr;
        error = true;
      }
    } else {
      modelSmartFaultDetector.errorSetTimeToReportFault = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(([
        SMART_FAULT_DETECTOR_CMDS.SET_TIME_TO_REPORT_FAULT,
        ...(divideIntInNBytes(value * 60, 4))
      ]));
    }
  }

  Future<void> bleApiSetTimeToFaultTimeOut() async {
    bool error = false;
    int value;

    if (modelSmartFaultDetector.setTimeToFaultTimeOut.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelSmartFaultDetector.setTimeToFaultTimeOut)) {
        value = int.parse(modelSmartFaultDetector.setTimeToFaultTimeOut);
        if (value > 255 || value < 1) {
          modelSmartFaultDetector.errorSetTimeToFaultTimeOut =
              'range_error'.trArgs(['1 - 255']);
          error = true;
        }
      } else {
        modelSmartFaultDetector.errorSetTimeToFaultTimeOut = 'format_error'.tr;
        error = true;
      }
    } else {
      modelSmartFaultDetector.errorSetTimeToFaultTimeOut = 'empty_error'.tr;
      error = true;
    }

    if (!error) {
      await sendDataToDevice(
          ([SMART_FAULT_DETECTOR_CMDS.TIME_TO_FAULT_TIME_OUT, value]));
    }
  }
}
