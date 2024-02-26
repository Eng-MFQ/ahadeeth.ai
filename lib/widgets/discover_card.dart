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

import '../icons.dart';
import '../localization/app_localizations.dart';
import '../provider/AnalyticsProvider.dart';
import 'ExpandableText.dart';

class HadeethCard extends StatelessWidget {
  final Hadeeth hadeeth;
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

  const HadeethCard(this.hadeeth,
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
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPrefProvider sharedPrefProvider =
        Provider.of<SharedPrefProvider>(context);
    LocaleProvider localProvider = Provider.of<LocaleProvider>(context);
    String shareText = AppLocalizations.of(context).shareText;
    String shareHeader = AppLocalizations.of(context).shareHeader;
    double screenWidth = 1;
    double screenHeight = 1;
    bool hadeethExsist = FavoriteManager()
        .isHadeethFavorite(sharedPrefProvider.hadeethList, hadeeth.id);
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
            width: 305 * screenWidth,
            child: Stack(
              children: [
                if (hadeethExsist)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: localProvider.isArabic
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Icon(
                          Icons.favorite,
                        )),
                  ),
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
                              child: Text(
                                title!,
                                style: TextStyle(
                                    fontSize: 22 * screenWidth,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8 * screenHeight,
                          ),
                          ExpandableText(
                            "... ${subtitle!}",
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
                      Row(
                        children: [
                          TextButton.icon(
                            icon: Icon(
                              Icons.share,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Utils.shareTextToSocialMedia(title,
                                  hadeeth.hadeeth, shareText, shareHeader);
                              AnalyticProvider.track("SharePressed");
                            },
                          ),
                          if (!hadeethExsist)
                            TextButton.icon(
                              icon: Icon(
                                Icons.favorite,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                sharedPrefProvider.addToFavorites(hadeeth);
                                AnalyticProvider.track("addToFavoritesPressed");
                              },
                              label: Text(
                                "",
                                // AppLocalizations.of(context).addToFavourite.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          TextButton.icon(
                            icon: Icon(
                              Icons.info,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _showPopup(
                                  context,
                                  localProvider.isArabic
                                      ? hadeeth.sanadAr
                                      : hadeeth.sanadEn);
                              AnalyticProvider.track("showSanadPressed");
                            },
                            label: Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
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

  void _showPopup(BuildContext context, String sanad) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).sanadTitle,
              style: TextStyle(fontSize: 21)),
          content: Text(
            sanad,
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }
}
