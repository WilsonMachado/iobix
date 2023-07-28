import 'package:dio/dio.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/instance_manager.dart';

import '../../../modules/bluetooth/bluetooth_controller.dart';
import '../../constants/constants.dart';

import '../../../data/providers/remote/network_api.dart';
import '../../../data/repositories/remote/network_repository.dart';
import '../../../data/providers/local/local_remember_login.dart';
import '../../../data/repositories/local/local_remember_login_repository.dart';

class DependencyInjection {
  static void init() {
    // Global instances

    // Storage
    Get.put(FlutterSecureStorage());
    
    // Bluetooth
    Get.put(FlutterBluePlus.instance);
    Get.put(BluetoothController());
    // RestApi
    Get.put(Dio(BaseOptions(
        baseUrl: CONSTANTS.BACKEND_API_BASEURL,
        connectTimeout: 5000,
        receiveTimeout: 5000)));

    // Providers
    Get.lazyPut<NetworkAPI>(() => NetworkAPI(), fenix: true);
    Get.lazyPut<LocalRememberLogin>(() => LocalRememberLogin(), fenix: true);

    // Repositories
    Get.lazyPut<NetworkRepository>(() => NetworkRepository(), fenix: true);
    Get.lazyPut<LocalRememberLoginRepository>(() => LocalRememberLoginRepository(), fenix: true);

  }
}
