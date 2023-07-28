import 'package:get/get_rx/get_rx.dart';

class RxDeviceInformation {
  final RxString developer,
      info,
      firmware,
      getId,
      errorSetId,
      apiBleVersion,
      setAutomaticID,
      errorSetAutomaticID;

  RxDeviceInformation(
      {this.developer,
      this.info,
      this.firmware,
      this.getId,
      this.errorSetId,
      this.apiBleVersion,
      this.errorSetAutomaticID,
      this.setAutomaticID});
}

class ModelDeviceInformation {
  RxDeviceInformation rx;
  String setId;

  ModelDeviceInformation({
    String developer = 'Colbits',
    String info = 'unknown',
    String firmware = 'v0.0.0',
    String getId = '0000000000000000',
    this.setId = '',
    String errorSetId,
    String apiBleVersion = 'unknown',
    String setAutomaticID,
    String errorSetAutomaticID,

    ///! Se deben definir así los Strings que van a indicar los errores en los InpuTextField, si se inicializa como '', cuenta como String y el InputTextField se pondrá del color de un error, lo que podría confundir a un usuario.
  }) {
    this.rx = RxDeviceInformation(
      developer: developer.obs,
      info: info.obs,
      firmware: firmware.obs,
      getId: getId.obs,
      errorSetId: errorSetId.obs,
      apiBleVersion: apiBleVersion.obs,
      setAutomaticID: setAutomaticID.obs,
      errorSetAutomaticID: errorSetAutomaticID.obs,
    );
  }

  String get developer => this.rx.developer.value;
  set developer(String v) => this.rx.developer.value = v;

  String get info => this.rx.info.value;
  set info(String v) => this.rx.info.value = v;

  String get firmware => this.rx.firmware.value;
  set firmware(String v) => this.rx.firmware.value = v;

  String get getId => this.rx.getId.value;
  set getId(String v) => this.rx.getId.value = v;

  String get errorSetId => this.rx.errorSetId.value;
  set errorSetId(String v) => this.rx.errorSetId.value = v;

  String get apiBleVersion => this.rx.apiBleVersion.value;
  set apiBleVersion(String v) => this.rx.apiBleVersion.value = v;

  String get setAutomaticID => this.rx.setAutomaticID.value;
  set setAutomaticID(String v) => this.rx.setAutomaticID.value = v;

  String get errorSetAutomaticID => this.rx.errorSetAutomaticID.value;
  set errorSetAutomaticID(String v) => this.rx.errorSetAutomaticID.value = v;
}
