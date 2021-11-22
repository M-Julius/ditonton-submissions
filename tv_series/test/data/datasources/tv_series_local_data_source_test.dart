import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSource dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist tv series', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTvSeriesWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertTvSeriesWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist tv series', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeTvSeriesWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeTvSeriesWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail By Id', () {
    const tId = 1;

    test('should return Tv Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
