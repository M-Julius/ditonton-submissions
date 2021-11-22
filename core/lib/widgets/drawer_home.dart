// ignore_for_file: use_key_in_widget_constructors

import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_series_page.dart';

class DrawerHome extends StatelessWidget {
  final FilmType type;
  const DrawerHome({required this.type});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              if (type == FilmType.Movies) {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Tv Series'),
            onTap: () {
              if (type == FilmType.Movies) {
                Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              if (FilmType.Movies == type) {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              } else {
                Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
              }
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
