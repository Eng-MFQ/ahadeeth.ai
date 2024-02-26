import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AppLocalization {
  static getLocalizedText(BuildContext context, String label) =>
      Intl.message(label);
}
