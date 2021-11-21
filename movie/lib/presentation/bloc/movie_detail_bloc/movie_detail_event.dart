part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovies extends MovieDetailEvent {
  final int id;

  const FetchDetailMovies(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchListMovie extends MovieDetailEvent {
  final MovieDetail movie;

  const AddWatchListMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchListMovie extends MovieDetailEvent {
  final MovieDetail movie;

  const RemoveWatchListMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadStatusWatchlistMovie extends MovieDetailEvent {
  final int id;
  const LoadStatusWatchlistMovie(this.id);

  @override
  List<Object> get props => [id];
}
