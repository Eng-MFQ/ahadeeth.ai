import 'package:ahafeeth_ai_app/provider/UserProvider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'language.dart';

abstract class AppLocalizations {
  static Language of(BuildContext context) {
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context);
    return localeProvider.isArabic ? Arabic() : English();
  }
}
