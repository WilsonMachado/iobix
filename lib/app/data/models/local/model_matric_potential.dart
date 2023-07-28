import 'package:get/get.dart';

class RxMatricPotential {
  final RxString electrovalveActivationSource;
  final RxInt pluv;
  final RxString soilTemperature, soilTemperature2;
  final RxDouble pressure1, pressure2;
  final RxInt pressureStatus1, pressureStatus2;

  final RxString getRtcOffset;
  final RxString setRtcOffset;
  final RxString getRtcOffsetSign;
  final RxString setRtcOffsetSign;

  // Para la lectura de las variables del suelo

  final RxString getSoilTemp;
  final RxString getSoilHum;
  final RxString getSoilElectro;
  final RxString getSoilpH;
  final RxString getSoilN;
  final RxString getSoilK;
  final RxString getSoilP;

  final RxBool irrigationStatus;
  final RxString getIrrigationTime, getIrrigationWaitTime;
  final RxString hoursIrrigationTime;
  final RxString rtcOffsetCalibration, rtcCLKOUT;
  final RxString minutesIrrigationTime;
  final RxString setIrrigationTime, setIrrigationWaitTime;
  final RxString setIrrigationThreshold;
  final RxString errorSetIrrigationThreshold;
  final RxString errorRTCOffset;
  final RxString errorSetIrrigationTime, errorSetIrrigationWaitTime;
  final RxString getPvToStartIrrigation, getPvToStopIrrigation;
  final RxString setPvToStartIrrigation, setPvToStopIrrigation;
  final RxString errorSetPvToStartIrrigation, errorSetPvToStopIrrigation;
  final RxBool electrovalveStatus;
  final RxInt setSensorsForIrrigation;
  final RxInt getGmIrrigationControl, setGmIrrigationControl;
  final RxString gmIrrigationControlSensors;
  final RxString errorSetGmIrrigationControl;
  final RxString getResistanceCalibValue,
      setResistanceCalibValue,
      errorSetResistanceCalibValue;
  final RxInt getElectrovalveControl;
  final RxInt getResistanceCalibStatus;
  final RxInt getIrrigationCycleStatus;

  // I2C Status

  final RxInt i2cStatus;

  // Device Version
  final RxDouble deviceVersion;
  final RxInt deviceVariation;

  ///* Para las diferentes variantes que aparecen a partir de las versiones del potencial mátrico

  RxMatricPotential({
    this.pluv,
    this.rtcCLKOUT,
    this.soilTemperature,
    this.soilTemperature2,
    this.pressure1,
    this.pressure2,
    this.pressureStatus1,
    this.pressureStatus2,
    this.irrigationStatus,
    this.getIrrigationTime,
    this.hoursIrrigationTime,
    this.rtcOffsetCalibration,
    this.minutesIrrigationTime,
    this.getIrrigationWaitTime,
    this.setIrrigationTime,
    this.setIrrigationThreshold,
    this.errorSetIrrigationThreshold,
    this.errorRTCOffset,
    this.setIrrigationWaitTime,
    this.getPvToStartIrrigation,
    this.getPvToStopIrrigation,
    this.setPvToStartIrrigation,
    this.setPvToStopIrrigation,
    this.electrovalveStatus,
    this.setSensorsForIrrigation,
    this.electrovalveActivationSource,
    this.getGmIrrigationControl,
    this.gmIrrigationControlSensors,
    this.setGmIrrigationControl,
    this.getResistanceCalibValue,
    this.setResistanceCalibValue,
    this.errorSetIrrigationTime,
    this.errorSetIrrigationWaitTime,
    this.errorSetPvToStartIrrigation,
    this.errorSetPvToStopIrrigation,
    this.errorSetGmIrrigationControl,
    this.errorSetResistanceCalibValue,
    this.getElectrovalveControl,
    this.getResistanceCalibStatus,
    this.getIrrigationCycleStatus,
    this.deviceVersion,
    this.deviceVariation,
    this.getRtcOffset,
    this.setRtcOffset,
    this.getRtcOffsetSign,
    this.setRtcOffsetSign,

    // I2C status

    this.i2cStatus,

    // Sensor de suelo GEMHO

    this.getSoilTemp,
    this.getSoilHum,
    this.getSoilElectro,
    this.getSoilpH,
    this.getSoilN,
    this.getSoilK,
    this.getSoilP,
  });
}

class ModelMatricPotential {
  RxMatricPotential rx;

  ModelMatricPotential({
    int pluv = 0,
    String rtcCLKOUT = '0',
    String soilTemperature = '0.00',
    String soilTemperature2 = '0.00',
    double pressure1 = 0.0,
    double pressure2 = 0.0,

    // Disconnect Status
    int pressureStatus1 = 4,
    int pressureStatus2 = 4,
    bool irrigationStatus = false,
    String getIrrigationTime = '0',
    String hoursIrrigationTime = '00',
    String rtcOffsetCalibration = '0',
    String minutesIrrigationTime = '00',
    String getIrrigationWaitTime = 'Desconocida',
    String setIrrigationTime = '',
    String setIrrigationThreshold = '',
    String errorSetIrrigationThreshold,
    String errorRTCOffset,
    String setIrrigationWaitTime = '',
    String getPvToStartIrrigation = '0',
    String getPvToStopIrrigation = '0',
    String setPvToStartIrrigation = '',
    String setPvToStopIrrigation = '',
    bool electrovalveStatus = false,
    int setSensorsForIrrigation = 0x00,
    String electrovalveActivationSource = 'Desconocido',
    int getGmIrrigationControl = 0,
    String gmIrrigationControlSensors = 'Desconocido',
    int setGmIrrigationControl = 0,
    String getResistanceCalibValue = '0',
    String setResistanceCalibValue = '',
    String errorSetIrrigationTime,
    String errorSetIrrigationWaitTime,
    String errorSetPvToStartIrrigation,
    String errorSetPvToStopIrrigation,
    String errorSetGmIrrigationControl,
    String errorSetResistanceCalibValue,
    int getElectrovalveControl = -1,
    int getResistanceCalibStatus = -1,
    int getIrrigationCycleStatus = -1,
    double deviceVersion = 1,
    int deviceVariation = 0,
    String getRtcOffset = '0',
    String setRtcOffset = '0',
    String getRtcOffsetSign = '+',
    String setRtcOffsetSign = '+',

    ///* Por defecto, no hay variación

    // Sensor de suelo GString
    String getSoilTemp = 'Desconocido',
    String getSoilHum = 'Desconocido',
    String getSoilElectro = 'Desconocido',
    String getSoilpH = 'Desconocido',
    String getSoilN = 'Desconocido',
    String getSoilK = 'Desconocido',
    String getSoilP = 'Desconocido',

    // I2C status

    int i2cStatus = 0,
  }) {
    this.rx = RxMatricPotential(
      pluv: pluv.obs,
      rtcCLKOUT: rtcCLKOUT.obs,
      soilTemperature: soilTemperature.obs,
      soilTemperature2: soilTemperature2.obs,
      pressure1: pressure1.obs,
      pressure2: pressure2.obs,
      pressureStatus1: pressureStatus1.obs,
      pressureStatus2: pressureStatus2.obs,
      irrigationStatus: irrigationStatus.obs,
      getIrrigationTime: getIrrigationTime.obs,
      hoursIrrigationTime: hoursIrrigationTime.obs,
      rtcOffsetCalibration: rtcOffsetCalibration.obs,
      minutesIrrigationTime: minutesIrrigationTime.obs,
      getIrrigationWaitTime: getIrrigationWaitTime.obs,
      setIrrigationTime: setIrrigationTime.obs,
      setIrrigationThreshold: setIrrigationThreshold.obs,
      errorSetIrrigationThreshold: errorSetIrrigationThreshold.obs,
      errorRTCOffset: errorRTCOffset.obs,
      setIrrigationWaitTime: setIrrigationWaitTime.obs,
      getPvToStartIrrigation: getPvToStartIrrigation.obs,
      getPvToStopIrrigation: getPvToStopIrrigation.obs,
      setPvToStartIrrigation: setPvToStartIrrigation.obs,
      setPvToStopIrrigation: setPvToStopIrrigation.obs,
      electrovalveStatus: electrovalveStatus.obs,
      setSensorsForIrrigation: setSensorsForIrrigation.obs,
      electrovalveActivationSource: electrovalveActivationSource.obs,
      getGmIrrigationControl: getGmIrrigationControl.obs,
      gmIrrigationControlSensors: gmIrrigationControlSensors.obs,
      setGmIrrigationControl: setGmIrrigationControl.obs,
      getResistanceCalibValue: getResistanceCalibValue.obs,
      setResistanceCalibValue: setResistanceCalibValue.obs,
      getRtcOffset: getRtcOffset.obs,
      setRtcOffset: setRtcOffset.obs,
      getRtcOffsetSign: getRtcOffsetSign.obs,
      setRtcOffsetSign: setRtcOffsetSign.obs,
      errorSetIrrigationTime: errorSetIrrigationTime.obs,
      errorSetIrrigationWaitTime: errorSetIrrigationWaitTime.obs,
      errorSetPvToStartIrrigation: errorSetPvToStartIrrigation.obs,
      errorSetPvToStopIrrigation: errorSetPvToStopIrrigation.obs,
      errorSetGmIrrigationControl: errorSetGmIrrigationControl.obs,
      errorSetResistanceCalibValue: errorSetResistanceCalibValue.obs,
      getElectrovalveControl: getElectrovalveControl.obs,
      getResistanceCalibStatus: getResistanceCalibStatus.obs,
      getIrrigationCycleStatus: getIrrigationCycleStatus.obs,
      deviceVersion: deviceVersion.obs,
      deviceVariation: deviceVariation.obs,

      // Sensor de suelo GEMHO

      getSoilTemp: getSoilTemp.obs,
      getSoilHum: getSoilHum.obs,
      getSoilElectro: getSoilElectro.obs,
      getSoilpH: getSoilpH.obs,
      getSoilN: getSoilN.obs,
      getSoilK: getSoilK.obs,
      getSoilP: getSoilP.obs,

      // I2C Status

      i2cStatus: i2cStatus.obs,
    );
  }

  RxList<String> mgResistance = [
    'disconnected',
    'disconnected',
    'disconnected',
    'disconnected',
    'disconnected',
    'disconnected'
  ].obs;
  RxList<String> mgKpa = [
    'disconnected',
    'disconnected',
    'disconnected',
    'disconnected',
    'disconnected',
    'disconnected'
  ].obs;

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;

  //deviceVariation

  int get deviceVariation => this.rx.deviceVariation.value;
  set deviceVariation(int v) => this.rx.deviceVariation.value = v;

  int get pluv => this.rx.pluv.value;
  set pluv(int v) => this.rx.pluv.value = v;

  String get rtcCLKOUT => this.rx.rtcCLKOUT.value;
  set rtcCLKOUT(String v) => this.rx.rtcCLKOUT.value = v;

  String get soilTemperature => this.rx.soilTemperature.value;
  set soilTemperature(String v) => this.rx.soilTemperature.value = v;

  String get soilTemperature2 => this.rx.soilTemperature2.value;
  set soilTemperature2(String v) => this.rx.soilTemperature2.value = v;

  double get pressure1 => this.rx.pressure1.value;
  set pressure1(double v) => this.rx.pressure1.value = v;

  double get pressure2 => this.rx.pressure2.value;
  set pressure2(double v) => this.rx.pressure2.value = v;

  int get pressureStatus1 => this.rx.pressureStatus1.value;
  set pressureStatus1(int v) => this.rx.pressureStatus1.value = v;

  int get pressureStatus2 => this.rx.pressureStatus2.value;
  set pressureStatus2(int v) => this.rx.pressureStatus2.value = v;

  bool get irrigationStatus => this.rx.irrigationStatus.value;
  set irrigationStatus(bool v) => this.rx.irrigationStatus.value = v;

  String get getIrrigationTime => this.rx.getIrrigationTime.value;
  set getIrrigationTime(String v) => this.rx.getIrrigationTime.value = v;

  // hoursIrrigationTime

  String get hoursIrrigationTime => this.rx.hoursIrrigationTime.value;
  set hoursIrrigationTime(String v) => this.rx.hoursIrrigationTime.value = v;

  // rtcOffsetCalibration

  String get rtcOffsetCalibration => this.rx.rtcOffsetCalibration.value;
  set rtcOffsetCalibration(String v) => this.rx.rtcOffsetCalibration.value = v;

  // minutesIrrigationTime

  String get minutesIrrigationTime => this.rx.minutesIrrigationTime.value;
  set minutesIrrigationTime(String v) =>
      this.rx.minutesIrrigationTime.value = v;

  String get getIrrigationWaitTime => this.rx.getIrrigationWaitTime.value;
  set getIrrigationWaitTime(String v) =>
      this.rx.getIrrigationWaitTime.value = v;

  String get setIrrigationTime => this.rx.setIrrigationTime.value;
  set setIrrigationTime(String v) => this.rx.setIrrigationTime.value = v;

  //setIrrigationThreshold

  String get setIrrigationThreshold => this.rx.setIrrigationThreshold.value;
  set setIrrigationThreshold(String v) =>
      this.rx.setIrrigationThreshold.value = v;

  String get setIrrigationWaitTime => this.rx.setIrrigationWaitTime.value;
  set setIrrigationWaitTime(String v) =>
      this.rx.setIrrigationWaitTime.value = v;

  String get getPvToStartIrrigation => this.rx.getPvToStartIrrigation.value;
  set getPvToStartIrrigation(String v) =>
      this.rx.getPvToStartIrrigation.value = v;

  String get getPvToStopIrrigation => this.rx.getPvToStopIrrigation.value;
  set getPvToStopIrrigation(String v) =>
      this.rx.getPvToStopIrrigation.value = v;

  String get setPvToStartIrrigation => this.rx.setPvToStartIrrigation.value;
  set setPvToStartIrrigation(String v) =>
      this.rx.setPvToStartIrrigation.value = v;

  String get setPvToStopIrrigation => this.rx.setPvToStopIrrigation.value;
  set setPvToStopIrrigation(String v) =>
      this.rx.setPvToStopIrrigation.value = v;

  bool get electrovalveStatus => this.rx.electrovalveStatus.value;
  set electrovalveStatus(bool v) => this.rx.electrovalveStatus.value = v;

  int get getGmIrrigationControl => this.rx.getGmIrrigationControl.value;
  set getGmIrrigationControl(int v) => this.rx.getGmIrrigationControl.value = v;

// setSensorsForIrrigation

  int get setSensorsForIrrigation => this.rx.setSensorsForIrrigation.value;
  set setSensorsForIrrigation(int v) =>
      this.rx.setSensorsForIrrigation.value = v;

  String get gmIrrigationControlSensors =>
      this.rx.gmIrrigationControlSensors.value;
  set gmIrrigationControlSensors(String v) =>
      this.rx.gmIrrigationControlSensors.value = v;

  int get setGmIrrigationControl => this.rx.setGmIrrigationControl.value;
  set setGmIrrigationControl(int v) => this.rx.setGmIrrigationControl.value = v;

  String get getResistanceCalibValue => this.rx.getResistanceCalibValue.value;
  set getResistanceCalibValue(String v) =>
      this.rx.getResistanceCalibValue.value = v;

  String get setResistanceCalibValue => this.rx.setResistanceCalibValue.value;
  set setResistanceCalibValue(String v) =>
      this.rx.setResistanceCalibValue.value = v;

  String get errorSetIrrigationTime => this.rx.errorSetIrrigationTime.value;
  set errorSetIrrigationTime(String v) =>
      this.rx.errorSetIrrigationTime.value = v;

  // errorSetIrrigationThreshold

  String get errorSetIrrigationThreshold =>
      this.rx.errorSetIrrigationThreshold.value;
  set errorSetIrrigationThreshold(String v) =>
      this.rx.errorSetIrrigationThreshold.value = v;

  String get errorSetIrrigationWaitTime =>
      this.rx.errorSetIrrigationWaitTime.value;
  set errorSetIrrigationWaitTime(String v) =>
      this.rx.errorSetIrrigationWaitTime.value = v;

  String get errorSetPvToStartIrrigation =>
      this.rx.errorSetPvToStartIrrigation.value;
  set errorSetPvToStartIrrigation(String v) =>
      this.rx.errorSetPvToStartIrrigation.value = v;

  String get errorSetPvToStopIrrigation =>
      this.rx.errorSetPvToStopIrrigation.value;
  set errorSetPvToStopIrrigation(String v) =>
      this.rx.errorSetPvToStopIrrigation.value = v;

  String get errorSetGmIrrigationControl =>
      this.rx.errorSetGmIrrigationControl.value;
  set errorSetGmIrrigationControl(String v) =>
      this.rx.errorSetGmIrrigationControl.value = v;

  String get errorSetResistanceCalibValue =>
      this.rx.errorSetResistanceCalibValue.value;
  set errorSetResistanceCalibValue(String v) =>
      this.rx.errorSetResistanceCalibValue.value = v;

  int get getElectrovalveControl => this.rx.getElectrovalveControl.value;
  set getElectrovalveControl(int v) => this.rx.getElectrovalveControl.value = v;

  String get electrovalveActivationSource =>
      this.rx.electrovalveActivationSource.value;
  set electrovalveActivationSource(String v) =>
      this.rx.electrovalveActivationSource.value = v;

  int get getResistanceCalibStatus => this.rx.getResistanceCalibStatus.value;
  set getResistanceCalibStatus(int v) =>
      this.rx.getResistanceCalibStatus.value = v;

  int get getIrrigationCycleStatus => this.rx.getIrrigationCycleStatus.value;
  set getIrrigationCycleStatus(int v) =>
      this.rx.getIrrigationCycleStatus.value = v;

  ///!rtcOffset

  String get getRtcOffsetSign => this.rx.getRtcOffsetSign.value;
  set getRtcOffsetSign(String v) => this.rx.getRtcOffsetSign.value = v;

  String get setRtcOffsetSign => this.rx.setRtcOffsetSign.value;
  set setRtcOffsetSign(String v) => this.rx.setRtcOffsetSign.value = v;

  String get getRtcOffset => this.rx.getRtcOffset.value;
  set getRtcOffset(String v) => this.rx.getRtcOffset.value = v;

  String get setRtcOffset => this.rx.setRtcOffset.value;
  set setRtcOffset(String v) => this.rx.setRtcOffset.value = v;

  String get errorRTCOffset => this.rx.errorRTCOffset.value;
  set errorRTCOffset(String v) => this.rx.errorRTCOffset.value = v;

  // Sensor de suelo GEMHO

  String get getSoilTemp => this.rx.getSoilTemp.value;
  set getSoilTemp(String v) => this.rx.getSoilTemp.value = v;

  String get getSoilHum => this.rx.getSoilHum.value;
  set getSoilHum(String v) => this.rx.getSoilHum.value = v;

  String get getSoilElectro => this.rx.getSoilElectro.value;
  set getSoilElectro(String v) => this.rx.getSoilElectro.value = v;

  String get getSoilpH => this.rx.getSoilpH.value;
  set getSoilpH(String v) => this.rx.getSoilpH.value = v;

  String get getSoilN => this.rx.getSoilN.value;
  set getSoilN(String v) => this.rx.getSoilN.value = v;

  String get getSoilK => this.rx.getSoilK.value;
  set getSoilK(String v) => this.rx.getSoilK.value = v;

  String get getSoilP => this.rx.getSoilP.value;
  set getSoilP(String v) => this.rx.getSoilP.value = v;

  // I2C Status

  int get i2cStatus => this.rx.i2cStatus.value;
  set i2cStatus(int v) => this.rx.i2cStatus.value = v;
}
