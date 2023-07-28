import 'package:get/get_rx/get_rx.dart';

class RxDeviceBluetoot {
  final RxString errorSetDeviceName, errorSetNewPassword, errorSetOldPassword;

  RxDeviceBluetoot(
      {this.errorSetDeviceName,
      this.errorSetNewPassword,
      this.errorSetOldPassword});
}

class ModelDeviceBluetooth {
  RxDeviceBluetoot rx;
  String setDeviceName, setNewPassword, setOldPassword;

  ModelDeviceBluetooth(
      {this.setDeviceName = '',
      String errorSetDeviceName,
      this.setNewPassword = '',
      this.setOldPassword = '',
      String errorSetNewPassword,
      String errorSetOldPassword
    }) {
    this.rx = RxDeviceBluetoot(
        errorSetDeviceName: errorSetDeviceName.obs,
        errorSetNewPassword: errorSetNewPassword.obs,
        errorSetOldPassword: errorSetOldPassword.obs
        );
  }

  String get errorSetDeviceName => this.rx.errorSetDeviceName.value;
  set errorSetDeviceName(String v) => this.rx.errorSetDeviceName.value = v;

  String get errorSetNewPassword => this.rx.errorSetNewPassword.value;
  set errorSetNewPassword(String v) => this.rx.errorSetNewPassword.value = v;

  String get errorSetOldPassword => this.rx.errorSetOldPassword.value;
  set errorSetOldPassword(String v) => this.rx.errorSetOldPassword.value = v;
}
