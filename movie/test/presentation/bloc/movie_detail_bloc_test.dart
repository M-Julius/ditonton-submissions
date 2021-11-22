import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';
import 'package:movie/domain/usecase/get_watchlist_status.dart';
import 'package:movie/domain/usecase/remove_watchlist.dart';
import 'package:movie/domain/usecase/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    mockGetMovieDetail = MockGetMovieDetail();

    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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
  const tStatusWatchlist = true;

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when get data detail movie & movies recomendation is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailMovies(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationState: RequestState.Loading,
          message: '',
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationState: RequestState.Loaded,
          movieRecommendations: tMovies,
          message: '',
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get data detail movie is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailMovies(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Error,
          message: 'Server Failure',
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [SaveWatchlist] when save movie in watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
            const Right(MovieDetailBloc.watchlistAddSuccessMessage));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => tStatusWatchlist);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchListMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            isAddedToWatchlist: !tStatusWatchlist,
            watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage),
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: tStatusWatchlist,
          watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage,
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [RemoveWatchlist] when remove movie in watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                const Right(MovieDetailBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => !tStatusWatchlist);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchListMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: !tStatusWatchlist,
          watchlistMessage: MovieDetailBloc.watchlistRemoveSuccessMessage,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
  });
}
