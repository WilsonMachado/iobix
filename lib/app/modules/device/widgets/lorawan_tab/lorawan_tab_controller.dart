import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:iobix/app/gsheet_api_keys/abp_sheet_api.dart';
import 'package:location/location.dart';

import '../system_tab/system_tab_controller.dart';
import '../../../../data/models/local/model_device_lorawan.dart';
import '../../../../data/repositories/remote/network_repository.dart';
import '../../../../data/models/remote/network/network_response.dart';
import '../../device_controller.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/ble_api/ble_general_commands.dart';
import '../../../../utils/constants/ble_api/lorawan_constants.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../../utils/constants/enums.dart';

class LorawanTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final NetworkRepository _networkRepository = Get.find<NetworkRepository>();

  static AbpSheetApi gsheet = AbpSheetApi();

  ModelDeviceLorawan modelDeviceLorawan = ModelDeviceLorawan();
  NetworkResponse networkResponse;

  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionLocationGranted;
  LocationData _locationData;
  List<LocationData> _locationDataOld = [];
  RxBool _setSaveCoverageMap = false.obs, _setAutoCoverage = false.obs;
  bool get setSaveCoverageMap => _setSaveCoverageMap.value;
  bool get setAutoCoverage => _setAutoCoverage.value;

  RxBool _isAutomaticConfig = false.obs;
  bool get isAutomaticConfig => _isAutomaticConfig.value;
  set isAutomaticConfig(bool v) => _isAutomaticConfig.value = v;
  RxString _automaticConfigMsg = '¡Vamos!'.obs;
  String get automaticConfigMsg => _automaticConfigMsg.value;

  @override
  void onClose() {
    modelDeviceLorawan.timerTestTx?.cancel();
    super.onClose();
  }

  bool isImstModule() =>
      modelDeviceLorawan.module == LORAWAN_CONSTANTS.MODULE_IMST;

  ColbitsCompatibleVersion getDeviceVersion() {
    return Get.find<DeviceController>().currentDeviceConnect;
  }

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> sendSetRequest(int cmd, bool v) async {
    await Get.find<DeviceController>().sendSetRequest(cmd, v);
  }

  void resetAutomaticConfig({String msg = '¡Vamos!'}) {
    _automaticConfigMsg.value = msg;
    _isAutomaticConfig.value = false;
  }

  Future<void> automaticConfig(int step) async {
    ColbitsCompatibleVersion device = getDeviceVersion();

    ///! Para saber qué dispositivo se ha conectado

    if (!_isAutomaticConfig.value) _isAutomaticConfig.value = true;

    await Future.delayed(Duration(seconds: 1));

    switch (step) {
      case 0:
        _automaticConfigMsg.value = 'Configurando banda AU915';
        modelDeviceLorawan.setBand = 0x06;
        await bleApiSetBand();
        break;

      case 1:
        await Future.delayed(Duration(seconds: 1));
        _automaticConfigMsg.value = 'Configurando sub-bandas (2, 2)';
        modelDeviceLorawan.setSubBand1 = 0x02;
        modelDeviceLorawan.setSubBand2 = 0x02;
        await bleApiSetSubBands();
        break;

      case 2:
        await Future.delayed(Duration(seconds: 1));
        _automaticConfigMsg.value = 'Configurando retransmisiones en 5';
        modelDeviceLorawan.setRetransmissions = '5';
        await bleApiSetRetransmissions();
        break;

      case 3:
        _automaticConfigMsg.value = 'Configurando SF en 12 con 125 KHz';
        modelDeviceLorawan.setSpreadingFactor = 0x00;
        await bleApiSetDataRate();
        break;

      case 4:
        _automaticConfigMsg.value =
            'Configurando potencia de transmisión en 20 dbm';
        modelDeviceLorawan.setPotency = '20';
        await bleApiSetTxPower();
        break;

      case 5:
        if (device == ColbitsCompatibleVersion.smartMeterAcV3_1) {
          ///! ADR Deshabilitado para el SMAC V3.1
          _automaticConfigMsg.value = 'Deshabilitando ADR';
          await bleApiSetAdr(false);
        } else {
          _automaticConfigMsg.value = 'Habilitando ADR';
          await bleApiSetAdr(true);
        }
        break;

      case 6:
        _automaticConfigMsg.value = 'Deshabilitando Duty Cycle';
        await bleApiSetDutyCycle(false);
        break;

      case 7:
        _automaticConfigMsg.value = 'Configurando el dispositivo en Clase A';
        modelDeviceLorawan.setClass = 0x00;
        await bleApiSetClass();
        break;

      case 8:
        if (device != ColbitsCompatibleVersion.smartMeterAcV3_1) {
          ///! Si el dispositivo es un SMAC V3.1, no se configura el periodo de transmisión en 120 min
          _automaticConfigMsg.value =
              'Configurando periodo de transmisión en 120 minutos';
          Get.find<SystemTabController>().modelDeviceGeneral.setTxTime = '120';
          await Get.find<SystemTabController>().bleApiTxTime();
        } else {
          automaticConfig(9);
        }

        break;

      case 9:
        if (device != ColbitsCompatibleVersion.smartMeterAcV3_1) {
          ///! Si el dispositivo es un SMAC V3.1, no se borran los registros de aplicación en memoria
          _automaticConfigMsg.value =
              'Eliminando registros de aplicación en memoria';
          await Get.find<SystemTabController>().bleApiClearLogApp();
        } else {
          automaticConfig(10);
        }
        break;

      case 10:
        if (device != ColbitsCompatibleVersion.smartMeterAcV3_1) {
          ///! Si el dispositivo es un SMAC V3.1, no se borran los registros del sistema en memoria
          _automaticConfigMsg.value =
              'Eliminando registros del sistema en memoria';
          await Get.find<SystemTabController>().bleApiClearLogSys();
        } else {
          automaticConfig(11);
        }
        break;

      case 11:
        resetAutomaticConfig(msg: 'Configuración completa, ¿Vamos nuevamente?');
        break;

      default:
    }
  }

  void onChangedSetEui(String text) {
    modelDeviceLorawan.setDevEui = text;
    if (modelDeviceLorawan.errorSetDevEui != null) {
      modelDeviceLorawan.errorSetDevEui = null;
    }
  }

  void onChangedSetAppEui(String text) {
    modelDeviceLorawan.setAppEui = text;
    if (modelDeviceLorawan.errorSetAppEui != null) {
      modelDeviceLorawan.errorSetAppEui = null;
    }
  }

  void onChangedSetAppKey(String text) {
    modelDeviceLorawan.setAppKey = text;
    if (modelDeviceLorawan.errorSetAppKey != null) {
      modelDeviceLorawan.errorSetAppKey = null;
    }
  }

  Future<void> bleApiLoraActiveOTAA() async {
    bool error = false;

    if (modelDeviceLorawan.setDevEui.length == 16) {
      if (!CONSTANTS.hexadecimalFormat.hasMatch(modelDeviceLorawan.setDevEui)) {
        modelDeviceLorawan.errorSetDevEui = 'hex_format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorSetDevEui = 'len_error_lora_key'.trArgs(['16']);
      error = true;
    }

    if (modelDeviceLorawan.setAppEui.length == 16) {
      if (!CONSTANTS.hexadecimalFormat.hasMatch(modelDeviceLorawan.setAppEui)) {
        modelDeviceLorawan.errorSetAppEui = 'hex_format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorSetAppEui = 'len_error_lora_key'.trArgs(['16']);
      error = true;
    }

    if (modelDeviceLorawan.setAppKey.length == 32) {
      if (!CONSTANTS.hexadecimalFormat.hasMatch(modelDeviceLorawan.setAppKey)) {
        modelDeviceLorawan.errorSetAppKey = 'hex_format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorSetAppKey = 'len_error_lora_key'.trArgs(['32']);
      error = true;
    }

    if (!error) await _bleApiLoraActive(LORAWAN_CONSTANTS.MODE_OTAA);
  }

  Future<void> bleApiJoinOtaa() async {
    modelDeviceLorawan.isTryJoin = true;
    await sendDataToDevice([BLE_GENERAL_CMDS.JOIN_OTAA]);
  }

  void onChangedSetDeviceAddress(String text) {
    modelDeviceLorawan.setDeviceAddress = text;
    if (modelDeviceLorawan.errorSetDeviceAddress != null) {
      modelDeviceLorawan.errorSetDeviceAddress = null;
    }
  }

  void onChangedSetNwsKey(String text) {
    modelDeviceLorawan.setNwsKey = text;
    if (modelDeviceLorawan.errorSetNwsKey != null) {
      modelDeviceLorawan.errorSetNwsKey = null;
    }
  }

  void onChangedSetAppsKey(String text) {
    modelDeviceLorawan.setAppsKey = text;
    if (modelDeviceLorawan.errorSetAppsKey != null) {
      modelDeviceLorawan.errorSetAppsKey = null;
    }
  }

  void getABPParamsFromGSheet() async {
    gsheet.init();
    if (modelDeviceLorawan.setConsecutiveDeviceNumber == null ||
        modelDeviceLorawan.setConsecutiveDeviceNumber == '') {
      //TODO: test
      print('No han seteado un ID');
    } else {
      List<String> result = await gsheet
          .getById(int.parse(modelDeviceLorawan.setConsecutiveDeviceNumber));
      print(result[1].replaceAll(' ', '').length);
      print(result[2].replaceAll(' ', '').length);
      print(result[3].replaceAll(' ', '').length);
      if (result == null) {
        modelDeviceLorawan.errorConsecutiveDeviceNumber =
            'No se ha seleccionado una hola de trabajo';
      }

      if (result[1] == '') {
        modelDeviceLorawan.errorConsecutiveDeviceNumber =
            'Revisar la API de ABP Keys';
      } else {
        modelDeviceLorawan.setDeviceAddress = result[1].replaceAll(' ', '');
      }

      if (result[2] == '') {
        modelDeviceLorawan.errorConsecutiveDeviceNumber =
            'Revisar la API de ABP Keys';
      } else {
        modelDeviceLorawan.setNwsKey = result[2].replaceAll(' ', '');
      }

      if (result[3] == '') {
        modelDeviceLorawan.errorConsecutiveDeviceNumber =
            'Revisar la API de ABP Keys';
      } else {
        modelDeviceLorawan.setAppsKey = result[3].replaceAll(' ', '');
      }

      if (modelDeviceLorawan.errorConsecutiveDeviceNumber == null) {
        bleApiLoraActiveABP();
      }
    }
  }

  Future<void> bleApiLoraActiveABP() async {
    bool error = false;

    if (modelDeviceLorawan.setDeviceAddress.length == 8) {
      if (!CONSTANTS.hexadecimalFormat
          .hasMatch(modelDeviceLorawan.setDeviceAddress)) {
        modelDeviceLorawan.errorSetDeviceAddress = 'hex_format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorSetDeviceAddress =
          'len_error_lora_key'.trArgs(['4']);
      error = true;
    }

    if (modelDeviceLorawan.setNwsKey.length == 32) {
      if (!CONSTANTS.hexadecimalFormat.hasMatch(modelDeviceLorawan.setNwsKey)) {
        modelDeviceLorawan.errorSetNwsKey = 'hex_format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorSetNwsKey = 'len_error_lora_key'.trArgs(['32']);
      error = true;
    }

    if (modelDeviceLorawan.setAppsKey.length == 32) {
      if (!CONSTANTS.hexadecimalFormat
          .hasMatch(modelDeviceLorawan.setAppsKey)) {
        modelDeviceLorawan.errorSetAppsKey = 'hex_format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorSetAppsKey = 'len_error_lora_key'.trArgs(['32']);
      error = true;
    }

    if (!error) await _bleApiLoraActive(LORAWAN_CONSTANTS.MODE_ABP);
  }

  Future<void> _bleApiLoraActive(int mode) async {
    switch (mode) {
      case LORAWAN_CONSTANTS.MODE_OTAA:
        await sendDataToDevice([
          BLE_GENERAL_CMDS.LORA_ACTIVE,
          LORAWAN_CONSTANTS.MODE_OTAA,
          ...hexaAsciiToListInt(modelDeviceLorawan.setDevEui),
          ...hexaAsciiToListInt(modelDeviceLorawan.setAppEui),
          ...hexaAsciiToListInt(modelDeviceLorawan.setAppKey)
        ], log: 'Mode: OTAA, Dev Eui: ${modelDeviceLorawan.setDevEui}, App Eui: ${modelDeviceLorawan.setAppEui}, App Key: ${modelDeviceLorawan.setAppKey}');
        break;

      case LORAWAN_CONSTANTS.MODE_ABP:
        await sendDataToDevice([
          BLE_GENERAL_CMDS.LORA_ACTIVE,
          LORAWAN_CONSTANTS.MODE_ABP,
          ...isImstModule()
              ? listIntLsbToMsb(
                  hexaAsciiToListInt(modelDeviceLorawan.setDeviceAddress))
              : hexaAsciiToListInt(modelDeviceLorawan.setDeviceAddress),
          ...hexaAsciiToListInt(modelDeviceLorawan.setNwsKey),
          ...hexaAsciiToListInt(modelDeviceLorawan.setAppsKey)
        ], log: 'Mode: ABP, Device address: ${modelDeviceLorawan.setDeviceAddress}, Network session key: ${modelDeviceLorawan.setNwsKey}, App session key: ${modelDeviceLorawan.setAppsKey}');
        break;
    }
  }

  Future<void> bleApiGetOtaaParams() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_OTAA_PARAMS]);
  }

  Future<void> bleApiGetAbpParams() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_ABP_PARAMS]);
  }

  Future<void> getNetworkCoverage() async {
    modelDeviceLorawan.attemptsGetNetworkCoverage++;
    //print('intento #${modelDeviceLorawan.attemptsGetNetworkCoverage}');

    try {
      networkResponse = await _networkRepository.requestNetworkCoverage(
          Get.find<SystemTabController>().modelDeviceInformation.getId);

      if ((!networkResponse.ok &&
              modelDeviceLorawan.attemptsGetNetworkCoverage < 3) ||
          (networkResponse.ok &&
              networkResponse.data.msgId !=
                  modelDeviceLorawan.networkCoverageMsgId &&
              modelDeviceLorawan.attemptsGetNetworkCoverage < 3)) {
        modelDeviceLorawan.timerTestTx = Timer(Duration(seconds: 20), () {
          getNetworkCoverage();
        });
      } else {
        if (!networkResponse.ok) {
          // Mensaje de error de que no se pudo obtener la info del server
          modelDeviceLorawan.finishMsgGetNetworkCoverage =
              'No se pudo obtener la información de cobertura, ' +
                  ((_setAutoCoverage.value)
                      ? 'lo intentaremos de nuevo en unos instantes'
                      : 'intenta nuevamente');
        } else {
          if (modelDeviceLorawan.networkCoverageMsgId ==
              networkResponse.data.msgId) {
            // Datos encontrados
            modelDeviceLorawan.currentStepGetNetworkCoverage = 2;
            await Future.delayed(Duration(seconds: 2));
            modelDeviceLorawan.finishMsgGetNetworkCoverage =
                '¡No más espera!, hemos encontrado la información de cobertura';
            modelDeviceLorawan.successGetNetworkCoverage = true;
          } else {
            // Se encontro información pero de una prueba anterior
            modelDeviceLorawan.finishMsgGetNetworkCoverage =
                'La información encontrada en el servidor corresponde a una prueba anterior, ' +
                    ((_setAutoCoverage.value)
                        ? 'lo intentaremos de nuevo en unos instantes'
                        : 'intenta nuevamente');
          }
        }

        // Reset
        modelDeviceLorawan.attemptsGetNetworkCoverage = 0;
        modelDeviceLorawan.tryGetNetworkCoverage = false;

        // Auto
        if (_setAutoCoverage.value) restartTestTxLora();
      }
    } catch (e) {
      print(e);
      modelDeviceLorawan.finishMsgGetNetworkCoverage =
          '¡Ups!, hubo un error al intentar verificar la cobertura de red, verifica tu conexión a internet e intenta nuevamente';
      _setAutoCoverage.value = false;
      //modelDeviceLorawan.finishMsgGetNetworkCoverage = e.toString();
      // Reset
      modelDeviceLorawan.attemptsGetNetworkCoverage = 0;
      modelDeviceLorawan.tryGetNetworkCoverage = false;

      // Auto
      if (_setAutoCoverage.value) restartTestTxLora();
    }
  }

  String getGatewayNetworkCoverage() {
    String name = 'Desconocido';
    networkResponse.data.gwData.gws.forEach((gw) {
      if (gw.rssi == networkResponse.data.rxData.rssi &&
          gw.snr == networkResponse.data.rxData.snr) {
        name = gw.name;
        return;
      }
    });

    return name;
  }

  void cancelTestTxLora({String msg}) {
    // Reset
    modelDeviceLorawan.attemptsGetNetworkCoverage = 0;
    modelDeviceLorawan.tryGetNetworkCoverage = false;
    modelDeviceLorawan.successGetNetworkCoverage = false;
    if (msg == null) _setAutoCoverage.value = false;
    modelDeviceLorawan.finishMsgGetNetworkCoverage = (msg == null)
        ? '!De acuerdo, lo mejor era cancelar¡, estamos listo para intentar nuevamente la prueba de cobertura'
        : msg;
    modelDeviceLorawan.timerTestTx.cancel();

    // Auto
    if (msg != null && _setAutoCoverage.value) restartTestTxLora();
  }

  Future<void> restartTestTxLora() async {
    await Future.delayed(Duration(seconds: 5));
    // Auto (Es posible que desmarquen antes de reiniciar)
    if (_setAutoCoverage.value) {
      modelDeviceLorawan.successGetNetworkCoverage = false;
      modelDeviceLorawan.finishMsgGetNetworkCoverage =
          'De acuerdo a lo solicitado, en unos instantes iniciaremos una nueva prueba de cobertura';
      await Future.delayed(Duration(seconds: 3));
      if (_setAutoCoverage.value)
        bleApiTestTxLora();
      else
        modelDeviceLorawan.finishMsgGetNetworkCoverage =
            'Ups!, deshabilitaste las pruebas automaticas en el último momento. Estamos listos para iniciar una nueva prueba de cobertura';
    } else
      modelDeviceLorawan.finishMsgGetNetworkCoverage =
          'Ok, deshabilitaste las pruebas automaticas. Estamos listos para iniciar una nueva prueba de cobertura';
  }

  Future<void> bleApiTestTxLora() async {
    modelDeviceLorawan.successGetNetworkCoverage = false;
    modelDeviceLorawan.tryGetNetworkCoverage = true;
    modelDeviceLorawan.currentStepGetNetworkCoverage = 0;

    modelDeviceLorawan.timerTestTx = Timer(Duration(seconds: 60), () async {
      modelDeviceLorawan.tryGetNetworkCoverage = false;
      // Mensaje de error de que no se pudo obtener la info del server debido a timeout
      modelDeviceLorawan.finishMsgGetNetworkCoverage =
          'No se pudo obtener la información de cobertura ya que no logramos comprobar que el mensaje llegará al servidor, intenta nuevamente';
      // Auto
      if (_setAutoCoverage.value) restartTestTxLora();
    });

    List<int> locationInfo = [];
    DateTime time = DateTime.now();
    if (_setSaveCoverageMap.value) {
      await getLocation();

      bool isOldLocation = _locationDataOld.any((e) {
        if (e.altitude == _locationData.altitude &&
            e.longitude == _locationData.longitude) {
          return true;
        } else
          return false;
      });

      if (isOldLocation) {
        cancelTestTxLora(
            msg: '¡Ups!, los datos de posicionamiento coinciden con una prueba reciente, ' +
                ((_setAutoCoverage.value)
                    ? 'intenta ubicarte en un punto geográfico diferente, lo intentaremos de nuevo en unos instantes'
                    : 'intenta realizar nuevamente la prueba de cobertura desde un punto geográfico diferente'));
        return null;
      }

      //  add new location data to old list
      _locationDataOld.add(_locationData);
      if (_locationDataOld.length > 5) _locationDataOld.removeAt(0);

      locationInfo += utf8.encode(_locationData.latitude.toString());
      locationInfo.add(0x00); // Separador
      locationInfo += utf8.encode(_locationData.longitude.toString());
    }
    List<int> msgId = [
      time.month,
      time.day,
      time.hour,
      time.minute,
      time.second
    ];

    modelDeviceLorawan.networkCoverageMsgId = hexaToAscii(msgId).toLowerCase();

    await sendDataToDevice([
      BLE_GENERAL_CMDS.TEST_TX_LORA,
      ...msgId,
      if (_setSaveCoverageMap.value) ...locationInfo
    ]);
  }

  Future<void> bleApiGetLoraInformation() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_HARDWARE]);
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_OPERATION_MODE]);
    if (isImstModule())
      await sendDataToDevice([BLE_GENERAL_CMDS.GET_CONNECTION_MODE]);
  }

  void onChangedRetransmissions(String text) {
    modelDeviceLorawan.setRetransmissions = text;
    if (modelDeviceLorawan.errorRetransmissions != null) {
      modelDeviceLorawan.errorRetransmissions = null;
    }
  }

  void onChangedConsecutiveDeviceNumber(String text) {
    modelDeviceLorawan.setConsecutiveDeviceNumber = text;
    if (modelDeviceLorawan.errorConsecutiveDeviceNumber != null) {
      modelDeviceLorawan.errorConsecutiveDeviceNumber = null;
    }
  }

  bool _checkRetransmissions() {
    bool error = false;

    if (modelDeviceLorawan.setRetransmissions.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelDeviceLorawan.setRetransmissions)) {
        int retransmissions = int.parse(modelDeviceLorawan.setRetransmissions);

        if (!(retransmissions >= 0 &&
            retransmissions <= (isImstModule() ? 15 : 7))) {
          modelDeviceLorawan.errorRetransmissions =
              'range_error'.trArgs(['(0 - ${isImstModule() ? '15' : '7'})']);
          error = true;
        }
      } else {
        modelDeviceLorawan.errorRetransmissions = 'format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorRetransmissions = 'empty_error'.tr;
      error = true;
    }

    return error;
  }

  Future<void> bleApiSetRetransmissions() async {
    if (!_checkRetransmissions())
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK,
        int.parse(modelDeviceLorawan.setRetransmissions)
      ], log: 'Forwardings: ${modelDeviceLorawan.setRetransmissions}');
  }

  void onChangedBand(int k) {
    modelDeviceLorawan.setBand = k;
    if (modelDeviceLorawan.errorSetBand != null) {
      modelDeviceLorawan.errorSetBand = null;
    }
  }

  bool _checkBand() {
    bool error = false;

    Map<int, String> bandIndex = isImstModule()
        ? LORAWAN_CONSTANTS.IMST_BAND_INDEX
        : LORAWAN_CONSTANTS.RAK_BAND_INDEX;

    if (!bandIndex.containsKey(modelDeviceLorawan.setBand)) {
      modelDeviceLorawan.errorSetBand = 'select_error'.tr;
      error = true;
    }

    return error;
  }

  Future<void> bleApiSetBand() async {
    if (!_checkBand()) {
      Map<int, String> bandIndex = isImstModule()
          ? LORAWAN_CONSTANTS.IMST_BAND_INDEX
          : LORAWAN_CONSTANTS.RAK_BAND_INDEX;

      await sendDataToDevice(
          [BLE_GENERAL_CMDS.SET_LORA_BAND, modelDeviceLorawan.setBand],
          log: 'Band: ${bandIndex[modelDeviceLorawan.setBand]}');
    }
  }

  void onChangedSubBand1(int k) {
    modelDeviceLorawan.setSubBand1 = k;
    if (modelDeviceLorawan.errorSetSubBand1 != null) {
      modelDeviceLorawan.errorSetSubBand1 = null;
    }
  }

  void onChangedSubBand2(int k) {
    modelDeviceLorawan.setSubBand2 = k;
    if (modelDeviceLorawan.errorSetSubBand2 != null) {
      modelDeviceLorawan.errorSetSubBand2 = null;
    }
  }

  bool _checkSubBands() {
    bool error = false;

    if (!LORAWAN_CONSTANTS.AU915_SUB_BAND_1
        .containsKey(modelDeviceLorawan.setSubBand1)) {
      modelDeviceLorawan.errorSetSubBand1 = 'select_error'.tr;
      error = true;
    }

    if (!LORAWAN_CONSTANTS.AU915_SUB_BAND_2
        .containsKey(modelDeviceLorawan.setSubBand2)) {
      modelDeviceLorawan.errorSetSubBand2 = 'select_error'.tr;
      error = true;
    }

    return error;
  }

  Future<void> bleApiSetSubBands() async {
    if (!_checkSubBands()) {
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_LORA_SUB_BANDS,
        modelDeviceLorawan.setSubBand1,
        modelDeviceLorawan.setSubBand2
      ], log: 'Sub-band 1: ${LORAWAN_CONSTANTS.AU915_SUB_BAND_1[modelDeviceLorawan.setSubBand1]}, Sub-band 2: ${LORAWAN_CONSTANTS.AU915_SUB_BAND_2[modelDeviceLorawan.setSubBand2]}');
    }
  }

  void onChangedSpreadingFactor(int k) {
    modelDeviceLorawan.setSpreadingFactor = k;
    if (modelDeviceLorawan.errorSetSpreadingFactor != null)
      modelDeviceLorawan.errorSetSpreadingFactor = null;
  }

  bool _checkDataRate() {
    bool error = false;

    if (!LORAWAN_CONSTANTS.SPREADING_FACTOR
        .containsKey(modelDeviceLorawan.setSpreadingFactor)) {
      modelDeviceLorawan.errorSetSpreadingFactor = 'select_error'.tr;
      error = true;
    }

    return error;
  }

  Future<void> bleApiSetDataRate() async {
    if (!_checkDataRate()) {
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_LORA_DATA_RATE,
        modelDeviceLorawan.setSpreadingFactor
      ], log: 'Data Rate: ${LORAWAN_CONSTANTS.SPREADING_FACTOR[modelDeviceLorawan.setSpreadingFactor]}');
    }
  }

  void onChangedPotency(String text) {
    modelDeviceLorawan.setPotency = text;
    if (modelDeviceLorawan.errorPotency != null) {
      modelDeviceLorawan.errorPotency = null;
    }
  }

  bool _checkTxPower() {
    bool error = false;

    if (modelDeviceLorawan.setPotency.length > 0) {
      if (CONSTANTS.positiveIntegerFormat
          .hasMatch(modelDeviceLorawan.setPotency)) {
        int potency = int.parse(modelDeviceLorawan.setPotency);

        if (!(potency >= (isImstModule() ? 0 : 10) &&
            potency <= (isImstModule() ? 22 : 20))) {
          modelDeviceLorawan.errorPotency = 'range_error'.trArgs([
            '(${isImstModule() ? '0' : '10'} - ${isImstModule() ? '22' : '20'})'
          ]);
          error = true;
        }
      } else {
        modelDeviceLorawan.errorPotency = 'format_error'.tr;
        error = true;
      }
    } else {
      modelDeviceLorawan.errorPotency = 'empty_error'.tr;
      error = true;
    }

    return error;
  }

  Future<void> bleApiSetTxPower() async {
    if (!_checkTxPower()) {
      int txPower = ((LORAWAN_CONSTANTS.RAK_MAX_EIRP -
                  int.parse(modelDeviceLorawan.setPotency)) /
              2)
          .round();

      await sendDataToDevice([BLE_GENERAL_CMDS.SET_LORA_TX_POWER, txPower],
          log:
              'Tx power: ${modelDeviceLorawan.setPotency} (dbm), $txPower (index)');
    }
  }

  Future<void> onChangeAdr(bool v) async {
    if (!isImstModule())
      await bleApiSetAdr(v);
    else
      modelDeviceLorawan.setAdr = v;
  }

  Future<void> bleApiSetAdr(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.SET_LORA_ADR, v);
  }

  Future<void> onChangeDutyCycle(bool v) async {
    if (!isImstModule())
      await bleApiSetDutyCycle(v);
    else
      modelDeviceLorawan.setDutyCycle = v;
  }

  Future<void> bleApiSetDutyCycle(bool v) async {
    await sendSetRequest(BLE_GENERAL_CMDS.SET_LORA_DUTY_CYCLE, v);
  }

  Map<int, String> mapLoraClassByModule() {
    if (isImstModule()) return LORAWAN_CONSTANTS.IMST_CLASS;
    return LORAWAN_CONSTANTS.RAK_CLASS;
  }

  void onChangedClass(int k) {
    modelDeviceLorawan.setClass = k;
    if (modelDeviceLorawan.errorSetClass != null)
      modelDeviceLorawan.errorSetClass = null;
  }

  bool _checkClass() {
    bool error = false;

    if (!mapLoraClassByModule().containsKey(modelDeviceLorawan.setClass)) {
      modelDeviceLorawan.errorSetClass = 'select_error'.tr;
      error = true;
    }

    return error;
  }

  Future<void> bleApiSetClass() async {
    if (!_checkClass()) {
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_LORA_CLASS,
        modelDeviceLorawan.setClass
      ], log: 'Class: ${LORAWAN_CONSTANTS.RAK_CLASS[modelDeviceLorawan.setClass]}');
    }
  }

  Future<void> bleApiSetRadioStack() async {
    if (!_checkBand() &&
        !_checkRetransmissions() &&
        !_checkSubBands() &&
        !_checkDataRate() &&
        !_checkTxPower() &&
        !_checkClass()) {
      int options = 0;
      int adr = modelDeviceLorawan.setAdr ? 1 : 0;
      int dutyCycle = modelDeviceLorawan.setDutyCycle ? 1 : 0;

      options = (modelDeviceLorawan.setClass << 2) | (dutyCycle << 1) | adr;

      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_LORA_FORWARDING_N_OR_RADIOSTACK,
        int.parse(modelDeviceLorawan.setRetransmissions),
        modelDeviceLorawan.setBand,
        modelDeviceLorawan.setSubBand1,
        modelDeviceLorawan.setSubBand2,
        modelDeviceLorawan.setSpreadingFactor,
        options,
        int.parse(modelDeviceLorawan.setPotency),
      ]);
    }
  }

  Future<void> bleApiGetRadioStack() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_RAK_INFO_OR_RADIOSTACK]);
  }

  Future<void> bleApiGetRakInformation() async {
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_RAK_INFO_OR_RADIOSTACK]);
    await Future.delayed(Duration(seconds: 4));
    modelDeviceLorawan.getSubBand1 = 'unknown';
    modelDeviceLorawan.getSubBand2 = 'unknown';
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_SUB_BANDS]);
    await Future.delayed(Duration(seconds: 4));
    await sendDataToDevice([BLE_GENERAL_CMDS.GET_LORA_DUTY_CYCLE]);
  }

  void onChangedOperationMode(int k) {
    modelDeviceLorawan.setOperationMode = k;
    if (modelDeviceLorawan.errorSetOperationMode != null)
      modelDeviceLorawan.errorSetOperationMode = null;
  }

  Future<void> bleApiSetOperationMode() async {
    if (LORAWAN_CONSTANTS.OPERATION_MODE
        .containsKey(modelDeviceLorawan.setOperationMode)) {
      await sendDataToDevice([
        BLE_GENERAL_CMDS.SET_LORA_OPERATION_MODE,
        modelDeviceLorawan.setOperationMode
      ], log: 'Mode: ${LORAWAN_CONSTANTS.OPERATION_MODE[modelDeviceLorawan.setOperationMode]}');
    } else
      modelDeviceLorawan.errorSetOperationMode = 'select_error'.tr;
  }

  // Prueba de get location para graficar

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocationGranted = await location.hasPermission();
    if (_permissionLocationGranted == PermissionStatus.denied) {
      _permissionLocationGranted = await location.requestPermission();
      if (_permissionLocationGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  void onChangeSetSaveCoverageMap(bool v) {
    _setSaveCoverageMap.value = v;
  }

  void onChangeSetAutoCoverage(bool v) {
    _setAutoCoverage.value = v;
  }
}
