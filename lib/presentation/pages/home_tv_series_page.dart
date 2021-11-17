import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/film_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/home_tv_series_bloc/home_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/drawer_home.dart';
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
    BlocProvider.of<HomeTvSeriesBloc>(context).add(FetchTvSeries());
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
                  return TvSeriesList(state.tvSeriesNowPlaying);
                } else if (state.tvSeriesNowPlayingState ==
                    RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvSeriesPage.ROUTE_NAME,
                ),
              ),
              BlocBuilder<HomeTvSeriesBloc, HomeTvSeriesState>(
                  builder: (context, state) {
                if (state.tvSeriesPopularState == RequestState.Loaded) {
                  return TvSeriesList(state.tvSeriesPopular);
                } else if (state.tvSeriesPopularState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<HomeTvSeriesBloc, HomeTvSeriesState>(
                  builder: (context, state) {
                if (state.tvSeriesTopRatedState == RequestState.Loaded) {
                  return TvSeriesList(state.tvSeriesTopRated);
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tv;

  TvSeriesList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
