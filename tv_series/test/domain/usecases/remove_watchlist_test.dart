import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/remove_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecaseTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseTvSeries = RemoveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  group('remove Watchlist', () {
    test('should remove watchlist tv series from repository', () async {
      // arrange
      when(mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from watchlist'));
      // act
      final result = await usecaseTvSeries.execute(testTvSeriesDetail);
      // assert
      verify(
          mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail));
      expect(result, const Right('Removed from watchlist'));
    });
  });
}
