import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvSeriesWatchlist usecaseTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseTvSeries = SaveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveTvSeriesWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecaseTvSeries.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.saveTvSeriesWatchlist(testTvSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
