part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchEvent {
  final String query;
  final FilmType type;

  OnQueryChanged(this.query, this.type);

  @override
  List<Object> get props => [query, type];
}
