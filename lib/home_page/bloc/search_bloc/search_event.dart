part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class PerformSearch extends SearchEvent {
  final String input;

  const PerformSearch({
    required this.input,
  });
}
