import 'package:ditonton/common/film_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_movies_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading movies',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      type: FilmType.Movies,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data movies is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResultMovie).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      type: FilmType.Movies,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should none display movies when result zonk',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      type: FilmType.Movies,
    )));

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading tv series',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      type: FilmType.TvSeries,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data Tv Series is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResultTvSeries).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      type: FilmType.TvSeries,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should none display tv series when result zonk',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      type: FilmType.TvSeries,
    )));

    expect(containerFinder, findsOneWidget);
  });
}
