import 'package:ditonton/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PopularTvSeriesBloc>(context).add(FetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
            builder: (context, state) {
          if (state is PopularTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.result[index];
                return TvSeriesCard(tv);
              },
              itemCount: state.result.length,
            );
          }
          if (state is PopularTvSeriesError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
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
