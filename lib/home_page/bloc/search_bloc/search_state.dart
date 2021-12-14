part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResults extends SearchState {
  final List<Track> tracks;

  SearchResults({
    required this.tracks,
  });

  @override
  List<Object?> get props => [tracks];
}
