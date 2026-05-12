import '../../features/favorites/domain/entities/favorite_item.dart';

class FavoriteService {
  static final List<FavoriteItem> _favorites = [];

  static Future<void> toggleFavorite(String title, String category) async {
    final exists = _favorites.any((e) => e.title == title);

    if (exists) {
      _favorites.removeWhere((e) => e.title == title);
    } else {
      _favorites.add(FavoriteItem(title: title, category: category));
    }
  }

  static Future<bool> isFavorite(String title) async {
    return _favorites.any((e) => e.title == title);
  }

  static List<FavoriteItem> getFavorites() {
    return _favorites;
  }
}
