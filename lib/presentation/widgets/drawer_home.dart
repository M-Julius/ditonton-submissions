import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';

class DrawerHome extends StatelessWidget {
  final FilmType type;
  const DrawerHome({required this.type});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              if (this.type == FilmType.Movies) {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Tv Series'),
            onTap: () {
              if (this.type == FilmType.Movies) {
                Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              if (FilmType.Movies == this.type) {
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
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
