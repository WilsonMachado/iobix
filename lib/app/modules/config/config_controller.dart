import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  RxString _currentLanguage = Get.locale.languageCode.obs;
  String get currentLanguage => _currentLanguage.value;

  void changeLanguage(String languageCode) {
    Locale locale = new Locale(languageCode);

    Get.updateLocale(locale);
    _currentLanguage.value = languageCode;
  }
}
