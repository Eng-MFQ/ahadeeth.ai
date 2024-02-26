import 'dart:math';

import 'package:ahafeeth_ai_app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static shareTextToSocialMedia(
      String? title, String? hadeeth, shareText, header) {
    String text = "$header \n\n $title \n\n$hadeeth";
    String url =
        'https://play.google.com/store/apps/details?id=com.whilelearn.ahadeeth.ai';
    String urlInfor = '${shareText} $url';
    String fullText = '$text\n\n$urlInfor';
    Share.share(fullText);
  }

  static Widget loadingView(BuildContext context,
      {bool isSearch = false, showLoading = true, String? text}) {
    List<String> search = [
      "assets/aiImages/search1.png",
      "assets/aiImages/search2.png",
    ];
    List<String> connect = [
      "assets/aiImages/connect1.png",
      "assets/aiImages/connect2.png",
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
              isSearch
                  ? search[Random().nextInt(search.length)]
                  : connect[Random().nextInt(connect.length)],
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text ?? AppLocalizations.of(context).loading,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              if (showLoading)
                CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> launchUrlFunction(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> openEmail(String emailAddress) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (!await launchUrl(_emailLaunchUri)) {
      throw Exception('Could not connect email');
    }
  }
}
