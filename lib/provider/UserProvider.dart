import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  late Locale locale = Locale("ar");
  bool isArabic = true;

  void setLocale(bool ar) {
    isArabic = ar;
    locale = Locale(ar ? "ar" : "en");
    notifyListeners();
  }
  LocaleProvider.init(ar) {
    setLocale(ar);
  }
}
