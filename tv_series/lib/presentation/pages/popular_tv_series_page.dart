// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTvSeriesBloc>().add(const FetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
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
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
