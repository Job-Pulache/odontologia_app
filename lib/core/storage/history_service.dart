import '../../features/history/domain/entities/history_item.dart';

class HistoryService {
  static final List<HistoryItem> _history = [];

  static void addHistory(HistoryItem item) {
    _history.removeWhere((e) => e.title == item.title);

    _history.insert(0, item);
  }

  static List<HistoryItem> getHistory() {
    return _history;
  }
}
