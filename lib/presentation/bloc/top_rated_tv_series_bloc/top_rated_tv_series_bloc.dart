// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this.getTopRatedTvSeries)
      : super(TopRatedTvSeriesEmpty());

  @override
  Stream<TopRatedTvSeriesState> mapEventToState(
    TopRatedTvSeriesEvent event,
  ) async* {
    if (event is FetchTopRatedTvSeries) {
      yield TopRatedTvSeriesLoading();
      final result = await getTopRatedTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield TopRatedTvSeriesError(failure.message);
        },
        (data) async* {
          yield TopRatedTvSeriesHasData(data);
        },
      );
    }
  }
}
