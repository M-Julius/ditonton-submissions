import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'watchlist_tv_series_page_test.mocks.dart';

@GenerateMocks([WatchlistTvSeriesNotifier])
void main() {
  late MockWatchlistTvSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTvSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display center progress bar when loading watchlist tv series',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display ListView when data is loaded watchlist tv series',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockNotifier.watchlistTvSeries).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when Error watchlist tv series',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
