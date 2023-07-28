import 'package:get/get_rx/get_rx.dart';

class RxVantageLogger {
  final RxDouble deviceVersion,
      rainRate,
      windSpeed,
      windDirection,
      solarRadiation,
      uvIndex,
      temperature,
      humidity,

      // Calidad del aire

      instantPM1_0,
      instantPM2_5,
      instantPM4_0,
      instantPM10,
      instantRH,
      instantTemp,
      instantVOC,
      maxPM1_0,
      minPM1_0,
      avgPM1_0,
      maxPM2_5,
      minPM2_5,
      avgPM2_5,
      maxPM4,
      minPM4,
      avgPM4,
      maxPM10,
      minPM10,
      avgPM10,
      maxRH,
      minRH,
      avgRH,
      maxTemp,
      minTemp,
      avgTemp,
      maxVOC,
      minVOC,
      avgVOC,

      // Davis

      sampleTime,
      maxSolarRad,
      minSolarRad,
      avgSolarRad,
      maxUV,
      minUV,
      avgUV,
      maxTempDavis,
      minTempDavis,
      avgTempDavis,
      maxRHDavis,
      minRHDavis,
      avgRHDavis,
      accPluv,
      maxWindSpeed,
      minWindSpeed,
      avgWindSpeed,
      maxWindDirection,
      minWindDirection,
      avgWindDirection,

      // Sensor de ruido

      instantNoiseRika,
      instantNoiseGemho,
      instantNoisePR300,
      instantNoiseRenke,
      maxNoiseRika,
      minNoiseRika,
      avgNoiseRika,
      maxNoiseGemho,
      minNoiseGemho,
      avgNoiseGemho,
      maxNoisePR300,
      minNoisePR300,
      avgNoisePR300,
      maxNoiseRenke,
      minNoiseRenke,
      avgNoiseRenke;

  final RxInt rainCount,
      sensorsRS485,
      selectedSensorPowerBehaviour,
      statusSensorPowerBehaviour,
      sensorRS485Mismatch,
      blePeriodicMeasureTime;

  final RxString errorSetPeriodicMeasureTime,
      errorSetSensorRS485Mismatch,
      getHourToCleanFan,
      setHourToCleanFan,
      errorHourToCleanFan;

  RxVantageLogger({
    this.deviceVersion,
    this.blePeriodicMeasureTime,
    this.getHourToCleanFan,
    this.setHourToCleanFan,
    this.errorHourToCleanFan,
    this.rainRate,
    this.rainCount,
    this.sensorsRS485,
    this.statusSensorPowerBehaviour,
    this.selectedSensorPowerBehaviour,
    this.windSpeed,
    this.windDirection,
    this.solarRadiation,
    this.uvIndex,
    this.temperature,
    this.humidity,
    this.sensorRS485Mismatch,
    this.errorSetPeriodicMeasureTime,
    this.errorSetSensorRS485Mismatch,

    // Calidad del aire

    this.maxPM1_0,
    this.minPM1_0,
    this.avgPM1_0,
    this.maxPM2_5,
    this.minPM2_5,
    this.avgPM2_5,
    this.maxPM4,
    this.minPM4,
    this.avgPM4,
    this.maxPM10,
    this.minPM10,
    this.avgPM10,
    this.maxRH,
    this.minRH,
    this.avgRH,
    this.maxTemp,
    this.minTemp,
    this.avgTemp,
    this.maxVOC,
    this.minVOC,
    this.avgVOC,

    // Davis

    this.sampleTime,
    this.maxSolarRad,
    this.minSolarRad,
    this.avgSolarRad,
    this.maxUV,
    this.minUV,
    this.avgUV,
    this.maxTempDavis,
    this.minTempDavis,
    this.avgTempDavis,
    this.maxRHDavis,
    this.minRHDavis,
    this.avgRHDavis,
    this.accPluv,
    this.maxWindSpeed,
    this.minWindSpeed,
    this.avgWindSpeed,
    this.maxWindDirection,
    this.minWindDirection,
    this.avgWindDirection,

    // Sensor de ruido

    this.instantPM1_0,
    this.instantPM2_5,
    this.instantPM4_0,
    this.instantPM10,
    this.instantRH,
    this.instantTemp,
    this.instantVOC,
    this.instantNoiseRika,
    this.instantNoiseGemho,
    this.instantNoisePR300,
    this.instantNoiseRenke,
    this.maxNoiseRika,
    this.minNoiseRika,
    this.avgNoiseRika,
    this.maxNoiseGemho,
    this.minNoiseGemho,
    this.avgNoiseGemho,
    this.maxNoisePR300,
    this.minNoisePR300,
    this.avgNoisePR300,
    this.maxNoiseRenke,
    this.minNoiseRenke,
    this.avgNoiseRenke,
  });
}

class ModelVantageLogger {
  RxVantageLogger rx;
  int measureTime;

  ModelVantageLogger(
      {

      // Davis Vantage 2

      double deviceVersion = 0.0,
      int blePeriodicMeasureTime = 0,
      double rainRate = 0.0,
      int rainCount = 0,
      int sensorsRS485 = 0,
      int statusSensorPowerBehaviour = 0x01,
      int selectedSensorPowerBehaviour = 1,
      double windSpeed = 0.0,
      double windDirection = 0.0,
      double solarRadiation = 0.0,
      double uvIndex = 0.0,
      double temperature = 0.0,
      double humidity = 0.0,
      int sensorRS485Mismatch = 0,
      String errorSetPeriodicMeasureTime,
      String errorSetSensorRS485Mismatch,
      String getHourToCleanFan = '',
      String setHourToCleanFan = '',
      String errorHourToCleanFan,

      // Sensor de calidad de aire

      double instantPM1_0 = 0.0,
      double instantPM2_5 = 0.0,
      double instantPM4_0 = 0.0,
      double instantPM10 = 0.0,
      double instantRH = 0.0,
      double instantTemp = 0.0,
      double instantVOC = 0.0,
      double maxPM1_0 = 0.0,
      double minPM1_0 = 0.0,
      double avgPM1_0 = 0.0,
      double maxPM2_5 = 0.0,
      double minPM2_5 = 0.0,
      double avgPM2_5 = 0.0,
      double maxPM4 = 0.0,
      double minPM4 = 0.0,
      double avgPM4 = 0.0,
      double maxPM10 = 0.0,
      double minPM10 = 0.0,
      double avgPM10 = 0.0,
      double maxRH = 0.0,
      double minRH = 0.0,
      double avgRH = 0.0,
      double maxTemp = 0.0,
      double minTemp = 0.0,
      double avgTemp = 0.0,
      double maxVOC = 0.0,
      double minVOC = 0.0,
      double avgVOC = 0.0,

      // Davis

      double sampleTime = 0.0,
      double maxSolarRad = 0.0,
      double minSolarRad = 0.0,
      double avgSolarRad = 0.0,
      double maxUV = 0.0,
      double minUV = 0.0,
      double avgUV = 0.0,
      double maxTempDavis = 0.0,
      double minTempDavis = 0.0,
      double avgTempDavis = 0.0,
      double maxRHDavis = 0.0,
      double minRHDavis = 0.0,
      double avgRHDavis = 0.0,
      double accPluv = 0.0,
      double maxWindSpeed = 0.0,
      double minWindSpeed = 0.0,
      double avgWindSpeed = 0.0,
      double maxWindDirection = 0.0,
      double minWindDirection = 0.0,
      double avgWindDirection = 0.0,

      // Sensor de ruido

      double instantNoiseRika = 0.0,
      double instantNoiseGemho = 0.0,
      double instantNoisePR300 = 0.0,
      double instantNoiseRenke = 0.0,
      double maxNoiseRika = 0.0,
      double minNoiseRika = 0.0,
      double avgNoiseRika = 0.0,
      double maxNoiseGemho = 0.0,
      double minNoiseGemho = 0.0,
      double avgNoiseGemho = 0.0,
      double maxNoisePR300 = 0.0,
      double minNoisePR300 = 0.0,
      double avgNoisePR300 = 0.0,
      double maxNoiseRenke = 0.0,
      double minNoiseRenke = 0.0,
      double avgNoiseRenke = 0.0,
      this.measureTime = 0}) {
    this.rx = RxVantageLogger(
      deviceVersion: deviceVersion.obs,
      blePeriodicMeasureTime: blePeriodicMeasureTime.obs,

      rainRate: rainRate.obs,
      rainCount: rainCount.obs,
      sensorsRS485: sensorsRS485.obs,
      windSpeed: windSpeed.obs,
      windDirection: windDirection.obs,
      solarRadiation: solarRadiation.obs,
      uvIndex: uvIndex.obs,
      temperature: temperature.obs,
      humidity: humidity.obs,
      statusSensorPowerBehaviour: statusSensorPowerBehaviour.obs,
      selectedSensorPowerBehaviour: selectedSensorPowerBehaviour.obs,

      sensorRS485Mismatch: sensorRS485Mismatch.obs,

      getHourToCleanFan: getHourToCleanFan.obs,
      setHourToCleanFan: setHourToCleanFan.obs,
      errorHourToCleanFan: errorHourToCleanFan.obs,

      errorSetPeriodicMeasureTime: errorSetPeriodicMeasureTime.obs,
      errorSetSensorRS485Mismatch: errorSetSensorRS485Mismatch.obs,

      // Calidad del aire

      instantPM1_0: instantPM1_0.obs,
      instantPM2_5: instantPM2_5.obs,
      instantPM4_0: instantPM4_0.obs,
      instantPM10: instantPM10.obs,
      instantRH: instantRH.obs,
      instantTemp: instantTemp.obs,
      instantVOC: instantVOC.obs,

      maxPM1_0: maxPM1_0.obs,
      minPM1_0: minPM1_0.obs,
      avgPM1_0: avgPM1_0.obs,
      maxPM2_5: maxPM2_5.obs,
      minPM2_5: minPM2_5.obs,
      avgPM2_5: avgPM2_5.obs,
      maxPM4: maxPM4.obs,
      minPM4: minPM4.obs,
      avgPM4: avgPM4.obs,
      maxPM10: maxPM10.obs,
      minPM10: minPM10.obs,
      avgPM10: avgPM10.obs,
      maxRH: maxRH.obs,
      minRH: minRH.obs,
      avgRH: avgRH.obs,
      maxTemp: maxTemp.obs,
      minTemp: minTemp.obs,
      avgTemp: avgTemp.obs,
      maxVOC: maxVOC.obs,
      minVOC: minVOC.obs,
      avgVOC: avgVOC.obs,

      // Davis

      sampleTime: sampleTime.obs,
      maxSolarRad: maxSolarRad.obs,
      minSolarRad: minSolarRad.obs,
      avgSolarRad: avgSolarRad.obs,
      maxUV: maxUV.obs,
      minUV: minUV.obs,
      avgUV: avgUV.obs,
      maxTempDavis: maxTempDavis.obs,
      minTempDavis: minTempDavis.obs,
      avgTempDavis: avgTempDavis.obs,
      maxRHDavis: maxRHDavis.obs,
      minRHDavis: minRHDavis.obs,
      avgRHDavis: avgRHDavis.obs,
      accPluv: accPluv.obs,
      maxWindSpeed: maxWindSpeed.obs,
      minWindSpeed: minWindSpeed.obs,
      avgWindSpeed: avgWindSpeed.obs,
      maxWindDirection: maxWindDirection.obs,
      avgWindDirection: avgWindDirection.obs,
      minWindDirection: minWindDirection.obs,

      // Sensor de ruido

      instantNoiseRika: instantNoiseRika.obs,
      instantNoiseGemho: instantNoiseGemho.obs,
      instantNoisePR300: instantNoisePR300.obs,
      instantNoiseRenke: instantNoiseRenke.obs,

      maxNoiseRika: maxNoiseRika.obs,
      minNoiseRika: minNoiseRika.obs,
      avgNoiseRika: avgNoiseRika.obs,
      maxNoiseGemho: maxNoiseGemho.obs,
      minNoiseGemho: minNoiseGemho.obs,
      avgNoiseGemho: avgNoiseGemho.obs,
      maxNoisePR300: maxNoisePR300.obs,
      minNoisePR300: minNoisePR300.obs,
      avgNoisePR300: avgNoisePR300.obs,
      maxNoiseRenke: maxNoiseRenke.obs,
      minNoiseRenke: minNoiseRenke.obs,
      avgNoiseRenke: avgNoiseRenke.obs,
    );
  }

  int get sensorRS485Mismatch => this.rx.sensorRS485Mismatch.value;
  set sensorRS485Mismatch(int v) => this.rx.sensorRS485Mismatch.value = v;

  String get errorSetPeriodicMeasureTime =>
      this.rx.errorSetPeriodicMeasureTime.value;
  set errorSetPeriodicMeasureTime(String v) =>
      this.rx.errorSetPeriodicMeasureTime.value = v;

  String get errorSetSensorRS485Mismatch =>
      this.rx.errorSetSensorRS485Mismatch.value;
  set errorSetSensorRS485Mismatch(String v) =>
      this.rx.errorSetSensorRS485Mismatch.value = v;

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;

  int get blePeriodicMeasureTime => this.rx.blePeriodicMeasureTime.value;
  set blePeriodicMeasureTime(int v) => this.rx.blePeriodicMeasureTime.value = v;

  String get getHourToCleanFan => this.rx.getHourToCleanFan.value;
  set getHourToCleanFan(String v) => this.rx.getHourToCleanFan.value = v;

  String get setHourToCleanFan => this.rx.setHourToCleanFan.value;
  set setHourToCleanFan(String v) => this.rx.setHourToCleanFan.value = v;

  String get errorHourToCleanFan => this.rx.errorHourToCleanFan.value;
  set errorHourToCleanFan(String v) => this.rx.errorHourToCleanFan.value = v;

  double get rainRate => this.rx.rainRate.value;
  set rainRate(double v) => this.rx.rainRate.value = v;

  int get rainCount => this.rx.rainCount.value;
  set rainCount(int v) => this.rx.rainCount.value = v;

  int get sensorsRS485 => this.rx.sensorsRS485.value;
  set sensorsRS485(int v) => this.rx.sensorsRS485.value = v;

  int get selectedSensorPowerBehaviour =>
      this.rx.selectedSensorPowerBehaviour.value;
  set selectedSensorPowerBehaviour(int v) =>
      this.rx.selectedSensorPowerBehaviour.value = v;

  int get statusSensorPowerBehaviour =>
      this.rx.statusSensorPowerBehaviour.value;
  set statusSensorPowerBehaviour(int v) =>
      this.rx.statusSensorPowerBehaviour.value = v;

  double get windSpeed => this.rx.windSpeed.value;
  set windSpeed(double v) => this.rx.windSpeed.value = v;

  double get windDirection => this.rx.windDirection.value;
  set windDirection(double v) => this.rx.windDirection.value = v;

  double get solarRadiation => this.rx.solarRadiation.value;
  set solarRadiation(double v) => this.rx.solarRadiation.value = v;

  double get uvIndex => this.rx.uvIndex.value;
  set uvIndex(double v) => this.rx.uvIndex.value = v;

  double get temperature => this.rx.temperature.value;
  set temperature(double v) => this.rx.temperature.value = v;

  double get humidity => this.rx.humidity.value;
  set humidity(double v) => this.rx.humidity.value = v;

  // Calidad del aire

  double get instantPM1_0 => this.rx.instantPM1_0.value;
  set instantPM1_0(double v) => this.rx.instantPM1_0.value = v;

  double get instantPM2_5 => this.rx.instantPM2_5.value;
  set instantPM2_5(double v) => this.rx.instantPM2_5.value = v;

  double get instantPM4_0 => this.rx.instantPM4_0.value;
  set instantPM4_0(double v) => this.rx.instantPM4_0.value = v;

  double get instantPM10 => this.rx.instantPM10.value;
  set instantPM10(double v) => this.rx.instantPM10.value = v;

  double get instantRH => this.rx.instantRH.value;
  set instantRH(double v) => this.rx.instantRH.value = v;

  double get instantTemp => this.rx.instantTemp.value;
  set instantTemp(double v) => this.rx.instantTemp.value = v;

  double get instantVOC => this.rx.instantVOC.value;
  set instantVOC(double v) => this.rx.instantVOC.value = v;

  double get maxPM1_0 => this.rx.maxPM1_0.value;
  set maxPM1_0(double v) => this.rx.maxPM1_0.value = v;

  double get minPM1_0 => this.rx.minPM1_0.value;
  set minPM1_0(double v) => this.rx.minPM1_0.value = v;

  double get avgPM1_0 => this.rx.avgPM1_0.value;
  set avgPM1_0(double v) => this.rx.avgPM1_0.value = v;

  double get maxPM2_5 => this.rx.maxPM2_5.value;
  set maxPM2_5(double v) => this.rx.maxPM2_5.value = v;

  double get minPM2_5 => this.rx.minPM2_5.value;
  set minPM2_5(double v) => this.rx.minPM2_5.value = v;

  double get avgPM2_5 => this.rx.avgPM2_5.value;
  set avgPM2_5(double v) => this.rx.avgPM2_5.value = v;

  double get maxPM4 => this.rx.maxPM4.value;
  set maxPM4(double v) => this.rx.maxPM4.value = v;

  double get minPM4 => this.rx.minPM4.value;
  set minPM4(double v) => this.rx.minPM4.value = v;

  double get avgPM4 => this.rx.avgPM4.value;
  set avgPM4(double v) => this.rx.avgPM4.value = v;

  double get maxPM10 => this.rx.maxPM10.value;
  set maxPM10(double v) => this.rx.maxPM10.value = v;

  double get minPM10 => this.rx.minPM10.value;
  set minPM10(double v) => this.rx.minPM10.value = v;

  double get avgPM10 => this.rx.avgPM10.value;
  set avgPM10(double v) => this.rx.avgPM10.value = v;

  double get maxRH => this.rx.maxRH.value;
  set maxRH(double v) => this.rx.maxRH.value = v;

  double get minRH => this.rx.minRH.value;
  set minRH(double v) => this.rx.minRH.value = v;

  double get avgRH => this.rx.avgRH.value;
  set avgRH(double v) => this.rx.avgRH.value = v;

  double get maxTemp => this.rx.maxTemp.value;
  set maxTemp(double v) => this.rx.maxTemp.value = v;

  double get minTemp => this.rx.minTemp.value;
  set minTemp(double v) => this.rx.minTemp.value = v;

  double get avgTemp => this.rx.avgTemp.value;
  set avgTemp(double v) => this.rx.avgTemp.value = v;

  double get maxVOC => this.rx.maxVOC.value;
  set maxVOC(double v) => this.rx.maxVOC.value = v;

  double get minVOC => this.rx.minVOC.value;
  set minVOC(double v) => this.rx.minVOC.value = v;

  double get avgVOC => this.rx.avgVOC.value;
  set avgVOC(double v) => this.rx.avgVOC.value = v;

  // Davis

  double get sampleTime => this.rx.sampleTime.value;
  set sampleTime(double v) => this.rx.sampleTime.value = v;

  double get maxSolarRad => this.rx.maxSolarRad.value;
  set maxSolarRad(double v) => this.rx.maxSolarRad.value = v;

  double get minSolarRad => this.rx.minSolarRad.value;
  set minSolarRad(double v) => this.rx.minSolarRad.value = v;

  double get avgSolarRad => this.rx.avgSolarRad.value;
  set avgSolarRad(double v) => this.rx.avgSolarRad.value = v;

  double get maxUV => this.rx.maxUV.value;
  set maxUV(double v) => this.rx.maxUV.value = v;

  double get minUV => this.rx.minUV.value;
  set minUV(double v) => this.rx.minUV.value = v;

  double get avgUV => this.rx.avgUV.value;
  set avgUV(double v) => this.rx.avgUV.value = v;

  double get maxTempDavis => this.rx.maxTempDavis.value;
  set maxTempDavis(double v) => this.rx.maxTempDavis.value = v;

  double get minTempDavis => this.rx.minTempDavis.value;
  set minTempDavis(double v) => this.rx.minTempDavis.value = v;

  double get avgTempDavis => this.rx.avgTempDavis.value;
  set avgTempDavis(double v) => this.rx.avgTempDavis.value = v;

  double get maxRHDavis => this.rx.maxRHDavis.value;
  set maxRHDavis(double v) => this.rx.maxRHDavis.value = v;

  double get minRHDavis => this.rx.minRHDavis.value;
  set minRHDavis(double v) => this.rx.minRHDavis.value = v;

  double get avgRHDavis => this.rx.avgRHDavis.value;
  set avgRHDavis(double v) => this.rx.avgRHDavis.value = v;

  double get accPluv => this.rx.accPluv.value;
  set accPluv(double v) => this.rx.accPluv.value = v;

  double get maxWindSpeed => this.rx.maxWindSpeed.value;
  set maxWindSpeed(double v) => this.rx.maxWindSpeed.value = v;

  double get minWindSpeed => this.rx.minWindSpeed.value;
  set minWindSpeed(double v) => this.rx.minWindSpeed.value = v;

  double get avgWindSpeed => this.rx.avgWindSpeed.value;
  set avgWindSpeed(double v) => this.rx.avgWindSpeed.value = v;

  double get maxWindDirection => this.rx.maxWindDirection.value;
  set maxWindDirection(double v) => this.rx.maxWindDirection.value = v;

  double get minWindDirection => this.rx.minWindDirection.value;
  set minWindDirection(double v) => this.rx.minWindDirection.value = v;

  double get avgWindDirection => this.rx.avgWindDirection.value;
  set avgWindDirection(double v) => this.rx.avgWindDirection.value = v;

  // Sensor de rudio

  double get instantNoiseRika => this.rx.instantNoiseRika.value;
  set instantNoiseRika(double v) => this.rx.instantNoiseRika.value = v;

  double get instantNoiseGemho => this.rx.instantNoiseGemho.value;
  set instantNoiseGemho(double v) => this.rx.instantNoiseGemho.value = v;

  double get instantNoisePR300 => this.rx.instantNoisePR300.value;
  set instantNoisePR300(double v) => this.rx.instantNoisePR300.value = v;

  double get instantNoiseRenke => this.rx.instantNoiseRenke.value;
  set instantNoiseRenke(double v) => this.rx.instantNoiseRenke.value = v;

  double get maxNoiseRika => this.rx.maxNoiseRika.value;
  set maxNoiseRika(double v) => this.rx.maxNoiseRika.value = v;

  double get minNoiseRika => this.rx.minNoiseRika.value;
  set minNoiseRika(double v) => this.rx.minNoiseRika.value = v;

  double get avgNoiseRika => this.rx.avgNoiseRika.value;
  set avgNoiseRika(double v) => this.rx.avgNoiseRika.value = v;

  double get maxNoiseGemho => this.rx.maxNoiseGemho.value;
  set maxNoiseGemho(double v) => this.rx.maxNoiseGemho.value = v;

  double get minNoiseGemho => this.rx.minNoiseGemho.value;
  set minNoiseGemho(double v) => this.rx.minNoiseGemho.value = v;

  double get avgNoiseGemho => this.rx.avgNoiseGemho.value;
  set avgNoiseGemho(double v) => this.rx.avgNoiseGemho.value = v;

  double get maxNoisePR300 => this.rx.maxNoisePR300.value;
  set maxNoisePR300(double v) => this.rx.maxNoisePR300.value = v;

  double get minNoisePR300 => this.rx.minNoisePR300.value;
  set minNoisePR300(double v) => this.rx.minNoisePR300.value = v;

  double get avgNoisePR300 => this.rx.avgNoisePR300.value;
  set avgNoisePR300(double v) => this.rx.avgNoisePR300.value = v;

  double get maxNoiseRenke => this.rx.maxNoiseRenke.value;
  set maxNoiseRenke(double v) => this.rx.maxNoiseRenke.value = v;

  double get minNoiseRenke => this.rx.minNoiseRenke.value;
  set minNoiseRenke(double v) => this.rx.minNoiseRenke.value = v;

  double get avgNoiseRenke => this.rx.avgNoiseRenke.value;
  set avgNoiseRenke(double v) => this.rx.avgNoiseRenke.value = v;
}
