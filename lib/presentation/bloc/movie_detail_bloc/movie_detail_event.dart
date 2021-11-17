part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovies extends MovieDetailEvent {
  final int id;

  FetchDetailMovies(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchListMovie extends MovieDetailEvent {
  final MovieDetail movie;

  AddWatchListMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchListMovie extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveWatchListMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadStatusWatchlistMovie extends MovieDetailEvent {
  final int id;
  LoadStatusWatchlistMovie(this.id);

  @override
  List<Object> get props => [id];
}
