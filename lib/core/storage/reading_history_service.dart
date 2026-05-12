import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReadingHistoryService {
  static const String historyKey = 'reading_history';

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(historyKey);

    if (data == null) return [];

    return List<String>.from(jsonDecode(data));
  }

  static Future<void> addToHistory(String title) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> history = await getHistory();

    history.remove(title);

    history.insert(0, title);

    if (history.length > 20) {
      history = history.take(20).toList();
    }

    await prefs.setString(historyKey, jsonEncode(history));
  }
}
