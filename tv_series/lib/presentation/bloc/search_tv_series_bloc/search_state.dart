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

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataTvSeries extends SearchState {
  final List<TvSeries> result;

  const SearchHasDataTvSeries(this.result);

  @override
  List<Object> get props => [result];
}
