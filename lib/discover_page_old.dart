import 'package:ahafeeth_ai_app/provider/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'detail_page.dart';
import 'localization/app_localizations.dart';
import 'widgets/category_boxes.dart';
import 'icons.dart';
import 'widgets/discover_card.dart';
import 'widgets/discover_small_card.dart';
import 'widgets/svg_asset.dart';

class DiscoverPageOld extends StatefulWidget {
  const DiscoverPageOld({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPageOld> createState() => _DiscoverPageOldState();
}

class _DiscoverPageOldState extends State<DiscoverPageOld> {
  late LocaleProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<LocaleProvider>(context);
    double screenWidth = 1;
    double screenHeight = 1;
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28 * screenWidth,
                right: 18 * screenWidth,
                top: 36 * screenHeight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discover",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34 * screenWidth,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    borderRadius: BorderRadius.circular(360),
                    onTap: onSearchIconTapped,
                    child: Container(
                      height: 35 * screenWidth,
                      width: 35 * screenWidth,
                      child: Center(
                        child: SvgAsset(
                          assetName: AssetName.search,
                          height: 24 * screenWidth,
                          width: 24 * screenWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120 * screenHeight,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 28 * screenWidth,
                  ),
                  CategoryBoxes(
                    text: "Insomnia",
                  ),
                  CategoryBoxes(
                    text: "Depression",
                  ),
                  CategoryBoxes(
                    text: "Baby Sleep",
                  ),
                  CategoryBoxes(
                    text: "Insomnia",
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28 * screenWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).labelChapters,
                    style: TextStyle(
                        color: Color(0xff515979),
                        fontWeight: FontWeight.w500,
                        fontSize: 14 * screenWidth),
                  ),
                  GestureDetector(
                      onTap: onSeeAllTapped,
                      child: Text("See All",
                          style: TextStyle(
                              color: Color(0xff4A80F0),
                              fontWeight: FontWeight.w500,
                              fontSize: 14 * screenWidth)))
                ],
              ),
            ),

            SizedBox(
              height: 16 * screenHeight,
            ),
            SizedBox(
              height: 176 * screenWidth,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 28 * screenWidth),
                  // HadeethCard(
                  //   tag: "sleepMeditation",
                  //   onTap: onSleepMeditationTapped,
                  //   title: "Sleep Meditation",
                  //   subtitle: "7 Day Audio and Video Series",
                  // ),
                  SizedBox(width: 20 * screenWidth),
                  // HadeethCard(
                  //   onTap: onDepressionHealingTapped,
                  //   title: "Depression Healing",
                  //   subtitle: "10 Days Audio and Video Series",
                  //   gradientStartColor: Color(0xffFC67A7),
                  //   gradientEndColor: Color(0xffF6815B),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 28 * screenHeight),
            Padding(
              padding: EdgeInsets.only(left: 28 * screenWidth),
              child: Text(
                "Recent",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * screenWidth),
              ),
            ),
            SizedBox(height: 16 * screenHeight),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28 * screenWidth),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 19 * screenWidth,
                    mainAxisExtent: 125 * screenWidth,
                    mainAxisSpacing: 19 * screenWidth),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Calming Sounds",
                    gradientStartColor: Color(0xff13DEA0),
                    gradientEndColor: Color(0xff06B782),
                  ),
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Insomnia",
                    gradientStartColor: Color(0xffFC67A7),
                    gradientEndColor: Color(0xffF6815B),
                    icon: SvgAsset(
                      assetName: AssetName.tape,
                      height: 24 * screenWidth,
                      width: 24 * screenWidth,
                    ),
                  ),
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "For Children",
                    gradientStartColor: Color(0xffFFD541),
                    gradientEndColor: Color(0xffF0B31A),
                  ),
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Tips For Sleeping",
                    icon: SvgAsset(
                      assetName: AssetName.tape,
                      height: 24 * screenWidth,
                      width: 24 * screenWidth,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSeeAllTapped() {

  }

  void onSleepMeditationTapped() {
    Get.to(() => DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {}

  void onSearchIconTapped() {}
}
