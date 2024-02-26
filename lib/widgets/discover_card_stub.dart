import 'package:ahafeeth_ai_app/constants/Utils.dart';
import 'package:ahafeeth_ai_app/provider/ApiProvider.dart';
import 'package:ahafeeth_ai_app/provider/FavoriteManage.dart';
import 'package:ahafeeth_ai_app/provider/SharedPrefProvider.dart';
import 'package:ahafeeth_ai_app/provider/UserProvider.dart';
import 'package:ahafeeth_ai_app/widgets/svg_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/styles.dart';
import '../icons.dart';
import '../localization/app_localizations.dart';
import '../provider/AnalyticsProvider.dart';
import 'ExpandableText.dart';

class AppCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final String? tag;
  final String? btnText;
  final String? btnUrl;

  const AppCard(
      {Key? key,
      this.title,
      this.subtitle,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.onTap,
      this.tag,
      this.btnText,
      this.btnUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = 1;
    double screenHeight = 1;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap!(),
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                gradientStartColor ?? Color(0xff441DFC),
                gradientEndColor ?? Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: tag ?? '',
                            child: Material(
                              color: Colors.transparent,
                              child: Center(
                                child: Text(
                                  title!,
                                  style: TextStyle(
                                      fontSize: 22 * screenWidth,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8 * screenHeight,
                          ),
                          ExpandableText(
                            subtitle!,
                            style: TextStyle(
                                fontSize: 18 * screenWidth,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      if (btnText != null)
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                backgroundColor: Colors.greenAccent),
                            onPressed: () {
                              Utils.launchUrlFunction(btnUrl!);
                              AnalyticProvider.track("WhilelearnVisited",
                                  properties: {
                                    "Url": btnUrl!.contains("academy")
                                        ? "Academy"
                                        : "GPT"
                                  });
                            },
                            child: Text(
                              btnText!,
                              style: TextStyle(
                                  color: Style.primaryColor, fontSize: 16.0),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
