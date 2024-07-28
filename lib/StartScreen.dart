import 'package:ahafeeth_ai_app/home_page.dart';
import 'package:ahafeeth_ai_app/provider/AnalyticsProvider.dart';
import 'package:ahafeeth_ai_app/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Fatawa/FatwaSearch.dart';
import 'Fatawa/SheikhGPT.dart';
import 'icons.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: SvgAsset(
            assetName: AssetName.discover,
            height: 24,
            width: 24,
            color: Color(0xff121421),
          ),
          onPressed: () {
            Get.to(() => ChatScreen(), transition: Transition.rightToLeft);
            AnalyticProvider.track("SheikhGPTPressed");
          },
          label: Text("إسأل شيخGPT", style: TextStyle(fontSize: 18),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 32),
              Text(
                'AI in Islam',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => SearchScreen(), transition: Transition.rightToLeft);
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0), // Adjust the roundness as needed
                            child: Image.asset(
                              'assets/aiImages/fatwa.jpeg', // Replace with your image URL
                              width: 200, // Adjust the width
                              height: 200, // Adjust the height
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'فتاوى إسلامية',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    InkWell(
                      onTap: () {
                        Get.to(() => HomePage(), transition: Transition.rightToLeft);
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0), // Adjust the roundness as needed
                            child: Image.asset(
                              'assets/aiImages/hadith.jpeg', // Replace with your image URL
                              width: 200, // Adjust the width
                              height: 200, // Adjust the height
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'أحاديث رياض الصالحين',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
