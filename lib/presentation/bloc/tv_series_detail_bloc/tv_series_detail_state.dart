part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;
  final RequestState tvSeriesDetailState;
  final List<TvSeries> tvSeriesRecommendations;
  final RequestState tvSeriesRecommendationState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  TvSeriesDetailState({
    required this.tvSeriesDetail,
    required this.tvSeriesDetailState,
    required this.tvSeriesRecommendations,
    required this.tvSeriesRecommendationState,
    required this.isAddedToWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  factory TvSeriesDetailState.initial() => TvSeriesDetailState(
        tvSeriesDetail: TvSeriesDetail(
          backdropPath: '',
          genres: [],
          id: 0,
          overview: '',
          posterPath: '',
          voteAverage: 0.0,
          voteCount: 0,
          createdBy: [],
          episodeRunTime: [],
          firstAirDate: '',
          homepage: '',
          inProduction: false,
          languages: [],
          lastAirDate: '',
          name: '',
          lastEpisodeToAir: null,
          networks: [],
          nextEpisodeToAir: [],
          numberOfEpisodes: 0,
          numberOfSeasons: 0,
          originCountry: [],
          originalLanguage: '',
          originalName: '',
          popularity: 0.0,
          productionCompanies: [],
          productionCountries: [],
          seasons: [],
          spokenLanguages: [],
          status: '',
          tagline: '',
        ),
        tvSeriesDetailState: RequestState.Empty,
        tvSeriesRecommendations: [],
        tvSeriesRecommendationState: RequestState.Empty,
        isAddedToWatchlist: false,
        message: '',
        watchlistMessage: '',
      );

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeriesDetail,
    RequestState? tvSeriesDetailState,
    List<TvSeries>? tvSeriesRecommendations,
    RequestState? tvSeriesRecommendationState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      tvSeriesRecommendations:
          tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      tvSeriesRecommendationState:
          tvSeriesRecommendationState ?? this.tvSeriesRecommendationState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }
}
