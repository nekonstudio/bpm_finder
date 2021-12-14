import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocalStorage {
  final Box box;

  static const _recentSearchesKey = 'recent_searches';

  LocalStorage({
    required this.box,
  });

  void saveRecentSearches(List<String> values) {
    box.put(_recentSearchesKey, values);
  }

  List<String> getRecentSearches() {
    return box.get(_recentSearchesKey, defaultValue: <String>[]);
  }
}
