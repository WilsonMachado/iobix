import 'package:get/get_rx/get_rx.dart';

class RxIskraMt174 {
  // All in Wh
  final RxString totalPositiveActiveEnergy;
  final RxString t1PositiveActiveEnergy;
  final RxString t2PositiveActiveEnergy;
  final RxString t3PositiveActiveEnergy;
  final RxString t4PositiveActiveEnergy;
  final RxString totalNegativeActiveEnergy;
  final RxString t1NegativeActiveEnergy;
  final RxString t2NegativeActiveEnergy;
  final RxString t3NegativeActiveEnergy;
  final RxString t4NegativeActiveEnergy;
  final RxString totalAbsoluteActiveEnergy;
  final RxString t1AbsoluteActiveEnergy;
  final RxString t2AbsoluteActiveEnergy;
  final RxString t3AbsoluteActiveEnergy;
  final RxString t4AbsoluteActiveEnergy;
  final RxString totalSumOfActiveEnergyWithoutReverseBlocking;
  final RxString t1SumOfActiveEnergyWithoutReverseBlocking;
  final RxString t2SumOfActiveEnergyWithoutReverseBlocking;
  final RxString t3SumOfActiveEnergyWithoutReverseBlocking;
  final RxString t4SumOfActiveEnergyWithoutReverseBlocking;

  // All in Varh
  final RxString totalPositiveReactiveEnergy;
  final RxString t1PositiveReactiveEnergy;
  final RxString t2PositiveReactiveEnergy;
  final RxString t3PositiveReactiveEnergy;
  final RxString t4PositiveReacctiveEnergy;
  final RxString totalNegativeReactiveEnergy;
  final RxString t1NegativeReactiveEnergy;
  final RxString t2NegativeReactiveEnergy;
  final RxString t3NegativeReactiveEnergy;
  final RxString t4NegativeReactiveEnergy;
  final RxString totalInductiveReactiveEnergyInQ1;
  final RxString t1InductiveReactiveEnergyInQ1;
  final RxString t2InductiveReactiveEnergyInQ1;
  final RxString t3InductiveReactiveEnergyInQ1;
  final RxString t4InductiveReactiveEnergyInQ1;
  final RxString totalCapacitiveReactiveEnergyInQ2;
  final RxString t1CapacitiveReactiveEnergyInQ2;
  final RxString t2CapacitiveReactiveEnergyInQ2;
  final RxString t3CapacitiveReactiveEnergyInQ2;
  final RxString t4CapacitiveReactiveEnergyInQ2;
  final RxString totalInductiveReactiveEnergyInQ3;
  final RxString t1InductiveReactiveEnergyInQ3;
  final RxString t2InductiveReactiveEnergyInQ3;
  final RxString t3InductiveReactiveEnergyInQ3;
  final RxString t4InductiveReactiveEnergyInQ3;
  final RxString totalCapacitiveReactiveEnergyInQ4;
  final RxString t1CapacitiveReactiveEnergyInQ4;
  final RxString t2CapacitiveReactiveEnergyInQ4;
  final RxString t3CapacitiveReactiveEnergyInQ4;
  final RxString t4CapacitiveReactiveEnergyInQ4;

  // I in A, V in V, pf and Hz
  final RxString instantaneousCurrent;
  final RxString instantaneousCurrentInPhase1;
  final RxString instantaneousCurrentInPhase2;
  final RxString instantaneousCurrentInPhase3;
  final RxString instantaneousCurrentInNeutro;
  final RxString maxCurrent;
  final RxString maxCurrentInPhase1;
  final RxString maxCurrentInPhase2;
  final RxString maxCurrentInPhase3;
  final RxString maxCurrentInNeutro;
  final RxString instantaneousVoltage;
  final RxString instantaneousVoltageInPhase1;
  final RxString instantaneousVoltageInPhase2;
  final RxString instantaneousVoltageInPhase3;
  final RxString instantaneousPowerFactor;
  final RxString instantaneousPowerFactorInPhase1;
  final RxString instantaneousPowerFactorInPhase2;
  final RxString instantaneousPowerFactorInPhase3;
  final RxString frequency;

  final RxString currentTime;
  final RxString currentDate;
  final RxString serie;

  RxIskraMt174({
    this.totalPositiveActiveEnergy,
    this.t1PositiveActiveEnergy,
    this.t2PositiveActiveEnergy,
    this.t3PositiveActiveEnergy,
    this.t4PositiveActiveEnergy,
    this.totalNegativeActiveEnergy,
    this.t1NegativeActiveEnergy,
    this.t2NegativeActiveEnergy,
    this.t3NegativeActiveEnergy,
    this.t4NegativeActiveEnergy,
    this.totalAbsoluteActiveEnergy,
    this.t1AbsoluteActiveEnergy,
    this.t2AbsoluteActiveEnergy,
    this.t3AbsoluteActiveEnergy,
    this.t4AbsoluteActiveEnergy,
    this.totalSumOfActiveEnergyWithoutReverseBlocking,
    this.t1SumOfActiveEnergyWithoutReverseBlocking,
    this.t2SumOfActiveEnergyWithoutReverseBlocking,
    this.t3SumOfActiveEnergyWithoutReverseBlocking,
    this.t4SumOfActiveEnergyWithoutReverseBlocking,
    this.totalPositiveReactiveEnergy,
    this.t1PositiveReactiveEnergy,
    this.t2PositiveReactiveEnergy,
    this.t3PositiveReactiveEnergy,
    this.t4PositiveReacctiveEnergy,
    this.totalNegativeReactiveEnergy,
    this.t1NegativeReactiveEnergy,
    this.t2NegativeReactiveEnergy,
    this.t3NegativeReactiveEnergy,
    this.t4NegativeReactiveEnergy,
    this.totalInductiveReactiveEnergyInQ1,
    this.t1InductiveReactiveEnergyInQ1,
    this.t2InductiveReactiveEnergyInQ1,
    this.t3InductiveReactiveEnergyInQ1,
    this.t4InductiveReactiveEnergyInQ1,
    this.totalCapacitiveReactiveEnergyInQ2,
    this.t1CapacitiveReactiveEnergyInQ2,
    this.t2CapacitiveReactiveEnergyInQ2,
    this.t3CapacitiveReactiveEnergyInQ2,
    this.t4CapacitiveReactiveEnergyInQ2,
    this.totalInductiveReactiveEnergyInQ3,
    this.t1InductiveReactiveEnergyInQ3,
    this.t2InductiveReactiveEnergyInQ3,
    this.t3InductiveReactiveEnergyInQ3,
    this.t4InductiveReactiveEnergyInQ3,
    this.totalCapacitiveReactiveEnergyInQ4,
    this.t1CapacitiveReactiveEnergyInQ4,
    this.t2CapacitiveReactiveEnergyInQ4,
    this.t3CapacitiveReactiveEnergyInQ4,
    this.t4CapacitiveReactiveEnergyInQ4,
    this.instantaneousCurrent,
    this.instantaneousCurrentInPhase1,
    this.instantaneousCurrentInPhase2,
    this.instantaneousCurrentInPhase3,
    this.instantaneousCurrentInNeutro,
    this.maxCurrent,
    this.maxCurrentInPhase1,
    this.maxCurrentInPhase2,
    this.maxCurrentInPhase3,
    this.maxCurrentInNeutro,
    this.instantaneousVoltage,
    this.instantaneousVoltageInPhase1,
    this.instantaneousVoltageInPhase2,
    this.instantaneousVoltageInPhase3,
    this.instantaneousPowerFactor,
    this.instantaneousPowerFactorInPhase1,
    this.instantaneousPowerFactorInPhase2,
    this.instantaneousPowerFactorInPhase3,
    this.frequency,
    this.currentTime,
    this.currentDate,
    this.serie,
  });
}

class ModelIskraMt174 {
  RxIskraMt174 rx;

  ModelIskraMt174({
    String totalPositiveActiveEnergy = '',
    String t1PositiveActiveEnergy = '',
    String t2PositiveActiveEnergy = '',
    String t3PositiveActiveEnergy = '',
    String t4PositiveActiveEnergy = '',
    String totalNegativeActiveEnergy = '',
    String t1NegativeActiveEnergy = '',
    String t2NegativeActiveEnergy = '',
    String t3NegativeActiveEnergy = '',
    String t4NegativeActiveEnergy = '',
    String totalAbsoluteActiveEnergy = '',
    String t1AbsoluteActiveEnergy = '',
    String t2AbsoluteActiveEnergy = '',
    String t3AbsoluteActiveEnergy = '',
    String t4AbsoluteActiveEnergy = '',
    String totalSumOfActiveEnergyWithoutReverseBlocking = '',
    String t1SumOfActiveEnergyWithoutReverseBlocking = '',
    String t2SumOfActiveEnergyWithoutReverseBlocking = '',
    String t3SumOfActiveEnergyWithoutReverseBlocking = '',
    String t4SumOfActiveEnergyWithoutReverseBlocking = '',
    String totalPositiveReactiveEnergy = '',
    String t1PositiveReactiveEnergy = '',
    String t2PositiveReactiveEnergy = '',
    String t3PositiveReactiveEnergy = '',
    String t4PositiveReacctiveEnergy = '',
    String totalNegativeReactiveEnergy = '',
    String t1NegativeReactiveEnergy = '',
    String t2NegativeReactiveEnergy = '',
    String t3NegativeReactiveEnergy = '',
    String t4NegativeReactiveEnergy = '',
    String totalInductiveReactiveEnergyInQ1 = '',
    String t1InductiveReactiveEnergyInQ1 = '',
    String t2InductiveReactiveEnergyInQ1 = '',
    String t3InductiveReactiveEnergyInQ1 = '',
    String t4InductiveReactiveEnergyInQ1 = '',
    String totalCapacitiveReactiveEnergyInQ2 = '',
    String t1CapacitiveReactiveEnergyInQ2 = '',
    String t2CapacitiveReactiveEnergyInQ2 = '',
    String t3CapacitiveReactiveEnergyInQ2 = '',
    String t4CapacitiveReactiveEnergyInQ2 = '',
    String totalInductiveReactiveEnergyInQ3 = '',
    String t1InductiveReactiveEnergyInQ3 = '',
    String t2InductiveReactiveEnergyInQ3 = '',
    String t3InductiveReactiveEnergyInQ3 = '',
    String t4InductiveReactiveEnergyInQ3 = '',
    String totalCapacitiveReactiveEnergyInQ4 = '',
    String t1CapacitiveReactiveEnergyInQ4 = '',
    String t2CapacitiveReactiveEnergyInQ4 = '',
    String t3CapacitiveReactiveEnergyInQ4 = '',
    String t4CapacitiveReactiveEnergyInQ4 = '',
    String instantaneousCurrent = '',
    String instantaneousCurrentInPhase1 = '',
    String instantaneousCurrentInPhase2 = '',
    String instantaneousCurrentInPhase3 = '',
    String instantaneousCurrentInNeutro = '',
    String maxCurrent = '',
    String maxCurrentInPhase1 = '',
    String maxCurrentInPhase2 = '',
    String maxCurrentInPhase3 = '',
    String maxCurrentInNeutro = '',
    String instantaneousVoltage = '',
    String instantaneousVoltageInPhase1 = '',
    String instantaneousVoltageInPhase2 = '',
    String instantaneousVoltageInPhase3 = '',
    String instantaneousPowerFactor = '',
    String instantaneousPowerFactorInPhase1 = '',
    String instantaneousPowerFactorInPhase2 = '',
    String instantaneousPowerFactorInPhase3 = '',
    String frequency = '',
    String currentTime = '',
    String currentDate = '',
    String serie = '',
  }) {
    this.rx = RxIskraMt174(
      totalPositiveActiveEnergy: totalPositiveActiveEnergy.obs,
      t1PositiveActiveEnergy: t1PositiveActiveEnergy.obs,
      t2PositiveActiveEnergy: t2PositiveActiveEnergy.obs,
      t3PositiveActiveEnergy: t3PositiveActiveEnergy.obs,
      t4PositiveActiveEnergy: t4PositiveActiveEnergy.obs,
      totalNegativeActiveEnergy: totalNegativeActiveEnergy.obs,
      t1NegativeActiveEnergy: t1NegativeActiveEnergy.obs,
      t2NegativeActiveEnergy: t2NegativeActiveEnergy.obs,
      t3NegativeActiveEnergy: t3NegativeActiveEnergy.obs,
      t4NegativeActiveEnergy: t4NegativeActiveEnergy.obs,
      totalAbsoluteActiveEnergy: totalAbsoluteActiveEnergy.obs,
      t1AbsoluteActiveEnergy: t1AbsoluteActiveEnergy.obs,
      t2AbsoluteActiveEnergy: t2AbsoluteActiveEnergy.obs,
      t3AbsoluteActiveEnergy: t3AbsoluteActiveEnergy.obs,
      t4AbsoluteActiveEnergy: t4AbsoluteActiveEnergy.obs,
      totalSumOfActiveEnergyWithoutReverseBlocking:
          totalSumOfActiveEnergyWithoutReverseBlocking.obs,
      t1SumOfActiveEnergyWithoutReverseBlocking:
          t1SumOfActiveEnergyWithoutReverseBlocking.obs,
      t2SumOfActiveEnergyWithoutReverseBlocking:
          t2SumOfActiveEnergyWithoutReverseBlocking.obs,
      t3SumOfActiveEnergyWithoutReverseBlocking:
          t3SumOfActiveEnergyWithoutReverseBlocking.obs,
      t4SumOfActiveEnergyWithoutReverseBlocking:
          t4SumOfActiveEnergyWithoutReverseBlocking.obs,
      totalPositiveReactiveEnergy: totalPositiveReactiveEnergy.obs,
      t1PositiveReactiveEnergy: t1PositiveReactiveEnergy.obs,
      t2PositiveReactiveEnergy: t2PositiveReactiveEnergy.obs,
      t3PositiveReactiveEnergy: t3PositiveReactiveEnergy.obs,
      t4PositiveReacctiveEnergy: t4PositiveReacctiveEnergy.obs,
      totalNegativeReactiveEnergy: totalNegativeReactiveEnergy.obs,
      t1NegativeReactiveEnergy: t1NegativeReactiveEnergy.obs,
      t2NegativeReactiveEnergy: t2NegativeReactiveEnergy.obs,
      t3NegativeReactiveEnergy: t3NegativeReactiveEnergy.obs,
      t4NegativeReactiveEnergy: t4NegativeReactiveEnergy.obs,
      totalInductiveReactiveEnergyInQ1: totalInductiveReactiveEnergyInQ1.obs,
      t1InductiveReactiveEnergyInQ1: t1InductiveReactiveEnergyInQ1.obs,
      t2InductiveReactiveEnergyInQ1: t2InductiveReactiveEnergyInQ1.obs,
      t3InductiveReactiveEnergyInQ1: t3InductiveReactiveEnergyInQ1.obs,
      t4InductiveReactiveEnergyInQ1: t4InductiveReactiveEnergyInQ1.obs,
      totalCapacitiveReactiveEnergyInQ2: totalCapacitiveReactiveEnergyInQ2.obs,
      t1CapacitiveReactiveEnergyInQ2: t1CapacitiveReactiveEnergyInQ2.obs,
      t2CapacitiveReactiveEnergyInQ2: t2CapacitiveReactiveEnergyInQ2.obs,
      t3CapacitiveReactiveEnergyInQ2: t3CapacitiveReactiveEnergyInQ2.obs,
      t4CapacitiveReactiveEnergyInQ2: t4CapacitiveReactiveEnergyInQ2.obs,
      totalInductiveReactiveEnergyInQ3: totalInductiveReactiveEnergyInQ3.obs,
      t1InductiveReactiveEnergyInQ3: t1InductiveReactiveEnergyInQ3.obs,
      t2InductiveReactiveEnergyInQ3: t2InductiveReactiveEnergyInQ3.obs,
      t3InductiveReactiveEnergyInQ3: t3InductiveReactiveEnergyInQ3.obs,
      t4InductiveReactiveEnergyInQ3: t4InductiveReactiveEnergyInQ3.obs,
      totalCapacitiveReactiveEnergyInQ4: totalCapacitiveReactiveEnergyInQ4.obs,
      t1CapacitiveReactiveEnergyInQ4: t1CapacitiveReactiveEnergyInQ4.obs,
      t2CapacitiveReactiveEnergyInQ4: t2CapacitiveReactiveEnergyInQ4.obs,
      t3CapacitiveReactiveEnergyInQ4: t3CapacitiveReactiveEnergyInQ4.obs,
      t4CapacitiveReactiveEnergyInQ4: t4CapacitiveReactiveEnergyInQ4.obs,
      instantaneousCurrent: instantaneousCurrent.obs,
      instantaneousCurrentInPhase1: instantaneousCurrentInPhase1.obs,
      instantaneousCurrentInPhase2: instantaneousCurrentInPhase2.obs,
      instantaneousCurrentInPhase3: instantaneousCurrentInPhase3.obs,
      instantaneousCurrentInNeutro: instantaneousCurrentInNeutro.obs,
      maxCurrent: maxCurrent.obs,
      maxCurrentInPhase1: maxCurrentInPhase1.obs,
      maxCurrentInPhase2: maxCurrentInPhase2.obs,
      maxCurrentInPhase3: maxCurrentInPhase3.obs,
      maxCurrentInNeutro: maxCurrentInNeutro.obs,
      instantaneousVoltage: instantaneousVoltage.obs,
      instantaneousVoltageInPhase1: instantaneousVoltageInPhase1.obs,
      instantaneousVoltageInPhase2: instantaneousVoltageInPhase2.obs,
      instantaneousVoltageInPhase3: instantaneousVoltageInPhase3.obs,
      instantaneousPowerFactor: instantaneousPowerFactor.obs,
      instantaneousPowerFactorInPhase1: instantaneousPowerFactorInPhase1.obs,
      instantaneousPowerFactorInPhase2: instantaneousPowerFactorInPhase2.obs,
      instantaneousPowerFactorInPhase3: instantaneousPowerFactorInPhase3.obs,
      frequency: frequency.obs,
      currentTime: currentTime.obs,
      currentDate: currentDate.obs,
      serie: serie.obs,
    );
  }

  String get totalPositiveActiveEnergy =>
      this.rx.totalPositiveActiveEnergy.value;
  set totalPositiveActiveEnergy(String v) =>
      this.rx.totalPositiveActiveEnergy.value = v;

  String get t1PositiveActiveEnergy => this.rx.t1PositiveActiveEnergy.value;
  set t1PositiveActiveEnergy(String v) =>
      this.rx.t1PositiveActiveEnergy.value = v;

  String get t2PositiveActiveEnergy => this.rx.t2PositiveActiveEnergy.value;
  set t2PositiveActiveEnergy(String v) =>
      this.rx.t2PositiveActiveEnergy.value = v;

  String get t3PositiveActiveEnergy => this.rx.t3PositiveActiveEnergy.value;
  set t3PositiveActiveEnergy(String v) =>
      this.rx.t3PositiveActiveEnergy.value = v;

  String get t4PositiveActiveEnergy => this.rx.t4PositiveActiveEnergy.value;
  set t4PositiveActiveEnergy(String v) =>
      this.rx.t4PositiveActiveEnergy.value = v;

  String get totalNegativeActiveEnergy =>
      this.rx.totalNegativeActiveEnergy.value;
  set totalNegativeActiveEnergy(String v) =>
      this.rx.totalNegativeActiveEnergy.value = v;

  String get t1NegativeActiveEnergy => this.rx.t1NegativeActiveEnergy.value;
  set t1NegativeActiveEnergy(String v) =>
      this.rx.t1NegativeActiveEnergy.value = v;

  String get t2NegativeActiveEnergy => this.rx.t2NegativeActiveEnergy.value;
  set t2NegativeActiveEnergy(String v) =>
      this.rx.t2NegativeActiveEnergy.value = v;

  String get t3NegativeActiveEnergy => this.rx.t3NegativeActiveEnergy.value;
  set t3NegativeActiveEnergy(String v) =>
      this.rx.t3NegativeActiveEnergy.value = v;

  String get t4NegativeActiveEnergy => this.rx.t4NegativeActiveEnergy.value;
  set t4NegativeActiveEnergy(String v) =>
      this.rx.t4NegativeActiveEnergy.value = v;

  String get totalAbsoluteActiveEnergy =>
      this.rx.totalAbsoluteActiveEnergy.value;
  set totalAbsoluteActiveEnergy(String v) =>
      this.rx.totalAbsoluteActiveEnergy.value = v;

  String get t1AbsoluteActiveEnergy => this.rx.t1AbsoluteActiveEnergy.value;
  set t1AbsoluteActiveEnergy(String v) =>
      this.rx.t1AbsoluteActiveEnergy.value = v;

  String get t2AbsoluteActiveEnergy => this.rx.t2AbsoluteActiveEnergy.value;
  set t2AbsoluteActiveEnergy(String v) =>
      this.rx.t2AbsoluteActiveEnergy.value = v;

  String get t3AbsoluteActiveEnergy => this.rx.t3AbsoluteActiveEnergy.value;
  set t3AbsoluteActiveEnergy(String v) =>
      this.rx.t3AbsoluteActiveEnergy.value = v;

  String get t4AbsoluteActiveEnergy => this.rx.t4AbsoluteActiveEnergy.value;
  set t4AbsoluteActiveEnergy(String v) =>
      this.rx.t4AbsoluteActiveEnergy.value = v;

  String get totalSumOfActiveEnergyWithoutReverseBlocking =>
      this.rx.totalSumOfActiveEnergyWithoutReverseBlocking.value;
  set totalSumOfActiveEnergyWithoutReverseBlocking(String v) =>
      this.rx.totalSumOfActiveEnergyWithoutReverseBlocking.value = v;

  String get t1SumOfActiveEnergyWithoutReverseBlocking =>
      this.rx.t1SumOfActiveEnergyWithoutReverseBlocking.value;
  set t1SumOfActiveEnergyWithoutReverseBlocking(String v) =>
      this.rx.t1SumOfActiveEnergyWithoutReverseBlocking.value = v;

  String get t2SumOfActiveEnergyWithoutReverseBlocking =>
      this.rx.t2SumOfActiveEnergyWithoutReverseBlocking.value;
  set t2SumOfActiveEnergyWithoutReverseBlocking(String v) =>
      this.rx.t2SumOfActiveEnergyWithoutReverseBlocking.value = v;

  String get t3SumOfActiveEnergyWithoutReverseBlocking =>
      this.rx.t3SumOfActiveEnergyWithoutReverseBlocking.value;
  set t3SumOfActiveEnergyWithoutReverseBlocking(String v) =>
      this.rx.t3SumOfActiveEnergyWithoutReverseBlocking.value = v;

  String get t4SumOfActiveEnergyWithoutReverseBlocking =>
      this.rx.t4SumOfActiveEnergyWithoutReverseBlocking.value;
  set t4SumOfActiveEnergyWithoutReverseBlocking(String v) =>
      this.rx.t4SumOfActiveEnergyWithoutReverseBlocking.value = v;

  String get totalPositiveReactiveEnergy =>
      this.rx.totalPositiveReactiveEnergy.value;
  set totalPositiveReactiveEnergy(String v) =>
      this.rx.totalPositiveReactiveEnergy.value = v;

  String get t1PositiveReactiveEnergy => this.rx.t1PositiveReactiveEnergy.value;
  set t1PositiveReactiveEnergy(String v) =>
      this.rx.t1PositiveReactiveEnergy.value = v;

  String get t2PositiveReactiveEnergy => this.rx.t2PositiveReactiveEnergy.value;
  set t2PositiveReactiveEnergy(String v) =>
      this.rx.t2PositiveReactiveEnergy.value = v;

  String get t3PositiveReactiveEnergy => this.rx.t3PositiveReactiveEnergy.value;
  set t3PositiveReactiveEnergy(String v) =>
      this.rx.t3PositiveReactiveEnergy.value = v;

  String get t4PositiveReacctiveEnergy =>
      this.rx.t4PositiveReacctiveEnergy.value;
  set t4PositiveReacctiveEnergy(String v) =>
      this.rx.t4PositiveReacctiveEnergy.value = v;

  String get totalNegativeReactiveEnergy =>
      this.rx.totalNegativeReactiveEnergy.value;
  set totalNegativeReactiveEnergy(String v) =>
      this.rx.totalNegativeReactiveEnergy.value = v;

  String get t1NegativeReactiveEnergy => this.rx.t1NegativeReactiveEnergy.value;
  set t1NegativeReactiveEnergy(String v) =>
      this.rx.t1NegativeReactiveEnergy.value = v;

  String get t2NegativeReactiveEnergy => this.rx.t2NegativeReactiveEnergy.value;
  set t2NegativeReactiveEnergy(String v) =>
      this.rx.t2NegativeReactiveEnergy.value = v;

  String get t3NegativeReactiveEnergy => this.rx.t3NegativeReactiveEnergy.value;
  set t3NegativeReactiveEnergy(String v) =>
      this.rx.t3NegativeReactiveEnergy.value = v;

  String get t4NegativeReactiveEnergy => this.rx.t4NegativeReactiveEnergy.value;
  set t4NegativeReactiveEnergy(String v) =>
      this.rx.t4NegativeReactiveEnergy.value = v;

  String get totalInductiveReactiveEnergyInQ1 =>
      this.rx.totalInductiveReactiveEnergyInQ1.value;
  set totalInductiveReactiveEnergyInQ1(String v) =>
      this.rx.totalInductiveReactiveEnergyInQ1.value = v;

  String get t1InductiveReactiveEnergyInQ1 =>
      this.rx.t1InductiveReactiveEnergyInQ1.value;
  set t1InductiveReactiveEnergyInQ1(String v) =>
      this.rx.t1InductiveReactiveEnergyInQ1.value = v;

  String get t2InductiveReactiveEnergyInQ1 =>
      this.rx.t2InductiveReactiveEnergyInQ1.value;
  set t2InductiveReactiveEnergyInQ1(String v) =>
      this.rx.t2InductiveReactiveEnergyInQ1.value = v;

  String get t3InductiveReactiveEnergyInQ1 =>
      this.rx.t3InductiveReactiveEnergyInQ1.value;
  set t3InductiveReactiveEnergyInQ1(String v) =>
      this.rx.t3InductiveReactiveEnergyInQ1.value = v;

  String get t4InductiveReactiveEnergyInQ1 =>
      this.rx.t4InductiveReactiveEnergyInQ1.value;
  set t4InductiveReactiveEnergyInQ1(String v) =>
      this.rx.t4InductiveReactiveEnergyInQ1.value = v;

  String get totalCapacitiveReactiveEnergyInQ2 =>
      this.rx.totalCapacitiveReactiveEnergyInQ2.value;
  set totalCapacitiveReactiveEnergyInQ2(String v) =>
      this.rx.totalCapacitiveReactiveEnergyInQ2.value = v;

  String get t1CapacitiveReactiveEnergyInQ2 =>
      this.rx.t1CapacitiveReactiveEnergyInQ2.value;
  set t1CapacitiveReactiveEnergyInQ2(String v) =>
      this.rx.t1CapacitiveReactiveEnergyInQ2.value = v;

  String get t2CapacitiveReactiveEnergyInQ2 =>
      this.rx.t2CapacitiveReactiveEnergyInQ2.value;
  set t2CapacitiveReactiveEnergyInQ2(String v) =>
      this.rx.t2CapacitiveReactiveEnergyInQ2.value = v;

  String get t3CapacitiveReactiveEnergyInQ2 =>
      this.rx.t3CapacitiveReactiveEnergyInQ2.value;
  set t3CapacitiveReactiveEnergyInQ2(String v) =>
      this.rx.t3CapacitiveReactiveEnergyInQ2.value = v;

  String get t4CapacitiveReactiveEnergyInQ2 =>
      this.rx.t4CapacitiveReactiveEnergyInQ2.value;
  set t4CapacitiveReactiveEnergyInQ2(String v) =>
      this.rx.t4CapacitiveReactiveEnergyInQ2.value = v;

  String get totalInductiveReactiveEnergyInQ3 =>
      this.rx.totalInductiveReactiveEnergyInQ3.value;
  set totalInductiveReactiveEnergyInQ3(String v) =>
      this.rx.totalInductiveReactiveEnergyInQ3.value = v;

  String get t1InductiveReactiveEnergyInQ3 =>
      this.rx.t1InductiveReactiveEnergyInQ3.value;
  set t1InductiveReactiveEnergyInQ3(String v) =>
      this.rx.t1InductiveReactiveEnergyInQ3.value = v;

  String get t2InductiveReactiveEnergyInQ3 =>
      this.rx.t2InductiveReactiveEnergyInQ3.value;
  set t2InductiveReactiveEnergyInQ3(String v) =>
      this.rx.t2InductiveReactiveEnergyInQ3.value = v;

  String get t3InductiveReactiveEnergyInQ3 =>
      this.rx.t3InductiveReactiveEnergyInQ3.value;
  set t3InductiveReactiveEnergyInQ3(String v) =>
      this.rx.t3InductiveReactiveEnergyInQ3.value = v;

  String get t4InductiveReactiveEnergyInQ3 =>
      this.rx.t4InductiveReactiveEnergyInQ3.value;
  set t4InductiveReactiveEnergyInQ3(String v) =>
      this.rx.t4InductiveReactiveEnergyInQ3.value = v;

  String get totalCapacitiveReactiveEnergyInQ4 =>
      this.rx.totalCapacitiveReactiveEnergyInQ4.value;
  set totalCapacitiveReactiveEnergyInQ4(String v) =>
      this.rx.totalCapacitiveReactiveEnergyInQ4.value = v;

  String get t1CapacitiveReactiveEnergyInQ4 =>
      this.rx.t1CapacitiveReactiveEnergyInQ4.value;
  set t1CapacitiveReactiveEnergyInQ4(String v) =>
      this.rx.t1CapacitiveReactiveEnergyInQ4.value = v;

  String get t2CapacitiveReactiveEnergyInQ4 =>
      this.rx.t2CapacitiveReactiveEnergyInQ4.value;
  set t2CapacitiveReactiveEnergyInQ4(String v) =>
      this.rx.t2CapacitiveReactiveEnergyInQ4.value = v;

  String get t3CapacitiveReactiveEnergyInQ4 =>
      this.rx.t3CapacitiveReactiveEnergyInQ4.value;
  set t3CapacitiveReactiveEnergyInQ4(String v) =>
      this.rx.t3CapacitiveReactiveEnergyInQ4.value = v;

  String get t4CapacitiveReactiveEnergyInQ4 =>
      this.rx.t4CapacitiveReactiveEnergyInQ4.value;
  set t4CapacitiveReactiveEnergyInQ4(String v) =>
      this.rx.t4CapacitiveReactiveEnergyInQ4.value = v;

  String get instantaneousCurrent => this.rx.instantaneousCurrent.value;
  set instantaneousCurrent(String v) => this.rx.instantaneousCurrent.value = v;

  String get instantaneousCurrentInPhase1 =>
      this.rx.instantaneousCurrentInPhase1.value;
  set instantaneousCurrentInPhase1(String v) =>
      this.rx.instantaneousCurrentInPhase1.value = v;

  String get instantaneousCurrentInPhase2 =>
      this.rx.instantaneousCurrentInPhase2.value;
  set instantaneousCurrentInPhase2(String v) =>
      this.rx.instantaneousCurrentInPhase2.value = v;

  String get instantaneousCurrentInPhase3 =>
      this.rx.instantaneousCurrentInPhase3.value;
  set instantaneousCurrentInPhase3(String v) =>
      this.rx.instantaneousCurrentInPhase3.value = v;

  String get instantaneousCurrentInNeutro =>
      this.rx.instantaneousCurrentInNeutro.value;
  set instantaneousCurrentInNeutro(String v) =>
      this.rx.instantaneousCurrentInNeutro.value = v;

  String get maxCurrent => this.rx.maxCurrent.value;
  set maxCurrent(String v) => this.rx.maxCurrent.value = v;

  String get maxCurrentInPhase1 => this.rx.maxCurrentInPhase1.value;
  set maxCurrentInPhase1(String v) => this.rx.maxCurrentInPhase1.value = v;

  String get maxCurrentInPhase2 => this.rx.maxCurrentInPhase2.value;
  set maxCurrentInPhase2(String v) => this.rx.maxCurrentInPhase2.value = v;

  String get maxCurrentInPhase3 => this.rx.maxCurrentInPhase3.value;
  set maxCurrentInPhase3(String v) => this.rx.maxCurrentInPhase3.value = v;

  String get maxCurrentInNeutro => this.rx.maxCurrentInNeutro.value;
  set maxCurrentInNeutro(String v) => this.rx.maxCurrentInNeutro.value = v;

  String get instantaneousVoltage => this.rx.instantaneousVoltage.value;
  set instantaneousVoltage(String v) => this.rx.instantaneousVoltage.value = v;

  String get instantaneousVoltageInPhase1 =>
      this.rx.instantaneousVoltageInPhase1.value;
  set instantaneousVoltageInPhase1(String v) =>
      this.rx.instantaneousVoltageInPhase1.value = v;

  String get instantaneousVoltageInPhase2 =>
      this.rx.instantaneousVoltageInPhase2.value;
  set instantaneousVoltageInPhase2(String v) =>
      this.rx.instantaneousVoltageInPhase2.value = v;

  String get instantaneousVoltageInPhase3 =>
      this.rx.instantaneousVoltageInPhase3.value;
  set instantaneousVoltageInPhase3(String v) =>
      this.rx.instantaneousVoltageInPhase3.value = v;

  String get instantaneousPowerFactor => this.rx.instantaneousPowerFactor.value;
  set instantaneousPowerFactor(String v) =>
      this.rx.instantaneousPowerFactor.value = v;

  String get instantaneousPowerFactorInPhase1 =>
      this.rx.instantaneousPowerFactorInPhase1.value;
  set instantaneousPowerFactorInPhase1(String v) =>
      this.rx.instantaneousPowerFactorInPhase1.value = v;

  String get instantaneousPowerFactorInPhase2 =>
      this.rx.instantaneousPowerFactorInPhase2.value;
  set instantaneousPowerFactorInPhase2(String v) =>
      this.rx.instantaneousPowerFactorInPhase2.value = v;

  String get instantaneousPowerFactorInPhase3 =>
      this.rx.instantaneousPowerFactorInPhase3.value;
  set instantaneousPowerFactorInPhase3(String v) =>
      this.rx.instantaneousPowerFactorInPhase3.value = v;

  String get frequency => this.rx.frequency.value;
  set frequency(String v) => this.rx.frequency.value = v;

  String get currentTime => this.rx.currentTime.value;
  set currentTime(String v) => this.rx.currentTime.value = v;

  String get currentDate => this.rx.currentDate.value;
  set currentDate(String v) => this.rx.currentDate.value = v;

  String get serie => this.rx.serie.value;
  set serie(String v) => this.rx.serie.value = v;
}
