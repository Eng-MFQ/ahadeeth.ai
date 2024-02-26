import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'ApiProvider.dart';

class FavoriteManager {
  static const String _key = 'favoriteList';

  // Get the list of favorite objects from SharedPreferences
  static Future<List<Hadeeth>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_key);

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Hadeeth.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  // Add an object to the list of favorites
  static Future<void> addToFavorites(Hadeeth object) async {
    List<Hadeeth> favorites = await getFavorites();
    favorites.add(object);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString =
        jsonEncode(favorites.map((obj) => obj.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  bool isHadeethFavorite(List<Hadeeth> favoriteList, int hadeethId) {
    return favoriteList.any((hadeeth) => hadeeth.id == hadeethId);
  }
}
