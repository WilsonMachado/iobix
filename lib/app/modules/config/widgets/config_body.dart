import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config_controller.dart';
import '../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../utils/constants/constants.dart';

class ConfigBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfigController>(
        builder: (_) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: Column(
                children: [
                  CustomDropdown<String>(
                      showSetButton: false,
                      floatingLabel: 'language'.tr,
                      hintText: 'select'.tr,
                      itemsMap: Map.fromIterable(CONSTANTS.LANGUAGES.keys,
                          key: (k) => k,
                          value: (v) => CONSTANTS.LANGUAGES[v].tr),
                      onChanged: (code) => _.changeLanguage(code),
                      value: CONSTANTS.LANGUAGES[_.currentLanguage].tr,
                      dropdownTitle: 'select'.tr,
                      dropdownSubtitle: 'select_lang'.tr,
                      errorText: null)
                ],
              ),
            ));
  }
}
