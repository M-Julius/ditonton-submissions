// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchTvSeriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchEmpty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchTvSeries.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasDataTvSeries(data);
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
