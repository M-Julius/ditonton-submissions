import 'package:core/core.dart';
import 'package:ditonton/presentation/bloc/home_tv_series_bloc/home_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/widgets/drawer_home.dart';
import 'package:ditonton/presentation/widgets/film_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-series';

  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeTvSeriesBloc>().add(FetchTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(type: FilmType.TvSeries),
      appBar: AppBar(
        title: Text('Ditonton Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: FilmType.TvSeries,
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
              ),
              BlocBuilder<HomeTvSeriesBloc, HomeTvSeriesState>(
                  builder: (context, state) {
                if (state.tvSeriesNowPlayingState == RequestState.Loaded) {
                  return FilmList(
                    films: state.tvSeriesNowPlaying,
                    type: FilmType.TvSeries,
                  );
                } else if (state.tvSeriesNowPlayingState ==
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
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvSeriesPage.ROUTE_NAME,
                ),
              ),
              BlocBuilder<HomeTvSeriesBloc, HomeTvSeriesState>(
                  builder: (context, state) {
                if (state.tvSeriesPopularState == RequestState.Loaded) {
                  return FilmList(
                    films: state.tvSeriesPopular,
                    type: FilmType.TvSeries,
                  );
                } else if (state.tvSeriesPopularState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<HomeTvSeriesBloc, HomeTvSeriesState>(
                  builder: (context, state) {
                if (state.tvSeriesTopRatedState == RequestState.Loaded) {
                  return FilmList(
                    films: state.tvSeriesTopRated,
                    type: FilmType.TvSeries,
                  );
                } else if (state.tvSeriesTopRatedState ==
                    RequestState.Loading) {
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
