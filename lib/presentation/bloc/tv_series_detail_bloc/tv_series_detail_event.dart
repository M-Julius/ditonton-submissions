part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailTvSeries extends TvSeriesDetailEvent {
  final int id;

  FetchDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchListTvSeries extends TvSeriesDetailEvent {
  final TvSeriesDetail tv;

  AddWatchListTvSeries(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchListTvSeries extends TvSeriesDetailEvent {
  final TvSeriesDetail tv;

  RemoveWatchListTvSeries(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadStatusWatchlistTvSeries extends TvSeriesDetailEvent {
  final int id;
  LoadStatusWatchlistTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
