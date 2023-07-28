import 'package:get/get_rx/get_rx.dart';

class RxTemperatureLogger {
  final RxInt i2cSensor;

  final RxInt setI2cSensor;
  final RxString errorSetI2cSensor;

  final RxDouble deviceVersion;

  // BME280
  final RxString i2cBme280Status,
      i2cBme280Temperature,
      i2cBme280Humidity,
      i2cBme280Pressure;

  // Abp sensor
  final RxBool isAbpSensor;
  final RxInt abpSensorStatus, abpSensorPressureAdc;
  final RxString abpSensorPressure;

  RxTemperatureLogger({
    this.i2cSensor,
    this.i2cBme280Status,
    this.i2cBme280Temperature,
    this.i2cBme280Humidity,
    this.i2cBme280Pressure,
    this.setI2cSensor,
    this.errorSetI2cSensor,
    this.abpSensorStatus,
    this.abpSensorPressure,
    this.abpSensorPressureAdc,
    this.isAbpSensor,
    this.deviceVersion,
  });
}

class ModelTemperatureLogger {
  RxTemperatureLogger rx;

  ModelTemperatureLogger({
    int i2cSensor = 0,
    String i2cBme280Status = '',
    String i2cBme280Temperature = '0.00',
    String i2cBme280Humidity = '0',
    String i2cBme280Pressure = '0.00',
    int setI2cSensor = -1,
    String errorSetI2cSensor,
    bool isAbpSensor = false,
    int abpSensorStatus = -1,
    int abpSensorPressureAdc = 0,
    String abpSensorPressure = '0.00000',
    double deviceVersion = 1.0,
  }) {
    this.rx = RxTemperatureLogger(
        i2cSensor: i2cSensor.obs,
        i2cBme280Status: i2cBme280Status.obs,
        i2cBme280Temperature: i2cBme280Temperature.obs,
        i2cBme280Humidity: i2cBme280Humidity.obs,
        i2cBme280Pressure: i2cBme280Pressure.obs,
        setI2cSensor: setI2cSensor.obs,
        errorSetI2cSensor: errorSetI2cSensor.obs,
        isAbpSensor: isAbpSensor.obs,
        abpSensorStatus: abpSensorStatus.obs,
        abpSensorPressureAdc: abpSensorPressureAdc.obs,
        abpSensorPressure: abpSensorPressure.obs,
        deviceVersion: deviceVersion.obs);
  }

  // [value, delta, min, max] for each NTC (GET)
  RxList<List<String>> ntcData = [
    ['0.00', '0', '0', '0'],
    ['0.00', '0', '0', '0'],
    ['0.00', '0', '0', '0'],
    ['0.00', '0', '0', '0'],
    ['0', '0', '0', '0'],
    ['0', '0', '0', '0'],
  ].obs;

  int get i2cSensor => this.rx.i2cSensor.value;
  set i2cSensor(int v) => this.rx.i2cSensor.value = v;

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

  int get abpSensorStatus => this.rx.abpSensorStatus.value;
  set abpSensorStatus(int v) => this.rx.abpSensorStatus.value = v;

  bool get isAbpSensor => this.rx.isAbpSensor.value;
  set isAbpSensor(bool v) => this.rx.isAbpSensor.value = v;

  int get abpSensorPressureAdc => this.rx.abpSensorPressureAdc.value;
  set abpSensorPressureAdc(int v) => this.rx.abpSensorPressureAdc.value = v;

  String get abpSensorPressure => this.rx.abpSensorPressure.value;
  set abpSensorPressure(String v) => this.rx.abpSensorPressure.value = v;

  // deviceVersion

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;
}
