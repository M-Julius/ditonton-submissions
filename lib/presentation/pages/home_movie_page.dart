import 'package:core/core.dart';
import 'package:ditonton/presentation/bloc/home_movie_bloc/home_movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/widgets/drawer_home.dart';
import 'package:ditonton/presentation/widgets/film_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeMovieBloc>().add(FetchMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(
        type: FilmType.Movies,
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: FilmType.Movies,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
                key: Key('now_playing'),
              ),
              BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                if (state.moviesNowPlayingState == RequestState.Loaded) {
                  return FilmList(
                    films: state.moviesNowPlaying,
                    type: FilmType.Movies,
                  );
                } else if (state.moviesNowPlayingState ==
                    RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                if (state.moviesPopularState == RequestState.Loaded) {
                  return FilmList(
                    films: state.moviesPopular,
                    type: FilmType.Movies,
                  );
                } else if (state.moviesPopularState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                if (state.moviesTopRatedState == RequestState.Loaded) {
                  return FilmList(
                    films: state.moviesTopRated,
                    type: FilmType.Movies,
                  );
                } else if (state.moviesTopRatedState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
