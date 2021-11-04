import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_series_page_test.mocks.dart';

@GenerateMocks([TvSeriesListNotifier])
void main() {
  late MockTvSeriesListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Show list display home tv series', (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingTvSeries).thenReturn(testTvSeriesList);
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTvSeries).thenReturn(testTvSeriesList);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTvSeries).thenReturn(testTvSeriesList);

    final findTvSeriesList = find.byType(TvSeriesList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage()));

    expect(findTvSeriesList, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage()));

    expect(textFinder, findsWidgets);
  });
}
