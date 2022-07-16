import 'package:get/get.dart';
import 'package:varcore_flutter_base/core/localization/languages/english.dart';
import 'package:varcore_flutter_base/core/localization/languages/indonesian.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'id': id,
      };
}
