import 'package:get/get.dart';

import '../../providers/local/local_remember_login.dart';

class LocalRememberLoginRepository {
  final LocalRememberLogin _localRememberLogin = Get.find<LocalRememberLogin>();

  Future<void> setRememberLoginData(String user, password) =>
      _localRememberLogin.setRememberLoginData(user, password);
  Future<void> clearRememberLoginData() =>
      _localRememberLogin.clearRememberLoginData();
  Future<List<String>> get getRememberLoginData =>
      _localRememberLogin.getRememberLoginData();
}