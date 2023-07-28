import 'package:get/route_manager.dart';

import 'app_routes.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_page.dart';
import '../modules/home/home_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/device/device_page.dart';
import '../modules/device/device_binding.dart';
import '../modules/config/config_binding.dart';
import '../modules/config/config_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.HOME,
        page: () => HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.DEVICE,
        page: () => DevicePage(),
        binding: DeviceBinding()),
    GetPage(
        name: AppRoutes.CONFIG,
        page: () => ConfigPage(),
        binding: ConfigBinding()),
  ];
}
