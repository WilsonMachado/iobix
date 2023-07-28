import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../utils/constants/ble_api/ble_general_commands.dart';

class RxDeviceMemory {
  final RxInt logType, dataType;
  final RxString errordataType;

  final Rx<DateTime> readInitDate, readFinishDate;

  final RxBool isReadData, isDataFound, isDataNotFound;
  final RxInt counterFrames;

  RxDeviceMemory(
      {this.logType,
      this.dataType,
      this.errordataType,
      this.readInitDate,
      this.readFinishDate,
      this.isReadData,
      this.isDataFound,
      this.isDataNotFound,
      this.counterFrames});
}

class ModelDeviceMemory {
  RxDeviceMemory rx;
  List<List<int>> logsExtracted = [];

  DateTime logsGetDate;

  ModelDeviceMemory(
      {int logType = BLE_GENERAL_CMDS.READ_LOGSYS,
      int dataType,
      String errordataType,
      @required DateTime readInitDate,
      @required DateTime readFinishDate,
      bool isReadData = false,
      bool isDataFound = false,
      bool isDataNotFound = false,
      int counterFrames = 0}) {
    this.rx = RxDeviceMemory(
      logType: logType.obs,
      dataType: dataType.obs,
      errordataType: errordataType.obs,
      readInitDate: readInitDate.obs,
      readFinishDate: readFinishDate.obs,
      isReadData: isReadData.obs,
      isDataFound: isDataFound.obs,
      isDataNotFound: isDataNotFound.obs,
      counterFrames: counterFrames.obs
    );
  }
  bool get isReadData => this.rx.isReadData.value;
  set isReadData(bool v) => this.rx.isReadData.value = v;

  bool get isDataFound => this.rx.isDataFound.value;
  set isDataFound(bool v) => this.rx.isDataFound.value = v;

  bool get isDataNotFound => this.rx.isDataNotFound.value;
  set isDataNotFound(bool v) => this.rx.isDataNotFound.value = v;

  int get counterFrames => this.rx.counterFrames.value;
  set counterFrames(int v) => this.rx.counterFrames.value = v;

  DateTime get readInitDate => this.rx.readInitDate.value;
  set readInitDate(DateTime v) => this.rx.readInitDate.value = v;

  DateTime get readFinishDate => this.rx.readFinishDate.value;
  set readFinishDate(DateTime v) => this.rx.readFinishDate.value = v;

  String get errordataType => this.rx.errordataType.value;
  set errordataType(String v) => this.rx.errordataType.value = v;

  int get logType => this.rx.logType.value;
  set logType(int v) => this.rx.logType.value = v;

  int get dataType => this.rx.dataType.value;
  set dataType(int v) => this.rx.dataType.value = v;
}
