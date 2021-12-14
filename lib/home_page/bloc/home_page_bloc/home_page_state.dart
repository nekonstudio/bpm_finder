part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class TopTracksPage extends HomePageState {}

class RecentSearchsPage extends HomePageState {}

class FavoritesPage extends HomePageState {}

class SearchResultsPage extends HomePageState {
  final String searchPhrase;

  const SearchResultsPage({
    required this.searchPhrase,
  });

  @override
  List<Object> get props => [searchPhrase];
}

class TrackDetailsPage extends HomePageState {
  final Track track;

  const TrackDetailsPage({
    required this.track,
  });

  @override
  List<Object> get props => [track];
}
