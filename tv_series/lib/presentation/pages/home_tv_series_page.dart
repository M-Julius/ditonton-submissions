// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names

import 'package:core/core.dart';
import 'package:core/widgets/drawer_home.dart';
import 'package:core/widgets/film_list.dart';
import 'package:core/widgets/sub_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv_series_bloc/home_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:tv_series/presentation/pages/search_tv_series_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-series';

  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeTvSeriesBloc>().add(const FetchTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHome(type: FilmType.TvSeries),
      appBar: AppBar(
        title: const Text('Ditonton Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchTvSeriesPage.ROUTE_NAME,
                arguments: FilmType.TvSeries,
              );
            },
            icon: const Icon(Icons.search),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('Failed');
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('Failed');
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
