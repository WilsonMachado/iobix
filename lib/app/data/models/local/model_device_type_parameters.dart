class ModelDeviceTypeParameters {
  double adcBatteryParam,
      adcVpanelParam,
      adcVauxParam,
      voltageReference,
      vpanelVoltageReference,
      nominalBatteryMax,
      nominalBatteryMin, deviceVersion;
  int adcResolution, rf, ro, internalB, externalB;

  Map<int, String> memoryDataTypeLogApp = Map();
  Map<int, String> memoryDataTypeLogSys = Map();

  ModelDeviceTypeParameters({
    this.adcBatteryParam = 0.0,
    this.adcVpanelParam = 0.0,
    this.adcVauxParam = 0.0,
    this.voltageReference = 0.0,
    this.vpanelVoltageReference = 0.0,
    this.adcResolution = 0,
    this.nominalBatteryMax = 0.0,
    this.nominalBatteryMin = 0.0,
    this.rf = 10000,
    this.ro = 10000,
    this.internalB = 3435,
    this.externalB = 3950,
  });
}
