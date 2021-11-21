part of 'home_tv_series_bloc.dart';

abstract class HomeTvSeriesEvent extends Equatable {
  const HomeTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeries extends HomeTvSeriesEvent {
  const FetchTvSeries();

  @override
  List<Object> get props => [];
}
