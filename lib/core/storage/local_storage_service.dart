import 'package:hive/hive.dart';

class LocalStorageService {
  static const String notesBox = 'notes_box';

  static const String bookmarksBox = 'bookmarks_box';

  // =========================
  // NOTES
  // =========================

  static Future<void> saveNote(String note) async {
    final box = await Hive.openBox(notesBox);

    final List existing = box.get('notes', defaultValue: []);

    existing.add(note);

    await box.put('notes', existing);
  }

  static Future<List<String>> getNotes() async {
    final box = await Hive.openBox(notesBox);

    final List notes = box.get('notes', defaultValue: []);

    return notes.cast<String>();
  }

  // =========================
  // BOOKMARK
  // =========================

  static Future<void> saveBookmark(bool value) async {
    final box = await Hive.openBox(bookmarksBox);

    await box.put('bookmark', value);
  }

  static Future<bool> getBookmark() async {
    final box = await Hive.openBox(bookmarksBox);

    return box.get('bookmark', defaultValue: false);
  }
}
