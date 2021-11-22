import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';
import 'package:movie/domain/usecase/get_watchlist_status.dart';
import 'package:movie/domain/usecase/remove_watchlist.dart';
import 'package:movie/domain/usecase/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchDetailMovies>(_fetchDetailMovies);
    on<AddWatchListMovie>(_addWatchlist);
    on<RemoveWatchListMovie>(_removeWatchlist);
    on<LoadStatusWatchlistMovie>(_loadStatusWatchlist);
  }

  Future<void> _fetchDetailMovies(event, emit) async {
    emit(state.copyWith(movieDetailState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(event.id);

    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    detailResult.fold(
      (failure) async {
        emit(state.copyWith(
          movieDetailState: RequestState.Error,
          message: failure.message,
        ));
      },
      (movie) async {
        emit(state.copyWith(
          movieRecommendationState: RequestState.Loading,
          movieDetail: movie,
          movieDetailState: RequestState.Loaded,
          message: '',
        ));
        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              movieRecommendationState: RequestState.Error,
              message: failure.message,
            ));
          },
          (movies) {
            emit(state.copyWith(
              movieRecommendationState: RequestState.Loaded,
              movieRecommendations: movies,
              message: '',
            ));
          },
        );
      },
    );
  }

  Future<void> _addWatchlist(event, emit) async {
    final result = await saveWatchlist.execute(event.movie);

    result.fold((failure) {
      emit(state.copyWith(watchlistMessage: failure.message));
    }, (successMessage) {
      emit(state.copyWith(watchlistMessage: successMessage));
    });
    add(LoadStatusWatchlistMovie(event.movie.id));
  }

  Future<void> _removeWatchlist(event, emit) async {
    final result = await removeWatchlist.execute(event.movie);

    result.fold((failure) {
      emit(state.copyWith(watchlistMessage: failure.message));
    }, (successMessage) {
      emit(state.copyWith(watchlistMessage: successMessage));
    });
    add(LoadStatusWatchlistMovie(event.movie.id));
  }

  Future<void> _loadStatusWatchlist(event, emit) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
