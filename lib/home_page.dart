import 'package:ahafeeth_ai_app/FavouriteAhadeethScreen.dart';
import 'package:ahafeeth_ai_app/discover_page_old.dart';
import 'package:ahafeeth_ai_app/provider/AnalyticsProvider.dart';
import 'package:ahafeeth_ai_app/widgets/AboutUs.dart';
import 'package:ahafeeth_ai_app/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AhadeethScreen.dart';
import 'discover_page.dart';
import 'icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static getRoute() => PageRouteBuilder(
      opaque: false,
      transitionsBuilder: (_, animation, secondAnimation, child) {
        return FadeTransition(
          opacity: animation,
        );
      },
      pageBuilder: (_, __, ___) {
        return new HomePage();
      });
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    DiscoverPage(),
    FavouriteAhadeethScreen(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      //0- Hadeeth, 1- Fav, 2- aboutUs
      AnalyticProvider.track("TapPressed", properties: {"tabPressed": index});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> detectAndSaveLanguage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isArabic = await prefs.getBool("isArabic");
    if (isArabic == null) {
      Locale currentLocale = Localizations.localeOf(context);
      if (currentLocale.languageCode == 'ar') {
        isArabic = true;
        await prefs.setBool('isArabic', true);
      } else {
        isArabic = false;
        await prefs.setBool('isArabic', false);
      }
    }
    return isArabic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book_outlined,
                color: Colors.white38,
              ),
              label: '',
              tooltip: 'أحاديث',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff4A80F0).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: Icon(
                  Icons.menu_book_outlined,
                  color: Colors.greenAccent,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.white38),
              label: '',
              tooltip: 'أحاديث مفضلة',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff4A80F0).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: Icon(Icons.favorite, color: Colors.greenAccent),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info, color: Colors.white38),
              label: '',
              tooltip: 'عن التطبيق',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff4A80F0).withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: Icon(Icons.info, color: Colors.greenAccent),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          backgroundColor: Color(0xff1C2031),
        ),
      ),
    );
  }
}
