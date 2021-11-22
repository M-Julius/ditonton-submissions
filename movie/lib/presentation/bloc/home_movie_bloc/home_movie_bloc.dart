import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';

part 'home_movie_event.dart';
part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  HomeMovieBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(HomeMovieState.initial()) {
    on<FetchMovieList>(_fetchMovieList);
  }

  Future<void> _fetchMovieList(event, emit) async {
    emit(state.copyWith(
      moviesNowPlayingState: RequestState.Loading,
      moviesPopularState: RequestState.Loading,
      moviesTopRatedState: RequestState.Loading,
    ));

    final result = await getNowPlayingMovies.execute();
    final resultPopular = await getPopularMovies.execute();
    final resultTopRated = await getTopRatedMovies.execute();

    result.fold((failure) async {
      emit(state.copyWith(moviesNowPlayingState: RequestState.Error));
    }, (data) async {
      emit(state.copyWith(
        moviesNowPlayingState: RequestState.Loaded,
        moviesNowPlaying: data,
      ));
    });

    resultPopular.fold((failure) async {
      emit(state.copyWith(moviesPopularState: RequestState.Error));
    }, (data) async {
      emit(state.copyWith(
        moviesPopularState: RequestState.Loaded,
        moviesPopular: data,
      ));
    });

    resultTopRated.fold((failure) async {
      emit(state.copyWith(moviesTopRatedState: RequestState.Error));
    }, (data) async {
      emit(state.copyWith(
        moviesTopRatedState: RequestState.Loaded,
        moviesTopRated: data,
      ));
    });
  }
}
