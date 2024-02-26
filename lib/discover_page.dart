import 'dart:math';

import 'package:ahafeeth_ai_app/AhadeethScreen.dart';
import 'package:ahafeeth_ai_app/provider/AnalyticsProvider.dart';
import 'package:ahafeeth_ai_app/provider/UserProvider.dart';
import 'package:ahafeeth_ai_app/widgets/SearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';
import 'constants/styles.dart';
import 'detail_page.dart';
import 'localization/app_localizations.dart';
import 'widgets/category_boxes.dart';
import 'icons.dart';
import 'widgets/discover_card.dart';
import 'widgets/discover_small_card.dart';
import 'widgets/svg_asset.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late LocaleProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<LocaleProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = 1;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: SvgAsset(
            assetName: AssetName.search,
            height: 24,
            width: 24,
            color: Color(0xff121421),
          ),
          onPressed: () {
            Get.to(() => SearchScreen(), transition: Transition.rightToLeft);
            AnalyticProvider.track("AiSearchFabPressed");
          },
          label: Text(AppLocalizations.of(context).search_ai)),
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28,
                right: 18,
                top: 36,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).appTitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: changeLanguage,
                    child: Container(
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context).lang.toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.translate, color: Colors.greenAccent),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).labelChapters,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Consumer<LocaleProvider>(
                builder: (_, provider, child) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 16,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...Constants().chapters.map((e) {
                        Map<String, Color> color = Style.myGradientColors[
                            Random().nextInt(Style.myGradientColors.length)];
                        return InkWell(
                          onTap: () {
                            Get.to(() => AhadeethScreen(e),
                                transition: Transition.rightToLeft);
                            AnalyticProvider.track("ChapterPressed",
                                properties: {"Chapter": e["arabic"]});
                          },
                          child: DiscoverSmallCard(
                            image: e["image"],
                            title:
                                provider.isArabic ? e["arabic"] : e["english"],
                            gradientStartColor: color["gradientStartColor"],
                            gradientEndColor: color["gradientEndColor"],
                          ),
                        );
                      }).toList(),
                      Container(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSeeAllTapped() {}

  void onSleepMeditationTapped() {
    Get.to(() => DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {}

  void changeLanguage() {
    provider.setLocale(!provider.isArabic);
    AnalyticProvider.track("changeLanguage",
        properties: {"isArabic": provider.isArabic});
  }
}
