import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/custom_alert_modal_bottom_sheet.dart';
import '../../utils/constants/ble_api/ble_general_commands.dart';
import '../../utils/constants/ble_api/ble_general_constants.dart';
import '../../utils/helpers/slip/slip.dart';
import '../../utils/helpers/helpers.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/keys.dart';
import '../../utils/constants/enums.dart';

class BluetoothController extends GetxController {
  //Global instances
  final FlutterBluePlus _blue = Get.find<FlutterBluePlus>();
  final Slip _slip = new Slip();

  //Local
  //Streams
  StreamSubscription<BluetoothState> _stateStream;
  StreamSubscription<bool> _scanningStream;
  StreamSubscription<List<BluetoothDevice>> _connectedDevicesStream;
  StreamSubscription<List<ScanResult>> _scanResultsStream;
  StreamSubscription<List<int>> _rxDeviceStream;
  StreamSubscription<BluetoothDeviceState> _deviceStateStream;

  Rx<BluetoothState> _state = BluetoothState.unknown.obs;
  Rx<BluetoothState> get stateObservable => _state;
  BluetoothState get state => _state.value;

  RxBool _scanning = false.obs;
  bool get scanning => _scanning.value;

  // ignore: deprecated_member_use
  RxList<BluetoothDevice> _devices = List<BluetoothDevice>().obs;
  List<BluetoothDevice> get devices => _devices;

  Rx<BluetoothDeviceState> _deviceState = BluetoothDeviceState.disconnected.obs;
  Rx<BluetoothDeviceState> get deviceStateObservable => _deviceState;
  BluetoothDeviceState get deviceState => _deviceState.value;

  RxList<int> _rxFrame = [0].obs;
  RxList<int> get rxFrameObservable => _rxFrame;
  List<int> get rxFrame => _rxFrame;

  RxBool _tryConnectToDevice = false.obs;
  bool get tryConnectToDevice => _tryConnectToDevice.value;

  RxBool _errorFgTryConnectToDevice = false.obs;
  bool get errorFgTryConnectToDevice => _errorFgTryConnectToDevice.value;

  BluetoothDevice _device;
  List<BluetoothService> _deviceServices;
  BluetoothCharacteristic _deviceChannelWrite;
  BluetoothCharacteristic _deviceChannelRead;

  Rx<BluetoothProgressTryConnectToDevice> currentStepProgressConnectToDevice =
      BluetoothProgressTryConnectToDevice.idle.obs;

  int get currentIndexStepProgressConnectToDevice =>
      currentStepProgressConnectToDevice.value.index;

  Map<int, String> msgProgressTryConnectToDevice = {
    BluetoothProgressTryConnectToDevice.idle.index: 'ble_progress_idle',
    BluetoothProgressTryConnectToDevice.connecting.index:
        'ble_progress_connecting',
    BluetoothProgressTryConnectToDevice.check_services.index:
        'ble_progress_check_services',
    BluetoothProgressTryConnectToDevice.check_compatibility.index:
        'ble_progress_check_compatibility',
    BluetoothProgressTryConnectToDevice.check_api_ble.index:
        'Verificación de nivel de API BLE',
    BluetoothProgressTryConnectToDevice.connected.index:
        'ble_progress_connected',
  };

  int _cmdToCheckCompatibility = BLE_GENERAL_CMDS.GET_HARDWARE_ID;
  int _cmdToCheckApiBleCompatibility = BLE_GENERAL_CMDS.API_BLE_VERSION;

  Timer _timer;
  String errorMsgTryConnectToDevice = '';
  ColbitsCompatibleVersion currentDeviceVersionConnect;

  @override
  void onInit() {
    super.onInit();

    _stateStream = _blue.state.listen((BluetoothState event) {
      print('BLUETOOTH:::: State: $_state');
      _state.value = event;
    });

    _scanningStream = _blue.isScanning.listen((bool event) {
      print('BLUETOOTH:::: is scaning?: $event');
      _scanning.value = event;
      if (event) {
        // Devices already connect
        _connectedDevicesStream = _blue.connectedDevices
            .asStream()
            .listen((List<BluetoothDevice> devices) {
          for (BluetoothDevice device in devices) {
            _addDeviceFound(device);
          }
        });

        // New devices found
        _scanResultsStream =
            _blue.scanResults.listen((List<ScanResult> results) {
          for (ScanResult result in results) {
            _addDeviceFound(result.device);
          }
        });
      } else {
        _connectedDevicesStream?.cancel();
        _scanResultsStream?.cancel();
      }
    });
  }

  @override
  void onClose() {
    _stateStream?.cancel();
    _scanningStream?.cancel();
    _connectedDevicesStream?.cancel();
    _scanResultsStream?.cancel();
    _rxDeviceStream?.cancel();
    _deviceStateStream?.cancel();
    _timer?.cancel();
    super.onClose();
  }

  void _addDeviceFound(final BluetoothDevice device) {
    String name = device.name;
    // Remove RUI devices
    List<String> split = name.split('-');
    bool isRui = false;
    if (split.length > 1 && split[0] == 'RUI') isRui = true;
    if (!_devices.contains(device) && name != '' && !isRui) {
      _devices.add(device);
    }
  }

  void initScanDevices() {
    _devices.clear();
    _errorFgTryConnectToDevice.value = false;
    print('BLUETOOTH:::: Start scan');
    _blue.startScan(timeout: Duration(seconds: 10));
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    initConnectionWithDevice();

    try {
      await device.connect();
      currentStepProgressConnectToDevice.value =
          BluetoothProgressTryConnectToDevice.check_services;
      print('BLUETOOTH:::: Connected to device');
      _deviceServices = await device.discoverServices();

      BluetoothService serviceNordic;

      for (BluetoothService service in _deviceServices) {
        if (service.uuid.toString() == KEYS.SERVICE_UUID_NORDIC_UART) {
          serviceNordic = service;
          break;
        }
      }

      if (serviceNordic != null) {
        for (BluetoothCharacteristic characteristic
            in serviceNordic.characteristics) {
          if (characteristic.properties.write) {
            _deviceChannelWrite = characteristic;
          } else if (characteristic.properties.notify) {
            _deviceChannelRead = characteristic;
          }
        }
        _device = device;
        currentStepProgressConnectToDevice.value =
            BluetoothProgressTryConnectToDevice.check_compatibility;
        await initSubscriptionWithDevice();
      } else {
        print('BLUETOOTH:::: Error in UUID device');
        await _errorTryConnectToDevice('ble_error_compatibility', device);
      }
    } on PlatformException catch (e) {
      String msg = '';
      msg = e.code == 'already_connected'
          ? 'ble_error_already_connected'
          : 'ble_error_unknown';
      await _errorTryConnectToDevice(msg, device);
    } catch (e) {
      await _errorTryConnectToDevice('ble_error_unknown', device);
    }

    return null;
  }

  void initConnectionWithDevice() {
    _blue.stopScan();
    currentStepProgressConnectToDevice.value =
        BluetoothProgressTryConnectToDevice.connecting;
    print('BLUETOOTH:::: Try conect to device');
    _tryConnectToDevice.value = true;
    _timer = Timer(Duration(seconds: 25), () async {
      await _errorTryConnectToDevice('ble_error_timeout', _device);
    });
  }

  Future<void> _errorTryConnectToDevice(
      String msg, BluetoothDevice device) async {
    errorMsgTryConnectToDevice = msg;
    _errorFgTryConnectToDevice.value = true;
    _tryConnectToDevice.value = false;
    _timer?.cancel();
    await disconnectDevice(device: device);
  }

  Future<void> initSubscriptionWithDevice() async {
    _rxDeviceStream = _deviceChannelRead.value.listen((List<int> frame) async {
      if (frame != null && frame.isNotEmpty) {
        String result = frame
            .map((e) => e.toRadixString(16))
            .toList()
            .toString()
            .toUpperCase(); //* Convierte la lista 'frame' que es de enteros a una lista de strings en base 16
        print('BLUETOOTH:::: New frame received para W: $result');
        _rxFrame.assignAll(_slip.rxFrame(frame));

        if (currentStepProgressConnectToDevice.value !=
            BluetoothProgressTryConnectToDevice.connected) {
          if (_rxFrame[0] == _cmdToCheckCompatibility) {
            if (_rxFrame[1] == BLE_GENERAL_CONSTANTS.STATUS_OK) {
              int version = listBytesToInt(_rxFrame.sublist(2, 4));

              if (CONSTANTS.COLBITS_DEVICE_VERSION.containsKey(version)) {
                currentDeviceVersionConnect =
                    CONSTANTS.COLBITS_DEVICE_VERSION[version];
                currentStepProgressConnectToDevice.value =
                    BluetoothProgressTryConnectToDevice.check_api_ble;
                await sendDataToDevice([_cmdToCheckApiBleCompatibility]);
              } else
                await _errorTryConnectToDevice(
                  'ble_error_compatibility',
                  _device,
                );
            } else
              await _errorTryConnectToDevice(
                  'ble_error_compatibility', _device);
          } else if (_rxFrame[0] == _cmdToCheckApiBleCompatibility) {
            _timer?.cancel();
            bool _isErrorApiBle = false, isErrorForNullApiBle = false;
            String apiBleVersion = '';
            if (_rxFrame[1] == BLE_GENERAL_CONSTANTS.STATUS_OK) {
              apiBleVersion =
                  'v${(_rxFrame[2] & 0x0F).toString()}.${((_rxFrame[3] & 0xF0) >> 4).toString()}.${(_rxFrame[3] & 0x0F).toString()}';

              //! Descomentar esta linea para habilitar de nuevo el mensaje de API BLE Version: //if (apiBleVersion == CONSTANTS.API_BLE_VERSION) {
              currentStepProgressConnectToDevice.value =
                  BluetoothProgressTryConnectToDevice.connected;
              //! Descomentar esta linea para habilitar de nuevo el mensaje de API BLE Version: //} else {
              //! Descomentar esta linea para habilitar de nuevo el mensaje de API BLE Version:  //_isErrorApiBle = true;
              //! Descomentar esta linea para habilitar de nuevo el mensaje de API BLE Version: //}
            } else {
              //! Descomentar esta linea para habilitar de nuevo el mensaje de API BLE Version:    //_isErrorApiBle = true;
              //! Descomentar esta linea para habilitar de nuevo el mensaje de API BLE Version:    //isErrorForNullApiBle = true;

              /* Eliminar esta línea para habilitar de nuevo el mensaje de API BLE Version: */
              currentStepProgressConnectToDevice.value =
                  BluetoothProgressTryConnectToDevice.connected;
              /**************************************************************************** */
            }

            if (_isErrorApiBle) {
              showCupertinoModalBottomSheet(
                isDismissible: false,
                barrierColor: Colors.black38,
                expand: false,
                context: Get.context,
                builder: (context) => CustomAlertModalBottomSheet(
                  title: 'Alerta',
                  message:
                      'Su dispositivo IoT no cuenta con ${(isErrorForNullApiBle) ? 'una versión' : 'la última versión'} de API de la interface Bluetooth, es posible que experimente fallos en la aplicación y la comunicación con su dispositivo. Le sugerimos que actualice su dispositivo IoT a la última versión soportada por la aplicación: ${CONSTANTS.API_BLE_VERSION}. Aún asi, ¿Desea continuar?',
                  actionYes: () {
                    currentStepProgressConnectToDevice.value =
                        BluetoothProgressTryConnectToDevice.connected;
                  },
                  actionNo: () async {
                    await _errorTryConnectToDevice(
                      'El dispositivo IoT ${(isErrorForNullApiBle) ? 'no cuenta con una versión de API de la interface Bluetooth' : 'cuenta con una versión de API de la interface Bluetooth ($apiBleVersion) diferente a la soportada'}. Versión actual soportada por la aplicación: ${CONSTANTS.API_BLE_VERSION}',
                      _device,
                    );
                  },
                ),
              );
            }
          }
        }
      }
    });

    print('1 await');

    await _deviceChannelRead.setNotifyValue(true);

    print('OK');

    _deviceStateStream = _device.state.listen((BluetoothDeviceState state) {
      print('BLUETOOTH:::: Device state: $state');
      _deviceState.value = state;
    });
    print('2 await');
    await sendDataToDevice([_cmdToCheckCompatibility]);
    print('OK');
  }

  Future<void> sendDataToDevice(List<int> data) async {
    String result =
        data.map((e) => e.toRadixString(16)).toList().toString().toUpperCase();
    print('BLUETOOTH:::: New frame to sent: $result');
    List<int> frame = _slip.txFrame(data);
    print(frame);
    await _deviceChannelWrite.write(frame);
  }

  Future<void> disconnectDevice({BluetoothDevice device}) async {
    await _deviceStateStream?.cancel();
    await _rxDeviceStream?.cancel();
    if (device == null) device = _device;
    if (device != null) await device.disconnect();
    print('BLUETOOTH:::: Device disconnect');
    _tryConnectToDevice.value = false;
    currentStepProgressConnectToDevice.value =
        BluetoothProgressTryConnectToDevice.idle;
  }
}
