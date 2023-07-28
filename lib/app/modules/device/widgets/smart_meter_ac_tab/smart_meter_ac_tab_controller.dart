import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';

import '../../device_controller.dart';
import '../../../../data/models/local/model_smart_meter_ac.dart';
import '../../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_commands.dart';
import '../../../../utils/helpers/helpers.dart';

class SmartMeterAcTabController extends GetxController {
  ModelSmartMeterAc modelSmartMeterAc = ModelSmartMeterAc();

  ///* Verificaciones de versión de FW

  bool get isFwHigherOrEqual1_0_4 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.0.4',
      );

  RxBool _selectSetRegType = false.obs;
  bool get selectSetRegType => _selectSetRegType.value;
  RxBool _selectSetRegSubtype = false.obs;
  bool get selectSetRegSubtype => _selectSetRegSubtype.value;

  RxBool _selectSetVarType = false.obs;
  bool get selectSetVarType => _selectSetVarType.value;
  RxBool _selectSetParameterPhaseIndex = false.obs;
  bool get selectSetParameterPhaseIndex => _selectSetParameterPhaseIndex.value;

  // Variables Phase Card
  RxBool _seeMorePhaseCard = false.obs;
  bool get seeMorePhaseCard => _seeMorePhaseCard.value;
  RxInt _currentPhaseInPhaseCard = 1.obs;
  int get currentPhaseInPhaseCard => _currentPhaseInPhaseCard.value;
  String phaseCardVoltage = '0.00',
      phaseCardCurrent = '0.00',
      phaseCardPositiveActiveEnergy = '0.0000',
      phaseCardNegativeActiveEnergy = '0.0000',
      phaseCardPositiveReactiveEnergy = '0.0000',
      phaseCardNegativeReactiveEnergy = '0.0000',
      phaseCardPositiveApparentEnergy = '0.0000',
      phaseCardNegativeApparentEnergy = '0.0000',
      phaseCardActivePower = '0.00',
      phaseCardReactivePower = '0.00',
      phaseCardApparentPower = '0.00',
      phaseCardPowerFactor = '0.00',
      phaseCardVoltageAux1 = '0.00',
      phaseCardVoltageAux2 = '0.00',
      phaseCardTextVolAux1 = 'Fase S',
      phaseCardTextVolAux2 = 'Fase T';
  RxInt _currentParameterInParameterCard = 1.obs;
  int get currentParameterInParameterCard =>
      _currentParameterInParameterCard.value;
  String parameterCardPhaseA = 'unknown',
      parameterCardPhaseB = 'unknown',
      parameterCardPhaseC = 'unknown',
      parameterCardNeutro = 'unknown';

  void onChangedSeeMorePhaseCard() {
    _seeMorePhaseCard.value = !_seeMorePhaseCard.value;
  }

  void onChangedPhaseCard(int k) {
    _currentPhaseInPhaseCard.value = k;
    updatePhaseCardVariables();
  }

  void onChangedParameterCard(int k) {
    _currentParameterInParameterCard.value = k;
    updateParameterCardVariables();
  }

  bool isCurrentParameterCardCurrent(int varToCompare) {
    if (varToCompare == SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE ||
        varToCompare == SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE ||
        varToCompare == SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE)
      return true;
    return false;
  }

  void updateParameterCardVariables() {
    switch (_currentParameterInParameterCard.value) {
      case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.cteCurrentPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.cteCurrentPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.cteCurrentPhaseC;
        parameterCardNeutro = modelSmartMeterAc.cteCurrentNeutro;
        break;

      case SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.cteVoltagePhaseA;
        parameterCardPhaseB = modelSmartMeterAc.cteVoltagePhaseB;
        parameterCardPhaseC = modelSmartMeterAc.cteVoltagePhaseC;
        break;

      /*case SMART_METER_AC_CONSTANTS.PHASE_VAR_TYPE_CODE:
        break;*/

      case SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.ctePowerPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.ctePowerPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.ctePowerPhaseC;
        break;

      case SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.cteEnergyPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.cteEnergyPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.cteEnergyPhaseC;
        break;

      case SMART_METER_AC_CONSTANTS.VOLTAGE_LOWER_THR_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.voltageLowerThrPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.voltageLowerThrPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.voltageLowerThrPhaseC;
        break;

      case SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.voltageUpperThrPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.voltageUpperThrPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.voltageUpperThrPhaseC;
        break;

      case SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.energyMeasureFreqPhaseAll;
        parameterCardPhaseB = modelSmartMeterAc.energyMeasureFreqPhaseAll;
        parameterCardPhaseC = modelSmartMeterAc.energyMeasureFreqPhaseAll;
        break;

      case SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.currentGainPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.currentGainPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.currentGainPhaseC;
        parameterCardNeutro = modelSmartMeterAc.currentGainNeutro;
        break;
      case SMART_METER_AC_CONSTANTS.VOLTAGE_GAIN_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.voltageGainPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.voltageGainPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.voltageGainPhaseC;
        break;
      case SMART_METER_AC_CONSTANTS.POWER_GAIN_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.powerGainPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.powerGainPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.powerGainPhaseC;
        break;
      case SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.currentOffsetPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.currentOffsetPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.currentOffsetPhaseC;
        parameterCardNeutro = modelSmartMeterAc.currentOffsetNeutro;
        break;
      case SMART_METER_AC_CONSTANTS.VOLTAGE_OFFSET_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.voltageOffsetPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.voltageOffsetPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.voltageOffsetPhaseC;
        break;
      case SMART_METER_AC_CONSTANTS.ACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.activePowerOffsetPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.activePowerOffsetPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.activePowerOffsetPhaseC;
        break;
      case SMART_METER_AC_CONSTANTS.REACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
        parameterCardPhaseA = modelSmartMeterAc.reactivePowerOffsetPhaseA;
        parameterCardPhaseB = modelSmartMeterAc.reactivePowerOffsetPhaseB;
        parameterCardPhaseC = modelSmartMeterAc.reactivePowerOffsetPhaseC;
        break;

      default:
    }
    update(['smartMeterAcParameterCard']);
  }

  void updatePhaseCardVariables() {
    switch (_currentPhaseInPhaseCard.value) {
      //Fase R
      case 1:
        phaseCardVoltage = modelSmartMeterAc.getVA;
        phaseCardCurrent = modelSmartMeterAc.getIA;
        phaseCardVoltageAux1 = modelSmartMeterAc.getVB;
        phaseCardVoltageAux2 = modelSmartMeterAc.getVC;
        phaseCardTextVolAux1 = 'Fase S';
        phaseCardTextVolAux2 = 'Fase T';
        phaseCardPositiveActiveEnergy =
            modelSmartMeterAc.phaseAPositiveActiveEnergy;
        phaseCardNegativeActiveEnergy =
            modelSmartMeterAc.phaseANegativeActiveEnergy;
        phaseCardPositiveReactiveEnergy =
            modelSmartMeterAc.phaseAPositiveReactiveEnergy;
        phaseCardNegativeReactiveEnergy =
            modelSmartMeterAc.phaseANegativeReactiveEnergy;
        phaseCardPositiveApparentEnergy =
            modelSmartMeterAc.phaseAPositiveApparentEnergy;
        phaseCardNegativeApparentEnergy =
            modelSmartMeterAc.phaseANegativeApparentEnergy;
        phaseCardActivePower = modelSmartMeterAc.phaseAActivePower;
        phaseCardReactivePower = modelSmartMeterAc.phaseAReactivePower;
        phaseCardApparentPower = modelSmartMeterAc.phaseAApparentPower;
        phaseCardPowerFactor = modelSmartMeterAc.phaseAPowerFactor;
        break;

      //Fase S
      case 2:
        phaseCardVoltage = modelSmartMeterAc.getVB;
        phaseCardCurrent = modelSmartMeterAc.getIB;
        phaseCardVoltageAux1 = modelSmartMeterAc.getVA;
        phaseCardVoltageAux2 = modelSmartMeterAc.getVC;
        phaseCardTextVolAux1 = 'Fase R';
        phaseCardTextVolAux2 = 'Fase T';
        phaseCardPositiveActiveEnergy =
            modelSmartMeterAc.phaseBPositiveActiveEnergy;
        phaseCardNegativeActiveEnergy =
            modelSmartMeterAc.phaseBNegativeActiveEnergy;
        phaseCardPositiveReactiveEnergy =
            modelSmartMeterAc.phaseBPositiveReactiveEnergy;
        phaseCardNegativeReactiveEnergy =
            modelSmartMeterAc.phaseBNegativeReactiveEnergy;
        phaseCardPositiveApparentEnergy =
            modelSmartMeterAc.phaseBPositiveApparentEnergy;
        phaseCardNegativeApparentEnergy =
            modelSmartMeterAc.phaseBNegativeApparentEnergy;
        phaseCardActivePower = modelSmartMeterAc.phaseBActivePower;
        phaseCardReactivePower = modelSmartMeterAc.phaseBReactivePower;
        phaseCardApparentPower = modelSmartMeterAc.phaseBApparentPower;
        phaseCardPowerFactor = modelSmartMeterAc.phaseBPowerFactor;
        break;

      //Fase T
      case 3:
      default:
        phaseCardVoltage = modelSmartMeterAc.getVC;
        phaseCardCurrent = modelSmartMeterAc.getIC;
        phaseCardVoltageAux1 = modelSmartMeterAc.getVA;
        phaseCardVoltageAux2 = modelSmartMeterAc.getVB;
        phaseCardTextVolAux1 = 'Fase R';
        phaseCardTextVolAux2 = 'Fase S';
        phaseCardPositiveActiveEnergy =
            modelSmartMeterAc.phaseCPositiveActiveEnergy;
        phaseCardNegativeActiveEnergy =
            modelSmartMeterAc.phaseCNegativeActiveEnergy;
        phaseCardPositiveReactiveEnergy =
            modelSmartMeterAc.phaseCPositiveReactiveEnergy;
        phaseCardNegativeReactiveEnergy =
            modelSmartMeterAc.phaseCNegativeReactiveEnergy;
        phaseCardPositiveApparentEnergy =
            modelSmartMeterAc.phaseCPositiveApparentEnergy;
        phaseCardNegativeApparentEnergy =
            modelSmartMeterAc.phaseCNegativeApparentEnergy;
        phaseCardActivePower = modelSmartMeterAc.phaseCActivePower;
        phaseCardReactivePower = modelSmartMeterAc.phaseCReactivePower;
        phaseCardApparentPower = modelSmartMeterAc.phaseCApparentPower;
        phaseCardPowerFactor = modelSmartMeterAc.phaseCPowerFactor;
        break;
    }

    update(['smartMeterAcPhaseCard']);
  }

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  // Para versión 2
  /*
  void onChangedSetWriteRegType(int k) {
    modelSmartMeterAc.setWriteRegType = k;
    if (modelSmartMeterAc.errorSetWriteRegType != null) {
      modelSmartMeterAc.errorSetWriteRegType = null;
    }

    modelSmartMeterAc.setWriteRegSubtype = -1;
    _selectSetRegSubtype.value = false;

    if (k == SMART_METER_AC_CONSTANTS.PHASE_REG_TYPE_CODE) {
      _selectSetRegSubtype.value = true;
    } else if (!_selectSetRegType.value) _selectSetRegType.value = true;
  }

  Map<int, String> getSetWriteRegSubtype() {
    switch (modelSmartMeterAc.setWriteRegType) {
      case SMART_METER_AC_CONSTANTS.CURRENT_REG_TYPE_CODE:
        return SMART_METER_AC_CONSTANTS.CURRENT_REG_SUBTYPE_MAP;

      case SMART_METER_AC_CONSTANTS.VOLTAGE_REG_TYPE_CODE:
        return SMART_METER_AC_CONSTANTS.VOLTAGE_REG_SUBTYPE_MAP;

      case SMART_METER_AC_CONSTANTS.POWER_REG_TYPE_CODE:
        return SMART_METER_AC_CONSTANTS.POWER_REG_SUBTYPE_MAP;

      default:
        return null;
    }
  }

  void onChangedSetWriteRegSubtype(int k) {
    modelSmartMeterAc.setWriteRegSubtype = k;
    if (modelSmartMeterAc.errorSetWriteRegSubtype != null) {
      modelSmartMeterAc.errorSetWriteRegSubtype = null;
    }
    if (!_selectSetRegSubtype.value) _selectSetRegSubtype.value = true;
  }

  Map<int, String> getSetWriteRegAddress() {
    switch (modelSmartMeterAc.setWriteRegType) {
      case SMART_METER_AC_CONSTANTS.CURRENT_REG_TYPE_CODE:
        switch (modelSmartMeterAc.setWriteRegSubtype) {
          case SMART_METER_AC_CONSTANTS.RMS_GAIN_CURRENT_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS.RMS_CURRENT_GAIN_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS.RMS_OFFSET_CURRENT_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS.RMS_CURRENT_OFFSET_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS
              .RMS_FUNDAMENTAL_OFFSET_CURRENT_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS
                .RMS_FUNDAMENTAL_CURRENT_OFFSET_REG_ADDRESS_MAP;
        }
        break;

      case SMART_METER_AC_CONSTANTS.VOLTAGE_REG_TYPE_CODE:
        switch (modelSmartMeterAc.setWriteRegSubtype) {
          case SMART_METER_AC_CONSTANTS.RMS_GAIN_VOLTAGE_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS.RMS_VOLTAGE_GAIN_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS.RMS_OFFSET_VOLTAGE_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS.RMS_VOLTAGE_OFFSET_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS
              .RMS_FUNDAMENTAL_OFFSET_VOLTAGE_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS
                .RMS_FUNDAMENTAL_VOLTAGE_OFFSET_REG_ADDRESS_MAP;
        }
        break;

      case SMART_METER_AC_CONSTANTS.PHASE_REG_TYPE_CODE:
        return SMART_METER_AC_CONSTANTS.PHASE_REG_ADDRESS_MAP;

      case SMART_METER_AC_CONSTANTS.POWER_REG_TYPE_CODE:
        switch (modelSmartMeterAc.setWriteRegSubtype) {
          case SMART_METER_AC_CONSTANTS.RMS_GAIN_POWER_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS.RMS_POWER_GAIN_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS
              .RMS_ACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS.ACTIVE_POWER_OFFSET_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS
              .RMS_ACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS
                .FUNDAMENTAL_ACTIVE_POWER_OFFSET_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS
              .RMS_REACTIVE_OFFSET_POWER_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS
                .REACTIVE_POWER_OFFSET_REG_ADDRESS_MAP;

          case SMART_METER_AC_CONSTANTS
              .RMS_REACTIVE_FUNDAMENTAL_OFFSET_POWER_REG_SUBTYPE_CODE:
            return SMART_METER_AC_CONSTANTS
                .FUNDAMENTAL_REACTIVE_POWER_OFFSET_REG_ADDRESS_MAP;
        }
        break;
    }

    return null;
  }

  void onChangedSetWriteRegData(String t, int idx) {
    modelSmartMeterAc.setWriteRegDataList[idx] = t;
  }

  Future<void> bleApiWriteRegAddress(int idx) async {
    bool error = false;

    if (modelSmartMeterAc.setWriteRegDataList[idx].length <= 0) {
      error = true;
      modelSmartMeterAc.errorSetWriteRegDataList[idx] = 'empty_error'.tr;
    } else if (!modelSmartMeterAc.setWriteRegDataList[idx].length.isEven ||
        !CONSTANTS.hexadecimalFormat
            .hasMatch(modelSmartMeterAc.setWriteRegDataList[idx])) {
      error = true;
      modelSmartMeterAc.errorSetWriteRegDataList[idx] = 'hex_format_error'.tr;
    }

    if (!error)
      await sendDataToDevice([
        SMART_METER_AC_CMDS.WRITE_REGISTER,
        modelSmartMeterAc.setWriteRegType,
        modelSmartMeterAc.setWriteRegSubtype,
        idx + 1,
        ...hexaAsciiToListInt(modelSmartMeterAc.setWriteRegDataList[idx])
      ], log: ': Register ${getSetWriteRegAddress()[idx + 1]}, Data: ${modelSmartMeterAc.setWriteRegDataList[idx]}');
    else
      update(['setWriteRegDataUI']);
  }*/

  void onChangedSetWriteParameter(int k) {
    modelSmartMeterAc.setWriteParameter = k;
    if (modelSmartMeterAc.errorSetWriteParameter != null) {
      modelSmartMeterAc.errorSetWriteParameter = null;
    }

    modelSmartMeterAc.setParameterPhaseIndex = -1;
    _selectSetParameterPhaseIndex.value = false;

    if (!_selectSetVarType.value) _selectSetVarType.value = true;
  }

  Map<int, String> getSetParameterPhaseIndexMap() {
    switch (modelSmartMeterAc.setWriteParameter) {
      case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE:
        return SMART_METER_AC_CONSTANTS.CURRENT_PHASE_INDEX_MAP;

      case SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE:
        return SMART_METER_AC_CONSTANTS.ONLY_ALL_PHASE_INDEX_MAP;

      default:
    }
    return SMART_METER_AC_CONSTANTS.PHASE_INDEX_MAP;
  }

  void onChangedSetWriteParameterPhaseIndex(int k) {
    modelSmartMeterAc.setParameterPhaseIndex = k;
    if (modelSmartMeterAc.errorSetParameterPhaseIndex != null) {
      modelSmartMeterAc.errorSetParameterPhaseIndex = null;
    }

    if (!_selectSetParameterPhaseIndex.value)
      _selectSetParameterPhaseIndex.value = true;
  }

  void onChangedSetWriteParameterValue(String t) {
    modelSmartMeterAc.setWriteParameterValue = t;
    if (modelSmartMeterAc.errorSetWriteParameterValue != null) {
      modelSmartMeterAc.errorSetWriteParameterValue = null;
    }
  }

  int getMaxLengthSetWriteParameterValue() {
    switch (modelSmartMeterAc.setWriteParameter) {
      //case SMART_METER_AC_CONSTANTS.PHASE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_LOWER_THR_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE:
        return 6;

      case SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.POWER_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.REACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
        return 8;

      case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE:
      default:
        return 12;
    }
  }

  int _getUnitSetWriteParameterValue() {
    switch (modelSmartMeterAc.setWriteParameter) {
      case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE:
        return 1000000;

      case SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE:
        return 1000;

      //case SMART_METER_AC_CONSTANTS.PHASE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_LOWER_THR_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE:
      default:
        return 1;
    }
  }

  bool _isFormatParameterValue(String value) {
    switch (modelSmartMeterAc.setWriteParameter) {
      case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE:
      //case SMART_METER_AC_CONSTANTS.PHASE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_LOWER_THR_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE:
        List<String> split = value.split('.');

        if (split.length <= 2) {
          if (split[0] == '') {
            modelSmartMeterAc.errorSetWriteParameterValue =
                'Ingrese un valor válido en la parte entera';
            return false;
          }

          if (split[0].length > 3) {
            modelSmartMeterAc.errorSetWriteParameterValue =
                'La parte entera no puede tener más de 3 digitos';
            return false;
          }

          int _totalDecimalLen = (modelSmartMeterAc.setWriteParameter ==
                      SMART_METER_AC_CONSTANTS
                          .VOLTAGE_LOWER_THR_VAR_TYPE_CODE ||
                  modelSmartMeterAc.setWriteParameter ==
                      SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE)
              ? 2
              : 8;

          if (split.length == 2 && split[1].length > _totalDecimalLen) {
            modelSmartMeterAc.errorSetWriteParameterValue =
                'La parte decimal no puede tener más de $_totalDecimalLen digitos';
            return false;
          }
        } else {
          modelSmartMeterAc.errorSetWriteParameterValue = 'Error de formato';
          return false;
        }

        return true;

      case SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE:
        if (!CONSTANTS.positiveIntegerFormat.hasMatch(value)) {
          modelSmartMeterAc.errorSetWriteParameterValue =
              'Ingrese un entero positivo';
          return false;
        }
        break;

      case SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.POWER_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.REACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
        if (value.length == 8) {
          if (!CONSTANTS.hexadecimalFormat.hasMatch(value)) {
            modelSmartMeterAc.errorSetWriteParameterValue =
                'hex_format_error'.tr;
            return false;
          }
        } else {
          modelSmartMeterAc.errorSetWriteParameterValue =
              'El valor debe ser de 8 bytes (Hexadecimal)';
          return false;
        }
        break;

      default:
    }

    modelSmartMeterAc.errorSetWriteParameterValue = null;
    return true;
  }

  List<int> _getProcessedValueSetWriteParameterValue() {
    switch (modelSmartMeterAc.setWriteParameter) {

      //case SMART_METER_AC_CONSTANTS.PHASE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_LOWER_THR_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_UPPER_THR_VAR_TYPE_CODE:
        int unit = _getUnitSetWriteParameterValue();
        var bd = ByteData(4);
        bd.setFloat32(
            0, double.parse(modelSmartMeterAc.setWriteParameterValue) / unit);

        return listIntLsbToMsb(
          divideIntInNBytes(bd.getInt32(0), 4),
        );

      case SMART_METER_AC_CONSTANTS.CURRENT_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.POWER_GAIN_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.CURRENT_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.VOLTAGE_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.ACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
      case SMART_METER_AC_CONSTANTS.REACTIVE_POWER_OFFSET_VAR_TYPE_CODE:
        return listIntLsbToMsb(
            hexaAsciiToListInt(modelSmartMeterAc.setWriteParameterValue));

      case SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE:
      default:
        return listIntLsbToMsb(
          divideIntInNBytes(
              int.parse(modelSmartMeterAc.setWriteParameterValue), 4),
        );
    }
  }

  Future<void> bleApiWriteParameter() async {
    bool error = false;

    if (SMART_METER_AC_CONSTANTS.VAR_TYPE_MAP
        .containsKey(modelSmartMeterAc.setWriteParameter)) {
      if (SMART_METER_AC_CONSTANTS.CURRENT_PHASE_INDEX_MAP
          .containsKey(modelSmartMeterAc.setParameterPhaseIndex)) {
        if (modelSmartMeterAc.setWriteParameterValue.length > 0) {
          error = !_isFormatParameterValue(
              modelSmartMeterAc.setWriteParameterValue);
        } else {
          error = true;
          modelSmartMeterAc.errorSetWriteParameterValue = 'empty_error'.tr;
        }
      } else {
        error = true;
        modelSmartMeterAc.errorSetParameterPhaseIndex = 'select_error'.tr;
      }
    } else {
      error = true;
      modelSmartMeterAc.errorSetWriteParameter = 'select_error'.tr;
    }

    if (!error) {
      List<int> parameter = _getProcessedValueSetWriteParameterValue();

      // Variable para enviar comando por Fase
      int _totalPhaseToSet = 1;

      if (modelSmartMeterAc.setWriteParameter !=
          SMART_METER_AC_CONSTANTS.ENERGY_MEASURE_FREQ_VAR_TYPE_CODE) {
        if (modelSmartMeterAc.setParameterPhaseIndex ==
            SMART_METER_AC_CONSTANTS.ONLY_ALL_PHASE_INDEX) {
          _totalPhaseToSet = 3;
          if (isCurrentParameterCardCurrent(
              modelSmartMeterAc.setWriteParameter)) _totalPhaseToSet = 4;
        }
      }

      // Solo enviarle a la fase seleccionada
      for (int i = 0; i < _totalPhaseToSet; i++) {
        int _phaseIndex = i + 1;
        if (_totalPhaseToSet == 1) {
          _phaseIndex = modelSmartMeterAc.setParameterPhaseIndex;
        } else {
          await Future.delayed(Duration(milliseconds: 200));
        }
        await sendDataToDevice(
          [
            SMART_METER_AC_CMDS.WRITE_PARAMETER,
            modelSmartMeterAc.setWriteParameter,
            _phaseIndex,
            ...parameter,
          ],
          log:
              'Parameter: ${SMART_METER_AC_CONSTANTS.VAR_TYPE_MAP[modelSmartMeterAc.setWriteParameter]}, Fase: ${SMART_METER_AC_CONSTANTS.CURRENT_PHASE_INDEX_MAP[_phaseIndex]}, Value: ${modelSmartMeterAc.setWriteParameterValue}',
        );
      }
    }
  }

  Future<void> bleApiDataReport() async {
    await sendDataToDevice([SMART_METER_AC_CMDS.DATA_REPORT]);
    await Future.delayed(Duration(seconds: 1));
    await sendDataToDevice([SMART_METER_AC_CMDS.ENERGY_DATA_REPORT]);
    await Future.delayed(Duration(seconds: 1));
    await sendDataToDevice([SMART_METER_AC_CMDS.POWER_REPORT]);
    await Future.delayed(Duration(seconds: 1));
    await sendDataToDevice([SMART_METER_AC_CMDS.GET_PARAMETER]);
  }

  Future<void> bleApiResetEnergyAccumulation() async {
    await sendDataToDevice([SMART_METER_AC_CMDS.RESET_ENERGY_ACCUMULATION]);
  }

  Future<void> bleApiDebugRead() async {
    await sendDataToDevice([SMART_METER_AC_CMDS.DEBUG_READ]);
  }

  void updateDebugCard() {
    update(['smartMeterAcDebugCard']);
  }

  // El idx esta asociado a una variable booleana de los tipos de calibración
  void onChangedSetCalibStatusRegType(int i, bool value) {
    switch (i) {
      case 0:
        modelSmartMeterAc.setRmsCurrentGainCalib = value;
        break;
      case 1:
        modelSmartMeterAc.setRmsCurrentOffsetCalib = value;
        break;
      case 2:
        modelSmartMeterAc.setRmsFundamentalCurrentOffsetCalib = value;
        break;
      case 3:
        modelSmartMeterAc.setRmsVoltageGainCalib = value;
        break;
      case 4:
        modelSmartMeterAc.setRmsVoltageOffsetCalib = value;
        break;
      case 5:
        modelSmartMeterAc.setRmsFundamentalVoltageOffsetCalib = value;
        break;
      case 6:
        modelSmartMeterAc.setPhaseCalib = value;
        break;
      case 7:
        modelSmartMeterAc.setPowerGainCalib = value;
        break;
      case 8:
        modelSmartMeterAc.setActivePowerOffsetCalib = value;
        break;
      case 9:
        modelSmartMeterAc.setFundamentalActivePowerOffsetCalib = value;
        break;
      case 10:
        modelSmartMeterAc.setReactivePowerOffsetCalib = value;
        break;
      case 11:
        modelSmartMeterAc.setFundamentalReactivePowerOffsetCalib = value;
        break;
      default:
    }
    updateSmartMeterAcSetCalibStatusRegCard();
  }

  void updateSmartMeterAcSetCalibStatusRegCard() {
    update(['SmartMeterAcSetCalibStatusRegCard']);
  }

  Future<void> bleApiSetCalibStatusReg(List<bool> variables) async {
    int calibStatusReg1 = 0, calibStatusReg2 = 0;

    for (int i = 0; i < 8; i++) {
      int _v = variables[i] ? 1 : 0;
      calibStatusReg1 |= _v << (8 - i - 1);
    }

    calibStatusReg1 &= 0xFF;

    for (int i = 0; i < 4; i++) {
      int _v = variables[i + 8] ? 1 : 0;
      calibStatusReg2 |= _v << (8 - i - 1);
    }

    calibStatusReg2 &= 0xFF;

    await sendDataToDevice([
      SMART_METER_AC_CMDS.SET_CALIB_STATUS_REG,
      calibStatusReg1,
      calibStatusReg2,
    ]);
  }

  Future<void> bleApiGetCalibStatusReg() async {
    await sendDataToDevice([SMART_METER_AC_CMDS.GET_CALIB_STATUS_REG]);
  }

  void onChangedSetRmsRegAddress(int k) {
    modelSmartMeterAc.setRmsRegAddress = k;
  }

  Future<void> bleApiSetRmsRegAddress() async {
    await sendDataToDevice([
      SMART_METER_AC_CMDS.GET_RMS_REG,
      ...listIntLsbToMsb(
          divideIntInNBytes(modelSmartMeterAc.setRmsRegAddress, 2)),
    ], log: 'Register: ${SMART_METER_AC_CONSTANTS.RMS_REG_ADDRESS[modelSmartMeterAc.setRmsRegAddress]}');
  }
}
