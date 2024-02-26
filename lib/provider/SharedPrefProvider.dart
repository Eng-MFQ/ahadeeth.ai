import 'dart:convert';
import 'package:ahafeeth_ai_app/provider/FavoriteManage.dart';
import 'package:flutter/foundation.dart';
import 'ApiProvider.dart'; // Replace with the actual path to your Hadeeth class

class SharedPrefProvider extends ChangeNotifier {
  List<Hadeeth> _hadeethList = [];

  List<Hadeeth> get hadeethList => _hadeethList;

  Future<void> loadFavoritesHadeeth() async {
    _hadeethList = await FavoriteManager.getFavorites();
    notifyListeners();
  }

  // Add a Hadeeth to favorites
  Future<void> addToFavorites(Hadeeth hadeeth) async {
    await FavoriteManager.addToFavorites(hadeeth);
    hadeethList.add(hadeeth);
    notifyListeners();
  }

  SharedPrefProvider.init() {
    loadFavoritesHadeeth();
  }
}
