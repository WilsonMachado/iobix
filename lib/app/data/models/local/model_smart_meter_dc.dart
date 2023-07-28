import 'package:get/get_rx/get_rx.dart';

class RxSmartMeterDc {
  RxString vdc1, vdc2, idc1, idc2;
  RxString delta1, min1, max1, delta2, min2, max2;
  RxString externalTemperature, dcdcReading, externalSupplyStatus;

  RxInt getCurrentRange;
  RxString setCurrentRange, errorSetCurrentRange;

  RxDouble deviceVersion;

  RxSmartMeterDc({
    this.deviceVersion,
    this.vdc1,
    this.vdc2,
    this.idc1,
    this.idc2,
    this.externalTemperature,
    this.dcdcReading,
    this.externalSupplyStatus,
    this.delta1,
    this.min1,
    this.max1,
    this.delta2,
    this.min2,
    this.max2,
    this.getCurrentRange,
    this.setCurrentRange,
    this.errorSetCurrentRange,
  });
}

class ModelSmartMeterDc {
  RxSmartMeterDc rx;

  ModelSmartMeterDc({
    double deviceVersion = 2.0,
    String vdc1 = '0.00',
    String vdc2 = '0.00',
    String idc1 = '0.00',
    String idc2 = '0.00',
    String externalTemperature = 'unknown',
    String dcdcReading = '0.00',
    String externalSupplyStatus = 'unknown',
    String delta1 = '?',
    String min1 = '?',
    String max1 = '?',
    String delta2 = '?',
    String min2 = '?',
    String max2 = '?',
    int getCurrentRange = 0,
    String setCurrentRange = '',
    String errorSetCurrentRange,
  }) {
    this.rx = RxSmartMeterDc(
      deviceVersion: deviceVersion.obs,
      vdc1: vdc1.obs,
      vdc2: vdc2.obs,
      idc1: idc1.obs,
      idc2: idc2.obs,
      externalTemperature: externalTemperature.obs,
      dcdcReading: dcdcReading.obs,
      externalSupplyStatus: externalSupplyStatus.obs,
      delta1: delta1.obs,
      min1: min1.obs,
      max1: max1.obs,
      delta2: delta2.obs,
      min2: min2.obs,
      max2: max2.obs,
      getCurrentRange: getCurrentRange.obs,
      setCurrentRange: setCurrentRange.obs,
      errorSetCurrentRange: errorSetCurrentRange.obs,
    );
  }

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;

  String get vdc1 => this.rx.vdc1.value;
  set vdc1(String v) => this.rx.vdc1.value = v;

  String get vdc2 => this.rx.vdc2.value;
  set vdc2(String v) => this.rx.vdc2.value = v;

  String get idc1 => this.rx.idc1.value;
  set idc1(String v) => this.rx.idc1.value = v;

  String get idc2 => this.rx.idc2.value;
  set idc2(String v) => this.rx.idc2.value = v;

  String get externalTemperature => this.rx.externalTemperature.value;
  set externalTemperature(String v) => this.rx.externalTemperature.value = v;

  String get dcdcReading => this.rx.dcdcReading.value;
  set dcdcReading(String v) => this.rx.dcdcReading.value = v;

  String get externalSupplyStatus => this.rx.externalSupplyStatus.value;
  set externalSupplyStatus(String v) => this.rx.externalSupplyStatus.value = v;

  String get delta1 => this.rx.delta1.value;
  set delta1(String v) => this.rx.delta1.value = v;

  String get min1 => this.rx.min1.value;
  set min1(String v) => this.rx.min1.value = v;

  String get max1 => this.rx.max1.value;
  set max1(String v) => this.rx.max1.value = v;

  String get delta2 => this.rx.delta2.value;
  set delta2(String v) => this.rx.delta2.value = v;

  String get min2 => this.rx.min2.value;
  set min2(String v) => this.rx.min2.value = v;

  String get max2 => this.rx.max2.value;
  set max2(String v) => this.rx.max2.value = v;

  int get getCurrentRange => this.rx.getCurrentRange.value;
  set getCurrentRange(int v) => this.rx.getCurrentRange.value = v;

  String get setCurrentRange => this.rx.setCurrentRange.value;
  set setCurrentRange(String v) => this.rx.setCurrentRange.value = v;

  String get errorSetCurrentRange => this.rx.errorSetCurrentRange.value;
  set errorSetCurrentRange(String v) => this.rx.errorSetCurrentRange.value = v;
}
