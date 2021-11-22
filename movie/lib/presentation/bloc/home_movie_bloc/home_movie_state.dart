part of 'home_movie_bloc.dart';

class HomeMovieState extends Equatable {
  final List<Movie> moviesPopular;
  final RequestState moviesPopularState;
  final List<Movie> moviesNowPlaying;
  final RequestState moviesNowPlayingState;
  final List<Movie> moviesTopRated;
  final RequestState moviesTopRatedState;

  const HomeMovieState({
    required this.moviesPopular,
    required this.moviesPopularState,
    required this.moviesNowPlaying,
    required this.moviesNowPlayingState,
    required this.moviesTopRated,
    required this.moviesTopRatedState,
  });

  HomeMovieState copyWith({
    List<Movie>? moviesPopular,
    RequestState? moviesPopularState,
    List<Movie>? moviesNowPlaying,
    RequestState? moviesNowPlayingState,
    List<Movie>? moviesTopRated,
    RequestState? moviesTopRatedState,
  }) {
    return HomeMovieState(
      moviesPopular: moviesPopular ?? this.moviesPopular,
      moviesPopularState: moviesPopularState ?? this.moviesPopularState,
      moviesNowPlaying: moviesNowPlaying ?? this.moviesNowPlaying,
      moviesNowPlayingState:
          moviesNowPlayingState ?? this.moviesNowPlayingState,
      moviesTopRated: moviesTopRated ?? this.moviesTopRated,
      moviesTopRatedState: moviesTopRatedState ?? this.moviesTopRatedState,
    );
  }

  factory HomeMovieState.initial() => const HomeMovieState(
        moviesNowPlaying: [],
        moviesNowPlayingState: RequestState.Empty,
        moviesPopular: [],
        moviesPopularState: RequestState.Empty,
        moviesTopRated: [],
        moviesTopRatedState: RequestState.Empty,
      );

  @override
  List<Object> get props => [
        moviesNowPlaying,
        moviesNowPlayingState,
        moviesPopular,
        moviesPopularState,
        moviesTopRated,
        moviesTopRatedState,
      ];
}
