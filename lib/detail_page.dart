import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'widgets/svg_asset.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = 1;
    double screenHeight = 1;
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66*  screenHeight,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28*  screenHeight),
                  child: Hero(
                  tag: "sleepMeditation",
                    child: Material(
                      color: Colors.transparent,
                      child: Text("Sleep Meditation",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34*  screenHeight,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10*  screenHeight,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28*  screenHeight),
                  child: Text(
                    "Best practice meditations",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16*  screenHeight),
                  ),
                ),
                SizedBox(height: 25*  screenHeight),
                SizedBox(
                  height: 279*  screenHeight,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 28*  screenHeight),
                      Container(
                        height: 280*  screenHeight,
                        width: 280*  screenHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/pics/pic1.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20*  screenHeight),
                      Container(
                        height: 280*  screenHeight,
                        width: 280*  screenHeight,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/pics/pic2.jpg",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 32*  screenHeight),
                Padding(
                  padding: EdgeInsets.only(left: 28*  screenHeight),
                  child: Row(
                    children: [
                      Container(
                        height: 56*  screenHeight,
                        width: 56*  screenHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                            child: SvgAsset(
                                assetName: AssetName.headphone,
                                height: 28*  screenHeight,
                                width: 28*  screenHeight)),
                      ),
                      SizedBox(width: 16*  screenHeight),
                      Container(
                        height: 56*  screenHeight,
                        width: 56*  screenHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                            child: SvgAsset(
                                assetName: AssetName.tape,
                                height: 28*  screenHeight,
                                width: 28*  screenHeight)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 46*  screenHeight),
                Padding(
                  padding: EdgeInsets.only(left: 28*  screenHeight, right: 28*  screenHeight, bottom: 80*  screenHeight),
                  child: Text(
                    "Meditation is a practice where an individual uses a technique – such as mindfulness, or focusing their mind on a particular object, thought or activity – to train attention and awareness, and achieve a mentally clear and emotionally calm and stable state. Scholars have found meditation difficult to define, as practices vary both between traditions and within them.",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16*  screenHeight),
                  ),
                )
              ],
            ),

            Align(alignment: Alignment.topCenter,
            child:   Container(
              color:  Color(0xff121421),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 22*  screenHeight,
                  right: 22*  screenHeight,
                  top: 20*  screenHeight,
                  bottom: 10*  screenHeight
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        onTap: onBackIconTapped,
                        child: Container(
                          height: 35*  screenHeight,
                          width: 35*  screenHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: SvgAsset(
                              assetName: AssetName.back,
                              height: 20*  screenHeight,
                              width: 20*  screenHeight,
                            ),
                          ),
                        ),
                      ),


                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        onTap: onHeartIconTapped,
                        child: Container(
                          height: 35*  screenHeight,
                          width: 35*  screenHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: SvgAsset(
                              assetName: AssetName.heart,
                              height: 24*  screenHeight,
                              width: 24*  screenHeight,
                              color: isHeartIconTapped! ? Colors.red: Colors.white,
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ),
              ),
            )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87*  screenHeight,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                    stops: [0,1],
                    colors: [
                      Color(0xff121421),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  )
                ),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onStartButtonPressed,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(0xff4A80F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 56*  screenHeight,
                          width: 319*  screenHeight,
                          child: Center(child: Text("Start", style: TextStyle(fontSize: 16*  screenHeight, fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  void onStartButtonPressed() {

  }

  void onBackIconTapped() {
   Get.back();
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }
}
