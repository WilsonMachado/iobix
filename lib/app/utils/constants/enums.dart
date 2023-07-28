enum BluetoothProgressTryConnectToDevice {
  idle,
  connecting,
  check_services,
  check_compatibility,
  check_api_ble,
  connected
}

enum BottomNavBarDevice { home, config, console }

enum ColbitsCompatibleVersion {
  temperatureLoggerV2,
  temperatureLoggerV3,
  smartMeterAcV2,
  smartMeterAcV3,
  smartMeterAcV3_1,
  vantageLoggerV2,
  vantageLoggerV3,
  multipurposeRS485V1,
  loggerRS485,
  matricPotentialV1,
  levelSensorV1,
  matricPotentialV3_1,
  matricPotentialV4,
  iskraMt174V1,
  iRISLogger,
  smartMeterDcV2,
  smartMeterDcV3,
  demoLoggerPanicButton,
  smartFaultDetector,
  tiltSensor,
}

enum Roles { device, user, admin, superAdmin }
