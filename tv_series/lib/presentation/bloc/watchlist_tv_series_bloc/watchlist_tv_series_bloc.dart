// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this.getWatchlistTvSeries)
      : super(WatchlistTvSeriesEmpty());

  @override
  Stream<WatchlistTvSeriesState> mapEventToState(
    WatchlistTvSeriesEvent event,
  ) async* {
    if (event is FetchWatchlistTvSeries) {
      yield WatchlistTvSeriesLoading();
      final result = await getWatchlistTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchlistTvSeriesError(failure.message);
        },
        (data) async* {
          yield WatchlistTvSeriesHasData(data);
        },
      );
    }
  }
}
