import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/film_enum.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/movie.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mocktail/mocktail.dart';

class SearchBlocMock extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {} // extend MockBloc rather than Mock

class FakeSearchEvent extends Fake implements SearchEvent {}

class FakeSearchState extends Fake implements SearchState {}

@GenerateMocks([SearchBloc])
void main() {
  late SearchBlocMock searchBlocMock;

  setUp(() {
    searchBlocMock = SearchBlocMock();
  });

  setUpAll(() {
    registerFallbackValue(FakeSearchEvent());
    registerFallbackValue(FakeSearchState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>(
      create: (_) => searchBlocMock,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Test', (WidgetTester tester) async {
    final testBloc = SearchBlocMock();
    mockito
        .when(testBloc.state)
        .thenReturn(SearchLoading()); // stub state rather than initialState
    whenListen<SearchState>(
      testBloc,
      Stream<SearchState>.fromIterable([
        SearchLoading(),
        // TestState('First emission'),
        // TestState('Second emission'),
      ]),
    );
    await tester.pumpWidget(
      BlocProvider<SearchBloc>(
          create: (c) => testBloc,
          child: SearchPage(
            type: FilmType.Movies,
          )),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pump(Duration.zero);
    expect(progressBarFinder, findsOneWidget);
  });

  // testWidgets('Page should display center progress bar when loading movies',
  //     (WidgetTester tester) async {
  //   when(searchBlocMock.state).thenReturn(SearchLoading());
  //   // whenListen(
  //   //   searchBlocMock,
  //   //   Stream<SearchState>.fromIterable(
  //   //       [Sea('query', FilmType.Movies)]),
  //   // );

  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   // final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(SearchPage(
  //     type: FilmType.Movies,
  //   )));

  //   expect(progressBarFinder, findsOneWidget);
  // });

  // testWidgets('Page should display ListView when data movies is loaded',
  //     (WidgetTester tester) async {
  //   when(mockSearchBloc.state).thenReturn(mockSearchBloc);
  //   when(SearchHasDataMovies).thenReturn(<Movie>[]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(SearchPage(
  //     type: FilmType.Movies,
  //   )));

  //   expect(listViewFinder, findsOneWidget);
  // });

  // testWidgets('Page should none display movies when result zonk',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Error);

  //   final containerFinder = find.byType(Container);

  //   await tester.pumpWidget(_makeTestableWidget(SearchPage(
  //     type: FilmType.Movies,
  //   )));

  //   expect(containerFinder, findsOneWidget);
  // });

  // testWidgets('Page should display center progress bar when loading tv series',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loading);

  //   final progressBarFinder = find.byType(CircularProgressIndicator);

  //   await tester.pumpWidget(_makeTestableWidget(SearchPage(
  //     type: FilmType.TvSeries,
  //   )));

  //   expect(progressBarFinder, findsOneWidget);
  // });

  // testWidgets('Page should display ListView when data Tv Series is loaded',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.searchResultTvSeries).thenReturn(<TvSeries>[]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(SearchPage(
  //     type: FilmType.TvSeries,
  //   )));

  //   expect(listViewFinder, findsOneWidget);
  // });

  // testWidgets('Page should none display tv series when result zonk',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Error);

  //   final containerFinder = find.byType(Container);

  //   await tester.pumpWidget(_makeTestableWidget(SearchPage(
  //     type: FilmType.TvSeries,
  //   )));

  //   expect(containerFinder, findsOneWidget);
  // });
}
