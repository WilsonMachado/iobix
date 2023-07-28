import 'package:get/get_rx/get_rx.dart';

class RxLevelSensor {
  final RxString getMaxsonarDistance,
      getMaxsonarDelta,
      getMaxsonarMax,
      getMaxsonarMin;
  final RxString setMaxsonarDelta, setMaxsonarMax, setMaxsonarMin;
  final RxString errorSetMaxsonarDelta,
      errorSetMaxsonarMax,
      errorSetMaxsonarMin;

  final RxInt getI2cSensor, setI2cSensor;
  final RxString errorSetI2cSensor;

  // BME280
  final RxString i2cBme280Status,
      i2cBme280Temperature,
      i2cBme280Humidity,
      i2cBme280Pressure;

  // GPS Sync
  final RxBool isAnyEnableGnssSync;
  final RxString getGnssSyncPeriodicity;

  final RxBool enableGnssSyncMinute;
  final RxString setGnssSyncMinute, errorSetGnssSyncMinute;
  final RxBool enableGnssSyncHour;
  final RxString setGnssSyncHour, errorSetGnssSyncHour;

  final RxBool enableGnssSyncDayWeekOrMonth;
  final RxInt selectGnssSyncDayWeekOrMonth;
  final RxString setGnssSyncDayWeekOrMonth, errorSetGnssSyncDayWeekOrMonth;

  RxLevelSensor({
    this.setMaxsonarDelta,
    this.setMaxsonarMax,
    this.setMaxsonarMin,
    this.errorSetMaxsonarDelta,
    this.errorSetMaxsonarMax,
    this.errorSetMaxsonarMin,
    this.getMaxsonarDelta,
    this.getMaxsonarMax,
    this.getMaxsonarMin,
    this.getMaxsonarDistance,
    this.getI2cSensor,
    this.setI2cSensor,
    this.errorSetI2cSensor,
    this.i2cBme280Status,
    this.i2cBme280Temperature,
    this.i2cBme280Humidity,
    this.i2cBme280Pressure,
    this.isAnyEnableGnssSync,
    this.enableGnssSyncMinute,
    this.setGnssSyncMinute,
    this.enableGnssSyncHour,
    this.setGnssSyncHour,
    this.enableGnssSyncDayWeekOrMonth,
    this.getGnssSyncPeriodicity,
    this.setGnssSyncDayWeekOrMonth,
    this.selectGnssSyncDayWeekOrMonth,
    this.errorSetGnssSyncMinute,
    this.errorSetGnssSyncHour,
    this.errorSetGnssSyncDayWeekOrMonth,
  });
}

class ModelLevelSensor {
  RxLevelSensor rx;

  ModelLevelSensor({
    String setMaxsonarDelta = '',
    String setMaxsonarMax = '',
    String setMaxsonarMin = '',
    String errorSetMaxsonarDelta,
    String errorSetMaxsonarMax,
    String errorSetMaxsonarMin,
    String getMaxsonarDelta = '0',
    String getMaxsonarMax = '0',
    String getMaxsonarMin = '0',
    String getMaxsonarDistance = '0',
    int getI2cSensor = 0,
    String i2cBme280Status = '',
    String i2cBme280Temperature = '0.00',
    String i2cBme280Humidity = '0',
    String i2cBme280Pressure = '0.00',
    int setI2cSensor = -1,
    String errorSetI2cSensor,
    bool isAnyEnableGnssSync = false,
    bool enableGnssSyncMinute = false,
    String setGnssSyncMinute = '',
    bool enableGnssSyncHour = false,
    String setGnssSyncHour = '',
    bool enableGnssSyncDayWeekOrMonth = false,
    String getGnssSyncPeriodicity = '',
    String setGnssSyncDayWeekOrMonth = '',
    int selectGnssSyncDayWeekOrMonth = 0,
    String errorSetGnssSyncMinute = '',
    String errorSetGnssSyncHour = '',
    String errorSetGnssSyncDayWeekOrMonth = '',
  }) {
    this.rx = RxLevelSensor(
      setMaxsonarDelta: setMaxsonarDelta.obs,
      setMaxsonarMax: setMaxsonarMax.obs,
      setMaxsonarMin: setMaxsonarMin.obs,
      errorSetMaxsonarDelta: errorSetMaxsonarDelta.obs,
      errorSetMaxsonarMax: errorSetMaxsonarMax.obs,
      errorSetMaxsonarMin: errorSetMaxsonarMin.obs,
      getMaxsonarDelta: getMaxsonarDelta.obs,
      getMaxsonarMax: getMaxsonarMax.obs,
      getMaxsonarMin: getMaxsonarMin.obs,
      getMaxsonarDistance: getMaxsonarDistance.obs,
      getI2cSensor: getI2cSensor.obs,
      i2cBme280Status: i2cBme280Status.obs,
      i2cBme280Temperature: i2cBme280Temperature.obs,
      i2cBme280Humidity: i2cBme280Humidity.obs,
      i2cBme280Pressure: i2cBme280Pressure.obs,
      setI2cSensor: setI2cSensor.obs,
      errorSetI2cSensor: errorSetI2cSensor.obs,
      isAnyEnableGnssSync: isAnyEnableGnssSync.obs,
      enableGnssSyncMinute: enableGnssSyncMinute.obs,
      setGnssSyncMinute: setGnssSyncMinute.obs,
      enableGnssSyncHour: enableGnssSyncHour.obs,
      setGnssSyncHour: setGnssSyncHour.obs,
      enableGnssSyncDayWeekOrMonth: enableGnssSyncDayWeekOrMonth.obs,
      getGnssSyncPeriodicity: getGnssSyncPeriodicity.obs,
      setGnssSyncDayWeekOrMonth: setGnssSyncDayWeekOrMonth.obs,
      selectGnssSyncDayWeekOrMonth: selectGnssSyncDayWeekOrMonth.obs,
      errorSetGnssSyncMinute: errorSetGnssSyncMinute.obs,
      errorSetGnssSyncHour: errorSetGnssSyncHour.obs,
      errorSetGnssSyncDayWeekOrMonth: errorSetGnssSyncDayWeekOrMonth.obs,
    );
  }

  String get setMaxsonarDelta => this.rx.setMaxsonarDelta.value;
  set setMaxsonarDelta(String v) => this.rx.setMaxsonarDelta.value = v;

  String get setMaxsonarMax => this.rx.setMaxsonarMax.value;
  set setMaxsonarMax(String v) => this.rx.setMaxsonarMax.value = v;

  String get setMaxsonarMin => this.rx.setMaxsonarMin.value;
  set setMaxsonarMin(String v) => this.rx.setMaxsonarMin.value = v;

  String get errorSetMaxsonarDelta => this.rx.errorSetMaxsonarDelta.value;
  set errorSetMaxsonarDelta(String v) =>
      this.rx.errorSetMaxsonarDelta.value = v;

  String get errorSetMaxsonarMax => this.rx.errorSetMaxsonarMax.value;
  set errorSetMaxsonarMax(String v) => this.rx.errorSetMaxsonarMax.value = v;

  String get errorSetMaxsonarMin => this.rx.errorSetMaxsonarMin.value;
  set errorSetMaxsonarMin(String v) => this.rx.errorSetMaxsonarMin.value = v;

  String get getMaxsonarDelta => this.rx.getMaxsonarDelta.value;
  set getMaxsonarDelta(String v) => this.rx.getMaxsonarDelta.value = v;

  String get getMaxsonarMax => this.rx.getMaxsonarMax.value;
  set getMaxsonarMax(String v) => this.rx.getMaxsonarMax.value = v;

  String get getMaxsonarMin => this.rx.getMaxsonarMin.value;
  set getMaxsonarMin(String v) => this.rx.getMaxsonarMin.value = v;

  String get getMaxsonarDistance => this.rx.getMaxsonarDistance.value;
  set getMaxsonarDistance(String v) => this.rx.getMaxsonarDistance.value = v;

  int get getI2cSensor => this.rx.getI2cSensor.value;
  set getI2cSensor(int v) => this.rx.getI2cSensor.value = v;

  String get i2cBme280Status => this.rx.i2cBme280Status.value;
  set i2cBme280Status(String v) => this.rx.i2cBme280Status.value = v;

  String get i2cBme280Temperature => this.rx.i2cBme280Temperature.value;
  set i2cBme280Temperature(String v) => this.rx.i2cBme280Temperature.value = v;

  String get i2cBme280Humidity => this.rx.i2cBme280Humidity.value;
  set i2cBme280Humidity(String v) => this.rx.i2cBme280Humidity.value = v;

  String get i2cBme280Pressure => this.rx.i2cBme280Pressure.value;
  set i2cBme280Pressure(String v) => this.rx.i2cBme280Pressure.value = v;

  int get setI2cSensor => this.rx.setI2cSensor.value;
  set setI2cSensor(int v) => this.rx.setI2cSensor.value = v;

  String get errorSetI2cSensor => this.rx.errorSetI2cSensor.value;
  set errorSetI2cSensor(String v) => this.rx.errorSetI2cSensor.value = v;

  bool get isAnyEnableGnssSync => this.rx.isAnyEnableGnssSync.value;
  set isAnyEnableGnssSync(bool v) => this.rx.isAnyEnableGnssSync.value = v;

  bool get enableGnssSyncMinute => this.rx.enableGnssSyncMinute.value;
  set enableGnssSyncMinute(bool v) => this.rx.enableGnssSyncMinute.value = v;

  String get setGnssSyncMinute => this.rx.setGnssSyncMinute.value;
  set setGnssSyncMinute(String v) => this.rx.setGnssSyncMinute.value = v;

  bool get enableGnssSyncHour => this.rx.enableGnssSyncHour.value;
  set enableGnssSyncHour(bool v) => this.rx.enableGnssSyncHour.value = v;

  String get setGnssSyncHour => this.rx.setGnssSyncHour.value;
  set setGnssSyncHour(String v) => this.rx.setGnssSyncHour.value = v;

  bool get enableGnssSyncDayWeekOrMonth =>
      this.rx.enableGnssSyncDayWeekOrMonth.value;
  set enableGnssSyncDayWeekOrMonth(bool v) =>
      this.rx.enableGnssSyncDayWeekOrMonth.value = v;

  String get getGnssSyncPeriodicity =>
      this.rx.getGnssSyncPeriodicity.value;
  set getGnssSyncPeriodicity(String v) =>
      this.rx.getGnssSyncPeriodicity.value = v;

  String get setGnssSyncDayWeekOrMonth =>
      this.rx.setGnssSyncDayWeekOrMonth.value;
  set setGnssSyncDayWeekOrMonth(String v) =>
      this.rx.setGnssSyncDayWeekOrMonth.value = v;

  int get selectGnssSyncDayWeekOrMonth =>
      this.rx.selectGnssSyncDayWeekOrMonth.value;
  set selectGnssSyncDayWeekOrMonth(int v) =>
      this.rx.selectGnssSyncDayWeekOrMonth.value = v;

  String get errorSetGnssSyncMinute => this.rx.errorSetGnssSyncMinute.value;
  set errorSetGnssSyncMinute(String v) =>
      this.rx.errorSetGnssSyncMinute.value = v;

  String get errorSetGnssSyncHour => this.rx.errorSetGnssSyncHour.value;
  set errorSetGnssSyncHour(String v) => this.rx.errorSetGnssSyncHour.value = v;

  String get errorSetGnssSyncDayWeekOrMonth =>
      this.rx.errorSetGnssSyncDayWeekOrMonth.value;
  set errorSetGnssSyncDayWeekOrMonth(String v) =>
      this.rx.errorSetGnssSyncDayWeekOrMonth.value = v;
}
