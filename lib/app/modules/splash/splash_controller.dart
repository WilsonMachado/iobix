import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  //Global Instances

  //Local
  RxInt _currentPage = 0.obs;
  int get currentPage => _currentPage.value;
  RxBool _isContinue = false.obs;
  bool get isContinue => _isContinue.value;

  List<Map<String, String>> splashData = [
    {'text': 'splash_page_1', 'image': 'assets/images/splash/welcome.jpg'},
    {'text': 'splash_page_2', 'image': 'assets/images/splash/ble_devices.jpg'},
    {
      'text': 'splash_page_3',
      'image': 'assets/images/splash/config_devices.jpg'
    }
  ];

  void onPageChanged(int index) {
    _currentPage.value = index;
    if (index == 2 && !_isContinue.value) _isContinue.value = true;
  }

  void continueButton() {
    Get.offNamed(AppRoutes.LOGIN);
  }
}
