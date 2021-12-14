import 'package:bloc/bloc.dart';
import 'package:bpm_finder/home_page/data/models/track.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:stack/stack.dart';

part 'home_page_state.dart';

@singleton
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(TopTracksPage()) {
    // _stateStack.push(TopTracksPage());
  }

  final _stateStack = Stack<HomePageState>();

  void showTopTracksPage() {
    if (_stateStack.isNotEmpty) {
      _stateStack.pop();
    }
    _pushCurrentStateToStack();
    emit(TopTracksPage());
  }

  void showRecentSearchsPage() {
    _pushCurrentStateToStack();

    emit(RecentSearchsPage());
  }

  void showSearchResultsPage(String searchPhrase) {
    if (state is! SearchResultsPage) {
      _pushCurrentStateToStack();
      emit(SearchResultsPage(searchPhrase: searchPhrase));
    }
  }

  void showTrackDetailsPage(Track track) {
    _pushCurrentStateToStack();
    emit(TrackDetailsPage(track: track));
  }

  void showFavoritesPage() {
    if (_stateStack.isNotEmpty) {
      _stateStack.pop();
    }
    _pushCurrentStateToStack();
    emit(FavoritesPage());
  }

  void backToPreviousPage() {
    if (_stateStack.isNotEmpty) {
      final previousState = _stateStack.pop();
      emit(previousState);
    }
  }

  void _pushCurrentStateToStack() {
    print('Current state: $state');
    print('Stack size: ${_stateStack.size()}');
    _stateStack.push(state);
  }
}
