import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iobix/app/gsheet_api_keys/abp_sheet_api.dart';

import 'app/modules/splash/splash_binding.dart';
import 'app/modules/splash/splash_page.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'app/utils/helpers/dependency_injection/dependency_injection.dart';
import 'app/translations/app_translations.dart';

AbpSheetApi gsheet = AbpSheetApi();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  gsheet.init();
  gsheet.setWorkSpreadSheet(0);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      initialBinding: SplashBinding(),
      home: SplashPage(),
      translationsKeys: AppTranslation.translations,
      locale: Get.deviceLocale,
      fallbackLocale: Locale('es', 'CO'),
    );
  }
}
