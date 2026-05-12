import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String favoritesKey = 'favorites';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(favoritesKey);

    return data ?? [];
  }

  static Future<void> toggleFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(favoritesKey) ?? [];

    if (favorites.contains(title)) {
      favorites.remove(title);
    } else {
      favorites.add(title);
    }

    await prefs.setStringList(favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String title) async {
    final favorites = await getFavorites();

    return favorites.contains(title);
  }
}
