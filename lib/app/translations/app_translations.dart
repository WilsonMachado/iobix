import 'en_US/en_us_translations.dart';
import 'es_CO/es_co_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = 
  {
    'es_CO': esCo,
    'en_US' : enUs
  };
}