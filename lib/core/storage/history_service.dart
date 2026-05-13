import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'history_item.dart';

class HistoryService {
  static const String key = 'history_documents';

  static Future<void> addHistory(String title, String category) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key) ?? [];

    final item = HistoryItem(title: title, category: category);

    data.insert(0, jsonEncode(item.toJson()));

    await prefs.setStringList(key, data);
  }

  static Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key) ?? [];

    return data.map((e) {
      return HistoryItem.fromJson(jsonDecode(e));
    }).toList();
  }
}
