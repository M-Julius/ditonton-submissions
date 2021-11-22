part of 'home_movie_bloc.dart';

abstract class HomeMovieEvent extends Equatable {
  const HomeMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieList extends HomeMovieEvent {
  const FetchMovieList();

  @override
  List<Object> get props => [];
}
