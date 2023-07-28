import 'package:get/get.dart';

class NoiseSensorRika {
  RxBool isSensor;
  RxInt sensorStatus;

  RxString noiseLevel;

  NoiseSensorRika({
    this.isSensor,
    this.sensorStatus,
    this.noiseLevel,
  });
}

class NoiseSensorRenke {
  RxBool isSensor;
  RxInt sensorStatus;

  RxString noiseLevel;

  NoiseSensorRenke({
    this.isSensor,
    this.sensorStatus,
    this.noiseLevel,
  });
}

class ParticleSensorRenke {
  RxBool isSensor;
  RxInt sensorStatus;

  RxInt particulateMatter2_5;
  RxInt particulateMatter10;

  ParticleSensorRenke({
    this.isSensor,
    this.sensorStatus,
    this.particulateMatter2_5,
    this.particulateMatter10,
  });
}

// Chinese Weather Station
class CWSSensorHonde {
  RxBool isSensor;
  RxInt sensorStatus;

  RxInt radiation;
  RxDouble temperature, humidity, pressure, rainFall;

  CWSSensorHonde({
    this.isSensor,
    this.sensorStatus,
    this.temperature,
    this.radiation,
    this.humidity,
    this.pressure,
    this.rainFall,
  });
}

class SoilSensorGemho {
  RxBool isSensor;
  RxInt sensorStatus;

  RxDouble temperature, humidity, ph;
  RxInt electroconductivity, nitrogen, phosphorus, potassium;

  SoilSensorGemho({
    this.isSensor,
    this.sensorStatus,
    this.temperature,
    this.humidity,
    this.electroconductivity,
    this.ph,
    this.nitrogen,
    this.phosphorus,
    this.potassium,
  });
}

class TempHumLuxSensorGemho {
  RxBool isSensor;
  RxInt sensorStatus;

  RxInt illuminance;
  RxDouble temperature, humidity;

  TempHumLuxSensorGemho({
    this.isSensor,
    this.sensorStatus,
    this.temperature,
    this.humidity,
    this.illuminance,
  });
}

class AmmoniaSensorGemho {
  RxBool isSensor;
  RxInt sensorStatus;

  RxString ammoniaLevel;

  AmmoniaSensorGemho({this.isSensor, this.sensorStatus, this.ammoniaLevel});
}

class NoiseSensorGemho {
  RxBool isSensor;
  RxInt sensorStatus;

  RxString noiseLevel;

  NoiseSensorGemho({this.isSensor, this.sensorStatus, this.noiseLevel});
}

class PressureScout {
  RxBool isSensor;

  RxString pressureScoutStatus; // String (Error, Ok, Desconocido)

  RxInt voltageSensorScout; // uint
  RxInt psiIntSensorScout; // int
  RxInt psiIntSensorScoutx100; // int

  RxInt highAlarmSensorScout; // bool (0x01 true)
  RxInt lowAlarmSensorScout; // bool (0x01 true)
  RxInt lowBatteryAlarmSensorScout; // bool (0x01 batería por debajo de 3.0 V)

  RxInt psiRangeSensorScout; // uint
  RxInt
      psiStatusSensorScout; // uint (0: ok, 1: fuera de rango bajo, 2: fuera de rango alto)
  RxDouble psiFloatReadingSensorScout; // float
  RxDouble psiScaleReadingSensorScout; // float
  RxDouble alarmHighThreshold; // float
  RxDouble alarmLowThreshold; // float

  RxInt mainCardTopRevisionNumber;
  RxInt mainCardBotRevisionNumber;
  RxInt radioTopRevisionNumber;
  RxInt radioBotRevisionNumber;
  RxInt sftsNodeAddress;
  RxInt modbusAddressSensorScout; // uint
  RxInt rssiSensorScout; // int
  RxInt sensorBatteryVoltage; // uint
  RxInt timeToLive; // uint
  RxInt numberOfRegisterCatched; // uint
  RxInt sensorType;

  //! Para el HART

  RxInt hartMfgID; // uint
  RxInt hartDeviceType; // uint
  RxInt hartDeviceId; // uint
  RxInt hartStatus; // uint
  RxInt hartPvUnitsCode; // uint
  RxInt hartSvUnitsCode; // uint
  RxInt hartTvUnitsCode; // uint
  RxInt hartQvUnitsCode; // uint
  RxDouble hartPv; // float
  RxDouble hartSv; // float
  RxDouble hartTv; // float
  RxDouble hartQv; // float
  RxInt hartCommunicationStatus; // uint
  RxInt hartAlarmHighAlert; // uint
  RxInt hartAlarmLowAlert; // uint
  RxString sentinelStatus; // string
  RxInt hartMainCardTopRevisionNumber;
  RxInt hartMainCardBotRevisionNumber;
  RxInt hartRadioTopRevisionNumber;
  RxInt hartRadioBotRevisionNumber;
  RxInt hartSftsNodeAddress;
  RxInt hartModbusAddressSensorScout; // uint
  RxInt hartRssiSensorScout; // int  - dBm
  RxInt hartSensorBatteryVoltage; // uint - mV
  RxInt hartTimeToLive; // uint - min
  RxInt hartNumberOfRegisterCatched; // uint
  RxInt hartSensorType; // ?

  PressureScout({
    this.isSensor,
    this.pressureScoutStatus, // String (Error, Ok, Desconocido)

    this.voltageSensorScout, // uint
    this.psiIntSensorScout, // int
    this.psiIntSensorScoutx100, // int

    this.highAlarmSensorScout, // bool (0x01 true)
    this.lowAlarmSensorScout, // bool (0x01 true)
    this.lowBatteryAlarmSensorScout, // bool (0x01 batería por debajo de 3.0 V)

    this.psiRangeSensorScout, // uint
    this.psiStatusSensorScout, // uint (0: ok, 1: fuera de rango bajo, 2: fuera de rango alto)
    this.psiFloatReadingSensorScout, // float
    this.psiScaleReadingSensorScout, // float
    this.alarmHighThreshold, // float
    this.alarmLowThreshold, // float

    this.mainCardTopRevisionNumber,
    this.mainCardBotRevisionNumber,
    this.radioTopRevisionNumber,
    this.radioBotRevisionNumber,
    this.sftsNodeAddress,
    this.modbusAddressSensorScout, // uint
    this.rssiSensorScout, // int
    this.sensorBatteryVoltage, // uint
    this.timeToLive, // uint
    this.numberOfRegisterCatched, // uint
    this.sensorType,

    //! Para el Hart

    this.hartMfgID, // uint
    this.hartDeviceType, // uint
    this.hartDeviceId, // uint
    this.hartStatus, // uint
    this.hartPvUnitsCode, // uint
    this.hartSvUnitsCode, // uint
    this.hartTvUnitsCode, // uint
    this.hartQvUnitsCode, // uint
    this.hartPv, // float
    this.hartSv, // float
    this.hartTv, // float
    this.hartQv, // float
    this.hartCommunicationStatus, // uint
    this.hartAlarmHighAlert, // uint
    this.hartAlarmLowAlert, // uint
    this.sentinelStatus, // string
    this.hartMainCardTopRevisionNumber,
    this.hartMainCardBotRevisionNumber,
    this.hartRadioTopRevisionNumber,
    this.hartRadioBotRevisionNumber,
    this.hartSftsNodeAddress,
    this.hartModbusAddressSensorScout, // uint
    this.hartRssiSensorScout, // int  - dBm
    this.hartSensorBatteryVoltage, // uint - mV
    this.hartTimeToLive, // uint - min
    this.hartNumberOfRegisterCatched, // uint
    this.hartSensorType, // ?
  });
}

// class IskraMT174 {
//   RxBool isSensor;
//   RxInt sensorStatus;

//   RxString serie, firmware;
//   RxDouble internalBattery, frequency, iPowerFactor;
//   RxInt totalActiveEnergy, totalPositiveReactiveEnergy, totalApparentEnergy;
//   RxDouble totalICurrent, phase1ICurrent, phase2ICurrent, phase3ICurrent;
//   RxDouble phase1IVoltage, phase2IVoltage, phase3IVoltage;

//   IskraMT174({
//     this.isSensor,
//     this.sensorStatus,
//     this.serie,
//     this.firmware,
//     this.internalBattery,
//     this.totalActiveEnergy,
//     this.totalPositiveReactiveEnergy,
//     this.totalApparentEnergy,
//     this.totalICurrent,
//     this.phase1ICurrent,
//     this.phase2ICurrent,
//     this.phase3ICurrent,
//     this.phase1IVoltage,
//     this.phase2IVoltage,
//     this.phase3IVoltage,
//     this.iPowerFactor,
//     this.frequency,
//   });
// }

class RxMultipurposeRS485 {
  //IskraMT174 iskraMT174;
  NoiseSensorGemho noiseSensorGemho;
  AmmoniaSensorGemho ammoniaSensorGemho;
  TempHumLuxSensorGemho tempHumLuxSensorGemho;
  SoilSensorGemho soilSensorGemho;
  CWSSensorHonde cwsSensorHonde;
  ParticleSensorRenke particleSensorRenke;
  NoiseSensorRenke noiseSensorRenke;
  NoiseSensorRika noiseSensorRika;

  PressureScout pressureScout;

  RxInt setDevices;

  RxMultipurposeRS485({
    //this.iskraMT174,
    this.noiseSensorGemho,
    this.ammoniaSensorGemho,
    this.tempHumLuxSensorGemho,
    this.soilSensorGemho,
    this.cwsSensorHonde,
    this.particleSensorRenke,
    this.noiseSensorRenke,
    this.noiseSensorRika,
    this.pressureScout,
    this.setDevices,
  });
}

class ModelMultipurposeRS485 {
  RxMultipurposeRS485 rx;

  ModelMultipurposeRS485({
    int setDevices = 256,
    // bool isIskramt174 = false,
    // int iskramt174Status = 0,
    // String iskramt174Serie = '',
    // String iskramt174Firmware = '',
    // double iskramt174InternalBattery = 0.00,
    // int iskramt174TotalActiveEnergy = 0,
    // int iskramt174TotalPositiveReactiveEnergy = 0,
    // int iskramt174TotalApparentEnergy = 0,
    // double iskramt174TotalICurrent = 0.00,
    // double iskramt174Phase1ICurrent = 0.00,
    // double iskramt174Phase2ICurrent = 0.00,
    // double iskramt174Phase3ICurrent = 0.00,
    // double iskramt174Phase1IVoltage = 0.00,
    // double iskramt174Phase2IVoltage = 0.00,
    // double iskramt174Phase3IVoltage = 0.00,
    // double iskramt174IPowerFactor = 0.00,
    // double iskramt174Frequency = 0.00,
    bool isNoiseSensorGemho = false,
    int noiseSensorGemhoStatus = 0,
    String noiseSensorGemhoNoiseLevel = '0',
    bool isAmmoniaSensorGemho = false,
    int ammoniaSensorGemhoStatus = 0,
    String ammoniaSensorGemhoAmmoniaLevel = '0',
    bool isTemphumiluxSensorGemho = false,
    int temphumiluxSensorGemhoStatus = 0,
    double temphumiluxSensorGemhoTemperature = 0.0,
    double temphumiluxSensorGemhoHumidity = 0.0,
    int temphumiluxSensorGemhoIlluminance = 0,
    bool isSoilSensorGemho = false,
    int soilSensorGemhoStatus = 0,
    double soilSensorGemhoTemperature = 0.0,
    double soilSensorGemhoHumidity = 0.0,
    int soilSensorGemhoElectroconductivity = 0,
    double soilSensorGemhoPh = 0.0,
    int soilSensorGemhoNitrogen = 0,
    int soilSensorGemhoPhosphorus = 0,
    int soilSensorGemhoPotassium = 0,
    bool isCwsSensorHonde = false,
    int cwsSensorHondeStatus = 0,
    double cwsSensorHondeTemperature = 0,
    int cwsSensorHondeRadiation = 0,
    double cwsSensorHondeHumidity = 0.0,
    double cwsSensorHondePressure = 0.0,
    double cwsSensorHondeRainFall = 0.0,
    bool isParticleSensorRenke = false,
    int particleSensorRenkeStatus = 0,
    int particleSensorRenkeParticulateMatter2_5 = 0,
    int particleSensorRenkeParticulateMatter10 = 0,
    bool isNoiseSensorRenke = false,
    int noiseSensorRenkeStatus = 0,
    String noiseSensorRenkeNoiseLevel = '0',
    bool isNoiseSensorRika = false,
    int noiseSensorRikaStatus = 0,
    String noiseSensorRikaNoiseLevel = '0',

    //! Para el Pressure Scout

    bool isPressureScout = false,
    String pressureScoutStatus =
        'Desconocido', // String (Error, Ok, Desconocido)

    int voltageSensorScout = 0, // uint
    int psiIntSensorScout = 0, // int
    int psiIntSensorScoutx100 = 0, // int

    int highAlarmSensorScout = 0, // bool (0x01 true)
    int lowAlarmSensorScout = 0, // bool (0x01 true)
    int lowBatteryAlarmSensorScout =
        0, // bool (0x01 batería por debajo de 3.0 V)

    int psiRangeSensorScout = 0, // uint
    int psiStatusSensorScout =
        0, // uint (0: ok, 1: fuera de rango bajo, 2: fuera de rango alto)
    double psiFloatReadingSensorScout = 0.0, // float
    double psiScaleReadingSensorScout = 0.0, // float
    double alarmHighThreshold = 0.0, // float
    double alarmLowThreshold = 0.0, // float

    int mainCardTopRevisionNumber = 0,
    int mainCardBotRevisionNumber = 0,
    int radioTopRevisionNumber = 0,
    int radioBotRevisionNumber = 0,
    int sftsNodeAddress = 0,
    int modbusAddressSensorScout = 0, // uint
    int rssiSensorScout = 0, // int
    int sensorBatteryVoltage = 0, // uint
    int timeToLive = 0, // uint
    int numberOfRegisterCatched = 0, // uint
    int sensorType = 0,

    //! Para el Hart

    int hartMfgID = 0, // uint
    int hartDeviceType = 0, // uint
    int hartDeviceId = 0, // uint
    int hartStatus = 0, // uint
    int hartPvUnitsCode = 0, // uint
    int hartSvUnitsCode = 0, // uint
    int hartTvUnitsCode = 0, // uint
    int hartQvUnitsCode = 0, // uint
    double hartPv = 0, // float
    double hartSv = 0, // float
    double hartTv = 0, // float
    double hartQv = 0, // float
    int hartCommunicationStatus = 0, // uint
    int hartAlarmHighAlert = 0, // uint
    int hartAlarmLowAlert = 0, // uint
    String sentinelStatus = 'Desconocido', // string
    int hartMainCardTopRevisionNumber = 0,
    int hartMainCardBotRevisionNumber = 0,
    int hartRadioTopRevisionNumber = 0,
    int hartRadioBotRevisionNumber = 0,
    int hartSftsNodeAddress = 0,
    int hartModbusAddressSensorScout = 0, // uint
    int hartRssiSensorScout = 0, // int  - dBm
    int hartSensorBatteryVoltage = 0, // uint - mV
    int hartTimeToLive = 0, // uint - min
    int hartNumberOfRegisterCatched = 0, // uint
    int hartSensorType = 0, // ?
  }) {
    this.rx = RxMultipurposeRS485(
      setDevices: setDevices.obs,
      // iskraMT174: IskraMT174(
      //     isSensor: isIskramt174.obs,
      //     sensorStatus: iskramt174Status.obs,
      //     serie: iskramt174Serie.obs,
      //     firmware: iskramt174Firmware.obs,
      //     internalBattery: iskramt174InternalBattery.obs,
      //     iPowerFactor: iskramt174IPowerFactor.obs,
      //     frequency: iskramt174Frequency.obs,
      //     totalActiveEnergy: iskramt174TotalActiveEnergy.obs,
      //     totalPositiveReactiveEnergy:
      //         iskramt174TotalPositiveReactiveEnergy.obs,
      //     totalApparentEnergy: iskramt174TotalApparentEnergy.obs,
      //     totalICurrent: iskramt174TotalICurrent.obs,
      //     phase1ICurrent: iskramt174Phase1ICurrent.obs,
      //     phase2ICurrent: iskramt174Phase2ICurrent.obs,
      //     phase3ICurrent: iskramt174Phase3ICurrent.obs,
      //     phase1IVoltage: iskramt174Phase1IVoltage.obs,
      //     phase2IVoltage: iskramt174Phase2IVoltage.obs,
      //     phase3IVoltage: iskramt174Phase3IVoltage.obs),
      noiseSensorGemho: NoiseSensorGemho(
          isSensor: isNoiseSensorGemho.obs,
          sensorStatus: noiseSensorGemhoStatus.obs,
          noiseLevel: noiseSensorGemhoNoiseLevel.obs),
      ammoniaSensorGemho: AmmoniaSensorGemho(
        isSensor: isAmmoniaSensorGemho.obs,
        sensorStatus: ammoniaSensorGemhoStatus.obs,
        ammoniaLevel: ammoniaSensorGemhoAmmoniaLevel.obs,
      ),
      tempHumLuxSensorGemho: TempHumLuxSensorGemho(
        isSensor: isTemphumiluxSensorGemho.obs,
        sensorStatus: temphumiluxSensorGemhoStatus.obs,
        temperature: temphumiluxSensorGemhoTemperature.obs,
        humidity: temphumiluxSensorGemhoHumidity.obs,
        illuminance: temphumiluxSensorGemhoIlluminance.obs,
      ),
      soilSensorGemho: SoilSensorGemho(
        isSensor: isSoilSensorGemho.obs,
        sensorStatus: soilSensorGemhoStatus.obs,
        temperature: soilSensorGemhoTemperature.obs,
        humidity: soilSensorGemhoHumidity.obs,
        electroconductivity: soilSensorGemhoElectroconductivity.obs,
        ph: soilSensorGemhoPh.obs,
        nitrogen: soilSensorGemhoNitrogen.obs,
        phosphorus: soilSensorGemhoPhosphorus.obs,
        potassium: soilSensorGemhoPotassium.obs,
      ),
      cwsSensorHonde: CWSSensorHonde(
        isSensor: isCwsSensorHonde.obs,
        sensorStatus: cwsSensorHondeStatus.obs,
        temperature: cwsSensorHondeTemperature.obs,
        radiation: cwsSensorHondeRadiation.obs,
        humidity: cwsSensorHondeHumidity.obs,
        pressure: cwsSensorHondePressure.obs,
        rainFall: cwsSensorHondeRainFall.obs,
      ),
      particleSensorRenke: ParticleSensorRenke(
        isSensor: isParticleSensorRenke.obs,
        sensorStatus: particleSensorRenkeStatus.obs,
        particulateMatter2_5: particleSensorRenkeParticulateMatter2_5.obs,
        particulateMatter10: particleSensorRenkeParticulateMatter10.obs,
      ),
      noiseSensorRenke: NoiseSensorRenke(
        isSensor: isNoiseSensorRenke.obs,
        sensorStatus: noiseSensorRenkeStatus.obs,
        noiseLevel: noiseSensorRenkeNoiseLevel.obs,
      ),
      noiseSensorRika: NoiseSensorRika(
        isSensor: isNoiseSensorRika.obs,
        sensorStatus: noiseSensorRikaStatus.obs,
        noiseLevel: noiseSensorRikaNoiseLevel.obs,
      ),

      pressureScout: PressureScout(
        isSensor: isPressureScout.obs,

        pressureScoutStatus:
            pressureScoutStatus.obs, // String (Error, Ok, Desconocido)

        voltageSensorScout: voltageSensorScout.obs, // uint
        psiIntSensorScout: psiIntSensorScout.obs, // int
        psiIntSensorScoutx100: psiIntSensorScoutx100.obs, // int

        highAlarmSensorScout: highAlarmSensorScout.obs, // bool (0x01 true)
        lowAlarmSensorScout: lowAlarmSensorScout.obs, // bool (0x01 true)
        lowBatteryAlarmSensorScout: lowBatteryAlarmSensorScout
            .obs, // bool (0x01 batería por debajo de 3.0 V)

        psiRangeSensorScout: psiRangeSensorScout.obs, // uint
        psiStatusSensorScout: psiStatusSensorScout
            .obs, // uint (0: ok, 1: fuera de rango bajo, 2: fuera de rango alto)
        psiFloatReadingSensorScout: psiFloatReadingSensorScout.obs, // float
        psiScaleReadingSensorScout: psiScaleReadingSensorScout.obs, // float
        alarmHighThreshold: alarmHighThreshold.obs, // float
        alarmLowThreshold: alarmLowThreshold.obs, // float

        mainCardTopRevisionNumber: mainCardTopRevisionNumber.obs,
        mainCardBotRevisionNumber: mainCardBotRevisionNumber.obs,
        radioTopRevisionNumber: radioTopRevisionNumber.obs,
        radioBotRevisionNumber: radioBotRevisionNumber.obs,
        sftsNodeAddress: sftsNodeAddress.obs,
        modbusAddressSensorScout: modbusAddressSensorScout.obs, // uint
        rssiSensorScout: rssiSensorScout.obs, // int
        sensorBatteryVoltage: sensorBatteryVoltage.obs, // uint
        timeToLive: timeToLive.obs, // uint
        numberOfRegisterCatched: numberOfRegisterCatched.obs, // uint
        sensorType: sensorType.obs,

        //! Hart

        hartMfgID: hartMfgID.obs,
        hartDeviceType: hartDeviceType.obs,
        hartDeviceId: hartDeviceId.obs,
        hartStatus: hartStatus.obs,
        hartPvUnitsCode: hartPvUnitsCode.obs,
        hartSvUnitsCode: hartSvUnitsCode.obs,
        hartTvUnitsCode: hartTvUnitsCode.obs,
        hartQvUnitsCode: hartQvUnitsCode.obs,
        hartPv: hartPv.obs,
        hartSv: hartSv.obs,
        hartTv: hartTv.obs,
        hartQv: hartQv.obs,
        hartCommunicationStatus: hartCommunicationStatus.obs,
        hartAlarmHighAlert: hartAlarmHighAlert.obs,
        hartAlarmLowAlert: hartAlarmLowAlert.obs,
        sentinelStatus: sentinelStatus.obs,
        hartMainCardTopRevisionNumber: hartMainCardTopRevisionNumber.obs,
        hartMainCardBotRevisionNumber: hartMainCardBotRevisionNumber.obs,
        hartRadioTopRevisionNumber: hartRadioTopRevisionNumber.obs,
        hartRadioBotRevisionNumber: hartRadioBotRevisionNumber.obs,
        hartSftsNodeAddress: hartSftsNodeAddress.obs,
        hartModbusAddressSensorScout: hartModbusAddressSensorScout.obs,
        hartRssiSensorScout: hartRssiSensorScout.obs,
        hartSensorBatteryVoltage: hartSensorBatteryVoltage.obs,
        hartTimeToLive: hartTimeToLive.obs,
        hartNumberOfRegisterCatched: hartNumberOfRegisterCatched.obs,
        hartSensorType: hartSensorType.obs,
      ),
    );
  }

  /*
  
  pressureScoutStatus        
  voltageSensorScout         
  psiIntSensorScout          
  psiIntSensorScoutx100      
  highAlarmSensorScout       
  lowAlarmSensorScout        
  lowBatteryAlarmSensorScout 
  psiRangeSensorScout        
  psiStatusSensorScout       
  psiFloatReadingSensorScout 
  psiScaleReadingSensorScout 
  alarmHighThreshold         
  alarmLowThreshold          
  mainCardTopRevisionNumber  
  mainCardBotRevisionNumber  
  radioTopRevisionNumber     
  radioBotRevisionNumber     
  sftsNodeAddress            
  modbusAddressSensorScout   
  rssiSensorScout            
  sensorBatteryVoltage       
  timeToLive                 
  numberOfRegisterCatched    
  sensorType                 
  
  
  */

  int get setDevices => this.rx.setDevices.value;
  set setDevices(int v) => this.rx.setDevices.value = v;

  bool get isAmmoniaSensorGemho => this.rx.ammoniaSensorGemho.isSensor.value;
  set isAmmoniaSensorGemho(bool v) =>
      this.rx.ammoniaSensorGemho.isSensor.value = v;

  int get ammoniaSensorGemhoStatus =>
      this.rx.ammoniaSensorGemho.sensorStatus.value;
  set ammoniaSensorGemhoStatus(int v) =>
      this.rx.ammoniaSensorGemho.sensorStatus.value = v;

  String get ammoniaSensorGemhoAmmoniaLevel =>
      this.rx.ammoniaSensorGemho.ammoniaLevel.value;
  set ammoniaSensorGemhoAmmoniaLevel(String v) =>
      this.rx.ammoniaSensorGemho.ammoniaLevel.value = v;

  int get soilSensorGemhoStatus => this.rx.soilSensorGemho.sensorStatus.value;
  set soilSensorGemhoStatus(int v) =>
      this.rx.soilSensorGemho.sensorStatus.value = v;

  int get temphumiluxSensorGemhoStatus =>
      this.rx.tempHumLuxSensorGemho.sensorStatus.value;
  set temphumiluxSensorGemhoStatus(int v) =>
      this.rx.tempHumLuxSensorGemho.sensorStatus.value = v;

  int get noiseSensorGemhoStatus => this.rx.noiseSensorGemho.sensorStatus.value;
  set noiseSensorGemhoStatus(int v) =>
      this.rx.noiseSensorGemho.sensorStatus.value = v;

  bool get isSoilSensorGemho => this.rx.soilSensorGemho.isSensor.value;
  set isSoilSensorGemho(bool v) => this.rx.soilSensorGemho.isSensor.value = v;

  bool get isTemphumiluxSensorGemho =>
      this.rx.tempHumLuxSensorGemho.isSensor.value;
  set isTemphumiluxSensorGemho(bool v) =>
      this.rx.tempHumLuxSensorGemho.isSensor.value = v;

  bool get isNoiseSensorGemho => this.rx.noiseSensorGemho.isSensor.value;
  set isNoiseSensorGemho(bool v) => this.rx.noiseSensorGemho.isSensor.value = v;

  double get soilSensorGemhoTemperature =>
      this.rx.soilSensorGemho.temperature.value;
  set soilSensorGemhoTemperature(double v) =>
      this.rx.soilSensorGemho.temperature.value = v;

  double get soilSensorGemhoHumidity => this.rx.soilSensorGemho.humidity.value;
  set soilSensorGemhoHumidity(double v) =>
      this.rx.soilSensorGemho.humidity.value = v;

  int get soilSensorGemhoElectroconductivity =>
      this.rx.soilSensorGemho.electroconductivity.value;
  set soilSensorGemhoElectroconductivity(int v) =>
      this.rx.soilSensorGemho.electroconductivity.value = v;

  double get soilSensorGemhoPh => this.rx.soilSensorGemho.ph.value;
  set soilSensorGemhoPh(double v) => this.rx.soilSensorGemho.ph.value = v;

  int get soilSensorGemhoNitrogen => this.rx.soilSensorGemho.nitrogen.value;
  set soilSensorGemhoNitrogen(int v) =>
      this.rx.soilSensorGemho.nitrogen.value = v;

  int get soilSensorGemhoPhosphorus => this.rx.soilSensorGemho.phosphorus.value;
  set soilSensorGemhoPhosphorus(int v) =>
      this.rx.soilSensorGemho.phosphorus.value = v;

  int get soilSensorGemhoPotassium => this.rx.soilSensorGemho.potassium.value;
  set soilSensorGemhoPotassium(int v) =>
      this.rx.soilSensorGemho.potassium.value = v;

  double get temphumiluxSensorGemhoTemperature =>
      this.rx.tempHumLuxSensorGemho.temperature.value;
  set temphumiluxSensorGemhoTemperature(double v) =>
      this.rx.tempHumLuxSensorGemho.temperature.value = v;

  double get temphumiluxSensorGemhoHumidity =>
      this.rx.tempHumLuxSensorGemho.humidity.value;
  set temphumiluxSensorGemhoHumidity(double v) =>
      this.rx.tempHumLuxSensorGemho.humidity.value = v;

  int get temphumiluxSensorGemhoIlluminance =>
      this.rx.tempHumLuxSensorGemho.illuminance.value;
  set temphumiluxSensorGemhoIlluminance(int v) =>
      this.rx.tempHumLuxSensorGemho.illuminance.value = v;

  String get noiseSensorGemhoNoiseLevel =>
      this.rx.noiseSensorGemho.noiseLevel.value;
  set noiseSensorGemhoNoiseLevel(String v) =>
      this.rx.noiseSensorGemho.noiseLevel.value = v;

  //     int get iskramt174Status => this.rx.iskraMT174.sensorStatus.value;
  // set iskramt174Status(int v) => this.rx.iskraMT174.sensorStatus.value = v;

  // bool get isIskramt174 => this.rx.iskraMT174.isSensor.value;
  // set isIskramt174(bool v) => this.rx.iskraMT174.isSensor.value = v;

  // String get iskramt174Serie => this.rx.iskraMT174.serie.value;
  // set iskramt174Serie(String v) => this.rx.iskraMT174.serie.value = v;

  // String get iskramt174Firmware => this.rx.iskraMT174.firmware.value;
  // set iskramt174Firmware(String v) => this.rx.iskraMT174.firmware.value = v;

  // double get iskramt174InternalBattery =>
  //     this.rx.iskraMT174.internalBattery.value;
  // set iskramt174InternalBattery(double v) =>
  //     this.rx.iskraMT174.internalBattery.value = v;

  // double get iskramt174IPowerFactor => this.rx.iskraMT174.iPowerFactor.value;
  // set iskramt174IPowerFactor(double v) =>
  //     this.rx.iskraMT174.iPowerFactor.value = v;

  // double get iskramt174Frequency => this.rx.iskraMT174.frequency.value;
  // set iskramt174Frequency(double v) => this.rx.iskraMT174.frequency.value = v;

  // int get iskramt174TotalActiveEnergy =>
  //     this.rx.iskraMT174.totalActiveEnergy.value;
  // set iskramt174TotalActiveEnergy(int v) =>
  //     this.rx.iskraMT174.totalActiveEnergy.value = v;

  // int get iskramt174TotalPositiveReactiveEnergy =>
  //     this.rx.iskraMT174.totalPositiveReactiveEnergy.value;
  // set iskramt174TotalPositiveReactiveEnergy(int v) =>
  //     this.rx.iskraMT174.totalPositiveReactiveEnergy.value = v;

  // int get iskramt174TotalApparentEnergy =>
  //     this.rx.iskraMT174.totalApparentEnergy.value;
  // set iskramt174TotalApparentEnergy(int v) =>
  //     this.rx.iskraMT174.totalApparentEnergy.value = v;

  // double get iskramt174TotalICurrent => this.rx.iskraMT174.totalICurrent.value;
  // set iskramt174TotalICurrent(double v) =>
  //     this.rx.iskraMT174.totalICurrent.value = v;

  // double get iskramt174Phase1ICurrent =>
  //     this.rx.iskraMT174.phase1ICurrent.value;
  // set iskramt174Phase1ICurrent(double v) =>
  //     this.rx.iskraMT174.phase1ICurrent.value = v;

  // double get iskramt174Phase2ICurrent =>
  //     this.rx.iskraMT174.phase2ICurrent.value;
  // set iskramt174Phase2ICurrent(double v) =>
  //     this.rx.iskraMT174.phase2ICurrent.value = v;

  // double get iskramt174Phase3ICurrent =>
  //     this.rx.iskraMT174.phase3ICurrent.value;
  // set iskramt174Phase3ICurrent(double v) =>
  //     this.rx.iskraMT174.phase3ICurrent.value = v;

  // double get iskramt174Phase1IVoltage =>
  //     this.rx.iskraMT174.phase1IVoltage.value;
  // set iskramt174Phase1IVoltage(double v) =>
  //     this.rx.iskraMT174.phase1IVoltage.value = v;

  // double get iskramt174Phase2IVoltage =>
  //     this.rx.iskraMT174.phase2IVoltage.value;
  // set iskramt174Phase2IVoltage(double v) =>
  //     this.rx.iskraMT174.phase2IVoltage.value = v;

  // double get iskramt174Phase3IVoltage =>
  //     this.rx.iskraMT174.phase3IVoltage.value;
  // set iskramt174Phase3IVoltage(double v) =>
  //     this.rx.iskraMT174.phase3IVoltage.value = v;

  bool get isCwsSensorHonde => this.rx.cwsSensorHonde.isSensor.value;
  set isCwsSensorHonde(bool v) => this.rx.cwsSensorHonde.isSensor.value = v;

  int get cwsSensorHondeStatus => this.rx.cwsSensorHonde.sensorStatus.value;
  set cwsSensorHondeStatus(int v) =>
      this.rx.cwsSensorHonde.sensorStatus.value = v;

  double get cwsSensorHondeTemperature =>
      this.rx.cwsSensorHonde.temperature.value;
  set cwsSensorHondeTemperature(double v) =>
      this.rx.cwsSensorHonde.temperature.value = v;

  int get cwsSensorHondeRadiation => this.rx.cwsSensorHonde.radiation.value;
  set cwsSensorHondeRadiation(int v) =>
      this.rx.cwsSensorHonde.radiation.value = v;

  double get cwsSensorHondeHumidity => this.rx.cwsSensorHonde.humidity.value;
  set cwsSensorHondeHumidity(double v) =>
      this.rx.cwsSensorHonde.humidity.value = v;

  double get cwsSensorHondePressure => this.rx.cwsSensorHonde.pressure.value;
  set cwsSensorHondePressure(double v) =>
      this.rx.cwsSensorHonde.pressure.value = v;

  double get cwsSensorHondeRainFall => this.rx.cwsSensorHonde.rainFall.value;
  set cwsSensorHondeRainFall(double v) =>
      this.rx.cwsSensorHonde.rainFall.value = v;

  bool get isParticleSensorRenke => this.rx.particleSensorRenke.isSensor.value;
  set isParticleSensorRenke(bool v) =>
      this.rx.particleSensorRenke.isSensor.value = v;

  int get particleSensorRenkeStatus =>
      this.rx.particleSensorRenke.sensorStatus.value;
  set particleSensorRenkeStatus(int v) =>
      this.rx.particleSensorRenke.sensorStatus.value = v;

  int get particleSensorRenkeParticulateMatter2_5 =>
      this.rx.particleSensorRenke.particulateMatter2_5.value;
  set particleSensorRenkeParticulateMatter2_5(int v) =>
      this.rx.particleSensorRenke.particulateMatter2_5.value = v;

  int get particleSensorRenkeParticulateMatter10 =>
      this.rx.particleSensorRenke.particulateMatter10.value;
  set particleSensorRenkeParticulateMatter10(int v) =>
      this.rx.particleSensorRenke.particulateMatter10.value = v;

  bool get isNoiseSensorRenke => this.rx.noiseSensorRenke.isSensor.value;
  set isNoiseSensorRenke(bool v) => this.rx.noiseSensorRenke.isSensor.value = v;

  int get noiseSensorRenkeStatus => this.rx.noiseSensorRenke.sensorStatus.value;
  set noiseSensorRenkeStatus(int v) =>
      this.rx.noiseSensorRenke.sensorStatus.value = v;

  String get noiseSensorRenkeNoiseLevel =>
      this.rx.noiseSensorRenke.noiseLevel.value;
  set noiseSensorRenkeNoiseLevel(String v) =>
      this.rx.noiseSensorRenke.noiseLevel.value = v;

  bool get isNoiseSensorRika => this.rx.noiseSensorRika.isSensor.value;
  set isNoiseSensorRika(bool v) => this.rx.noiseSensorRika.isSensor.value = v;

  int get noiseSensorRikaStatus => this.rx.noiseSensorRika.sensorStatus.value;
  set noiseSensorRikaStatus(int v) =>
      this.rx.noiseSensorRika.sensorStatus.value = v;

  String get noiseSensorRikaNoiseLevel =>
      this.rx.noiseSensorRika.noiseLevel.value;
  set noiseSensorRikaNoiseLevel(String v) =>
      this.rx.noiseSensorRika.noiseLevel.value = v;

  //! Para el Pressure Scout

  bool get isPressureScout => this.rx.pressureScout.isSensor.value;
  set isPressureScout(bool v) => this.rx.pressureScout.isSensor.value = v;

  String get pressureScoutStatus =>
      this.rx.pressureScout.pressureScoutStatus.value;
  set pressureScoutStatus(String v) =>
      this.rx.pressureScout.pressureScoutStatus.value = v;

  int get voltageSensorScout => this.rx.pressureScout.voltageSensorScout.value;
  set voltageSensorScout(int v) =>
      this.rx.pressureScout.voltageSensorScout.value = v;

  int get psiIntSensorScout => this.rx.pressureScout.psiIntSensorScout.value;
  set psiIntSensorScout(int v) =>
      this.rx.pressureScout.psiIntSensorScout.value = v;

  int get psiIntSensorScoutx100 =>
      this.rx.pressureScout.psiIntSensorScoutx100.value;
  set psiIntSensorScoutx100(int v) =>
      this.rx.pressureScout.psiIntSensorScoutx100.value = v;

  int get highAlarmSensorScout =>
      this.rx.pressureScout.highAlarmSensorScout.value;
  set highAlarmSensorScout(int v) =>
      this.rx.pressureScout.highAlarmSensorScout.value = v;

  int get lowAlarmSensorScout =>
      this.rx.pressureScout.lowAlarmSensorScout.value;
  set lowAlarmSensorScout(int v) =>
      this.rx.pressureScout.lowAlarmSensorScout.value = v;

  int get lowBatteryAlarmSensorScout =>
      this.rx.pressureScout.lowBatteryAlarmSensorScout.value;
  set lowBatteryAlarmSensorScout(int v) =>
      this.rx.pressureScout.lowBatteryAlarmSensorScout.value = v;

  int get psiRangeSensorScout =>
      this.rx.pressureScout.psiRangeSensorScout.value;
  set psiRangeSensorScout(int v) =>
      this.rx.pressureScout.psiRangeSensorScout.value = v;

  int get psiStatusSensorScout =>
      this.rx.pressureScout.psiStatusSensorScout.value;
  set psiStatusSensorScout(int v) =>
      this.rx.pressureScout.psiStatusSensorScout.value = v;

  double get psiFloatReadingSensorScout =>
      this.rx.pressureScout.psiFloatReadingSensorScout.value;
  set psiFloatReadingSensorScout(double v) =>
      this.rx.pressureScout.psiFloatReadingSensorScout.value = v;

  double get psiScaleReadingSensorScout =>
      this.rx.pressureScout.psiScaleReadingSensorScout.value;
  set psiScaleReadingSensorScout(double v) =>
      this.rx.pressureScout.psiScaleReadingSensorScout.value = v;

  double get alarmHighThreshold =>
      this.rx.pressureScout.alarmHighThreshold.value;
  set alarmHighThreshold(double v) =>
      this.rx.pressureScout.alarmHighThreshold.value = v;

  double get alarmLowThreshold => this.rx.pressureScout.alarmLowThreshold.value;
  set alarmLowThreshold(double v) =>
      this.rx.pressureScout.alarmLowThreshold.value = v;

  ////////! Segunda trama del Pressure Scout //////////////////////////

  int get mainCardTopRevisionNumber =>
      this.rx.pressureScout.mainCardTopRevisionNumber.value;
  set mainCardTopRevisionNumber(int v) =>
      this.rx.pressureScout.mainCardTopRevisionNumber.value = v;

  int get mainCardBotRevisionNumber =>
      this.rx.pressureScout.mainCardBotRevisionNumber.value;
  set mainCardBotRevisionNumber(int v) =>
      this.rx.pressureScout.mainCardBotRevisionNumber.value = v;

  int get radioTopRevisionNumber =>
      this.rx.pressureScout.radioTopRevisionNumber.value;
  set radioTopRevisionNumber(int v) =>
      this.rx.pressureScout.radioTopRevisionNumber.value = v;

  int get radioBotRevisionNumber =>
      this.rx.pressureScout.radioBotRevisionNumber.value;
  set radioBotRevisionNumber(int v) =>
      this.rx.pressureScout.radioBotRevisionNumber.value = v;

  int get sftsNodeAddress => this.rx.pressureScout.sftsNodeAddress.value;
  set sftsNodeAddress(int v) => this.rx.pressureScout.sftsNodeAddress.value = v;

  int get modbusAddressSensorScout =>
      this.rx.pressureScout.modbusAddressSensorScout.value;
  set modbusAddressSensorScout(int v) =>
      this.rx.pressureScout.modbusAddressSensorScout.value = v;

  int get rssiSensorScout => this.rx.pressureScout.rssiSensorScout.value;
  set rssiSensorScout(int v) => this.rx.pressureScout.rssiSensorScout.value = v;

  int get sensorBatteryVoltage =>
      this.rx.pressureScout.sensorBatteryVoltage.value;
  set sensorBatteryVoltage(int v) =>
      this.rx.pressureScout.sensorBatteryVoltage.value = v;

  int get timeToLive => this.rx.pressureScout.timeToLive.value;
  set timeToLive(int v) => this.rx.pressureScout.timeToLive.value = v;

  int get numberOfRegisterCatched =>
      this.rx.pressureScout.numberOfRegisterCatched.value;
  set numberOfRegisterCatched(int v) =>
      this.rx.pressureScout.numberOfRegisterCatched.value = v;

  int get sensorType => this.rx.pressureScout.sensorType.value;
  set sensorType(int v) => this.rx.pressureScout.sensorType.value = v;

  /*! Para el HART

  hartSftsNodeAddress          
  hartModbusAddressSensorScout	
  hartRssiSensorScout			       
  hartSensorBatteryVoltage		   
  hartTimeToLive			            
  hartNumberOfRegisterCatched		
  hartSensorType			            
  
  */

  int get hartMfgID => this.rx.pressureScout.hartMfgID.value;
  set hartMfgID(int v) => this.rx.pressureScout.hartMfgID.value = v;

  int get hartDeviceType => this.rx.pressureScout.hartDeviceType.value;
  set hartDeviceType(int v) => this.rx.pressureScout.hartDeviceType.value = v;

  int get hartDeviceId => this.rx.pressureScout.hartDeviceId.value;
  set hartDeviceId(int v) => this.rx.pressureScout.hartDeviceId.value = v;

  int get hartStatus => this.rx.pressureScout.hartStatus.value;
  set hartStatus(int v) => this.rx.pressureScout.hartStatus.value = v;

  int get hartPvUnitsCode => this.rx.pressureScout.hartPvUnitsCode.value;
  set hartPvUnitsCode(int v) => this.rx.pressureScout.hartPvUnitsCode.value = v;

  int get hartSvUnitsCode => this.rx.pressureScout.hartSvUnitsCode.value;
  set hartSvUnitsCode(int v) => this.rx.pressureScout.hartSvUnitsCode.value = v;

  int get hartTvUnitsCode => this.rx.pressureScout.hartTvUnitsCode.value;
  set hartTvUnitsCode(int v) => this.rx.pressureScout.hartTvUnitsCode.value = v;

  int get hartQvUnitsCode => this.rx.pressureScout.hartQvUnitsCode.value;
  set hartQvUnitsCode(int v) => this.rx.pressureScout.hartQvUnitsCode.value = v;

  double get hartPv => this.rx.pressureScout.hartPv.value;
  set hartPv(double v) => this.rx.pressureScout.hartPv.value = v;

  double get hartSv => this.rx.pressureScout.hartSv.value;
  set hartSv(double v) => this.rx.pressureScout.hartSv.value = v;

  double get hartTv => this.rx.pressureScout.hartTv.value;
  set hartTv(double v) => this.rx.pressureScout.hartTv.value = v;

  double get hartQv => this.rx.pressureScout.hartQv.value;
  set hartQv(double v) => this.rx.pressureScout.hartQv.value = v;

  int get hartCommunicationStatus =>
      this.rx.pressureScout.hartCommunicationStatus.value;
  set hartCommunicationStatus(int v) =>
      this.rx.pressureScout.hartCommunicationStatus.value = v;

  int get hartAlarmHighAlert => this.rx.pressureScout.hartAlarmHighAlert.value;
  set hartAlarmHighAlert(int v) =>
      this.rx.pressureScout.hartAlarmHighAlert.value = v;

  int get hartAlarmLowAlert => this.rx.pressureScout.hartAlarmLowAlert.value;
  set hartAlarmLowAlert(int v) =>
      this.rx.pressureScout.hartAlarmLowAlert.value = v;

  //! Segunda trama del Hart

  String get sentinelStatus => this.rx.pressureScout.sentinelStatus.value;
  set sentinelStatus(String v) =>
      this.rx.pressureScout.sentinelStatus.value = v;

  int get hartMainCardTopRevisionNumber =>
      this.rx.pressureScout.hartMainCardTopRevisionNumber.value;
  set hartMainCardTopRevisionNumber(int v) =>
      this.rx.pressureScout.hartMainCardTopRevisionNumber.value = v;

  int get hartMainCardBotRevisionNumber =>
      this.rx.pressureScout.hartMainCardBotRevisionNumber.value;
  set hartMainCardBotRevisionNumber(int v) =>
      this.rx.pressureScout.hartMainCardBotRevisionNumber.value = v;

  int get hartRadioTopRevisionNumber =>
      this.rx.pressureScout.hartRadioTopRevisionNumber.value;
  set hartRadioTopRevisionNumber(int v) =>
      this.rx.pressureScout.hartRadioTopRevisionNumber.value = v;

  int get hartRadioBotRevisionNumber =>
      this.rx.pressureScout.hartRadioBotRevisionNumber.value;
  set hartRadioBotRevisionNumber(int v) =>
      this.rx.pressureScout.hartRadioBotRevisionNumber.value = v;

  int get hartSftsNodeAddress =>
      this.rx.pressureScout.hartSftsNodeAddress.value;
  set hartSftsNodeAddress(int v) =>
      this.rx.pressureScout.hartSftsNodeAddress.value = v;

  int get hartModbusAddressSensorScout =>
      this.rx.pressureScout.hartModbusAddressSensorScout.value;
  set hartModbusAddressSensorScout(int v) =>
      this.rx.pressureScout.hartModbusAddressSensorScout.value = v;

  int get hartRssiSensorScout =>
      this.rx.pressureScout.hartRssiSensorScout.value;
  set hartRssiSensorScout(int v) =>
      this.rx.pressureScout.hartRssiSensorScout.value = v;

  int get hartSensorBatteryVoltage =>
      this.rx.pressureScout.hartSensorBatteryVoltage.value;
  set hartSensorBatteryVoltage(int v) =>
      this.rx.pressureScout.hartSensorBatteryVoltage.value = v;

  int get hartTimeToLive => this.rx.pressureScout.hartTimeToLive.value;
  set hartTimeToLive(int v) => this.rx.pressureScout.hartTimeToLive.value = v;

  int get hartNumberOfRegisterCatched =>
      this.rx.pressureScout.hartNumberOfRegisterCatched.value;
  set hartNumberOfRegisterCatched(int v) =>
      this.rx.pressureScout.hartNumberOfRegisterCatched.value = v;

  int get hartSensorType => this.rx.pressureScout.hartSensorType.value;
  set hartSensorType(int v) => this.rx.pressureScout.hartSensorType.value = v;
}
