import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  final tTv = TvSeries(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      firstAirDate: '20-01-2000',
      name: 'Name',
      originalName: 'Original name',
      originCountry: ['us'],
      originalLanguage: 'us');

  final tTvSeriesList = <TvSeries>[tTv];

  test('initial state should be empty', () {
    expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, HasData] when data popular tv series is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, Error] when get popular tv series is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
