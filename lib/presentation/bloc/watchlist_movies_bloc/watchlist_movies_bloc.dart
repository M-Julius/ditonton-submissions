// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc(
    this.getWatchlistMovies,
  ) : super(WatchlistMoviesEmpty());

  @override
  Stream<WatchlistMoviesState> mapEventToState(
    WatchlistMoviesEvent event,
  ) async* {
    if (event is FetchWatchlistMovies) {
      yield WatchlistMoviesLoading();
      final result = await getWatchlistMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchlistMoviesError(failure.message);
        },
        (data) async* {
          yield WatchlistMoviesHasData(data);
        },
      );
    }
  }
}
