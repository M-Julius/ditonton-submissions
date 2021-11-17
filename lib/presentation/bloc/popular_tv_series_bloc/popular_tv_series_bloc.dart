// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc(this.getPopularTvSeries) : super(PopularTvSeriesEmpty());

  @override
  Stream<PopularTvSeriesState> mapEventToState(
    PopularTvSeriesEvent event,
  ) async* {
    if (event is FetchPopularTvSeries) {
      yield PopularTvSeriesLoading();
      final result = await getPopularTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularTvSeriesError(failure.message);
        },
        (data) async* {
          yield PopularTvSeriesHasData(data);
        },
      );
    }
  }
}
