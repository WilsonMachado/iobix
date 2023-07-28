import 'package:get/get_rx/get_rx.dart';

class RxSmartFaultDetector {
  //! En esta clase se crean los atributos que se setearán (o se obtendrán) a través del contexto
  final RxDouble deviceVersion;

  final RxInt permanentFault,
      transitoryFault,
      getTicksToDetonatePermanentAlarm,
      getTicksToDetonateTransitoryAlarm,
      isTimeReportChangingInAlarmMode,
      getTimeToReportFault,
      getTimeToFaultTimeOut;

  final RxString setTicksToDetonatePermanentAlarm,
      setTicksToDetonateTransitoryAlarm,
      setTimeToReportFault,
      setTimeToFaultTimeOut;

  final RxString errorSetTicksToDetonatePermanentAlarm,
      errorSetTicksToDetonateTransitoryAlarm,
      errorSetTimeToReportFault,
      errorSetTimeToFaultTimeOut;

  RxSmartFaultDetector({
    this.deviceVersion,
    this.permanentFault,
    this.transitoryFault,
    this.getTicksToDetonatePermanentAlarm,
    this.getTicksToDetonateTransitoryAlarm,
    this.isTimeReportChangingInAlarmMode,
    this.getTimeToReportFault,
    this.getTimeToFaultTimeOut,
    this.setTicksToDetonatePermanentAlarm,
    this.setTicksToDetonateTransitoryAlarm,
    this.setTimeToReportFault,
    this.setTimeToFaultTimeOut,
    this.errorSetTicksToDetonatePermanentAlarm,
    this.errorSetTicksToDetonateTransitoryAlarm,
    this.errorSetTimeToReportFault,
    this.errorSetTimeToFaultTimeOut,
  });
}

class ModelSmartFaultDetector {
  //! Esta es la clase principal. Aquí se definen los estados iniciales de los atributos, y los métodos get y set para cada uno de ellos. La clase RX se usa para enlazar el GetX con los atributos y métodos definidos para el dispositivo
  RxSmartFaultDetector rx;
  ModelSmartFaultDetector({
    double deviceVersion = 1.0,
    int permanentFault = 0,
    int transitoryFault = 0,
    int isTimeReportChangingInAlarmMode = 0,
    int getTicksToDetonatePermanentAlarm = 0,
    int getTicksToDetonateTransitoryAlarm = 0,
    int getTimeToReportFault = 0,
    int getTimeToFaultTimeOut = 0,
    String setTicksToDetonatePermanentAlarm = '',
    String setTimeToFaultTimeOut = '',
    String setTicksToDetonateTransitoryAlarm = '',
    String setTimeToReportFault = '',
    String errorSetTicksToDetonatePermanentAlarm,
    String errorSetTicksToDetonateTransitoryAlarm,
    String errorSetTimeToReportFault,
    String errorSetTimeToFaultTimeOut,
  }) {
    this.rx = RxSmartFaultDetector(
      deviceVersion: deviceVersion.obs,
      permanentFault: permanentFault.obs,
      transitoryFault: transitoryFault.obs,
      isTimeReportChangingInAlarmMode: isTimeReportChangingInAlarmMode.obs,
      getTicksToDetonatePermanentAlarm: getTicksToDetonatePermanentAlarm.obs,
      getTicksToDetonateTransitoryAlarm: getTicksToDetonateTransitoryAlarm.obs,
      getTimeToReportFault: getTimeToReportFault.obs,
      getTimeToFaultTimeOut: getTimeToFaultTimeOut.obs,
      setTicksToDetonatePermanentAlarm: setTicksToDetonatePermanentAlarm.obs,
      setTicksToDetonateTransitoryAlarm: setTicksToDetonateTransitoryAlarm.obs,
      setTimeToReportFault: setTimeToReportFault.obs,
      setTimeToFaultTimeOut: setTimeToFaultTimeOut.obs,
      errorSetTicksToDetonatePermanentAlarm:
          errorSetTicksToDetonatePermanentAlarm.obs,
      errorSetTicksToDetonateTransitoryAlarm:
          errorSetTicksToDetonateTransitoryAlarm.obs,
      errorSetTimeToReportFault: errorSetTimeToReportFault.obs,
      errorSetTimeToFaultTimeOut: errorSetTimeToFaultTimeOut.obs,
    );
  }

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;

  int get transitoryFault => this.rx.transitoryFault.value;
  set transitoryFault(int v) => this.rx.transitoryFault.value = v;

  int get permanentFault => this.rx.permanentFault.value;
  set permanentFault(int v) => this.rx.permanentFault.value = v;

  int get isTimeReportChangingInAlarmMode =>
      this.rx.isTimeReportChangingInAlarmMode.value;
  set isTimeReportChangingInAlarmMode(int v) =>
      this.rx.isTimeReportChangingInAlarmMode.value = v;

  int get getTicksToDetonatePermanentAlarm =>
      this.rx.getTicksToDetonatePermanentAlarm.value;
  set getTicksToDetonatePermanentAlarm(int v) =>
      this.rx.getTicksToDetonatePermanentAlarm.value = v;

  int get getTicksToDetonateTransitoryAlarm =>
      this.rx.getTicksToDetonateTransitoryAlarm.value;
  set getTicksToDetonateTransitoryAlarm(int v) =>
      this.rx.getTicksToDetonateTransitoryAlarm.value = v;

  int get getTimeToReportFault => this.rx.getTimeToReportFault.value;
  set getTimeToReportFault(int v) => this.rx.getTimeToReportFault.value = v;

  int get getTimeToFaultTimeOut => this.rx.getTimeToFaultTimeOut.value;
  set getTimeToFaultTimeOut(int v) => this.rx.getTimeToFaultTimeOut.value = v;

  String get setTicksToDetonatePermanentAlarm =>
      this.rx.setTicksToDetonatePermanentAlarm.value;
  set setTicksToDetonatePermanentAlarm(String v) =>
      this.rx.setTicksToDetonatePermanentAlarm.value = v;

  String get setTicksToDetonateTransitoryAlarm =>
      this.rx.setTicksToDetonateTransitoryAlarm.value;
  set setTicksToDetonateTransitoryAlarm(String v) =>
      this.rx.setTicksToDetonateTransitoryAlarm.value = v;

  String get setTimeToReportFault => this.rx.setTimeToReportFault.value;
  set setTimeToReportFault(String v) => this.rx.setTimeToReportFault.value = v;

  String get setTimeToFaultTimeOut => this.rx.setTimeToFaultTimeOut.value;
  set setTimeToFaultTimeOut(String v) =>
      this.rx.setTimeToFaultTimeOut.value = v;

  String get errorSetTicksToDetonatePermanentAlarm =>
      this.rx.errorSetTicksToDetonatePermanentAlarm.value;
  set errorSetTicksToDetonatePermanentAlarm(String v) =>
      this.rx.errorSetTicksToDetonatePermanentAlarm.value = v;

  String get errorSetTicksToDetonateTransitoryAlarm =>
      this.rx.errorSetTicksToDetonateTransitoryAlarm.value;
  set errorSetTicksToDetonateTransitoryAlarm(String v) =>
      this.rx.errorSetTicksToDetonateTransitoryAlarm.value = v;

  String get errorSetTimeToReportFault =>
      this.rx.errorSetTimeToReportFault.value;
  set errorSetTimeToReportFault(String v) =>
      this.rx.errorSetTimeToReportFault.value = v;

  String get errorSetTimeToFaultTimeOut =>
      this.rx.errorSetTimeToFaultTimeOut.value;
  set errorSetTimeToFaultTimeOut(String v) =>
      this.rx.errorSetTimeToFaultTimeOut.value = v;
}
