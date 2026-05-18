import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
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

  static Future<void> removeHistory(String title) async {
    final box = await Hive.openBox('history_box');

    final current = await getHistory();

    current.removeWhere((item) => item.title == title);

    final updated = current
        .map((e) => {'title': e.title, 'category': e.category})
        .toList();

    await box.put('history', updated);
  }
}
