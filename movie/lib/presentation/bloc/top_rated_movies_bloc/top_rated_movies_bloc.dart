// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty());

  @override
  Stream<TopRatedMoviesState> mapEventToState(
    TopRatedMoviesEvent event,
  ) async* {
    if (event is FetchTopRatedMovies) {
      yield TopRatedMoviesLoading();
      final result = await getTopRatedMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield TopRatedMoviesError(failure.message);
        },
        (data) async* {
          yield TopRatedMoviesHasData(data);
        },
      );
    }
  }
}
