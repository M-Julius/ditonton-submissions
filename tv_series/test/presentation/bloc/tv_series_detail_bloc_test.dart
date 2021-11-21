import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_watchlist.dart';
import 'package:tv_series/domain/usecases/save_watchlist.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListTvSeriesStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockSaveTvSeriesWatchlist mockSaveWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveWatchlist;
  late MockGetWatchListTvSeriesStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListTvSeriesStatus();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockRemoveWatchlist = MockRemoveTvSeriesWatchlist();
    mockSaveWatchlist = MockSaveTvSeriesWatchlist();
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();

    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      removeTvSeriesWatchlist: mockRemoveWatchlist,
      saveTvSeriesWatchlist: mockSaveWatchlist,
    );
  });

  const tId = 1;
  final tTvModel = TvSeries(
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: const [14, 28],
      id: 557,
      originalName: 'Spider-Man',
      overview: 'After being bitten by a genetically altered spider.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      firstAirDate: '2002-05-01',
      name: 'Spider-Man',
      voteAverage: 7.2,
      voteCount: 13507,
      originCountry: const ['us'],
      originalLanguage: 'US');
  final tTvSeries = <TvSeries>[tTvModel];
  const tStatusWatchlist = true;

  group('Get Tv Series Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, HasData] when data detail tv series & tv series recomendation is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvSeriesDetail));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailTvSeries(tId)),
      expect: () => [
        TvSeriesDetailState.initial().copyWith(
          tvSeriesDetailState: RequestState.Loading,
        ),
        TvSeriesDetailState.initial().copyWith(
          tvSeriesDetailState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          tvSeriesRecommendationState: RequestState.Loading,
          message: '',
        ),
        TvSeriesDetailState.initial().copyWith(
          tvSeriesDetailState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          tvSeriesRecommendationState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeries,
          message: '',
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Error] when get data detail tv series is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailTvSeries(tId)),
      expect: () => [
        TvSeriesDetailState.initial().copyWith(
          tvSeriesDetailState: RequestState.Loading,
        ),
        TvSeriesDetailState.initial().copyWith(
          tvSeriesDetailState: RequestState.Error,
          message: 'Server Failure',
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [SaveWatchlist] when save tv series in watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail)).thenAnswer(
            (_) async =>
                const Right(TvSeriesDetailBloc.watchlistAddSuccessMessage));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => tStatusWatchlist);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchListTvSeries(testTvSeriesDetail)),
      expect: () => [
        TvSeriesDetailState.initial().copyWith(
            isAddedToWatchlist: !tStatusWatchlist,
            watchlistMessage: TvSeriesDetailBloc.watchlistAddSuccessMessage),
        TvSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: tStatusWatchlist,
          watchlistMessage: TvSeriesDetailBloc.watchlistAddSuccessMessage,
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTvSeriesDetail));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [RemoveWatchlist] when remove tv series in watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testTvSeriesDetail)).thenAnswer(
            (_) async =>
                const Right(TvSeriesDetailBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => !tStatusWatchlist);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveWatchListTvSeries(testTvSeriesDetail)),
      expect: () => [
        TvSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: !tStatusWatchlist,
          watchlistMessage: TvSeriesDetailBloc.watchlistRemoveSuccessMessage,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testTvSeriesDetail));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
  });
}
