import 'package:get/get_rx/get_rx.dart';

class RxIrisLogger {
  final RxDouble tempCurrent,
      wsCurrent,
      wdCurrent,
      humCurrent,
      pressCurrent,
      rainMP600Current,
      evaporationCurrent,
      rainCurrent,
      batteryCurrent;

  final RxDouble tempLogged,
      wsLogged,
      wdLogged,
      humLogged,
      pressLogged,
      rainMP600Logged,
      evaporationLogged,
      rainLogged,
      batteryLogged;

  final RxString communicationStatus;

  RxIrisLogger({
    // Current

    this.tempCurrent,
    this.wsCurrent,
    this.wdCurrent,
    this.humCurrent,
    this.pressCurrent,
    this.rainMP600Current,
    this.evaporationCurrent,
    this.rainCurrent,
    this.batteryCurrent,

    // Logged

    this.tempLogged,
    this.wsLogged,
    this.wdLogged,
    this.humLogged,
    this.pressLogged,
    this.rainMP600Logged,
    this.evaporationLogged,
    this.rainLogged,
    this.batteryLogged,
    this.communicationStatus,
  });
}

class ModelIrisLogger {
  RxIrisLogger rx;

  ModelIrisLogger({
    // Current

    double tempCurrent = 0.0,
    double wsCurrent = 0.0,
    double wdCurrent = 0.0,
    double humCurrent = 0.0,
    double pressCurrent = 0.0,
    double rainMP600Current = 0.0,
    double evaporationCurrent = 0.0,
    double rainCurrent = 0.0,
    double batteryCurrent = 0.0,

    // Logged

    double tempLogged = 0.0,
    double wsLogged = 0.0,
    double wdLogged = 0.0,
    double humLogged = 0.0,
    double pressLogged = 0.0,
    double rainMP600Logged = 0.0,
    double evaporationLogged = 0.0,
    double rainLogged = 0.0,
    double batteryLogged = 0.0,
    String communicationStatus = 'Desconocido',
  }) {
    this.rx = RxIrisLogger(
      // Current

      tempCurrent: tempCurrent.obs,
      wsCurrent: wsCurrent.obs,
      wdCurrent: wdCurrent.obs,
      humCurrent: humCurrent.obs,
      pressCurrent: pressCurrent.obs,
      rainMP600Current: rainMP600Current.obs,
      evaporationCurrent: evaporationCurrent.obs,
      rainCurrent: rainCurrent.obs,
      batteryCurrent: batteryCurrent.obs,

      // Logged

      tempLogged: tempLogged.obs,
      wsLogged: wsCurrent.obs,
      wdLogged: wdLogged.obs,
      humLogged: humLogged.obs,
      pressLogged: pressLogged.obs,
      rainMP600Logged: rainMP600Logged.obs,
      evaporationLogged: evaporationLogged.obs,
      rainLogged: rainLogged.obs,
      batteryLogged: batteryLogged.obs,

      communicationStatus: communicationStatus.obs,
    );
  }

  // Variables current

  double get tempCurrent => this.rx.tempCurrent.value;
  set tempCurrent(double v) => this.rx.tempCurrent.value = v;

  double get wsCurrent => this.rx.wsCurrent.value;
  set wsCurrent(double v) => this.rx.wsCurrent.value = v;

  double get wdCurrent => this.rx.wdCurrent.value;
  set wdCurrent(double v) => this.rx.wdCurrent.value = v;

  double get humCurrent => this.rx.humCurrent.value;
  set humCurrent(double v) => this.rx.humCurrent.value = v;

  double get pressCurrent => this.rx.pressCurrent.value;
  set pressCurrent(double v) => this.rx.pressCurrent.value = v;

  double get rainMP600Current => this.rx.rainMP600Current.value;
  set rainMP600Current(double v) => this.rx.rainMP600Current.value = v;

  double get evaporationCurrent => this.rx.evaporationCurrent.value;
  set evaporationCurrent(double v) => this.rx.evaporationCurrent.value = v;

  double get rainCurrent => this.rx.rainCurrent.value;
  set rainCurrent(double v) => this.rx.rainCurrent.value = v;

  double get batteryCurrent => this.rx.batteryCurrent.value;
  set batteryCurrent(double v) => this.rx.batteryCurrent.value = v;

  // Variables logged

  double get tempLogged => this.rx.tempLogged.value;
  set tempLogged(double v) => this.rx.tempLogged.value = v;

  double get wsLogged => this.rx.wsLogged.value;
  set wsLogged(double v) => this.rx.wsLogged.value = v;

  double get wdLogged => this.rx.wdLogged.value;
  set wdLogged(double v) => this.rx.wdLogged.value = v;

  double get humLogged => this.rx.humLogged.value;
  set humLogged(double v) => this.rx.humLogged.value = v;

  double get pressLogged => this.rx.pressLogged.value;
  set pressLogged(double v) => this.rx.pressLogged.value = v;

  double get rainMP600Logged => this.rx.rainMP600Logged.value;
  set rainMP600Logged(double v) => this.rx.rainMP600Logged.value = v;

  double get evaporationLogged => this.rx.evaporationLogged.value;
  set evaporationLogged(double v) => this.rx.evaporationLogged.value = v;

  double get rainLogged => this.rx.rainLogged.value;
  set rainLogged(double v) => this.rx.rainLogged.value = v;

  double get batteryLogged => this.rx.batteryLogged.value;
  set batteryLogged(double v) => this.rx.batteryLogged.value = v;

  String get communicationStatus => this.rx.communicationStatus.value;
  set communicationStatus(String v) => this.rx.communicationStatus.value = v;
}
