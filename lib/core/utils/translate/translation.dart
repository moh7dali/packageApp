import 'package:get/get.dart';

import '../../../mozaic_loyalty_sdk.dart';
import 'ar.dart';
import 'en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'ar': ar};
}

extension MozaicTranslate on String {
  String get sdkTr {
    if (appLanguage == 'ar') {
      return ar[this] ?? this;
    } else {
      return en[this] ?? this;
    }
  }
}
