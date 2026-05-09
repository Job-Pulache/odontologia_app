import 'package:shared_preferences/shared_preferences.dart';

class DocumentStorageService {
  static const favoritesKey = 'favorites_documents';
  static const downloadsKey = 'downloads_documents';

  // ===============================
  // FAVORITES
  // ===============================

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(favoritesKey) ?? [];
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

  // ===============================
  // DOWNLOADS
  // ===============================

  static Future<List<String>> getDownloads() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(downloadsKey) ?? [];
  }

  static Future<void> toggleDownload(String title) async {
    final prefs = await SharedPreferences.getInstance();

    final downloads = prefs.getStringList(downloadsKey) ?? [];

    if (downloads.contains(title)) {
      downloads.remove(title);
    } else {
      downloads.add(title);
    }

    await prefs.setStringList(downloadsKey, downloads);
  }
}
