import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
  }) : super(TvSeriesDetailState.initial()) {
    on<FetchDetailTvSeries>((event, emit) async {
      emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));

      final detailResult = await getTvSeriesDetail.execute(event.id);

      final recommendationResult =
          await getTvSeriesRecommendations.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(
            tvSeriesDetailState: RequestState.Error,
            message: failure.message,
          ));
        },
        (tvSeries) async {
          emit(state.copyWith(
            tvSeriesRecommendationState: RequestState.Loading,
            tvSeriesDetail: tvSeries,
            tvSeriesDetailState: RequestState.Loaded,
            message: '',
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                tvSeriesRecommendationState: RequestState.Error,
                message: failure.message,
              ));
            },
            (tvSeriess) {
              emit(state.copyWith(
                tvSeriesRecommendationState: RequestState.Loaded,
                tvSeriesRecommendations: tvSeriess,
                message: '',
              ));
            },
          );
        },
      );
    });

    on<AddWatchListTvSeries>((event, emit) async {
      final result = await saveTvSeriesWatchlist.execute(event.tv);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });
      add(LoadStatusWatchlistTvSeries(event.tv.id!));
    });

    on<RemoveWatchListTvSeries>((event, emit) async {
      final result = await removeTvSeriesWatchlist.execute(event.tv);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });
      add(LoadStatusWatchlistTvSeries(event.tv.id!));
    });

    on<LoadStatusWatchlistTvSeries>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
