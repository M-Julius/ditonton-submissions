import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  MovieSearchNotifier({
    required this.searchMovies,
    required this.searchTvSeries,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _searchResultMovie = [];
  List<Movie> get searchResultMovie => _searchResultMovie;

  List<TvSeries> _searchResultTvSeries = [];
  List<TvSeries> get searchResultTvSeries => _searchResultTvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResultMovie = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResultTvSeries = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
