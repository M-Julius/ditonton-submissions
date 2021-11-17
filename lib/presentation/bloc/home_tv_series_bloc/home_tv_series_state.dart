part of 'home_tv_series_bloc.dart';

class HomeTvSeriesState {
  final List<TvSeries> tvSeriesPopular;
  final RequestState tvSeriesPopularState;
  final List<TvSeries> tvSeriesNowPlaying;
  final RequestState tvSeriesNowPlayingState;
  final List<TvSeries> tvSeriesTopRated;
  final RequestState tvSeriesTopRatedState;
  HomeTvSeriesState({
    required this.tvSeriesPopular,
    required this.tvSeriesPopularState,
    required this.tvSeriesNowPlaying,
    required this.tvSeriesNowPlayingState,
    required this.tvSeriesTopRated,
    required this.tvSeriesTopRatedState,
  });

  HomeTvSeriesState copyWith({
    List<TvSeries>? tvSeriesPopular,
    RequestState? tvSeriesPopularState,
    List<TvSeries>? tvSeriesNowPlaying,
    RequestState? tvSeriesNowPlayingState,
    List<TvSeries>? tvSeriesTopRated,
    RequestState? tvSeriesTopRatedState,
  }) {
    return HomeTvSeriesState(
      tvSeriesPopular: tvSeriesPopular ?? this.tvSeriesPopular,
      tvSeriesPopularState: tvSeriesPopularState ?? this.tvSeriesPopularState,
      tvSeriesNowPlaying: tvSeriesNowPlaying ?? this.tvSeriesNowPlaying,
      tvSeriesNowPlayingState:
          tvSeriesNowPlayingState ?? this.tvSeriesNowPlayingState,
      tvSeriesTopRated: tvSeriesTopRated ?? this.tvSeriesTopRated,
      tvSeriesTopRatedState:
          tvSeriesTopRatedState ?? this.tvSeriesTopRatedState,
    );
  }

  factory HomeTvSeriesState.initial() => HomeTvSeriesState(
        tvSeriesNowPlaying: [],
        tvSeriesNowPlayingState: RequestState.Empty,
        tvSeriesPopular: [],
        tvSeriesPopularState: RequestState.Empty,
        tvSeriesTopRated: [],
        tvSeriesTopRatedState: RequestState.Empty,
      );
}
