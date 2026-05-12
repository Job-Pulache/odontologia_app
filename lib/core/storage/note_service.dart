import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NoteService {
  static const String notesKey = 'reader_notes';

  static Future<List<String>> getNotes(String documentTitle) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('$notesKey-$documentTitle');

    if (data == null) return [];

    return List<String>.from(jsonDecode(data));
  }

  static Future<void> saveNotes(
    String documentTitle,
    List<String> notes,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('$notesKey-$documentTitle', jsonEncode(notes));
  }
}
