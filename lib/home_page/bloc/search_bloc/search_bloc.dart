import 'package:bloc/bloc.dart';
import 'package:bpm_finder/home_page/data/models/track.dart';
import 'package:bpm_finder/home_page/data/repositories/recent_searches_repository.dart';
import 'package:bpm_finder/home_page/data/repositories/spotify_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

@lazySingleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SpotifyRepository spotifyRepository;
  final RecentSearchesRepository recentSearchesRepository;

  SearchBloc({
    required this.spotifyRepository,
    required this.recentSearchesRepository,
  }) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is PerformSearch) {
        emit(SearchLoading());

        final result = await spotifyRepository.searchTracks(event.input);
        recentSearchesRepository.saveRecentSearch(event.input);

        emit(SearchResults(tracks: result));
      }
    });
  }

  // void _performSearch(Emitter<SearchState> emit, String input) async {
  //   emit(SearchLoading());

  //   final result = await repository.searchTracks(input);

  //   emit(SearchResults(tracks: result));
  // }
}
