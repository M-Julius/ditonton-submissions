import 'package:ditonton/presentation/bloc/watchlist_movies_bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/error_info.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WatchlistMoviesBloc>(context).add(FetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
            builder: (context, state) {
          if (state is WatchlistMoviesHasData) {
            if (state.result.length == 0) {
              return ErrorInfo(message: 'Sorry, you favorite is empty');
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
            );
          }
          if (state is WatchlistMoviesError) {
            return ErrorInfo(message: state.message);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
