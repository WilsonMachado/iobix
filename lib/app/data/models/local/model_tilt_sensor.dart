import 'package:get/get_rx/get_rx.dart';

class RxTiltSensor {
  //! En esta clase se crean los atributos que se setearán (o se obtendrán) a través del contexto
  final RxDouble deviceVersion, angleIncl, angleX, angleY, angleZ;

  final RxInt getAlarmTransmitionPeriod,
      getAlarmModeStatus,
      getAngleDelta,
      getAngleMin,
      getAngleMax;

  final RxString setAlarmTransmitionPeriod,
      setAlarmModeStatus,
      setAngleDelta,
      setAngleMin,
      setAngleMax;

  final RxString errorSetAlarmTransmitionPeriod,
      errorSetAlarmModeStatus,
      errorSetAngleDelta,
      errorSetAngleMin,
      errorSetAngleMax;
  RxTiltSensor({
    this.angleIncl,
    this.angleX,
    this.angleY,
    this.angleZ,
    this.getAlarmTransmitionPeriod,
    this.getAlarmModeStatus,
    this.getAngleDelta,
    this.getAngleMin,
    this.getAngleMax,
    this.setAlarmTransmitionPeriod,
    this.setAlarmModeStatus,
    this.setAngleDelta,
    this.setAngleMin,
    this.setAngleMax,
    this.errorSetAlarmTransmitionPeriod,
    this.errorSetAlarmModeStatus,
    this.errorSetAngleDelta,
    this.errorSetAngleMin,
    this.errorSetAngleMax,
    this.deviceVersion,
  });
}

class ModelTiltSensor {
  //! Esta es la clase principal. Aquí se definen los estados iniciales de los atributos, y los métodos get y set para cada uno de ellos. La clase RX se usa para enlazar el GetX con los atributos y métodos definidos para el dispositivo
  RxTiltSensor rx;
  ModelTiltSensor({
    double deviceVersion = 1.0,
    double angleIncl = 0.0,
    double angleX = 0.0,
    double angleY = 0.0,
    double angleZ = 0.0,
    int getAlarmTransmitionPeriod = 0,
    int getAlarmModeStatus = 0,
    int getAngleDelta = 0,
    int getAngleMin = 0,
    int getAngleMax = 0,
    String setAlarmTransmitionPeriod = '',
    String setAlarmModeStatus = '',
    String setAngleDelta = '',
    String setAngleMin = '315',
    String setAngleMax = '45',
    String errorSetAlarmTransmitionPeriod,
    String errorSetAlarmModeStatus,
    String errorSetAngleDelta,
    String errorSetAngleMin,
    String errorSetAngleMax,
  }) {
    this.rx = RxTiltSensor(
      deviceVersion: deviceVersion.obs,
      angleIncl: angleIncl.obs,
      angleX: angleX.obs,
      angleY: angleY.obs,
      angleZ: angleZ.obs,
      getAlarmTransmitionPeriod: getAlarmTransmitionPeriod.obs,
      getAlarmModeStatus: getAlarmModeStatus.obs,
      getAngleDelta: getAngleDelta.obs,
      getAngleMin: getAngleMin.obs,
      getAngleMax: getAngleMax.obs,
      setAlarmTransmitionPeriod: setAlarmTransmitionPeriod.obs,
      setAlarmModeStatus: setAlarmModeStatus.obs,
      setAngleDelta: setAngleDelta.obs,
      setAngleMin: setAngleMin.obs,
      setAngleMax: setAngleMax.obs,
      errorSetAlarmTransmitionPeriod: errorSetAlarmTransmitionPeriod.obs,
      errorSetAlarmModeStatus: errorSetAlarmModeStatus.obs,
      errorSetAngleDelta: errorSetAngleDelta.obs,
      errorSetAngleMin: errorSetAngleMin.obs,
      errorSetAngleMax: errorSetAngleMax.obs,
    );
  }

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;

  double get angleIncl => this.rx.angleIncl.value;
  set angleIncl(double v) => this.rx.angleIncl.value = v;

  double get angleX => this.rx.angleX.value;
  set angleX(double v) => this.rx.angleX.value = v;

  double get angleY => this.rx.angleY.value;
  set angleY(double v) => this.rx.angleY.value = v;

  double get angleZ => this.rx.angleZ.value;
  set angleZ(double v) => this.rx.angleZ.value = v;

  int get getAlarmTransmitionPeriod => this.rx.getAlarmTransmitionPeriod.value;
  set getAlarmTransmitionPeriod(int v) =>
      this.rx.getAlarmTransmitionPeriod.value = v;

  int get getAlarmModeStatus => this.rx.getAlarmModeStatus.value;
  set getAlarmModeStatus(int v) => this.rx.getAlarmModeStatus.value = v;

  int get getAngleDelta => this.rx.getAngleDelta.value;
  set getAngleDelta(int v) => this.rx.getAngleDelta.value = v;

  int get getAngleMin => this.rx.getAngleMin.value;
  set getAngleMin(int v) => this.rx.getAngleMin.value = v;

  int get getAngleMax => this.rx.getAngleMax.value;
  set getAngleMax(int v) => this.rx.getAngleMax.value = v;

  String get setAlarmTransmitionPeriod =>
      this.rx.setAlarmTransmitionPeriod.value;
  set setAlarmTransmitionPeriod(String v) =>
      this.rx.setAlarmTransmitionPeriod.value = v;

  String get setAlarmModeStatus => this.rx.setAlarmModeStatus.value;
  set setAlarmModeStatus(String v) => this.rx.setAlarmModeStatus.value = v;

  String get setAngleDelta => this.rx.setAngleDelta.value;
  set setAngleDelta(String v) => this.rx.setAngleDelta.value = v;

  String get setAngleMin => this.rx.setAngleMin.value;
  set setAngleMin(String v) => this.rx.setAngleMin.value = v;

  String get setAngleMax => this.rx.setAngleMax.value;
  set setAngleMax(String v) => this.rx.setAngleMax.value = v;

  String get errorSetAlarmTransmitionPeriod =>
      this.rx.errorSetAlarmTransmitionPeriod.value;
  set errorSetAlarmTransmitionPeriod(String v) =>
      this.rx.errorSetAlarmTransmitionPeriod.value = v;

  String get errorSetAlarmModeStatus => this.rx.errorSetAlarmModeStatus.value;
  set errorSetAlarmModeStatus(String v) =>
      this.rx.errorSetAlarmModeStatus.value = v;

  String get errorSetAngleDelta => this.rx.errorSetAngleDelta.value;
  set errorSetAngleDelta(String v) => this.rx.errorSetAngleDelta.value = v;

  String get errorSetAngleMin => this.rx.errorSetAngleMin.value;
  set errorSetAngleMin(String v) => this.rx.errorSetAngleMin.value = v;

  String get errorSetAngleMax => this.rx.errorSetAngleMax.value;
  set errorSetAngleMax(String v) => this.rx.errorSetAngleMax.value = v;
}
