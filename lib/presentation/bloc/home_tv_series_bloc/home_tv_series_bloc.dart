import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_tv_series_event.dart';
part 'home_tv_series_state.dart';

class HomeTvSeriesBloc extends Bloc<HomeTvSeriesEvent, HomeTvSeriesState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  HomeTvSeriesBloc({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(HomeTvSeriesState.initial()) {
    on<FetchTvSeries>((event, emit) async {
      emit(state.copyWith(
        tvSeriesNowPlayingState: RequestState.Loading,
        tvSeriesPopularState: RequestState.Loading,
        tvSeriesTopRatedState: RequestState.Loading,
      ));

      final result = await getNowPlayingTvSeries.execute();
      final resultPopular = await getPopularTvSeries.execute();
      final resultTopRated = await getTopRatedTvSeries.execute();

      result.fold((failure) async {
        emit(state.copyWith(tvSeriesNowPlayingState: RequestState.Error));
      }, (data) async {
        emit(state.copyWith(
          tvSeriesNowPlayingState: RequestState.Loaded,
          tvSeriesNowPlaying: data,
        ));
      });

      resultPopular.fold((failure) async {
        emit(state.copyWith(tvSeriesPopularState: RequestState.Error));
      }, (data) async {
        emit(state.copyWith(
          tvSeriesPopularState: RequestState.Loaded,
          tvSeriesPopular: data,
        ));
      });

      resultTopRated.fold((failure) async {
        emit(state.copyWith(tvSeriesTopRatedState: RequestState.Error));
      }, (data) async {
        emit(state.copyWith(
          tvSeriesTopRatedState: RequestState.Loaded,
          tvSeriesTopRated: data,
        ));
      });
    });
  }
}
