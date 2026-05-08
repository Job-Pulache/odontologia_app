import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String favoritesKey = 'favorite_documents';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(favoritesKey) ?? [];
  }

  static Future<void> toggleFavorite(String documentId) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(favoritesKey) ?? [];

    if (favorites.contains(documentId)) {
      favorites.remove(documentId);
    } else {
      favorites.add(documentId);
    }

    await prefs.setStringList(favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String documentId) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(favoritesKey) ?? [];

    return favorites.contains(documentId);
  }
}
