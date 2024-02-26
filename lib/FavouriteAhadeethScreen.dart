import 'dart:math';

import 'package:ahafeeth_ai_app/provider/ApiProvider.dart';
import 'package:ahafeeth_ai_app/provider/FavoriteManage.dart';
import 'package:ahafeeth_ai_app/provider/SharedPrefProvider.dart';
import 'package:ahafeeth_ai_app/provider/UserProvider.dart';
import 'package:ahafeeth_ai_app/widgets/discover_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/styles.dart';
import 'localization/app_localizations.dart';

class FavouriteAhadeethScreen extends StatefulWidget {
  FavouriteAhadeethScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteAhadeethScreen> createState() =>
      _FavouriteAhadeethScreenState();
}

class _FavouriteAhadeethScreenState extends State<FavouriteAhadeethScreen> {
  List<Hadeeth> hadeethList = [];
  late LocaleProvider localeProvider;
  late SharedPrefProvider sharedPrefProvider;

  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    sharedPrefProvider = Provider.of<SharedPrefProvider>(context);
    hadeethList = sharedPrefProvider.hadeethList;
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
          backgroundColor: const Color(0xff121421),
          title: Text(
            AppLocalizations.of(context).favTitle,
            style: TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          )),
      body: sharedPrefProvider.hadeethList.isEmpty
          ? emptyView()
          : buildListView(),
    );
  }

  Widget emptyView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.asset(
                'assets/aiImages/fav.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              AppLocalizations.of(context).fav,
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  ListView buildListView() {
    print("sharedPrefProvider.hadeethList.length");
    print(sharedPrefProvider.hadeethList.length);
    var color =
        Style.myGradientColors[Random().nextInt(Style.myGradientColors.length)];
    return ListView.builder(
      itemCount: hadeethList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: HadeethCard(
            hadeethList[index],
            gradientStartColor: color["gradientStartColor"],
            gradientEndColor: color["gradientEndColor"],
            title: localeProvider.isArabic
                ? hadeethList[index].titleArGpt4
                : hadeethList[index].titleEn,
            subtitle: localeProvider.isArabic
                ? hadeethList[index].matinAr
                : hadeethList[index].matinEn,
          ),
        );
      },
    );
  }
}
