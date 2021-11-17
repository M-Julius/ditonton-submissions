part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataMovies extends SearchState {
  final List<Movie> result;

  SearchHasDataMovies(this.result);

  @override
  List<Object> get props => [result];
}

class SearchHasDataTvSeries extends SearchState {
  final List<TvSeries> result;

  SearchHasDataTvSeries(this.result);

  @override
  List<Object> get props => [result];
}
