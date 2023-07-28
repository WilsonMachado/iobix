import 'package:get/get_rx/get_rx.dart';

class RxSmartMeterAc {
  //Versión 2
  /*RxInt setWriteRegType, setWriteRegSubtype;
  RxString errorSetWriteRegType, errorSetWriteRegSubtype;*/

  RxDouble deviceVersion;

  RxInt setWriteParameter, setParameterPhaseIndex;
  RxString errorSetWriteParameter,
      errorSetWriteParameterValue,
      errorSetParameterPhaseIndex;

  // Current
  RxString getIA, getIB, getIC, getIN;
  // Voltage
  RxString getVA, getVB, getVC;
  // Energy
  RxString phaseAPositiveActiveEnergy,
      phaseAPositiveReactiveEnergy,
      phaseAPositiveApparentEnergy,
      phaseANegativeActiveEnergy,
      phaseANegativeReactiveEnergy,
      phaseANegativeApparentEnergy;
  RxString phaseBPositiveActiveEnergy,
      phaseBPositiveReactiveEnergy,
      phaseBPositiveApparentEnergy,
      phaseBNegativeActiveEnergy,
      phaseBNegativeReactiveEnergy,
      phaseBNegativeApparentEnergy;
  RxString phaseCPositiveActiveEnergy,
      phaseCPositiveReactiveEnergy,
      phaseCPositiveApparentEnergy,
      phaseCNegativeActiveEnergy,
      phaseCNegativeReactiveEnergy,
      phaseCNegativeApparentEnergy;
  RxString phaseAActivePower,
      phaseBActivePower,
      phaseCActivePower,
      phaseAReactivePower,
      phaseBReactivePower,
      phaseCReactivePower,
      phaseAApparentPower,
      phaseBApparentPower,
      phaseCApparentPower,
      phaseAPowerFactor,
      phaseBPowerFactor,
      phaseCPowerFactor;

  RxBool setRmsCurrentGainCalib,
      setRmsCurrentOffsetCalib,
      setRmsFundamentalCurrentOffsetCalib;
  RxBool setRmsVoltageGainCalib,
      setRmsVoltageOffsetCalib,
      setRmsFundamentalVoltageOffsetCalib;
  RxBool setPhaseCalib;
  RxBool setPowerGainCalib,
      setActivePowerOffsetCalib,
      setFundamentalActivePowerOffsetCalib,
      setReactivePowerOffsetCalib,
      setFundamentalReactivePowerOffsetCalib;

  // Variables para SMAC V2
  /*RxString constantIA, constantIB, constantIC, constantIN;
  RxString getIAHex, getIBHex, getICHex, getINHex;
  RxString getIAPGAHex, getIBPGAHex, getICPGAHex, getINPGAHex;
  RxString constantVA, constantVB, constantVC;
  RxString getVAHex, getVBHex, getVCHex;*/

  // Others
  RxString externalTemperature, externalSupplyStatus;

  // Variables de lectura de parametros
  RxString cteCurrentPhaseA,
      cteCurrentPhaseB,
      cteCurrentPhaseC,
      cteCurrentNeutro;
  RxString cteVoltagePhaseA, cteVoltagePhaseB, cteVoltagePhaseC;
  RxString ctePowerPhaseA, ctePowerPhaseB, ctePowerPhaseC;
  RxString cteEnergyPhaseA, cteEnergyPhaseB, cteEnergyPhaseC;
  RxString voltageUpperThrPhaseA, voltageUpperThrPhaseB, voltageUpperThrPhaseC;
  RxString voltageLowerThrPhaseA, voltageLowerThrPhaseB, voltageLowerThrPhaseC;
  RxString energyMeasureFreqPhaseAll;
  RxString currentGainPhaseA,
      currentGainPhaseB,
      currentGainPhaseC,
      currentGainNeutro;
  RxString voltageGainPhaseA, voltageGainPhaseB, voltageGainPhaseC;
  RxString powerGainPhaseA, powerGainPhaseB, powerGainPhaseC;
  RxString currentOffsetPhaseA,
      currentOffsetPhaseB,
      currentOffsetPhaseC,
      currentOffsetNeutro;
  RxString voltageOffsetPhaseA, voltageOffsetPhaseB, voltageOffsetPhaseC;
  RxString activePowerOffsetPhaseA,
      activePowerOffsetPhaseB,
      activePowerOffsetPhaseC;
  RxString reactivePowerOffsetPhaseA,
      reactivePowerOffsetPhaseB,
      reactivePowerOffsetPhaseC;

  RxInt setRmsRegAddress;
  RxString getRmsRegValue;

  // Variables Debug
  RxInt analogMeasureProcess,
      loraMeasureProcess,
      bleMeasureProcess,
      loraApiProcess,
      rak4600Process,
      adeProcess,
      adeIrq0Process,
      adeIrq1Process,
      adeEnergyProcess,
      adeBurstReadProcess,
      rakSendDataStatus,
      rakSendingProcess;

  RxInt adeType;

  RxSmartMeterAc({
    //Versión 2
    /*
    this.setWriteRegType,
    this.errorSetWriteRegType,
    this.setWriteRegSubtype,
    this.errorSetWriteRegSubtype,*/
    this.deviceVersion,
    this.setWriteParameter,
    this.errorSetWriteParameter,
    this.errorSetWriteParameterValue,
    this.setParameterPhaseIndex,
    this.errorSetParameterPhaseIndex,
    this.setRmsCurrentGainCalib,
    this.setRmsCurrentOffsetCalib,
    this.setRmsFundamentalCurrentOffsetCalib,
    this.setRmsVoltageGainCalib,
    this.setRmsVoltageOffsetCalib,
    this.setRmsFundamentalVoltageOffsetCalib,
    this.setPhaseCalib,
    this.setPowerGainCalib,
    this.setActivePowerOffsetCalib,
    this.setFundamentalActivePowerOffsetCalib,
    this.setReactivePowerOffsetCalib,
    this.setFundamentalReactivePowerOffsetCalib,
    this.getIA,
    this.getIB,
    this.getIC,
    this.getIN,
    this.getVA,
    this.getVB,
    this.getVC,
    this.externalTemperature,
    this.externalSupplyStatus,
    this.phaseAPositiveActiveEnergy,
    this.phaseAPositiveReactiveEnergy,
    this.phaseAPositiveApparentEnergy,
    this.phaseANegativeActiveEnergy,
    this.phaseANegativeReactiveEnergy,
    this.phaseANegativeApparentEnergy,
    this.phaseBPositiveActiveEnergy,
    this.phaseBPositiveReactiveEnergy,
    this.phaseBPositiveApparentEnergy,
    this.phaseBNegativeActiveEnergy,
    this.phaseBNegativeReactiveEnergy,
    this.phaseBNegativeApparentEnergy,
    this.phaseCPositiveActiveEnergy,
    this.phaseCPositiveReactiveEnergy,
    this.phaseCPositiveApparentEnergy,
    this.phaseCNegativeActiveEnergy,
    this.phaseCNegativeReactiveEnergy,
    this.phaseCNegativeApparentEnergy,
    this.phaseAActivePower,
    this.phaseBActivePower,
    this.phaseCActivePower,
    this.phaseAReactivePower,
    this.phaseBReactivePower,
    this.phaseCReactivePower,
    this.phaseAApparentPower,
    this.phaseBApparentPower,
    this.phaseCApparentPower,
    this.phaseAPowerFactor,
    this.phaseBPowerFactor,
    this.phaseCPowerFactor,
    /*this.constantIA,
    this.constantIB,
    this.constantIC,
    this.constantIN,
    this.getIAHex,
    this.getIBHex,
    this.getICHex,
    this.getINHex,
    this.getIAPGAHex,
    this.getIBPGAHex,
    this.getICPGAHex,
    this.getINPGAHex,
    this.constantVA,
    this.constantVB,
    this.constantVC,
    this.getVAHex,
    this.getVBHex,
    this.getVCHex,*/
    this.cteCurrentPhaseA,
    this.cteCurrentPhaseB,
    this.cteCurrentPhaseC,
    this.cteCurrentNeutro,
    this.cteVoltagePhaseA,
    this.cteVoltagePhaseB,
    this.cteVoltagePhaseC,
    this.ctePowerPhaseA,
    this.ctePowerPhaseB,
    this.ctePowerPhaseC,
    this.cteEnergyPhaseA,
    this.cteEnergyPhaseB,
    this.cteEnergyPhaseC,
    this.voltageUpperThrPhaseA,
    this.voltageUpperThrPhaseB,
    this.voltageUpperThrPhaseC,
    this.voltageLowerThrPhaseA,
    this.voltageLowerThrPhaseB,
    this.voltageLowerThrPhaseC,
    this.energyMeasureFreqPhaseAll,
    this.currentGainPhaseA,
    this.currentGainPhaseB,
    this.currentGainPhaseC,
    this.currentGainNeutro,
    this.voltageGainPhaseA,
    this.voltageGainPhaseB,
    this.voltageGainPhaseC,
    this.powerGainPhaseA,
    this.powerGainPhaseB,
    this.powerGainPhaseC,
    this.currentOffsetPhaseA,
    this.currentOffsetPhaseB,
    this.currentOffsetPhaseC,
    this.currentOffsetNeutro,
    this.voltageOffsetPhaseA,
    this.voltageOffsetPhaseB,
    this.voltageOffsetPhaseC,
    this.activePowerOffsetPhaseA,
    this.activePowerOffsetPhaseB,
    this.activePowerOffsetPhaseC,
    this.reactivePowerOffsetPhaseA,
    this.reactivePowerOffsetPhaseB,
    this.reactivePowerOffsetPhaseC,
    this.setRmsRegAddress,
    this.getRmsRegValue,
    this.analogMeasureProcess,
    this.loraMeasureProcess,
    this.bleMeasureProcess,
    this.loraApiProcess,
    this.rak4600Process,
    this.adeProcess,
    this.adeIrq0Process,
    this.adeIrq1Process,
    this.adeEnergyProcess,
    this.adeBurstReadProcess,
    this.rakSendDataStatus,
    this.rakSendingProcess,
    this.adeType,
  });
}

class ModelSmartMeterAc {
  RxSmartMeterAc rx;

  String setWriteParameterValue;
  List<String> setWriteRegDataList = ['', '', '', '', ''];
  RxList<String> errorSetWriteRegDataList = ['', '', '', '', ''].obs;

  ModelSmartMeterAc({
    //Versión 2
    /*int setWriteRegType = -1,
    String errorSetWriteRegType,
    int setWriteRegSubtype = -1,
    String errorSetWriteRegSubtype,*/
    double deviceVersion = 1.0,
    int setWriteParameter = -1,
    String errorSetWriteParameter,
    this.setWriteParameterValue = '',
    String errorSetWriteParameterValue,
    int setParameterPhaseIndex = -1,
    String errorSetParameterPhaseIndex,
    bool setRmsCurrentGainCalib = false,
    bool setRmsCurrentOffsetCalib = false,
    bool setRmsFundamentalCurrentOffsetCalib = false,
    bool setRmsVoltageGainCalib = false,
    bool setRmsVoltageOffsetCalib = false,
    bool setRmsFundamentalVoltageOffsetCalib = false,
    bool setPhaseCalib = false,
    bool setPowerGainCalib = false,
    bool setActivePowerOffsetCalib = false,
    bool setFundamentalActivePowerOffsetCalib = false,
    bool setReactivePowerOffsetCalib = false,
    bool setFundamentalReactivePowerOffsetCalib = false,
    String getIA = '0.00',
    String getIB = '0.00',
    String getIC = '0.00',
    String getIN = '0.00',
    String getVA = '0.00',
    String getVB = '0.00',
    String getVC = '0.00',
    String externalTemperature = 'unknown',
    String externalSupplyStatus = 'unknown',
    String phaseAPositiveActiveEnergy = '0.00',
    String phaseAPositiveReactiveEnergy = '0.00',
    String phaseAPositiveApparentEnergy = '0.00',
    String phaseANegativeActiveEnergy = '0.00',
    String phaseANegativeReactiveEnergy = '0.00',
    String phaseANegativeApparentEnergy = '0.00',
    String phaseBPositiveActiveEnergy = '0.00',
    String phaseBPositiveReactiveEnergy = '0.00',
    String phaseBPositiveApparentEnergy = '0.00',
    String phaseBNegativeActiveEnergy = '0.00',
    String phaseBNegativeReactiveEnergy = '0.00',
    String phaseBNegativeApparentEnergy = '0.00',
    String phaseCPositiveActiveEnergy = '0.00',
    String phaseCPositiveReactiveEnergy = '0.00',
    String phaseCPositiveApparentEnergy = '0.00',
    String phaseCNegativeActiveEnergy = '0.00',
    String phaseCNegativeReactiveEnergy = '0.00',
    String phaseCNegativeApparentEnergy = '0.00',
    String phaseAActivePower = '0.00',
    String phaseBActivePower = '0.00',
    String phaseCActivePower = '0.00',
    String phaseAReactivePower = '0.00',
    String phaseBReactivePower = '0.00',
    String phaseCReactivePower = '0.00',
    String phaseAApparentPower = '0.00',
    String phaseBApparentPower = '0.00',
    String phaseCApparentPower = '0.00',
    String phaseAPowerFactor = '0.00',
    String phaseBPowerFactor = '0.00',
    String phaseCPowerFactor = '0.00',
    String cteCurrentPhaseA = 'unknown',
    String cteCurrentPhaseB = 'unknown',
    String cteCurrentPhaseC = 'unknown',
    String cteCurrentNeutro = 'unknown',
    String cteVoltagePhaseA = 'unknown',
    String cteVoltagePhaseB = 'unknown',
    String cteVoltagePhaseC = 'unknown',
    String ctePowerPhaseA = 'unknown',
    String ctePowerPhaseB = 'unknown',
    String ctePowerPhaseC = 'unknown',
    String cteEnergyPhaseA = 'unknown',
    String cteEnergyPhaseB = 'unknown',
    String cteEnergyPhaseC = 'unknown',
    String voltageUpperThrPhaseA = 'unknown',
    String voltageUpperThrPhaseB = 'unknown',
    String voltageUpperThrPhaseC = 'unknown',
    String voltageLowerThrPhaseA = 'unknown',
    String voltageLowerThrPhaseB = 'unknown',
    String voltageLowerThrPhaseC = 'unknown',
    String energyMeasureFreqPhaseAll = 'unknown',
    String currentGainPhaseA = 'unknown',
    String currentGainPhaseB = 'unknown',
    String currentGainPhaseC = 'unknown',
    String currentGainNeutro = 'unknown',
    String voltageGainPhaseA = 'unknown',
    String voltageGainPhaseB = 'unknown',
    String voltageGainPhaseC = 'unknown',
    String powerGainPhaseA = 'unknown',
    String powerGainPhaseB = 'unknown',
    String powerGainPhaseC = 'unknown',
    String currentOffsetPhaseA = 'unknown',
    String currentOffsetPhaseB = 'unknown',
    String currentOffsetPhaseC = 'unknown',
    String currentOffsetNeutro = 'unknown',
    String voltageOffsetPhaseA = 'unknown',
    String voltageOffsetPhaseB = 'unknown',
    String voltageOffsetPhaseC = 'unknown',
    String activePowerOffsetPhaseA = 'unknown',
    String activePowerOffsetPhaseB = 'unknown',
    String activePowerOffsetPhaseC = 'unknown',
    String reactivePowerOffsetPhaseA = 'unknown',
    String reactivePowerOffsetPhaseB = 'unknown',
    String reactivePowerOffsetPhaseC = 'unknown',
    int setRmsRegAddress = 0x020C,
    String getRmsRegValue = 'unknown',
    /*
    String constantIA = '000.00000000',
    String constantIB = '000.00000000',
    String constantIC = '000.00000000',
    String constantIN = '000.00000000',
    String getIAHex = '0x0000',
    String getIBHex = '0x0000',
    String getICHex = '0x0000',
    String getINHex = '0x0000',
    String getIAPGAHex = '0x0000',
    String getIBPGAHex = '0x0000',
    String getICPGAHex = '0x0000',
    String getINPGAHex = '0x0000',
    String constantVA = '000.00000000',
    String constantVB = '000.00000000',
    String constantVC = '000.00000000',    
    String getVAHex = '0x0000',
    String getVBHex = '0x0000',
    String getVCHex = '0x0000',*/
    int analogMeasureProcess = -1,
    int loraMeasureProcess = -1,
    int bleMeasureProcess = -1,
    int loraApiProcess = -1,
    int rak4600Process = -1,
    int adeProcess = -1,
    int adeIrq0Process = -1,
    int adeIrq1Process = -1,
    int adeEnergyProcess = -1,
    int adeBurstReadProcess = -1,
    int rakSendDataStatus = -1,
    int rakSendingProcess = -1,
    int adeType = 0,
  }) {
    this.rx = RxSmartMeterAc(
      //Versión 2
      /*
      setWriteRegType: setWriteRegType.obs,
      errorSetWriteRegType: errorSetWriteRegType.obs,
      setWriteRegSubtype: setWriteRegSubtype.obs,
      errorSetWriteRegSubtype: errorSetWriteRegSubtype.obs,*/
      deviceVersion: deviceVersion.obs,
      setWriteParameter: setWriteParameter.obs,
      errorSetWriteParameter: errorSetWriteParameter.obs,
      errorSetWriteParameterValue: errorSetWriteParameterValue.obs,
      setParameterPhaseIndex: setParameterPhaseIndex.obs,
      errorSetParameterPhaseIndex: errorSetParameterPhaseIndex.obs,
      setRmsCurrentGainCalib: setRmsCurrentGainCalib.obs,
      setRmsCurrentOffsetCalib: setRmsCurrentOffsetCalib.obs,
      setRmsFundamentalCurrentOffsetCalib:
          setRmsFundamentalCurrentOffsetCalib.obs,
      setRmsVoltageGainCalib: setRmsVoltageGainCalib.obs,
      setRmsVoltageOffsetCalib: setRmsVoltageOffsetCalib.obs,
      setRmsFundamentalVoltageOffsetCalib:
          setRmsFundamentalVoltageOffsetCalib.obs,
      setPhaseCalib: setPhaseCalib.obs,
      setPowerGainCalib: setPowerGainCalib.obs,
      setActivePowerOffsetCalib: setActivePowerOffsetCalib.obs,
      setFundamentalActivePowerOffsetCalib:
          setFundamentalActivePowerOffsetCalib.obs,
      setReactivePowerOffsetCalib: setReactivePowerOffsetCalib.obs,
      setFundamentalReactivePowerOffsetCalib:
          setFundamentalReactivePowerOffsetCalib.obs,
      getIA: getIA.obs,
      getIB: getIB.obs,
      getIC: getIC.obs,
      getIN: getIN.obs,
      getVA: getVA.obs,
      getVB: getVB.obs,
      getVC: getVC.obs,
      externalTemperature: externalTemperature.obs,
      externalSupplyStatus: externalSupplyStatus.obs,
      phaseAPositiveActiveEnergy: phaseAPositiveActiveEnergy.obs,
      phaseAPositiveReactiveEnergy: phaseAPositiveReactiveEnergy.obs,
      phaseAPositiveApparentEnergy: phaseAPositiveApparentEnergy.obs,
      phaseANegativeActiveEnergy: phaseANegativeActiveEnergy.obs,
      phaseANegativeReactiveEnergy: phaseANegativeReactiveEnergy.obs,
      phaseANegativeApparentEnergy: phaseANegativeApparentEnergy.obs,
      phaseBPositiveActiveEnergy: phaseBPositiveActiveEnergy.obs,
      phaseBPositiveReactiveEnergy: phaseBPositiveReactiveEnergy.obs,
      phaseBPositiveApparentEnergy: phaseBPositiveApparentEnergy.obs,
      phaseBNegativeActiveEnergy: phaseBNegativeActiveEnergy.obs,
      phaseBNegativeReactiveEnergy: phaseBNegativeReactiveEnergy.obs,
      phaseBNegativeApparentEnergy: phaseBNegativeApparentEnergy.obs,
      phaseCPositiveActiveEnergy: phaseCPositiveActiveEnergy.obs,
      phaseCPositiveReactiveEnergy: phaseCPositiveReactiveEnergy.obs,
      phaseCPositiveApparentEnergy: phaseCPositiveApparentEnergy.obs,
      phaseCNegativeActiveEnergy: phaseCNegativeActiveEnergy.obs,
      phaseCNegativeReactiveEnergy: phaseCNegativeReactiveEnergy.obs,
      phaseCNegativeApparentEnergy: phaseCNegativeApparentEnergy.obs,
      phaseAActivePower: phaseAActivePower.obs,
      phaseBActivePower: phaseBActivePower.obs,
      phaseCActivePower: phaseCActivePower.obs,
      phaseAReactivePower: phaseAReactivePower.obs,
      phaseBReactivePower: phaseBReactivePower.obs,
      phaseCReactivePower: phaseCReactivePower.obs,
      phaseAApparentPower: phaseAApparentPower.obs,
      phaseBApparentPower: phaseBApparentPower.obs,
      phaseCApparentPower: phaseCApparentPower.obs,
      phaseAPowerFactor: phaseAPowerFactor.obs,
      phaseBPowerFactor: phaseBPowerFactor.obs,
      phaseCPowerFactor: phaseCPowerFactor.obs,
      /*constantIA: constantIA.obs,
      constantIB: constantIB.obs,
      constantIC: constantIC.obs,
      constantIN: constantIN.obs,
      getIAHex: getIAHex.obs,
      getIBHex: getIBHex.obs,
      getICHex: getICHex.obs,
      getINHex: getINHex.obs,
      getIAPGAHex: getIAPGAHex.obs,
      getIBPGAHex: getIBPGAHex.obs,
      getICPGAHex: getICPGAHex.obs,
      getINPGAHex: getINPGAHex.obs,
      constantVA: constantVA.obs,
      constantVB: constantVB.obs,
      constantVC: constantVC.obs,
      getVAHex: getVAHex.obs,
      getVBHex: getVBHex.obs,
      getVCHex: getVCHex.obs,*/
      cteCurrentPhaseA: cteCurrentPhaseA.obs,
      cteCurrentPhaseB: cteCurrentPhaseB.obs,
      cteCurrentPhaseC: cteCurrentPhaseC.obs,
      cteCurrentNeutro: cteCurrentNeutro.obs,
      cteVoltagePhaseA: cteVoltagePhaseA.obs,
      cteVoltagePhaseB: cteVoltagePhaseB.obs,
      cteVoltagePhaseC: cteVoltagePhaseC.obs,
      ctePowerPhaseA: ctePowerPhaseA.obs,
      ctePowerPhaseB: ctePowerPhaseB.obs,
      ctePowerPhaseC: ctePowerPhaseC.obs,
      cteEnergyPhaseA: cteEnergyPhaseA.obs,
      cteEnergyPhaseB: cteEnergyPhaseB.obs,
      cteEnergyPhaseC: cteEnergyPhaseC.obs,
      voltageUpperThrPhaseA: voltageUpperThrPhaseA.obs,
      voltageUpperThrPhaseB: voltageUpperThrPhaseB.obs,
      voltageUpperThrPhaseC: voltageUpperThrPhaseC.obs,
      voltageLowerThrPhaseA: voltageLowerThrPhaseA.obs,
      voltageLowerThrPhaseB: voltageLowerThrPhaseB.obs,
      voltageLowerThrPhaseC: voltageLowerThrPhaseC.obs,
      energyMeasureFreqPhaseAll: energyMeasureFreqPhaseAll.obs,
      currentGainPhaseA: currentGainPhaseA.obs,
      currentGainPhaseB: currentGainPhaseB.obs,
      currentGainPhaseC: currentGainPhaseC.obs,
      currentGainNeutro: currentGainNeutro.obs,
      voltageGainPhaseA: voltageGainPhaseA.obs,
      voltageGainPhaseB: voltageGainPhaseB.obs,
      voltageGainPhaseC: voltageGainPhaseC.obs,
      powerGainPhaseA: powerGainPhaseA.obs,
      powerGainPhaseB: powerGainPhaseB.obs,
      powerGainPhaseC: powerGainPhaseC.obs,
      currentOffsetPhaseA: currentOffsetPhaseA.obs,
      currentOffsetPhaseB: currentOffsetPhaseB.obs,
      currentOffsetPhaseC: currentOffsetPhaseC.obs,
      currentOffsetNeutro: currentOffsetNeutro.obs,
      voltageOffsetPhaseA: voltageOffsetPhaseA.obs,
      voltageOffsetPhaseB: voltageOffsetPhaseB.obs,
      voltageOffsetPhaseC: voltageOffsetPhaseC.obs,
      activePowerOffsetPhaseA: activePowerOffsetPhaseA.obs,
      activePowerOffsetPhaseB: activePowerOffsetPhaseB.obs,
      activePowerOffsetPhaseC: activePowerOffsetPhaseC.obs,
      reactivePowerOffsetPhaseA: reactivePowerOffsetPhaseA.obs,
      reactivePowerOffsetPhaseB: reactivePowerOffsetPhaseB.obs,
      reactivePowerOffsetPhaseC: reactivePowerOffsetPhaseC.obs,
      setRmsRegAddress: setRmsRegAddress.obs,
      getRmsRegValue: getRmsRegValue.obs,
      analogMeasureProcess: analogMeasureProcess.obs,
      loraMeasureProcess: loraMeasureProcess.obs,
      bleMeasureProcess: bleMeasureProcess.obs,
      loraApiProcess: loraApiProcess.obs,
      rak4600Process: rak4600Process.obs,
      adeProcess: adeProcess.obs,
      adeIrq0Process: adeIrq0Process.obs,
      adeIrq1Process: adeIrq1Process.obs,
      adeEnergyProcess: adeEnergyProcess.obs,
      adeBurstReadProcess: adeBurstReadProcess.obs,
      rakSendDataStatus: rakSendDataStatus.obs,
      rakSendingProcess: rakSendingProcess.obs,
      adeType: adeType.obs,
    );
  }

  //Versión 2
  /*
  int get setWriteRegType => this.rx.setWriteRegType.value;
  set setWriteRegType(int v) => this.rx.setWriteRegType.value = v;

  String get errorSetWriteRegType => this.rx.errorSetWriteRegType.value;
  set errorSetWriteRegType(String v) => this.rx.errorSetWriteRegType.value = v;

  int get setWriteRegSubtype => this.rx.setWriteRegSubtype.value;
  set setWriteRegSubtype(int v) => this.rx.setWriteRegSubtype.value = v;

  String get errorSetWriteRegSubtype => this.rx.errorSetWriteRegSubtype.value;
  set errorSetWriteRegSubtype(String v) =>
      this.rx.errorSetWriteRegSubtype.value = v;*/

  double get deviceVersion => this.rx.deviceVersion.value;
  set deviceVersion(double v) => this.rx.deviceVersion.value = v;

  int get setWriteParameter => this.rx.setWriteParameter.value;
  set setWriteParameter(int v) => this.rx.setWriteParameter.value = v;

  String get errorSetWriteParameter => this.rx.errorSetWriteParameter.value;
  set errorSetWriteParameter(String v) =>
      this.rx.errorSetWriteParameter.value = v;

  String get errorSetWriteParameterValue =>
      this.rx.errorSetWriteParameterValue.value;
  set errorSetWriteParameterValue(String v) =>
      this.rx.errorSetWriteParameterValue.value = v;

  int get setParameterPhaseIndex => this.rx.setParameterPhaseIndex.value;
  set setParameterPhaseIndex(int v) => this.rx.setParameterPhaseIndex.value = v;

  String get errorSetParameterPhaseIndex =>
      this.rx.errorSetParameterPhaseIndex.value;
  set errorSetParameterPhaseIndex(String v) =>
      this.rx.errorSetParameterPhaseIndex.value = v;

  bool get setRmsCurrentGainCalib => this.rx.setRmsCurrentGainCalib.value;
  set setRmsCurrentGainCalib(bool v) =>
      this.rx.setRmsCurrentGainCalib.value = v;

  bool get setRmsCurrentOffsetCalib => this.rx.setRmsCurrentOffsetCalib.value;
  set setRmsCurrentOffsetCalib(bool v) =>
      this.rx.setRmsCurrentOffsetCalib.value = v;

  bool get setRmsFundamentalCurrentOffsetCalib =>
      this.rx.setRmsFundamentalCurrentOffsetCalib.value;
  set setRmsFundamentalCurrentOffsetCalib(bool v) =>
      this.rx.setRmsFundamentalCurrentOffsetCalib.value = v;

  bool get setRmsVoltageGainCalib => this.rx.setRmsVoltageGainCalib.value;
  set setRmsVoltageGainCalib(bool v) =>
      this.rx.setRmsVoltageGainCalib.value = v;

  bool get setRmsVoltageOffsetCalib => this.rx.setRmsVoltageOffsetCalib.value;
  set setRmsVoltageOffsetCalib(bool v) =>
      this.rx.setRmsVoltageOffsetCalib.value = v;

  bool get setRmsFundamentalVoltageOffsetCalib =>
      this.rx.setRmsFundamentalVoltageOffsetCalib.value;
  set setRmsFundamentalVoltageOffsetCalib(bool v) =>
      this.rx.setRmsFundamentalVoltageOffsetCalib.value = v;

  bool get setPhaseCalib => this.rx.setPhaseCalib.value;
  set setPhaseCalib(bool v) => this.rx.setPhaseCalib.value = v;

  bool get setPowerGainCalib => this.rx.setPowerGainCalib.value;
  set setPowerGainCalib(bool v) => this.rx.setPowerGainCalib.value = v;

  bool get setActivePowerOffsetCalib => this.rx.setActivePowerOffsetCalib.value;
  set setActivePowerOffsetCalib(bool v) =>
      this.rx.setActivePowerOffsetCalib.value = v;

  bool get setFundamentalActivePowerOffsetCalib =>
      this.rx.setFundamentalActivePowerOffsetCalib.value;
  set setFundamentalActivePowerOffsetCalib(bool v) =>
      this.rx.setFundamentalActivePowerOffsetCalib.value = v;

  bool get setReactivePowerOffsetCalib =>
      this.rx.setReactivePowerOffsetCalib.value;
  set setReactivePowerOffsetCalib(bool v) =>
      this.rx.setReactivePowerOffsetCalib.value = v;

  bool get setFundamentalReactivePowerOffsetCalib =>
      this.rx.setFundamentalReactivePowerOffsetCalib.value;
  set setFundamentalReactivePowerOffsetCalib(bool v) =>
      this.rx.setFundamentalReactivePowerOffsetCalib.value = v;

  String get getIA => this.rx.getIA.value;
  set getIA(String v) => this.rx.getIA.value = v;

  String get getIB => this.rx.getIB.value;
  set getIB(String v) => this.rx.getIB.value = v;

  String get getIC => this.rx.getIC.value;
  set getIC(String v) => this.rx.getIC.value = v;

  String get getIN => this.rx.getIN.value;
  set getIN(String v) => this.rx.getIN.value = v;

  String get getVA => this.rx.getVA.value;
  set getVA(String v) => this.rx.getVA.value = v;

  String get getVB => this.rx.getVB.value;
  set getVB(String v) => this.rx.getVB.value = v;

  String get getVC => this.rx.getVC.value;
  set getVC(String v) => this.rx.getVC.value = v;

  String get externalTemperature => this.rx.externalTemperature.value;
  set externalTemperature(String v) => this.rx.externalTemperature.value = v;

  String get externalSupplyStatus => this.rx.externalSupplyStatus.value;
  set externalSupplyStatus(String v) => this.rx.externalSupplyStatus.value = v;

  String get phaseAPositiveActiveEnergy =>
      this.rx.phaseAPositiveActiveEnergy.value;
  set phaseAPositiveActiveEnergy(String v) =>
      this.rx.phaseAPositiveActiveEnergy.value = v;

  String get phaseAPositiveReactiveEnergy =>
      this.rx.phaseAPositiveReactiveEnergy.value;
  set phaseAPositiveReactiveEnergy(String v) =>
      this.rx.phaseAPositiveReactiveEnergy.value = v;

  String get phaseAPositiveApparentEnergy =>
      this.rx.phaseAPositiveApparentEnergy.value;
  set phaseAPositiveApparentEnergy(String v) =>
      this.rx.phaseAPositiveApparentEnergy.value = v;

  String get phaseANegativeActiveEnergy =>
      this.rx.phaseANegativeActiveEnergy.value;
  set phaseANegativeActiveEnergy(String v) =>
      this.rx.phaseANegativeActiveEnergy.value = v;

  String get phaseANegativeReactiveEnergy =>
      this.rx.phaseANegativeReactiveEnergy.value;
  set phaseANegativeReactiveEnergy(String v) =>
      this.rx.phaseANegativeReactiveEnergy.value = v;

  String get phaseANegativeApparentEnergy =>
      this.rx.phaseANegativeApparentEnergy.value;
  set phaseANegativeApparentEnergy(String v) =>
      this.rx.phaseANegativeApparentEnergy.value = v;

  String get phaseBPositiveActiveEnergy =>
      this.rx.phaseBPositiveActiveEnergy.value;
  set phaseBPositiveActiveEnergy(String v) =>
      this.rx.phaseBPositiveActiveEnergy.value = v;

  String get phaseBPositiveReactiveEnergy =>
      this.rx.phaseBPositiveReactiveEnergy.value;
  set phaseBPositiveReactiveEnergy(String v) =>
      this.rx.phaseBPositiveReactiveEnergy.value = v;

  String get phaseBPositiveApparentEnergy =>
      this.rx.phaseBPositiveApparentEnergy.value;
  set phaseBPositiveApparentEnergy(String v) =>
      this.rx.phaseBPositiveApparentEnergy.value = v;

  String get phaseBNegativeActiveEnergy =>
      this.rx.phaseBNegativeActiveEnergy.value;
  set phaseBNegativeActiveEnergy(String v) =>
      this.rx.phaseBNegativeActiveEnergy.value = v;

  String get phaseBNegativeReactiveEnergy =>
      this.rx.phaseBNegativeReactiveEnergy.value;
  set phaseBNegativeReactiveEnergy(String v) =>
      this.rx.phaseBNegativeReactiveEnergy.value = v;

  String get phaseBNegativeApparentEnergy =>
      this.rx.phaseBNegativeApparentEnergy.value;
  set phaseBNegativeApparentEnergy(String v) =>
      this.rx.phaseBNegativeApparentEnergy.value = v;

  String get phaseCPositiveActiveEnergy =>
      this.rx.phaseCPositiveActiveEnergy.value;
  set phaseCPositiveActiveEnergy(String v) =>
      this.rx.phaseCPositiveActiveEnergy.value = v;

  String get phaseCPositiveReactiveEnergy =>
      this.rx.phaseCPositiveReactiveEnergy.value;
  set phaseCPositiveReactiveEnergy(String v) =>
      this.rx.phaseCPositiveReactiveEnergy.value = v;

  String get phaseCPositiveApparentEnergy =>
      this.rx.phaseCPositiveApparentEnergy.value;
  set phaseCPositiveApparentEnergy(String v) =>
      this.rx.phaseCPositiveApparentEnergy.value = v;

  String get phaseCNegativeActiveEnergy =>
      this.rx.phaseCNegativeActiveEnergy.value;
  set phaseCNegativeActiveEnergy(String v) =>
      this.rx.phaseCNegativeActiveEnergy.value = v;

  String get phaseCNegativeReactiveEnergy =>
      this.rx.phaseCNegativeReactiveEnergy.value;
  set phaseCNegativeReactiveEnergy(String v) =>
      this.rx.phaseCNegativeReactiveEnergy.value = v;

  String get phaseCNegativeApparentEnergy =>
      this.rx.phaseCNegativeApparentEnergy.value;
  set phaseCNegativeApparentEnergy(String v) =>
      this.rx.phaseCNegativeApparentEnergy.value = v;

  String get phaseAActivePower => this.rx.phaseAActivePower.value;
  set phaseAActivePower(String v) => this.rx.phaseAActivePower.value = v;

  String get phaseBActivePower => this.rx.phaseBActivePower.value;
  set phaseBActivePower(String v) => this.rx.phaseBActivePower.value = v;

  String get phaseCActivePower => this.rx.phaseCActivePower.value;
  set phaseCActivePower(String v) => this.rx.phaseCActivePower.value = v;

  String get phaseAReactivePower => this.rx.phaseAReactivePower.value;
  set phaseAReactivePower(String v) => this.rx.phaseAReactivePower.value = v;

  String get phaseBReactivePower => this.rx.phaseBReactivePower.value;
  set phaseBReactivePower(String v) => this.rx.phaseBReactivePower.value = v;

  String get phaseCReactivePower => this.rx.phaseCReactivePower.value;
  set phaseCReactivePower(String v) => this.rx.phaseCReactivePower.value = v;

  String get phaseAApparentPower => this.rx.phaseAApparentPower.value;
  set phaseAApparentPower(String v) => this.rx.phaseAApparentPower.value = v;

  String get phaseBApparentPower => this.rx.phaseBApparentPower.value;
  set phaseBApparentPower(String v) => this.rx.phaseBApparentPower.value = v;

  String get phaseCApparentPower => this.rx.phaseCApparentPower.value;
  set phaseCApparentPower(String v) => this.rx.phaseCApparentPower.value = v;

  String get phaseAPowerFactor => this.rx.phaseAPowerFactor.value;
  set phaseAPowerFactor(String v) => this.rx.phaseAPowerFactor.value = v;

  String get phaseBPowerFactor => this.rx.phaseBPowerFactor.value;
  set phaseBPowerFactor(String v) => this.rx.phaseBPowerFactor.value = v;

  String get phaseCPowerFactor => this.rx.phaseCPowerFactor.value;
  set phaseCPowerFactor(String v) => this.rx.phaseCPowerFactor.value = v;

  /*String get constantIA => this.rx.constantIA.value;
  set constantIA(String v) => this.rx.constantIA.value = v;

  String get constantIB => this.rx.constantIB.value;
  set constantIB(String v) => this.rx.constantIB.value = v;

  String get constantIC => this.rx.constantIC.value;
  set constantIC(String v) => this.rx.constantIC.value = v;

  String get constantIN => this.rx.constantIN.value;
  set constantIN(String v) => this.rx.constantIN.value = v;

  String get getIAHex => this.rx.getIAHex.value;
  set getIAHex(String v) => this.rx.getIAHex.value = v;

  String get getIBHex => this.rx.getIBHex.value;
  set getIBHex(String v) => this.rx.getIBHex.value = v;

  String get getICHex => this.rx.getICHex.value;
  set getICHex(String v) => this.rx.getICHex.value = v;

  String get getINHex => this.rx.getINHex.value;
  set getINHex(String v) => this.rx.getINHex.value = v;

  String get getIAPGAHex => this.rx.getIAPGAHex.value;
  set getIAPGAHex(String v) => this.rx.getIAPGAHex.value = v;

  String get getIBPGAHex => this.rx.getIBPGAHex.value;
  set getIBPGAHex(String v) => this.rx.getIBPGAHex.value = v;

  String get getICPGAHex => this.rx.getICPGAHex.value;
  set getICPGAHex(String v) => this.rx.getICPGAHex.value = v;

  String get getINPGAHex => this.rx.getINPGAHex.value;
  set getINPGAHex(String v) => this.rx.getINPGAHex.value = v;

  String get constantVA => this.rx.constantVA.value;
  set constantVA(String v) => this.rx.constantVA.value = v;

  String get constantVB => this.rx.constantVB.value;
  set constantVB(String v) => this.rx.constantVB.value = v;

  String get constantVC => this.rx.constantVC.value;
  set constantVC(String v) => this.rx.constantVC.value = v;

  String get getVAHex => this.rx.getVAHex.value;
  set getVAHex(String v) => this.rx.getVAHex.value = v;

  String get getVBHex => this.rx.getVBHex.value;
  set getVBHex(String v) => this.rx.getVBHex.value = v;

  String get getVCHex => this.rx.getVCHex.value;
  set getVCHex(String v) => this.rx.getVCHex.value = v;*/

  String get cteCurrentPhaseA => this.rx.cteCurrentPhaseA.value;
  set cteCurrentPhaseA(String v) => this.rx.cteCurrentPhaseA.value = v;

  String get cteCurrentPhaseB => this.rx.cteCurrentPhaseB.value;
  set cteCurrentPhaseB(String v) => this.rx.cteCurrentPhaseB.value = v;

  String get cteCurrentPhaseC => this.rx.cteCurrentPhaseC.value;
  set cteCurrentPhaseC(String v) => this.rx.cteCurrentPhaseC.value = v;

  String get cteCurrentNeutro => this.rx.cteCurrentNeutro.value;
  set cteCurrentNeutro(String v) => this.rx.cteCurrentNeutro.value = v;

  String get cteVoltagePhaseA => this.rx.cteVoltagePhaseA.value;
  set cteVoltagePhaseA(String v) => this.rx.cteVoltagePhaseA.value = v;

  String get cteVoltagePhaseB => this.rx.cteVoltagePhaseB.value;
  set cteVoltagePhaseB(String v) => this.rx.cteVoltagePhaseB.value = v;

  String get cteVoltagePhaseC => this.rx.cteVoltagePhaseC.value;
  set cteVoltagePhaseC(String v) => this.rx.cteVoltagePhaseC.value = v;

  String get ctePowerPhaseA => this.rx.ctePowerPhaseA.value;
  set ctePowerPhaseA(String v) => this.rx.ctePowerPhaseA.value = v;

  String get ctePowerPhaseB => this.rx.ctePowerPhaseB.value;
  set ctePowerPhaseB(String v) => this.rx.ctePowerPhaseB.value = v;

  String get ctePowerPhaseC => this.rx.ctePowerPhaseC.value;
  set ctePowerPhaseC(String v) => this.rx.ctePowerPhaseC.value = v;

  String get cteEnergyPhaseA => this.rx.cteEnergyPhaseA.value;
  set cteEnergyPhaseA(String v) => this.rx.cteEnergyPhaseA.value = v;

  String get cteEnergyPhaseB => this.rx.cteEnergyPhaseB.value;
  set cteEnergyPhaseB(String v) => this.rx.cteEnergyPhaseB.value = v;

  String get cteEnergyPhaseC => this.rx.cteEnergyPhaseC.value;
  set cteEnergyPhaseC(String v) => this.rx.cteEnergyPhaseC.value = v;

  String get voltageUpperThrPhaseA => this.rx.voltageUpperThrPhaseA.value;
  set voltageUpperThrPhaseA(String v) =>
      this.rx.voltageUpperThrPhaseA.value = v;

  String get voltageUpperThrPhaseB => this.rx.voltageUpperThrPhaseB.value;
  set voltageUpperThrPhaseB(String v) =>
      this.rx.voltageUpperThrPhaseB.value = v;

  String get voltageUpperThrPhaseC => this.rx.voltageUpperThrPhaseC.value;
  set voltageUpperThrPhaseC(String v) =>
      this.rx.voltageUpperThrPhaseC.value = v;

  String get voltageLowerThrPhaseA => this.rx.voltageLowerThrPhaseA.value;
  set voltageLowerThrPhaseA(String v) =>
      this.rx.voltageLowerThrPhaseA.value = v;

  String get voltageLowerThrPhaseB => this.rx.voltageLowerThrPhaseB.value;
  set voltageLowerThrPhaseB(String v) =>
      this.rx.voltageLowerThrPhaseB.value = v;

  String get voltageLowerThrPhaseC => this.rx.voltageLowerThrPhaseC.value;
  set voltageLowerThrPhaseC(String v) =>
      this.rx.voltageLowerThrPhaseC.value = v;

  String get energyMeasureFreqPhaseAll =>
      this.rx.energyMeasureFreqPhaseAll.value;
  set energyMeasureFreqPhaseAll(String v) =>
      this.rx.energyMeasureFreqPhaseAll.value = v;

  int get analogMeasureProcess => this.rx.analogMeasureProcess.value;
  set analogMeasureProcess(int v) => this.rx.analogMeasureProcess.value = v;

  int get loraMeasureProcess => this.rx.loraMeasureProcess.value;
  set loraMeasureProcess(int v) => this.rx.loraMeasureProcess.value = v;

  int get bleMeasureProcess => this.rx.bleMeasureProcess.value;
  set bleMeasureProcess(int v) => this.rx.bleMeasureProcess.value = v;

  int get loraApiProcess => this.rx.loraApiProcess.value;
  set loraApiProcess(int v) => this.rx.loraApiProcess.value = v;

  int get rak4600Process => this.rx.rak4600Process.value;
  set rak4600Process(int v) => this.rx.rak4600Process.value = v;

  int get adeProcess => this.rx.adeProcess.value;
  set adeProcess(int v) => this.rx.adeProcess.value = v;

  int get adeIrq0Process => this.rx.adeIrq0Process.value;
  set adeIrq0Process(int v) => this.rx.adeIrq0Process.value = v;

  int get adeIrq1Process => this.rx.adeIrq1Process.value;
  set adeIrq1Process(int v) => this.rx.adeIrq1Process.value = v;

  int get adeEnergyProcess => this.rx.adeEnergyProcess.value;
  set adeEnergyProcess(int v) => this.rx.adeEnergyProcess.value = v;

  int get adeBurstReadProcess => this.rx.adeBurstReadProcess.value;
  set adeBurstReadProcess(int v) => this.rx.adeBurstReadProcess.value = v;

  int get rakSendDataStatus => this.rx.rakSendDataStatus.value;
  set rakSendDataStatus(int v) => this.rx.rakSendDataStatus.value = v;

  int get rakSendingProcess => this.rx.rakSendingProcess.value;
  set rakSendingProcess(int v) => this.rx.rakSendingProcess.value = v;

  int get adeType => this.rx.adeType.value;
  set adeType(int v) => this.rx.adeType.value = v;

  String get currentGainPhaseA => this.rx.currentGainPhaseA.value;
  set currentGainPhaseA(String v) => this.rx.currentGainPhaseA.value = v;

  String get currentGainPhaseB => this.rx.currentGainPhaseB.value;
  set currentGainPhaseB(String v) => this.rx.currentGainPhaseB.value = v;

  String get currentGainPhaseC => this.rx.currentGainPhaseC.value;
  set currentGainPhaseC(String v) => this.rx.currentGainPhaseC.value = v;

  String get currentGainNeutro => this.rx.currentGainNeutro.value;
  set currentGainNeutro(String v) => this.rx.currentGainNeutro.value = v;

  String get voltageGainPhaseA => this.rx.voltageGainPhaseA.value;
  set voltageGainPhaseA(String v) => this.rx.voltageGainPhaseA.value = v;

  String get voltageGainPhaseB => this.rx.voltageGainPhaseB.value;
  set voltageGainPhaseB(String v) => this.rx.voltageGainPhaseB.value = v;

  String get voltageGainPhaseC => this.rx.voltageGainPhaseC.value;
  set voltageGainPhaseC(String v) => this.rx.voltageGainPhaseC.value = v;

  String get powerGainPhaseA => this.rx.powerGainPhaseA.value;
  set powerGainPhaseA(String v) => this.rx.powerGainPhaseA.value = v;

  String get powerGainPhaseB => this.rx.powerGainPhaseB.value;
  set powerGainPhaseB(String v) => this.rx.powerGainPhaseB.value = v;

  String get powerGainPhaseC => this.rx.powerGainPhaseC.value;
  set powerGainPhaseC(String v) => this.rx.powerGainPhaseC.value = v;

  String get currentOffsetPhaseA => this.rx.currentOffsetPhaseA.value;
  set currentOffsetPhaseA(String v) => this.rx.currentOffsetPhaseA.value = v;

  String get currentOffsetPhaseB => this.rx.currentOffsetPhaseB.value;
  set currentOffsetPhaseB(String v) => this.rx.currentOffsetPhaseB.value = v;

  String get currentOffsetPhaseC => this.rx.currentOffsetPhaseC.value;
  set currentOffsetPhaseC(String v) => this.rx.currentOffsetPhaseC.value = v;

  String get currentOffsetNeutro => this.rx.currentOffsetNeutro.value;
  set currentOffsetNeutro(String v) => this.rx.currentOffsetNeutro.value = v;

  String get voltageOffsetPhaseA => this.rx.voltageOffsetPhaseA.value;
  set voltageOffsetPhaseA(String v) => this.rx.voltageOffsetPhaseA.value = v;

  String get voltageOffsetPhaseB => this.rx.voltageOffsetPhaseB.value;
  set voltageOffsetPhaseB(String v) => this.rx.voltageOffsetPhaseB.value = v;

  String get voltageOffsetPhaseC => this.rx.voltageOffsetPhaseC.value;
  set voltageOffsetPhaseC(String v) => this.rx.voltageOffsetPhaseC.value = v;

  String get activePowerOffsetPhaseA => this.rx.activePowerOffsetPhaseA.value;
  set activePowerOffsetPhaseA(String v) =>
      this.rx.activePowerOffsetPhaseA.value = v;

  String get activePowerOffsetPhaseB => this.rx.activePowerOffsetPhaseB.value;
  set activePowerOffsetPhaseB(String v) =>
      this.rx.activePowerOffsetPhaseB.value = v;

  String get activePowerOffsetPhaseC => this.rx.activePowerOffsetPhaseC.value;
  set activePowerOffsetPhaseC(String v) =>
      this.rx.activePowerOffsetPhaseC.value = v;

  String get reactivePowerOffsetPhaseA =>
      this.rx.reactivePowerOffsetPhaseA.value;
  set reactivePowerOffsetPhaseA(String v) =>
      this.rx.reactivePowerOffsetPhaseA.value = v;

  String get reactivePowerOffsetPhaseB =>
      this.rx.reactivePowerOffsetPhaseB.value;
  set reactivePowerOffsetPhaseB(String v) =>
      this.rx.reactivePowerOffsetPhaseB.value = v;

  String get reactivePowerOffsetPhaseC =>
      this.rx.reactivePowerOffsetPhaseC.value;
  set reactivePowerOffsetPhaseC(String v) =>
      this.rx.reactivePowerOffsetPhaseC.value = v;

  int get setRmsRegAddress => this.rx.setRmsRegAddress.value;
  set setRmsRegAddress(int v) => this.rx.setRmsRegAddress.value = v;

  String get getRmsRegValue => this.rx.getRmsRegValue.value;
  set getRmsRegValue(String v) => this.rx.getRmsRegValue.value = v;
}
