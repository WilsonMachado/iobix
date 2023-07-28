import 'dart:async';

import 'package:get/get_rx/get_rx.dart';

class RxDeviceLorawan {
  // OTAA
  final RxString errorSetAppEui, errorSetAppKey, errorSetDevEui;
  final RxString getAppEui, getAppKey, getDevEui;

  // Join OTAA
  final RxString joinedNetwork;

  // ABP
  final RxString errorSetDeviceAddress, errorSetNwsKey, errorSetAppsKey;
  final RxString getDeviceAddress, getNwsKey, getAppsKey;

  // General
  final RxString getOperationMode, connectionMode;
  final RxInt module;

  // Set Radiostack
  final RxInt setClass;
  final RxString errorSetClass;
  final RxInt setOperationMode;
  final RxString errorSetOperationMode;
  final RxInt setBand;
  final RxString errorSetBand;
  final RxInt setSubBand1;
  final RxString errorSetSubBand1;
  final RxInt setSubBand2;
  final RxString errorSetSubBand2;
  final RxInt setSpreadingFactor;
  final RxString errorSetSpreadingFactor;

  final RxString errorRetransmissions;
  final RxString errorConsecutiveDeviceNumber;
  final RxString errorPotency;

  final RxBool setAdr, setDutyCycle;
  final RxBool isTryJoin;

  // Get Radiostack
  final RxString getBand,
      getSubBand1,
      getSubBand2,
      getSpreadingFactor,
      getPotency,
      getClass,
      getAdr,
      getDutyCycle,
      getRetransmissions;

  // Network Coverage
  final RxBool tryGetNetworkCoverage;
  final RxInt attemptsGetNetworkCoverage;
  final RxInt currentStepGetNetworkCoverage;
  final RxBool successGetNetworkCoverage;
  final RxString finishMsgGetNetworkCoverage;

  RxDeviceLorawan({
    this.errorSetDevEui,
    this.errorSetDeviceAddress,
    this.errorSetNwsKey,
    this.errorSetAppsKey,
    this.errorSetAppEui,
    this.errorSetAppKey,
    this.getAppEui,
    this.getAppKey,
    this.getDeviceAddress,
    this.getNwsKey,
    this.getAppsKey,
    this.module,
    this.joinedNetwork,
    this.getOperationMode,
    this.connectionMode,
    this.getDevEui,
    this.setClass,
    this.errorSetClass,
    this.setOperationMode,
    this.errorSetOperationMode,
    this.setBand,
    this.errorSetBand,
    this.setSubBand1,
    this.errorSetSubBand1,
    this.setSubBand2,
    this.errorSetSubBand2,
    this.setSpreadingFactor,
    this.errorSetSpreadingFactor,
    this.errorRetransmissions,
    this.errorConsecutiveDeviceNumber,
    this.errorPotency,
    this.setAdr,
    this.setDutyCycle,
    this.getBand,
    this.getSubBand1,
    this.getSubBand2,
    this.getSpreadingFactor,
    this.getPotency,
    this.getClass,
    this.getAdr,
    this.getDutyCycle,
    this.getRetransmissions,
    this.tryGetNetworkCoverage,
    this.attemptsGetNetworkCoverage,
    this.currentStepGetNetworkCoverage,
    this.successGetNetworkCoverage,
    this.finishMsgGetNetworkCoverage,
    this.isTryJoin,
  });
}

class ModelDeviceLorawan {
  RxDeviceLorawan rx;

  // OTAA
  String setAppEui, setAppKey, setDevEui;

  // ABP
  String setDeviceAddress, setNwsKey, setAppsKey;

  // General
  String setRetransmissions;
  String setConsecutiveDeviceNumber;
  String setPotency;

  Timer timerTestTx;

  String networkCoverageMsgId = '';

  ModelDeviceLorawan({
    this.setAppEui = '',
    String errorSetAppEui,
    this.setAppKey = '',
    String errorSetAppKey,
    this.setDeviceAddress = '',
    String errorSetDeviceAddress,
    this.setNwsKey = '',
    String errorSetNwsKey,
    this.setAppsKey = '',
    String errorSetAppsKey,
    this.setDevEui = '',
    String errorSetDevEui,
    String getAppEui = '0000000000000000',
    String getAppKey = '00000000000000000000000000000000',
    String getDeviceAddress = '00000000',
    String getNwsKey = '00000000000000000000000000000000',
    String getAppsKey = '00000000000000000000000000000000',
    int module = -1,
    String joinedNetwork = 'unknown',
    String getOperationMode = 'unknown',
    String connectionMode = 'unknown',
    String getDevEui = '0000000000000000',
    int setClass = -1,
    bool isTimerTestTxActive = false,
    String errorSetClass,
    int setBand = 0x00,
    String errorSetBand,
    int setSubBand1 = 0x00,
    String errorSetSubBand1,
    int setSubBand2 = 0x00,
    String errorSetSubBand2,
    int setSpreadingFactor = 0x0F,
    String errorSetSpreadingFactor,
    int setOperationMode = 0x04,
    String errorSetOperationMode,
    this.setRetransmissions = '',
    this.setConsecutiveDeviceNumber = '',
    String errorRetransmissions,
    String errorConsecutiveDeviceNumber,
    this.setPotency = '',
    String errorPotency,
    bool setAdr = false,
    bool setDutyCycle = false,
    String getBand = 'unknown',
    String getSubBand1 = 'unknown',
    String getSubBand2 = 'unknown',
    String getSpreadingFactor = 'unknown',
    String getPotency = 'unknown',
    String getClass = 'unknown',
    String getAdr = 'unknown',
    String getDutyCycle = 'unknown',
    String getRetransmissions = 'unknown',
    bool tryGetNetworkCoverage = false,
    int attemptsGetNetworkCoverage = 0,
    int currentStepGetNetworkCoverage = 0,
    bool successGetNetworkCoverage = false,
    String finishMsgGetNetworkCoverage =
        '¡Estamos listos para iniciar la prueba de cobertura!',
    bool isTryJoin = false,
  }) {
    this.rx = RxDeviceLorawan(
      errorSetAppEui: errorSetAppEui.obs,
      errorSetAppKey: errorSetAppKey.obs,
      errorSetDeviceAddress: errorSetDeviceAddress.obs,
      errorSetNwsKey: errorSetNwsKey.obs,
      errorSetAppsKey: errorSetAppsKey.obs,
      errorSetDevEui: errorSetDevEui.obs,
      getAppEui: getAppEui.obs,
      getAppKey: getAppKey.obs,
      getDeviceAddress: getDeviceAddress.obs,
      getNwsKey: getNwsKey.obs,
      getAppsKey: getAppsKey.obs,
      module: module.obs,
      joinedNetwork: joinedNetwork.obs,
      getOperationMode: getOperationMode.obs,
      connectionMode: connectionMode.obs,
      getDevEui: getDevEui.obs,
      setClass: setClass.obs,
      errorSetClass: errorSetClass.obs,
      setOperationMode: setOperationMode.obs,
      errorSetOperationMode: errorSetOperationMode.obs,
      errorRetransmissions: errorRetransmissions.obs,
      errorConsecutiveDeviceNumber: errorConsecutiveDeviceNumber.obs,
      setBand: setBand.obs,
      errorSetBand: errorSetBand.obs,
      setSubBand1: setSubBand1.obs,
      errorSetSubBand1: errorSetSubBand1.obs,
      setSubBand2: setSubBand2.obs,
      errorSetSubBand2: errorSetSubBand2.obs,
      setSpreadingFactor: setSpreadingFactor.obs,
      errorSetSpreadingFactor: errorSetSpreadingFactor.obs,
      errorPotency: errorPotency.obs,
      setAdr: setAdr.obs,
      setDutyCycle: setDutyCycle.obs,
      getBand: getBand.obs,
      getSubBand1: getSubBand1.obs,
      getSubBand2: getSubBand2.obs,
      getSpreadingFactor: getSpreadingFactor.obs,
      getPotency: getPotency.obs,
      getClass: getClass.obs,
      getAdr: getAdr.obs,
      getDutyCycle: getDutyCycle.obs,
      getRetransmissions: getRetransmissions.obs,
      tryGetNetworkCoverage: tryGetNetworkCoverage.obs,
      attemptsGetNetworkCoverage: attemptsGetNetworkCoverage.obs,
      currentStepGetNetworkCoverage: currentStepGetNetworkCoverage.obs,
      successGetNetworkCoverage: successGetNetworkCoverage.obs,
      finishMsgGetNetworkCoverage: finishMsgGetNetworkCoverage.obs,
      isTryJoin: isTryJoin.obs,
    );
  }

  final List<String> msgsGetNetworkCoverage = [
    'Solicitud enviada al dispositivo',
    'Mensaje enviado al servidor',
    '¡Listo!, hemos finalizado el proceso'
  ];

  String currentMsgGetNetworkCoverage(int idx) {
    return msgsGetNetworkCoverage[idx];
  }

  bool get isTryJoin => this.rx.isTryJoin.value;
  set isTryJoin(bool v) => this.rx.isTryJoin.value = v;

  bool get successGetNetworkCoverage => this.rx.successGetNetworkCoverage.value;
  set successGetNetworkCoverage(bool v) =>
      this.rx.successGetNetworkCoverage.value = v;

  String get finishMsgGetNetworkCoverage =>
      this.rx.finishMsgGetNetworkCoverage.value;
  set finishMsgGetNetworkCoverage(String v) =>
      this.rx.finishMsgGetNetworkCoverage.value = v;

  bool get tryGetNetworkCoverage => this.rx.tryGetNetworkCoverage.value;
  set tryGetNetworkCoverage(bool v) => this.rx.tryGetNetworkCoverage.value = v;

  int get attemptsGetNetworkCoverage =>
      this.rx.attemptsGetNetworkCoverage.value;
  set attemptsGetNetworkCoverage(int v) =>
      this.rx.attemptsGetNetworkCoverage.value = v;

  int get currentStepGetNetworkCoverage =>
      this.rx.currentStepGetNetworkCoverage.value;
  set currentStepGetNetworkCoverage(int v) =>
      this.rx.currentStepGetNetworkCoverage.value = v;

  String get errorSetAppEui => this.rx.errorSetAppEui.value;
  set errorSetAppEui(String v) => this.rx.errorSetAppEui.value = v;

  String get errorSetAppKey => this.rx.errorSetAppKey.value;
  set errorSetAppKey(String v) => this.rx.errorSetAppKey.value = v;

  String get errorSetDeviceAddress => this.rx.errorSetDeviceAddress.value;
  set errorSetDeviceAddress(String v) =>
      this.rx.errorSetDeviceAddress.value = v;

  String get errorSetNwsKey => this.rx.errorSetNwsKey.value;
  set errorSetNwsKey(String v) => this.rx.errorSetNwsKey.value = v;

  String get errorSetAppsKey => this.rx.errorSetAppsKey.value;
  set errorSetAppsKey(String v) => this.rx.errorSetAppsKey.value = v;

  String get errorSetDevEui => this.rx.errorSetDevEui.value;
  set errorSetDevEui(String v) => this.rx.errorSetDevEui.value = v;

  String get getAppEui => this.rx.getAppEui.value;
  set getAppEui(String v) => this.rx.getAppEui.value = v;

  String get getAppKey => this.rx.getAppKey.value;
  set getAppKey(String v) => this.rx.getAppKey.value = v;

  String get getDeviceAddress => this.rx.getDeviceAddress.value;
  set getDeviceAddress(String v) => this.rx.getDeviceAddress.value = v;

  String get getNwsKey => this.rx.getNwsKey.value;
  set getNwsKey(String v) => this.rx.getNwsKey.value = v;

  String get getAppsKey => this.rx.getAppsKey.value;
  set getAppsKey(String v) => this.rx.getAppsKey.value = v;

  int get module => this.rx.module.value;
  set module(int v) => this.rx.module.value = v;

  String get joinedNetwork => this.rx.joinedNetwork.value;
  set joinedNetwork(String v) => this.rx.joinedNetwork.value = v;

  String get getOperationMode => this.rx.getOperationMode.value;
  set getOperationMode(String v) => this.rx.getOperationMode.value = v;

  String get connectionMode => this.rx.connectionMode.value;
  set connectionMode(String v) => this.rx.connectionMode.value = v;

  String get getDevEui => this.rx.getDevEui.value;
  set getDevEui(String v) => this.rx.getDevEui.value = v;

  int get setClass => this.rx.setClass.value;
  set setClass(int v) => this.rx.setClass.value = v;

  String get errorSetClass => this.rx.errorSetClass.value;
  set errorSetClass(String v) => this.rx.errorSetClass.value = v;

  int get setOperationMode => this.rx.setOperationMode.value;
  set setOperationMode(int v) => this.rx.setOperationMode.value = v;

  String get errorSetOperationMode => this.rx.errorSetOperationMode.value;
  set errorSetOperationMode(String v) =>
      this.rx.errorSetOperationMode.value = v;

  String get errorRetransmissions => this.rx.errorRetransmissions.value;
  set errorRetransmissions(String v) => this.rx.errorRetransmissions.value = v;

  String get errorConsecutiveDeviceNumber =>
      this.rx.errorConsecutiveDeviceNumber.value;
  set errorConsecutiveDeviceNumber(String v) =>
      this.rx.errorConsecutiveDeviceNumber.value = v;

  int get setBand => this.rx.setBand.value;
  set setBand(int v) => this.rx.setBand.value = v;

  String get errorSetBand => this.rx.errorSetBand.value;
  set errorSetBand(String v) => this.rx.errorSetBand.value = v;

  int get setSubBand1 => this.rx.setSubBand1.value;
  set setSubBand1(int v) => this.rx.setSubBand1.value = v;

  String get errorSetSubBand1 => this.rx.errorSetSubBand1.value;
  set errorSetSubBand1(String v) => this.rx.errorSetSubBand1.value = v;

  int get setSubBand2 => this.rx.setSubBand2.value;
  set setSubBand2(int v) => this.rx.setSubBand2.value = v;

  String get errorSetSubBand2 => this.rx.errorSetSubBand2.value;
  set errorSetSubBand2(String v) => this.rx.errorSetSubBand2.value = v;

  int get setSpreadingFactor => this.rx.setSpreadingFactor.value;
  set setSpreadingFactor(int v) => this.rx.setSpreadingFactor.value = v;

  String get errorSetSpreadingFactor => this.rx.errorSetSpreadingFactor.value;
  set errorSetSpreadingFactor(String v) =>
      this.rx.errorSetSpreadingFactor.value = v;

  String get errorPotency => this.rx.errorPotency.value;
  set errorPotency(String v) => this.rx.errorPotency.value = v;

  bool get setAdr => this.rx.setAdr.value;
  set setAdr(bool v) => this.rx.setAdr.value = v;

  bool get setDutyCycle => this.rx.setDutyCycle.value;
  set setDutyCycle(bool v) => this.rx.setDutyCycle.value = v;

  String get getBand => this.rx.getBand.value;
  set getBand(String v) => this.rx.getBand.value = v;

  String get getSubBand1 => this.rx.getSubBand1.value;
  set getSubBand1(String v) => this.rx.getSubBand1.value = v;

  String get getSubBand2 => this.rx.getSubBand2.value;
  set getSubBand2(String v) => this.rx.getSubBand2.value = v;

  String get getSpreadingFactor => this.rx.getSpreadingFactor.value;
  set getSpreadingFactor(String v) => this.rx.getSpreadingFactor.value = v;

  String get getPotency => this.rx.getPotency.value;
  set getPotency(String v) => this.rx.getPotency.value = v;

  String get getClass => this.rx.getClass.value;
  set getClass(String v) => this.rx.getClass.value = v;

  String get getAdr => this.rx.getAdr.value;
  set getAdr(String v) => this.rx.getAdr.value = v;

  String get getDutyCycle => this.rx.getDutyCycle.value;
  set getDutyCycle(String v) => this.rx.getDutyCycle.value = v;

  String get getRetransmissions => this.rx.getRetransmissions.value;
  set getRetransmissions(String v) => this.rx.getRetransmissions.value = v;
}
