import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late RemoveTvSeriesWatchlist usecaseTvSeries;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlist(mockMovieRepository);

    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseTvSeries = RemoveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  group('remove Watchlist', () {
    test('should remove watchlist movie from repository', () async {
      // arrange
      when(mockMovieRepository.removeWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));
      // act
      final result = await usecase.execute(testMovieDetail);
      // assert
      verify(mockMovieRepository.removeWatchlist(testMovieDetail));
      expect(result, Right('Removed from watchlist'));
    });

    test('should remove watchlist tv series from repository', () async {
      // arrange
      when(mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));
      // act
      final result = await usecaseTvSeries.execute(testTvSeriesDetail);
      // assert
      verify(
          mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail));
      expect(result, Right('Removed from watchlist'));
    });
  });
}
