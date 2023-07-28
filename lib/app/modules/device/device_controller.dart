import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../utils/constants/constants.dart';
import '../../utils/constants/enums.dart';
import '../../routes/app_routes.dart';
import '../bluetooth/bluetooth_controller.dart';
import '../../utils/helpers/helpers.dart';
import '../../data/models/local/model_device_type_parameters.dart';
import '../../utils/constants/keys.dart';
import '../../utils/constants/ble_api/ble_general_commands.dart';
import '../../utils/helpers/ble_api/ble_api_specific_device.dart';
import '../../utils/helpers/ble_api/ble_api_device_information.dart';
import '../../utils/helpers/ble_api/ble_api_device_general.dart';
import '../../utils/helpers/ble_api/ble_api_device_bluetooth.dart';
import '../../utils/helpers/ble_api/ble_api_device_memory.dart';
import '../../utils/helpers/ble_api/ble_api_device_lorawan.dart';
import '../../data/models/local/model_log_console.dart';
import '../../utils/constants/ble_api/ble_general_constants.dart';
import './widgets/lorawan_tab/lorawan_tab_controller.dart';
import './widgets/system_tab/system_tab_controller.dart';
import '../../data/models/local/model_login.dart';
import '../../theme/color_theme.dart';

class DeviceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Global Instances
  final BluetoothController _blue = Get.find<BluetoothController>();
  final LorawanTabController lorawanTabController =
      Get.find<LorawanTabController>();
  final SystemTabController _systemTabController =
      Get.find<SystemTabController>();

  // Streams
  StreamSubscription<BluetoothState> _blueStateStream;
  StreamSubscription<BluetoothDeviceState> _blueDeviceStateStream;
  StreamSubscription<List<int>> _blueRxFrameStream;

  ColbitsCompatibleVersion get currentDeviceConnect =>
      _blue.currentDeviceVersionConnect;

  RxList<String> title = ['title', '0'].obs;

  TabController tabController;
  final tabViews = <Tab>[
    Tab(text: 'device'.tr),
    Tab(text: 'system'.tr),
    Tab(text: 'LoRaWAN')
  ];

  Rx<BottomNavBarDevice> _bottomNavBarIdx = BottomNavBarDevice.home.obs;
  BottomNavBarDevice get bottomNavBarIdx => _bottomNavBarIdx.value;

  RxString _consoleText = ''.obs;
  String get consoleText => _consoleText.value;
  RxInt _counterNotifyConsole = 0.obs;
  int get counterNotifyConsole => _counterNotifyConsole.value;
  bool showCounterNotifyConsole = false;
  RxBool _floatingConsole = ModelLogin.isAdmin().obs;
  bool get floatingConsole => _floatingConsole.value;

  RxBool _hideApiPassword = true.obs;
  bool get hideApiPassword => _hideApiPassword.value;
  void onChangedHideApiPassword() =>
      _hideApiPassword.value = !_hideApiPassword.value;
  RxBool _isApiLogin = false.obs;
  bool get isApiLogin => _isApiLogin.value;
  RxString _errorApiLogin = 'enter_password'.obs;
  String get errorApiLogin => _errorApiLogin.value;
  int attemptsApiLogin = 3;
  String passwordApiLogin = '';
  RxBool _isWaitRespApiLogin = false.obs;
  bool get isWaitRespApiLogin => _isWaitRespApiLogin.value;

  String setTramaBluetooth = '';
  RxString _errorSetTramaBluetooth = ''.obs;
  String get errorSetTramaBluetooth => _errorSetTramaBluetooth.value;

  // BLE API Models
  ModelDeviceTypeParameters modelDeviceTypeParameters =
      ModelDeviceTypeParameters();

  @override
  Future<void> onInit() async {
    tabController = TabController(length: tabViews.length, vsync: this);

    // Specific device initialization: controller and constants
    title.assignAll(specificDeviceInitialization(
        modelDeviceTypeParameters, _blue.currentDeviceVersionConnect));

    super.onInit();

    /// Listener State Bluetooth
    _blueStateStream = _blue.stateObservable.listen((BluetoothState state) {
      _onChangedBluetoothState(state);
    });

    /// Listener State Device
    _blueDeviceStateStream =
        _blue.deviceStateObservable.listen((BluetoothDeviceState state) {
      _onChangedBluetoothDeviceState(state);
    });

    /// Listener Rx Frame Device
    _blueRxFrameStream = _blue.rxFrameObservable.listen(rxBluetoothCallback);
  }

  @override
  void onReady() {
    // is Colbits Admin, se envia password
    if (ModelLogin.isRole(Roles.superAdmin)) {
      passwordApiLogin = KEYS.DEVICE_DEFAULT_KEY;
      sendPasswordApiLogin();
    }
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    _blueStateStream?.cancel();
    _blueDeviceStateStream?.cancel();
    _blueRxFrameStream?.cancel();
    await _disconnectDevice();
    super.onClose();
  }

  void rxBluetoothCallback(List<int> frame) async {
    if (frame.isNotEmpty && frame != null) {
      // API Bluetooth
      final int cmd = frame[0];

      if (cmd >= BLE_GENERAL_CMDS.INFORMATION_RANGE_MIN &&
          cmd <= BLE_GENERAL_CMDS.INFORMATION_RANGE_MAX) {
        addLogToConsoleByCmd(bleApiDeviceInformation(
            frame, _systemTabController.modelDeviceInformation));
      } else if (cmd == BLE_GENERAL_CMDS.DEBUG_MESSAGE) {
        List<String> result = frame
            .map((e) => e.toRadixString(16))
            .toList(); //* Convierte la lista 'frame' que es de enteros a una lista de strings en base 16
        result.removeAt(
            0); //* Quita el primer elemento de la lista, porque este es el tipo de comando que llegó (0x1D, en este caso)
        addLogToConsoleByCmd(ModelLogConsole(
            cmd: frame[0],
            log: result.toString().toUpperCase(),
            isResponse: true));
      } //* Lo muestra en la consola
      else if (cmd >= BLE_GENERAL_CMDS.GENERAL_RANGE_MIN &&
          cmd <= BLE_GENERAL_CMDS.GENERAL_RANGE_MAX) {
        addLogToConsoleByCmd(bleApiDeviceGeneral(
            frame,
            _systemTabController.modelDeviceGeneral,
            modelDeviceTypeParameters));
      } else if (cmd >= BLE_GENERAL_CMDS.BLUETOOTH_RANGE_MIN &&
          cmd <= BLE_GENERAL_CMDS.BLUETOOTH_RANGE_MAX) {
        addLogToConsoleByCmd(bleApiDeviceBluetooth(frame));
        if (cmd == BLE_GENERAL_CMDS.PASSWORD_API) {
          _isWaitRespApiLogin.value = false;

          if (frame[1] == BLE_GENERAL_CONSTANTS.STATUS_OK) {
            _isApiLogin.value = true;
            update(['device_page']);
            await _onReadyApiLogin();
            await Future.delayed(Duration(seconds: 3));
            await onReadyApiLoginSpecificDevice(
                _blue.currentDeviceVersionConnect);
          } else {
            _isApiLogin.value = false;
            attemptsApiLogin--;

            switch (attemptsApiLogin) {
              case 2:
                _errorApiLogin.value = 'error_apilogin_2';
                break;

              case 1:
                _errorApiLogin.value = 'error_apilogin_1';
                break;

              case 0:
                await disconnectDevice();
                break;
            }
          }
        }
      } else if (cmd >= BLE_GENERAL_CMDS.MEMORY_RANGE_MIN &&
          cmd <= BLE_GENERAL_CMDS.MEMORY_RANGE_MAX) {
        addLogToConsoleByCmd(bleApiMemory(
            Get.context,
            frame,
            _systemTabController.modelDeviceMemory,
            title,
            _systemTabController.modelDeviceInformation.developer,
            _systemTabController.modelDeviceInformation.firmware,
            _systemTabController.modelDeviceInformation.getId,
            modelDeviceTypeParameters.memoryDataTypeLogApp,
            modelDeviceTypeParameters.memoryDataTypeLogSys));
      } else if (cmd >= BLE_GENERAL_CMDS.LORAWAN_RANGE_MIN &&
          cmd <= BLE_GENERAL_CMDS.LORAWAN_RANGE_MAX) {
        addLogToConsoleByCmd(bleApiDeviceLorawan(
            frame, lorawanTabController.modelDeviceLorawan));
      } else if (cmd >= BLE_GENERAL_CMDS.SPECIFIC_DEVICE_RANGE_MIN &&
          cmd <= BLE_GENERAL_CMDS.SPECIFIC_DEVICE_RANGE_MAX) {
        addLogToConsoleByCmd(
            bleApiSpecificDevice(frame, _blue.currentDeviceVersionConnect));
      } else
        addLogToConsoleByCmd(
            ModelLogConsole(cmd: cmd, log: 'Command not found'));
    }
  }

  Future<void> _onReadyApiLogin() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_HARDWARE]);
    await Future.delayed(Duration(milliseconds: 10));

    //! Descomentar el siguiente bloque de código para habilitar la configuración automática de RTC al loguearse

    _systemTabController.modelDeviceGeneral.setRtcDate = DateTime.now();
    _systemTabController.modelDeviceGeneral.setRtcTime = TimeOfDay.now();
    await _systemTabController.bleApiSetRtc();
    await Future.delayed(Duration(milliseconds: 10));
    await _systemTabController.bleApiGetDeviceInformation(getInfo: false);
    await Future.delayed(Duration(milliseconds: 10));
    await _systemTabController.bleApiGeneralReport();
  }

  void _onChangedBluetoothState(BluetoothState state) async {
    switch (state) {
      case BluetoothState.off:
        disconnectDevice();
        break;

      case BluetoothState.turningOn:
      case BluetoothState.on:
      case BluetoothState.turningOff:
      default:
        break;
    }
  }

  void _onChangedBluetoothDeviceState(BluetoothDeviceState state) async {
    switch (state) {
      case BluetoothDeviceState.disconnected:
        disconnectDevice();
        break;

      case BluetoothDeviceState.connecting:
      case BluetoothDeviceState.connected:
      case BluetoothDeviceState.disconnecting:
      default:
        break;
    }
  }

  Future<void> showSnackBar(ModelLogConsole consoleLog) async {
    bool _showSnackBar = consoleLog.cmd >=
            BLE_GENERAL_CMDS.SPECIFIC_DEVICE_RANGE_MIN
        ? specificDeviceContainSnackBarRequestType(
            consoleLog.cmd, _blue.currentDeviceVersionConnect)
        : BLE_GENERAL_CONSTANTS.SNACKBAR_REQ_TYPE.containsKey(consoleLog.cmd);

    if (_showSnackBar && consoleLog.showSnackBar) {
      String title, message, requestType;
      IconData icon;
      Color backgroundColor,
          iconColor = Colors.white70,
          msgColor = Colors.white70;
      int durationSeconds;

      if (consoleLog.cmd >= BLE_GENERAL_CMDS.SPECIFIC_DEVICE_RANGE_MIN) {
        requestType = specificDeviceSnackBarRequestType(
                consoleLog.cmd, _blue.currentDeviceVersionConnect)
            .tr;
      } else {
        // Special case
        if (consoleLog.cmd ==
            BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK) {
          if (lorawanTabController.isImstModule()) {
            requestType = 'snackbar_set_radiostack'.tr;
          } else {
            requestType = 'snackbar_set_forwardings'.tr;
          }
        } else {
          requestType =
              BLE_GENERAL_CONSTANTS.SNACKBAR_REQ_TYPE[consoleLog.cmd].tr;
        }
      }

      if (consoleLog.isResponse) {
        durationSeconds = 4;

        if (consoleLog.isResponseOk) {
          title = 'res_snackbar_ok'.tr;
          message = 'res_snackbar_ok_msg_common'.tr;
          icon = FontAwesomeIcons.circleCheck;
          backgroundColor = ColorsTheme.purpureBlue;
        } else {
          title = 'res_snackbar_err'.tr;
          message = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR
                  .containsKey(consoleLog.cmdError)
              ? BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR[consoleLog.cmdError].tr
              : 'res_snackbar_err_msg_common'.tr;
          icon = FontAwesomeIcons.circleExclamation;
          backgroundColor = ColorsTheme.salmon;
          durationSeconds = consoleLog.cmdError ==
                  BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_RAK_BUG
              ? 6
              : 4;
        }
      } else {
        title = 'req_snackbar'.tr;
        message = 'req_snackbar_msg_common'.tr;
        icon = FontAwesomeIcons.paperPlane;
        backgroundColor = ColorsTheme.darkBlue;
        durationSeconds =
            consoleLog.cmd == BLE_GENERAL_CMDS.TEST_TX_LORA ? 6 : 3;
      }

      await SystemSound.play(SystemSoundType.alert);
      Get.snackbar('', '',
          padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
          titleText: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          messageText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message,
                  style: TextStyle(
                      color: msgColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
              SizedBox(height: 5.0),
              Text(requestType,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 12)),
            ],
          ),
          icon: Icon(icon, color: iconColor, size: 40),
          shouldIconPulse: false,
          snackPosition: SnackPosition.TOP,
          backgroundColor: backgroundColor,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          duration: Duration(seconds: durationSeconds),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    }
  }

  Future<void> addLogToConsole(String log) async {
    if (ModelLogin.isAdmin()) {
      _consoleText.value = log + _consoleText.value;
      if (_bottomNavBarIdx.value != BottomNavBarDevice.console &&
          !_floatingConsole.value) {
        _counterNotifyConsole++;
        showCounterNotifyConsole = true;
        await SystemSound.play(SystemSoundType.alert);
      }
    }
  }

  void addLogToConsoleByCmd(ModelLogConsole consoleLog) {
    if (ModelLogin.isAdmin()) {
      String cmdText = '';
      String cmdType = consoleLog.isResponse ? '[RES]' : '[REQ]';

      if (consoleLog.cmd >= BLE_GENERAL_CMDS.SPECIFIC_DEVICE_RANGE_MIN) {
        cmdText = specificDeviceConsoleCmdText(
            consoleLog.cmd, _blue.currentDeviceVersionConnect);
      } else
        cmdText = BLE_GENERAL_CONSTANTS.CONSOLE.containsKey(consoleLog.cmd)
            ? BLE_GENERAL_CONSTANTS.CONSOLE[consoleLog.cmd]
            : 'Error ${hexaToAscii([consoleLog.cmd])}';

      addLogToConsole(
          '${getCurrentHour()} $cmdText - $cmdType ${consoleLog.log != null ? consoleLog.log : ''}\r\n');
    } else {
      showSnackBar(consoleLog);
    }
  }

  void clearConsole() => _consoleText.value = '';

  void onChangedFloatingConsole(bool v) {
    _floatingConsole.value = v;
  }

  void onChangedBottomNavBarIndex(int value) {
    _bottomNavBarIdx.value = BottomNavBarDevice.values[value];
    if (_bottomNavBarIdx.value == BottomNavBarDevice.console) {
      _counterNotifyConsole.value = 0;
      showCounterNotifyConsole = false;
    }
  }

  Future<void> _disconnectDevice() async {
    await _blue.disconnectDevice();
  }

  Future<void> disconnectDevice() async {
    await _disconnectDevice();
    Get.offNamed(AppRoutes.HOME);
  }

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    addLogToConsoleByCmd(
        ModelLogConsole(cmd: frame[0], log: log, isResponse: false));
    await _blue.sendDataToDevice(frame);
  }

  Future<void> sendSetRequest(int cmd, bool v) async {
    int payload = v ? 1 : 0;
    await sendDataToDevice([cmd, payload],
        log: BLE_GENERAL_CONSTANTS.SET[payload]);
  }

  void onChangedPasswordApiLogin(String text) {
    passwordApiLogin = text;
  }

  Future<void> sendPasswordApiLogin() async {
    if (passwordApiLogin.length > 0) {
      if (passwordApiLogin.length == 4) {
        _isWaitRespApiLogin.value = true;
        await _systemTabController.bleApiSendPassword(passwordApiLogin);
      } else
        _errorApiLogin.value = 'error_apilogin_len';
    } else
      _errorApiLogin.value = 'enter_password'.tr;
  }

  void onChangedSetTramaBluetooth(String text) {
    setTramaBluetooth = text;
    if (_errorSetTramaBluetooth.value != '') {
      _errorSetTramaBluetooth.value = '';
    }
  }

  void sendTramaBluetooth() {
    bool _error = false;

    if (setTramaBluetooth.length > 0) {
      if (!CONSTANTS.hexadecimalFormat.hasMatch(setTramaBluetooth)) {
        _errorSetTramaBluetooth.value = 'hex_format_error'.tr;
        _error = true;
      }
    } else {
      _errorSetTramaBluetooth.value = 'empty_error'.tr;
      _error = true;
    }

    if (!_error) {
      rxBluetoothCallback(hexaAsciiToListInt(setTramaBluetooth));
    }
  }
}
