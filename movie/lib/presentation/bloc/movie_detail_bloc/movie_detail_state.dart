part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail movieDetail;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const MovieDetailState({
    required this.movieDetail,
    required this.movieDetailState,
    required this.movieRecommendations,
    required this.movieRecommendationState,
    required this.isAddedToWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  factory MovieDetailState.initial() => const MovieDetailState(
        movieDetail: MovieDetail(
          adult: false,
          backdropPath: '',
          genres: [],
          id: 0,
          originalTitle: '',
          overview: '',
          posterPath: '',
          releaseDate: '',
          runtime: 0,
          title: '',
          voteAverage: 0.0,
          voteCount: 0,
        ),
        movieDetailState: RequestState.Empty,
        movieRecommendations: [],
        movieRecommendationState: RequestState.Empty,
        isAddedToWatchlist: false,
        message: '',
        watchlistMessage: '',
      );

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationState:
          movieRecommendationState ?? this.movieRecommendationState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
        movieDetail,
        movieDetailState,
        movieRecommendationState,
        movieRecommendations,
        isAddedToWatchlist,
        message,
        watchlistMessage
      ];
}
