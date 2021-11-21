part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailTvSeries extends TvSeriesDetailEvent {
  final int id;

  const FetchDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchListTvSeries extends TvSeriesDetailEvent {
  final TvSeriesDetail tv;

  const AddWatchListTvSeries(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchListTvSeries extends TvSeriesDetailEvent {
  final TvSeriesDetail tv;

  const RemoveWatchListTvSeries(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadStatusWatchlistTvSeries extends TvSeriesDetailEvent {
  final int id;
  const LoadStatusWatchlistTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
