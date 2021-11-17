// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesEmpty());

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is FetchPopularMovies) {
      yield PopularMoviesLoading();
      final result = await getPopularMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularMoviesError(failure.message);
        },
        (data) async* {
          yield PopularMoviesHasData(data);
        },
      );
    }
  }
}
