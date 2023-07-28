import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';

import '../bluetooth/bluetooth_controller.dart';
import '../../utils/helpers/size_config.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/enums.dart';
import '../../data/models/local/model_login.dart';

class HomeController extends GetxController {
  // Global Instances
  final BluetoothController _blue = Get.find<BluetoothController>();

  //Local
  BluetoothState get blueState => _blue.state;
  bool get blueIsScanning => _blue.scanning;
  List<BluetoothDevice> get blueDevices => _blue.devices;

  // Info for StepProgress
  StreamSubscription<BluetoothProgressTryConnectToDevice>
      _blueProgressTryConnectToDeviceStream;
  int get stepsProgressTryConnectToDevice =>
      BluetoothProgressTryConnectToDevice.values.length;
  int get currentIndexStepProgressTryConnectToDevice =>
      _blue.currentIndexStepProgressConnectToDevice;

  bool get blueTryConnectToDevice => _blue.tryConnectToDevice;
  bool get blueErrorTryConnectToDevice => _blue.errorFgTryConnectToDevice;
  String get blueErrorMsgTryConnectToDevice => _blue.errorMsgTryConnectToDevice;

  //Drawer Values
  double xOffsetDrawer = 0.0;
  double yOffsetDrawer = 0.0;
  double scaleFactorDrawer = 1.0;
  bool isDrawerOpen = false;
  List<Map<String, dynamic>> drawerItems = [
    {
      'icon': Icons.developer_board_rounded,
      'title': 'drawer_devices',
      'route': ''
    },
    {'icon': Icons.info_outline_rounded, 'title': 'drawer_about', 'route': ''}
  ];

  @override
  void onInit() {
    super.onInit();
    //Listener Progress Connect To Device
    _blueProgressTryConnectToDeviceStream = _blue
        .currentStepProgressConnectToDevice
        .listen((BluetoothProgressTryConnectToDevice progress) {
      if (progress == BluetoothProgressTryConnectToDevice.connected) {
        _goToColbitsDeviceScreen();
      }
    });
  }

  @override
  void onClose() {
    _blueProgressTryConnectToDeviceStream?.cancel();
    super.onClose();
  }

  String msgProgressTryConnectToDevice(int step) =>
      _blue.msgProgressTryConnectToDevice[step].tr;

  void showDrawer() {
    if (isDrawerOpen) {
      xOffsetDrawer = 0.0;
      yOffsetDrawer = 0.0;
      scaleFactorDrawer = 1.0;
      isDrawerOpen = false;
    } else {
      xOffsetDrawer = getProportionateScreenWidth(0.6);
      yOffsetDrawer = getProportionateScreenHeight(0.2);
      scaleFactorDrawer = 0.6;
      isDrawerOpen = true;
    }
    update(['home']);
  }

  void initBlueScan() => _blue.initScanDevices();

  Future<void> connectToDevice(BluetoothDevice device) async =>
      await _blue.connectToDevice(device);

  String checkDeviceType(BluetoothDevice device) {
    String name = device.name, deviceType;
    bool error = false;

    List<String> split = name.split('_');

    if (split.length == 3) {
      if (split[0] == CONSTANTS.COLBITS_NAME_PREFIX) {
        String type = split[1];
        deviceType = CONSTANTS.COLBITS_BLE_DEVICE_TYPE.containsKey(type)
            ? CONSTANTS.COLBITS_BLE_DEVICE_TYPE[type]
            : 'ble_name_unknown';
      } else
        error = true;
    } else
      error = true;

    return error ? 'ble_name_unknown' : deviceType;
  }

  void logout() => Get.offNamed(AppRoutes.LOGIN);
  void config() => Get.toNamed(AppRoutes.CONFIG);
  void drawerOption(String route) => Get.toNamed(route);

  Future<void> _goToColbitsDeviceScreen() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offNamed(AppRoutes.DEVICE);
  }

  void unlockAdmin() {
    ModelLogin.attemptsUnlockAdmin++;

    if (ModelLogin.attemptsUnlockAdmin == 10) {
      ModelLogin.unlockAdmin = true;

      // Show snackbar
      print('Ahora eres admin');
    } else if (ModelLogin.attemptsUnlockAdmin > 10) {
      // Show snackbar already admin unlock
      print('Ya eres admin');
    }
  }
}
