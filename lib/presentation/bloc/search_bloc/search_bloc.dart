// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchTvSeries _searchTvSeries;

  SearchBloc(this._searchMovies, this._searchTvSeries) : super(SearchEmpty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;
      final type = event.type;

      yield SearchLoading();
      final result;
      if (type == FilmType.Movies) {
        result = await _searchMovies.execute(query);
      } else {
        result = await _searchTvSeries.execute(query);
      }

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          if (type == FilmType.Movies) {
            yield SearchHasDataMovies(data);
          } else {
            yield SearchHasDataTvSeries(data);
          }
        },
      );
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
