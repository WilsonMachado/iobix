import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../data/models/local/model_login.dart';
import '../../data/repositories/local/local_remember_login_repository.dart';

class LoginController extends GetxController {
  // Global Instances
  final LocalRememberLoginRepository _localRememberLoginRepository =
      Get.find<LocalRememberLoginRepository>();

  // Local
  RxString _notify = ''.obs;
  String get notify => _notify.value;
  RxBool _rememberMe = false.obs;
  bool get rememberMe => _rememberMe.value;

  String user = '', password = '';
  RxBool _hidePassword = true.obs;
  bool get hidePassword => _hidePassword.value;

  @override
  void onInit() {
    _getRememberLoginData();
    super.onInit();
  }

  void onChangedUser(String text) => user = text.replaceAll(' ', '');
  void onChangedPassword(String text) => password = text.replaceAll(' ', '');
  void onChangedPasswordVisibility() =>
      _hidePassword.value = !_hidePassword.value;

  void onChangedRememberMe(bool v) {
    _rememberMe.value = !_rememberMe.value;
  }

  Future<void> _getRememberLoginData() async {
    try {
      List<String> data =
          await _localRememberLoginRepository.getRememberLoginData;
      user = data[0];
      password = data[1];

      if (data[0].length > 0) {
        _rememberMe.value = true;
        update(['login']);
      }
    } catch (e) {}
  }

  Future<void> login() async {
    _notify.value = '';

    if (ModelLogin.login(user, password)) {
      try {
        if (_rememberMe.value) {
          await _localRememberLoginRepository.setRememberLoginData(
              user, password);
        } else {
          await _localRememberLoginRepository.clearRememberLoginData();
        }
      } catch (e) {}

      Get.offNamed(AppRoutes.HOME);
    } else
      _notify.value = 'check_user';
  }
}
