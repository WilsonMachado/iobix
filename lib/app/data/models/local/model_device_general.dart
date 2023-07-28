import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RxDeviceGeneral {
  final RxBool leds,
      acelerometer,
      acelerometerFallAlarm,
      gnss,
      maintenance,
      confirmedMessages,
      debugFrame;
  final RxString getTxTime, getMeasureTime;
  final RxString errorMeasureTime, errorTxTime;
  final RxString acelerometerOrientation;
  final RxDouble batteryValue,
      batteryPercentage,
      supply,
      solarPanel,
      temperature;

  final RxInt gpsSyncStatus;
  final RxBool isGpsSync;
  final RxDouble gpsLatitude, gpsLongitude;

  final Rx<DateTime> getRtcDate;
  final Rx<TimeOfDay> getRtcTime;
  final Rx<DateTime> setRtcDate;
  final Rx<TimeOfDay> setRtcTime;

  final RxString tampering;

  RxDeviceGeneral({
    this.acelerometerOrientation,
    this.batteryValue,
    this.batteryPercentage,
    this.supply,
    this.solarPanel,
    this.temperature,
    this.confirmedMessages,
    this.debugFrame,
    this.maintenance,
    this.gnss,
    this.getTxTime,
    this.errorTxTime,
    this.getMeasureTime,
    this.errorMeasureTime,
    this.acelerometer,
    this.acelerometerFallAlarm,
    this.leds,
    this.getRtcDate,
    this.getRtcTime,
    this.setRtcDate,
    this.setRtcTime,
    this.tampering,
    this.gpsSyncStatus,
    this.isGpsSync,
    this.gpsLatitude,
    this.gpsLongitude,
  });
}

class ModelDeviceGeneral {
  RxDeviceGeneral rx;
  String setMeasureTime, setTxTime;
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markersGoogleMap = Map<MarkerId, Marker>();

  ModelDeviceGeneral({
    this.setMeasureTime = '',
    this.setTxTime = '',
    this.googleMapController,
    DateTime getRtcDate,
    TimeOfDay getRtcTime,
    DateTime setRtcDate,
    TimeOfDay setRtcTime,
    bool leds = false,
    bool acelerometer = false,
    bool acelerometerFallAlarm = false,
    bool gnss = false,
    bool confirmedMessages = false,
    bool debugFrame = false,
    String getMeasureTime = '0',
    String errorMeasureTime,
    String getTxTime = '0',
    String errorTxTime,
    bool maintenance = false,
    String acelerometerOrientation = 'unknown',
    double batteryValue = 0.0,
    double batteryPercentage = 0.0,
    double supply = 0.0,
    double solarPanel = 0.0,
    double temperature = 0.0,
    String tampering = 'unsupported',
    int gpsSyncStatus = -1,
    bool isGpsSync = false,
    double gpsLatitude = 0.0,
    double gpsLongitude = 0.0,
  }) {
    this.rx = RxDeviceGeneral(
      leds: leds.obs,
      acelerometer: acelerometer.obs,
      acelerometerFallAlarm: acelerometerFallAlarm.obs,
      acelerometerOrientation: acelerometerOrientation.obs,
      gnss: gnss.obs,
      confirmedMessages: confirmedMessages.obs,
      debugFrame: debugFrame.obs,
      getMeasureTime: getMeasureTime.obs,
      errorMeasureTime: errorMeasureTime.obs,
      getTxTime: getTxTime.obs,
      errorTxTime: errorTxTime.obs,
      maintenance: maintenance.obs,
      batteryValue: batteryValue.obs,
      batteryPercentage: batteryPercentage.obs,
      supply: supply.obs,
      solarPanel: solarPanel.obs,
      temperature: temperature.obs,
      getRtcDate: getRtcDate.obs,
      getRtcTime: getRtcTime.obs,
      setRtcDate: setRtcDate.obs,
      setRtcTime: setRtcTime.obs,
      tampering: tampering.obs,
      gpsSyncStatus: gpsSyncStatus.obs,
      isGpsSync: isGpsSync.obs,
      gpsLatitude: gpsLatitude.obs,
      gpsLongitude: gpsLongitude.obs,
    );
  }

  DateTime get getRtcDate => this.rx.getRtcDate.value;
  set getRtcDate(DateTime v) => this.rx.getRtcDate.value = v;

  TimeOfDay get getRtcTime => this.rx.getRtcTime.value;
  set getRtcTime(TimeOfDay v) => this.rx.getRtcTime.value = v;

  DateTime get setRtcDate => this.rx.setRtcDate.value;
  set setRtcDate(DateTime v) => this.rx.setRtcDate.value = v;

  TimeOfDay get setRtcTime => this.rx.setRtcTime.value;
  set setRtcTime(TimeOfDay v) => this.rx.setRtcTime.value = v;

  bool get leds => this.rx.leds.value;
  set leds(bool v) => this.rx.leds.value = v;

  bool get acelerometer => this.rx.acelerometer.value;
  set acelerometer(bool v) => this.rx.acelerometer.value = v;

  bool get acelerometerFallAlarm => this.rx.acelerometerFallAlarm.value;
  set acelerometerFallAlarm(bool v) => this.rx.acelerometerFallAlarm.value = v;

  String get acelerometerOrientation => this.rx.acelerometerOrientation.value;
  set acelerometerOrientation(String v) =>
      this.rx.acelerometerOrientation.value = v;

  bool get gnss => this.rx.gnss.value;
  set gnss(bool v) => this.rx.gnss.value = v;

  bool get confirmedMessages => this.rx.confirmedMessages.value;
  set confirmedMessages(bool v) => this.rx.confirmedMessages.value = v;

  bool get debugFrame => this.rx.debugFrame.value;
  set debugFrame(bool v) => this.rx.debugFrame.value = v;

  String get getMeasureTime => this.rx.getMeasureTime.value;
  set getMeasureTime(String v) => this.rx.getMeasureTime.value = v;

  String get errorMeasureTime => this.rx.errorMeasureTime.value;
  set errorMeasureTime(String v) => this.rx.errorMeasureTime.value = v;

  String get getTxTime => this.rx.getTxTime.value;
  set getTxTime(String v) => this.rx.getTxTime.value = v;

  String get errorTxTime => this.rx.errorTxTime.value;
  set errorTxTime(String v) => this.rx.errorTxTime.value = v;

  bool get maintenance => this.rx.maintenance.value;
  set maintenance(bool v) => this.rx.maintenance.value = v;

  double get batteryValue => this.rx.batteryValue.value;
  set batteryValue(double v) => this.rx.batteryValue.value = v;

  double get batteryPercentage => this.rx.batteryPercentage.value;
  set batteryPercentage(double v) => this.rx.batteryPercentage.value = v;

  double get supply => this.rx.supply.value;
  set supply(double v) => this.rx.supply.value = v;

  double get solarPanel => this.rx.solarPanel.value;
  set solarPanel(double v) => this.rx.solarPanel.value = v;

  double get temperature => this.rx.temperature.value;
  set temperature(double v) => this.rx.temperature.value = v;

  String get tampering => this.rx.tampering.value;
  set tampering(String v) => this.rx.tampering.value = v;

  int get gpsSyncStatus => this.rx.gpsSyncStatus.value;
  set gpsSyncStatus(int v) => this.rx.gpsSyncStatus.value = v;

  bool get isGpsSync => this.rx.isGpsSync.value;
  set isGpsSync(bool v) => this.rx.isGpsSync.value = v;

  double get gpsLatitude => this.rx.gpsLatitude.value;
  set gpsLatitude(double v) => this.rx.gpsLatitude.value = v;

  double get gpsLongitude => this.rx.gpsLongitude.value;
  set gpsLongitude(double v) => this.rx.gpsLongitude.value = v;
}
