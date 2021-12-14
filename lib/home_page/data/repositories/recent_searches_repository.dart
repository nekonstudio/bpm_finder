import 'package:bpm_finder/home_page/data/sources/local_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecentSearchesRepository {
  final LocalStorage storage;

  const RecentSearchesRepository({
    required this.storage,
  });

  void saveRecentSearch(String value) {
    const maxHistoryLength = 10;
    const firstIndex = 0;

    final recentSearches = getRecentSearches()
        .take(maxHistoryLength - 1)
        .toList()
      ..insert(firstIndex, value);

    storage.saveRecentSearches(recentSearches);
  }

  List<String> getRecentSearches() {
    return storage.getRecentSearches();
  }
}
