import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/home_movie_bloc/home_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late HomeMovieBloc homeMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    homeMovieBloc = HomeMovieBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovies));
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tMovies));
    when(mockGetTopRatedMovies.execute())
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Home Movie', () {
    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HasData] when data movie now playing, popular, top rated is gotten successfully',
      build: () {
        _arrangeUsecase();
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchMovieList()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        HomeMovieState.initial().copyWith(
          moviesNowPlayingState: RequestState.Loading,
          moviesPopularState: RequestState.Loading,
          moviesTopRatedState: RequestState.Loading,
        ),
        HomeMovieState.initial().copyWith(
          moviesNowPlayingState: RequestState.Loaded,
          moviesNowPlaying: tMovies,
          moviesPopularState: RequestState.Loading,
          moviesTopRatedState: RequestState.Loading,
        ),
        HomeMovieState.initial().copyWith(
          moviesNowPlayingState: RequestState.Loaded,
          moviesNowPlaying: tMovies,
          moviesPopularState: RequestState.Loaded,
          moviesPopular: tMovies,
          moviesTopRatedState: RequestState.Loading,
        ),
        HomeMovieState.initial().copyWith(
          moviesNowPlayingState: RequestState.Loaded,
          moviesNowPlaying: tMovies,
          moviesPopularState: RequestState.Loaded,
          moviesPopular: tMovies,
          moviesTopRatedState: RequestState.Loaded,
          moviesTopRated: tMovies,
        ),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        verify(mockGetPopularMovies.execute());
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
