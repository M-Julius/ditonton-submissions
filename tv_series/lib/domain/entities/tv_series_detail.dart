import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/created_by.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/last_episode_to_air.dart';
import 'package:tv_series/domain/entities/network_tv_series.dart';
import 'package:tv_series/domain/entities/production_company.dart';
import 'package:tv_series/domain/entities/production_country.dart';
import 'package:tv_series/domain/entities/spoken_langauge.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<NetworkTvSeries>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final List<SeasonModel>? seasons;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        voteAverage,
        voteCount,
      ];
}
