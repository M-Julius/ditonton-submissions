import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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

  final tId = 1;

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

  group('Get TvSeries Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, HasData] when data detail tvSeries & tvSeries recomendation is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchDetailTvSeries(tId)),
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
  });
}
