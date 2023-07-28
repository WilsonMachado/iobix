import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LocalRememberLogin {
  static const USER_KEY = 'user';
  static const PASSWORD_KEY = 'password';

  final FlutterSecureStorage _storage = Get.find<FlutterSecureStorage>();

  Future<void> setRememberLoginData(String user, password) async {
    await _storage.write(key: USER_KEY, value: user);
    await _storage.write(key: PASSWORD_KEY, value: password);
  }

  Future<void> clearRememberLoginData() async {
    await _storage.delete(key: USER_KEY);
    await _storage.delete(key: PASSWORD_KEY);
  }

  Future<List<String>> getRememberLoginData() async {
    final String user = await _storage.read(key: USER_KEY);
    final String password = await _storage.read(key: PASSWORD_KEY);

    return user != null && password != null ? [user, password]: ['',''];
  }
}
