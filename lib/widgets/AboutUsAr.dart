import 'package:flutter/cupertino.dart';
import 'package:ahafeeth_ai_app/constants/Utils.dart';
import 'package:ahafeeth_ai_app/constants/styles.dart';
import 'package:ahafeeth_ai_app/widgets/AboutUsAr.dart';
import 'package:ahafeeth_ai_app/widgets/discover_card_stub.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/AnalyticsProvider.dart';
class AboutUsAR extends StatelessWidget {
  const AboutUsAR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
          backgroundColor: const Color(0xff121421),
          title: Text(
            "عن التطبيق",
            style: TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'هذا التطبيق تم صنعه إحتساباً لوجه الله، وهو مقدم من شركة Whilelearn',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 21.0),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'من نحن؟',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'شركة Whilelearn هي شركة متخصصة في صنع تطبيقات الذكاء الإصطناعي ويندرج تحتها:',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Center(
              child: AppCard(
                subtitle:
                'حيث نقوم بربط أي موقع إلكتروني مع عقل ChatGPT وتوظيفه كخدمة عملاء. بالإضافة إلى تحسين البحث بالمواقع عن طريق إضافة البحث المتخصص بالذكاء الإصطناعي.',
                title: 'Whilelearn GPT',
                btnText: "قم بزيارة الموقع",
                btnUrl: "https://www.whilelearn.com",
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: AppCard(
                subtitle:
                'لتعليم الذكاء الإصطناعي للتقنيين وغير التقنيين، وتتضمن دورات تعليم بناي التطبيقات بإستخدام الذكاء الإصطناعي و ChatGPT و أيضا تدريب الشركات والموظفين بإستخدام الذكاء الإصطناعي الإنتاجي الحديث.',
                title: 'أكاديمية Whilelearn',
                btnText: "قم بزيارة الأكاديمية",
                btnUrl: "https://www.whilelearn.academy",
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'للمهتمين في التطوير',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'بإمكانك تحميل ال Dataset التي تحتوي على جميع الأحاديث من خلال الرابط الآتي:',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            Center(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50)),
                label: Text(
                  'Dataset in Kaggle'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.greenAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
                icon: FaIcon(FontAwesomeIcons.link),
                onPressed: () {
                  Utils.launchUrlFunction(
                      "https://www.kaggle.com/datasets/muwaffaqimam/riyad-al-saliheen-book-of-hadith");
                  AnalyticProvider.track("DatasetClicked");
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'ويوجد API مجانية لكل من يحب إضافة البحث بالأحاديث في تطبيقه، الرجاء التواصل معنا من خلال السوشال ميديا او من خلال الإيميل:',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            Center(
              child: TextButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50)),
                child: Text(
                  'muwaffaq@whilelearn.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.greenAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  Utils.openEmail("muwaffaq@whilelearn.com");
                  AnalyticProvider.track("SendMailClicked");
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'شكر وتقدير',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'هذا التطبيق تم صنعه تكميلا لعمل الأخ الذي صنع ملف جيسون يحتوي كامل الأحاديث باللغتين العربية والإنجليزية ( كل الشكر لمن قام بالعمل).\n بإمكانك إيجاد هذه الملفات من خلال الرابط:',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Center(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50)),
                label: Text(
                  'Hadeeth API'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.greenAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
                icon: FaIcon(FontAwesomeIcons.link),
                onPressed: () {
                  Utils.launchUrlFunction(
                      "https://github.com/A7med3bdulBaset/hadith-json");
                  AnalyticProvider.track("HadeethJsonClicked");
                },
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 16,
            ),
            Text("تواصل معنا",
                style: TextStyle(fontSize: 21, color: Colors.white)),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSocialMediaTile('Whatsapp', 'http://wa.me/+962781959591',
                    FontAwesomeIcons.whatsapp, Colors.green),
                buildSocialMediaTile(
                    'instagram',
                    'https://www.instagram.com/muwaffaqimam.ai',
                    FontAwesomeIcons.instagram,
                    null),
                buildSocialMediaTile(
                    'youtube',
                    'https://www.youtube.com/@ProfessorMuwaffaq',
                    FontAwesomeIcons.youtube,
                    Colors.redAccent),
                buildSocialMediaTile(
                    'linkedin',
                    'https://www.linkedin.com/in/muwaffaqimamai',
                    FontAwesomeIcons.linkedin,
                    Colors.blueAccent),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSocialMediaTile(String title, String url, IconData icon, color) {
    return InkWell(
      onTap: () {
        Utils.launchUrlFunction(url);
        AnalyticProvider.track("contactUsClicked",
            properties: {"SocialMedia": title});
      },
      child: CircleAvatar(
        radius: 35,
        child: FaIcon(
          icon,
          size: 32.0,
          color: color,
        ),
      ),
    );
  }
}
