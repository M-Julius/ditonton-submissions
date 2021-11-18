import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/home_tv_series_bloc/home_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late HomeTvSeriesBloc homeTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    homeTvSeriesBloc = HomeTvSeriesBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  final tTvModel = TvSeries(
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      originalName: 'Spider-Man',
      overview: 'After being bitten by a genetically altered spider.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      firstAirDate: '2002-05-01',
      name: 'Spider-Man',
      voteAverage: 7.2,
      voteCount: 13507,
      originCountry: ['us'],
      originalLanguage: 'US');
  final tTvSeries = <TvSeries>[tTvModel];

  group('Get Home Tv Series', () {
    blocTest<HomeTvSeriesBloc, HomeTvSeriesState>(
      'Should emit [Loading, HasData] when data Tv Series Now Playing, Popular, Top Rated is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeries));
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeries));
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeries));
        return homeTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Loading,
          tvSeriesPopularState: RequestState.Loading,
          tvSeriesTopRatedState: RequestState.Loading,
        ),
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Loaded,
          tvSeriesNowPlaying: tTvSeries,
          tvSeriesPopularState: RequestState.Loading,
          tvSeriesTopRatedState: RequestState.Loading,
        ),
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Loaded,
          tvSeriesNowPlaying: tTvSeries,
          tvSeriesPopularState: RequestState.Loaded,
          tvSeriesPopular: tTvSeries,
          tvSeriesTopRatedState: RequestState.Loading,
        ),
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Loaded,
          tvSeriesNowPlaying: tTvSeries,
          tvSeriesPopularState: RequestState.Loaded,
          tvSeriesPopular: tTvSeries,
          tvSeriesTopRatedState: RequestState.Loaded,
          tvSeriesTopRated: tTvSeries,
        ),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
        verify(mockGetPopularTvSeries.execute());
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<HomeTvSeriesBloc, HomeTvSeriesState>(
      'Should emit [Loading, Error] when data Tv Series Now Playing, Popular, Top Rated is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return homeTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Loading,
          tvSeriesPopularState: RequestState.Loading,
          tvSeriesTopRatedState: RequestState.Loading,
        ),
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Error,
          tvSeriesPopularState: RequestState.Loading,
          tvSeriesTopRatedState: RequestState.Loading,
        ),
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Error,
          tvSeriesPopularState: RequestState.Error,
          tvSeriesTopRatedState: RequestState.Loading,
        ),
        HomeTvSeriesState.initial().copyWith(
          tvSeriesNowPlayingState: RequestState.Error,
          tvSeriesPopularState: RequestState.Error,
          tvSeriesTopRatedState: RequestState.Error,
        ),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
        verify(mockGetPopularTvSeries.execute());
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
