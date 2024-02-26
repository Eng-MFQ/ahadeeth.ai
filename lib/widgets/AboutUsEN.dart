import 'package:flutter/cupertino.dart';
import 'package:ahafeeth_ai_app/constants/Utils.dart';
import 'package:ahafeeth_ai_app/widgets/discover_card_stub.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/AnalyticsProvider.dart';

class AboutUsEN extends StatelessWidget {
  const AboutUsEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
          backgroundColor: const Color(0xff121421),
          title: Text(
            "About the App",
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
                'This app was made for the sake of Allah and is brought to you by Whilelearn Company',
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
                  'Who Are We?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Whilelearn is a company specialized in creating artificial intelligence applications, including:',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Center(
              child: AppCard(
                subtitle:
                    'Where we connect any website with the ChatGPT mind and employ it as a customer service. In addition to improving website search by adding artificial intelligence specialized search.',
                title: 'Whilelearn GPT',
                btnText: "Visit Website",
                btnUrl: "https://www.whilelearn.com",
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: AppCard(
                subtitle:
                    'For teaching artificial intelligence to both technical and non-technical individuals, it includes courses in building applications using artificial intelligence and ChatGPT. Also, training companies and employees using modern productive artificial intelligence.',
                title: 'Whilelearn Academy',
                btnText: "Visit Academy",
                btnUrl: "https://www.whilelearn.academy",
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'For Developers',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'You can download the dataset containing all the Ahadeeth through the following link:',
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
              'And there is a free API for anyone who wants to add search for Ahadeeth in their application. Please contact us through social media or email:',
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
              'Acknowledgement',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'This app was created as a complement to the work of the brother who created a JSON file containing all the Ahadeeth in both Arabic and English (thanks to whoever did the work). You can find these files through the link:',
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
            Text("Contact Us",
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
                    'Instagram',
                    'https://www.instagram.com/muwaffaqimam.ai',
                    FontAwesomeIcons.instagram,
                    null),
                buildSocialMediaTile(
                    'YouTube',
                    'https://www.youtube.com/@ProfessorMuwaffaq',
                    FontAwesomeIcons.youtube,
                    Colors.redAccent),
                buildSocialMediaTile(
                    'LinkedIn',
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
