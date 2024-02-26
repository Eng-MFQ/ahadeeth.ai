import 'package:ahafeeth_ai_app/widgets/AboutUsEN.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../provider/UserProvider.dart';
import 'AboutUsAr.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return value.isArabic ? AboutUsAR() : AboutUsEN();
      },
    );
  }
}
