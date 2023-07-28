import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iobix/app/gsheet_api_keys/abp_sheet_api.dart';
import 'package:share/share.dart';

import '../../device_controller.dart';
import '../../../../data/models/local/model_device_information.dart';
import '../../../../data/models/local/model_device_general.dart';
import '../../../../data/models/local/model_device_bluetooth.dart';
import '../../../../data/models/local/model_device_memory.dart';
import '../../../../data/models/local/model_log_console.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/ble_api/ble_general_commands.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../../utils/helpers/ble_api/ble_api_device_memory.dart';
import '../../../../utils/helpers/storage.dart';

class SystemTabController extends GetxController {
  static AbpSheetApi gsheet = AbpSheetApi();

  ModelDeviceInformation modelDeviceInformation = ModelDeviceInformation();
  ModelDeviceGeneral modelDeviceGeneral = ModelDeviceGeneral(
      getRtcDate: DateTime.now(),
      setRtcDate: DateTime.now(),
      setRtcTime: TimeOfDay.now());
  ModelDeviceBluetooth modelDeviceBluetooth = ModelDeviceBluetooth();
  ModelDeviceMemory modelDeviceMemory = ModelDeviceMemory(
      readInitDate: DateTime.now(), readFinishDate: DateTime.now());

  RxBool _hideOldPassword = true.obs;
  RxBool _hideNewPassword = true.obs;
  bool get hideOldPassword => _hideOldPassword.value;
  bool get hideNewPassword => _hideNewPassword.value;

  Timer _timerSendTestData;
  RxBool _isEnableSendTestData = true.obs;
  bool get isEnableSendTestData => _isEnableSendTestData.value;

  RxMap<int, String> gsheetSheetNames =
      RxMap<int, String>(gsheet.getSpreadSheetsNames());

  RxInt _currentGSheetId = 0.obs;
  int get currentGSheetId => _currentGSheetId.value;
  set currentGSheetId(int v) => _currentGSheetId.value = v;

  @override
  void onClose() {
    _timerSendTestData?.cancel();
    super.onClose();
  }

  void onChangedHideOldPassword() =>
      _hideOldPassword.value = !_hideOldPassword.value;
  void onChangedHideNewPassword() =>
      _hideNewPassword.value = !_hideNewPassword.value;

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> sendSetRequest(int cmd, bool v) async {
    await Get.find<DeviceController>().sendSetRequest(cmd, v);
  }

  void addLogToConsoleByCmd(ModelLogConsole consoleLog) {
    Get.find<DeviceController>().addLogToConsoleByCmd(consoleLog);
  }

  /////////////////////// DEVICE INFORMATION ///////////////////////
  Future<void> bleApiGetDeviceInformation({bool getInfo = true}) async {
    await sendDataToDevice([BLE_GENERAL_CMDS.DEVELOPER]);
    if (getInfo) await sendDataToDevice([BLE_GENERAL_CMDS.DEVICE_INFO]);
    await sendDataToDevice([BLE_GENERAL_CMDS.FIRMWARE_VERSION]);
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_HARDWARE_ID]);
    await sendDataToDevice([BLE_GENERAL_CMDS.API_BLE_VERSION]);
  }

  void changeGSheetToWork(String c) {
    currentGSheetId = int.parse(c);
    gsheet.setWorkSpreadSheet(currentGSheetId);
    modelDeviceInformation.errorSetAutomaticID = null;
  }

  void onChangedSetId(String text) {
    modelDeviceInformation.setId = text;
    if (modelDeviceInformation.errorSetId != null) {
      modelDeviceInformation.errorSetId = null;
    }
  }

  Future<void> getUpdatedData() async {
    Map<int, String> result = await gsheet.updateSpreadSheetsNames();
    gsheetSheetNames = RxMap<int, String>(result);
    update(['systemTapSetView']);
  }

  Future<void> bleApiSetId() async {
    if (modelDeviceInformation.setId.length > 0) {
      if (modelDeviceInformation.setId.length == 10) {
        if (CONSTANTS.hexadecimalFormat
            .hasMatch(modelDeviceInformation.setId)) {
          await sendDataToDevice([
            BLE_GENERAL_CMDS.SET_HARDWARE_ID,
            ...hexaAsciiToListInt(modelDeviceInformation.setId)
          ], log: 'ID: ${modelDeviceInformation.setId}');

          modelDeviceInformation.getId = modelDeviceInformation.setId;
          String bleName =
              '${CONSTANTS.COLBITS_BLE_DEVICE_NAME[Get.find<DeviceController>().currentDeviceConnect]}${modelDeviceInformation.setId}';

          await sendDataToDevice(
              [BLE_GENERAL_CMDS.SET_DEVICE_NAME, ...utf8.encode(bleName)],
              log: 'New name: $bleName');
        } else
          modelDeviceInformation.errorSetId = 'format_error'.tr;
      } else
        modelDeviceInformation.errorSetId = 'len_error'.trArgs(['10']);
    } else
      modelDeviceInformation.errorSetId = 'empty_error'.tr;
  }

  void onChangedSetAutomaticID(String text) {
    modelDeviceInformation.setAutomaticID = text;
    if (modelDeviceInformation.errorSetAutomaticID != null) {
      modelDeviceInformation.errorSetAutomaticID = null;
    }
  }

  void getIDFromGSheet() async {
    //gsheet.init(); modelDeviceInformation.setAutomaticID

    if (modelDeviceInformation.setAutomaticID == null ||
        modelDeviceInformation.setAutomaticID == '') {
      modelDeviceInformation.errorSetAutomaticID =
          'Ingrese un número de consecutivo';
    } else if (modelDeviceInformation.setAutomaticID == '0') {
      modelDeviceInformation.errorSetAutomaticID =
          'El identificador no puede ser 0';
    } else {
      List<String> result = await gsheet
          .getById(int.parse(modelDeviceInformation.setAutomaticID));

      if (result == null) {
        modelDeviceInformation.errorSetAutomaticID =
            'Seleccione una opción de la lista desplegable';
      } else {
        if (result[0] == '') {
          modelDeviceInformation.errorSetAutomaticID =
              'Revisa el identificador en la API';
        } else {
          modelDeviceInformation.setId = result[0].replaceAll(' ', '');
        }

        if (modelDeviceInformation.errorSetAutomaticID == null) {
          bleApiSetId();
        }
      }
    }
  }

  /////////////////////// GENERAL DEVICE ///////////////////////
  Future<void> bleApiMcuReset() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.MCU_RESET]);
  }

  Future<void> bleApiBuzzer() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.BUZZER]);
  }

  Future<void> bleApiLeds(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.LEDS, v);
  }

  Future<void> bleApiAcelerometer(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.ACELEROMETER, v);
  }

  Future<void> bleApiGnss(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.GNSS, v);
  }

  void onChangedMeasureTime(String text) {
    modelDeviceGeneral.setMeasureTime = text;
    if (modelDeviceGeneral.errorMeasureTime != null)
      modelDeviceGeneral.errorMeasureTime = null;
  }

  Future<void> bleApiMeasureTime() async {
    if (modelDeviceGeneral.setMeasureTime.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelDeviceGeneral.setMeasureTime)) {
        int time = int.parse(modelDeviceGeneral.setMeasureTime);
        if (time >= 10 && time <= 4000000000) {
          sendDataToDevice([
            BLE_GENERAL_CMDS.MEASURE_TIME,
            ...listIntLsbToMsb(divideIntInNBytes(time, 4))
          ], log: '${modelDeviceGeneral.setMeasureTime} seconds');
        } else
          modelDeviceGeneral.errorMeasureTime =
              'range_error'.trArgs(['(10 - 4000000000)']);
      } else
        modelDeviceGeneral.errorMeasureTime = 'format_error'.tr;
    } else
      modelDeviceGeneral.errorMeasureTime = 'empty_error'.tr;
  }

  void onChangedTxTime(String text) {
    modelDeviceGeneral.setTxTime = text;
    if (modelDeviceGeneral.errorTxTime != null) {
      modelDeviceGeneral.errorTxTime = null;
    }
  }

  Future<void> bleApiTxTime() async {
    if (modelDeviceGeneral.setTxTime.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelDeviceGeneral.setTxTime)) {
        int time = int.parse(modelDeviceGeneral.setTxTime);
        if (time >= 2 && time < 71000000) {
          sendDataToDevice([
            BLE_GENERAL_CMDS.TX_TIME,
            ...listIntLsbToMsb(divideIntInNBytes(time, 4))
          ], log: '${modelDeviceGeneral.setTxTime} minutes');
        } else
          modelDeviceGeneral.errorTxTime =
              'range_error'.trArgs(['(2 - 71000000)']);
      } else
        modelDeviceGeneral.errorTxTime = 'format_error'.tr;
    } else
      modelDeviceGeneral.errorTxTime = 'empty_error'.tr;
  }

  Future<void> bleApiMaintenance(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.MAINTENANCE_MODE, v);
  }

  Future<void> bleApiGeneralReport() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.G_HEALTHY_REPORT],
        log: 'Please wait a moment');
  }

  Future<void> getDatePickerRtc(BuildContext context) async {
    DateTime dateNow = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: dateNow,
      lastDate: DateTime(modelDeviceGeneral.setRtcDate.year + 1),
    );

    if (picked != null) modelDeviceGeneral.setRtcDate = picked;
  }

  Future<void> getTimePickerRtc(BuildContext context) async {
    TimeOfDay timeNow = TimeOfDay.now();

    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: timeNow);

    if (picked != null) {
      if (picked.minute - timeNow.minute < 0)
        modelDeviceGeneral.setRtcTime = timeNow;
      else
        modelDeviceGeneral.setRtcTime = picked;
    }
  }

  Future<void> bleApiSetRtc() async {
    DateTime dateSeconds = DateTime.now();
    DateTime date = DateTime(
        modelDeviceGeneral.setRtcDate.year,
        modelDeviceGeneral.setRtcDate.month,
        modelDeviceGeneral.setRtcDate.day,
        modelDeviceGeneral.setRtcTime.hour,
        modelDeviceGeneral.setRtcTime.minute);

    if (date.difference(DateTime.now()).inMinutes >= 0) {
      DateTime utc = date.toUtc();
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_RTC,
        ...divideIntInNBytes(utc.year, 2),
        utc.month,
        utc.day,
        utc.hour,
        utc.minute,
        dateSeconds.second
      ]);
    } else {
      addLogToConsoleByCmd(ModelLogConsole(
          cmd: BLE_GENERAL_CMDS.SET_RTC,
          log:
              'The date you want to set must be greater than that of the device, check and try again',
          isResponse: true,
          isResponseOk: false,
          cmdError: BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_SET_RTC));
    }
  }

  Future<void> bleApiConfirmedMessages(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.CONFIRMED_MESSAGES, v);
  }

  void showDebugFrame(bool v) async {}

  Future<void> bleApiSendTestData() async {
    if (_isEnableSendTestData.value) {
      _isEnableSendTestData.value = false;
      await sendDataToDevice([BLE_GENERAL_CMDS.SEND_TEST_DATA],
          log: 'Please wait a moment');
      _timerSendTestData = Timer(Duration(seconds: 10), () {
        _isEnableSendTestData.value = true;
      });
    }
  }

  Future<void> bleApiGpsSync() async {
    modelDeviceGeneral.isGpsSync = true;
    await sendDataToDevice([BLE_GENERAL_CMDS.GPS_SYNC],
        log: 'Please wait a moment');
  }

  /////////////////////// BLUETOOTH MODULE ///////////////////////
  Future<void> bleApiTurnOffBle() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.TURN_OFF_BLE]);
  }

  void onChangedSetDeviceName(String text) {
    modelDeviceBluetooth.setDeviceName = text;
    if (modelDeviceBluetooth.errorSetDeviceName != null) {
      modelDeviceBluetooth.errorSetDeviceName = null;
    }
  }

  Future<void> bleApiSetDeviceName() async {
    if (modelDeviceBluetooth.setDeviceName.length > 0) {
      String _prefix = CONSTANTS.COLBITS_BLE_DEVICE_NAME[
          Get.find<DeviceController>().currentDeviceConnect];

      String _name = _prefix + modelDeviceBluetooth.setDeviceName;

      if (_name.length < 20) {
        await sendDataToDevice(
            [BLE_GENERAL_CMDS.SET_DEVICE_NAME, ...utf8.encode('$_name')],
            log: 'New name: $_name');
      } else {
        modelDeviceBluetooth.errorSetDeviceName =
            'El nombre debe ser de máximo ${20 - _prefix.length} caracteres';
      }
    } else
      modelDeviceBluetooth.errorSetDeviceName = 'empty_error'.tr;
  }

  Future<void> bleApiSendPassword(String password) async {
    await sendDataToDevice(
        [BLE_GENERAL_CMDS.PASSWORD_API, ...utf8.encode(password)]);
  }

  void onChangedSetOldPassword(String text) {
    modelDeviceBluetooth.setOldPassword = text;
    if (modelDeviceBluetooth.errorSetOldPassword != null) {
      modelDeviceBluetooth.errorSetOldPassword = null;
    }
  }

  void onChangedSetNewPassword(String text) {
    modelDeviceBluetooth.setNewPassword = text;
    if (modelDeviceBluetooth.errorSetNewPassword != null) {
      modelDeviceBluetooth.errorSetNewPassword = null;
    }
  }

  Future<void> bleApiSetPassword() async {
    bool error = false;

    if (modelDeviceBluetooth.setOldPassword.length > 0) {
      if (modelDeviceBluetooth.setOldPassword.length != 4) {
        modelDeviceBluetooth.errorSetOldPassword = 'error_apilogin_len'.tr;
        error = true;
      }
    } else {
      modelDeviceBluetooth.errorSetOldPassword = 'empty_error'.tr;
      error = true;
    }

    if (modelDeviceBluetooth.setNewPassword.length > 0) {
      if (modelDeviceBluetooth.setNewPassword.length != 4) {
        modelDeviceBluetooth.errorSetNewPassword = 'error_apilogin_len'.tr;
        error = true;
      }
    } else {
      modelDeviceBluetooth.errorSetNewPassword = 'empty_error'.tr;
      error = true;
    }

    if (!error)
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_PASSWORD_API,
        ...utf8.encode(modelDeviceBluetooth.setOldPassword),
        ...utf8.encode(modelDeviceBluetooth.setNewPassword)
      ], log: 'Old password: ${modelDeviceBluetooth.setOldPassword}, New password: ${modelDeviceBluetooth.setNewPassword}');
  }

  /////////////////////// MEMORY MODULE ///////////////////////
  void onChangedMemoryLogType(int k) {
    modelDeviceMemory.logType = k;
    modelDeviceMemory.dataType = null;
  }

  void onChangedMemoryDataType(int k) {
    modelDeviceMemory.dataType = k;
    if (modelDeviceMemory.errordataType != null) {
      modelDeviceMemory.errordataType = null;
    }
  }

  Map<int, String> memoryDataTypeMap() {
    return modelDeviceMemory.logType == BLE_GENERAL_CMDS.READ_LOGSYS
        ? BLE_GENERAL_CONSTANTS.MEMORY_DATA_TYPE_LOGSYS
        : Get.find<DeviceController>()
            .modelDeviceTypeParameters
            .memoryDataTypeLogApp;
  }

  Future<void> getDateRangePickerMemory(BuildContext context) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
            start: modelDeviceMemory.readInitDate,
            end: modelDeviceMemory.readFinishDate),
        firstDate: DateTime(modelDeviceMemory.readInitDate.year - 2),
        lastDate: DateTime(modelDeviceMemory.readInitDate.year + 2));

    if (picked != null && picked.start != null && picked.end != null) {
      modelDeviceMemory.readInitDate = picked.start;
      int checkDays = picked.end.difference(picked.start).inDays;
      if (checkDays > 27) {
        int daysSub = checkDays - 27;
        modelDeviceMemory.readFinishDate =
            (picked.end).subtract(Duration(days: daysSub));
      } else
        modelDeviceMemory.readFinishDate = picked.end;
    }
  }

  Future<void> bleApiMemoryRead() async {
    if (modelDeviceMemory.dataType != null) {
      memoryReadInitialization(modelDeviceMemory);
      modelDeviceMemory.isReadData = true;
      await sendDataToDevice([
        modelDeviceMemory.logType,
        ...setMemoryDateRangeFormat(modelDeviceMemory.dataType,
            modelDeviceMemory.readInitDate, modelDeviceMemory.readFinishDate)
      ]);
    } else
      modelDeviceMemory.errordataType = 'select_error'.tr;
  }

  void cancelMemoryRead() {
    memoryReadInitialization(modelDeviceMemory);
  }

  Future<void> readMemoryLogs() async {
    String logs = await Storage.readData();

    Get.find<DeviceController>().addLogToConsole(
        '${getCurrentHour()} Logs file - [REQ] Reading on console \r\n\n$logs\n\n');
  }

  Future<void> shareMemoryLogs() async {
    await Share.shareFiles(
        ['${await Storage.localPath}/${CONSTANTS.DEVICE_LOGS_PATH}']);
  }

  Future<void> bleApiClearLogApp() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.CLEAR_LOGAPP],
        log:
            'Starting the cleaning process in the device memory (LogApp), wait a moment');
  }

  Future<void> bleApiClearLogSys() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.CLEAR_LOGSYS],
        log:
            'Starting the cleaning process in the device memory (LogSys), wait a moment');
  }

  void onMapCreated(GoogleMapController controller) {
    modelDeviceGeneral.googleMapController = controller;
  }
}
