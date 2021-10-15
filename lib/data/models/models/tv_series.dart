import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

import 'last_episode_to_air.dart';
import '../network_model.dart';
import 'production_company.dart';
import 'production_country.dart';
import '../season_model.dart';
import '../spoken_language_model.dart';

class TvSeries extends Equatable {
  const TvSeries({
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final List<CreatedByModel>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<NetworkModel>? networks;
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
  final List<SpokenLanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  factory TvSeries.fromJson(Map<String, dynamic> json) => TvSeries(
        backdropPath: json['backdrop_path'] as String?,
        createdBy: (json['created_by'] as List<dynamic>?)
            ?.map((e) => CreatedByModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        episodeRunTime: json['episode_run_time'] as List<int>?,
        firstAirDate: json['first_air_date'] as String?,
        genres: (json['genres'] as List<dynamic>?)
            ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        homepage: json['homepage'] as String?,
        id: json['id'] as int?,
        inProduction: json['in_production'] as bool?,
        languages: json['languages'] as List<String>?,
        lastAirDate: json['last_air_date'] as String?,
        lastEpisodeToAir: json['last_episode_to_air'] == null
            ? null
            : LastEpisodeToAir.fromJson(
                json['last_episode_to_air'] as Map<String, dynamic>),
        name: json['name'] as String?,
        nextEpisodeToAir: json['next_episode_to_air'] as dynamic?,
        networks: (json['networks'] as List<dynamic>?)
            ?.map((e) => NetworkModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        numberOfEpisodes: json['number_of_episodes'] as int?,
        numberOfSeasons: json['number_of_seasons'] as int?,
        originCountry: json['origin_country'] as List<String>?,
        originalLanguage: json['original_language'] as String?,
        originalName: json['original_name'] as String?,
        overview: json['overview'] as String?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        posterPath: json['poster_path'] as String?,
        productionCompanies: (json['production_companies'] as List<dynamic>?)
            ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
            .toList(),
        productionCountries: (json['production_countries'] as List<dynamic>?)
            ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
            .toList(),
        seasons: (json['seasons'] as List<dynamic>?)
            ?.map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
            ?.map(
                (e) => SpokenLanguageModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['status'] as String?,
        tagline: json['tagline'] as String?,
        type: json['type'] as String?,
        voteAverage: (json['vote_average'] as num?)?.toDouble(),
        voteCount: json['vote_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'created_by': createdBy?.map((e) => e.toJson()).toList(),
        'episode_run_time': episodeRunTime,
        'first_air_date': firstAirDate,
        'genres': genres?.map((e) => e.toJson()).toList(),
        'homepage': homepage,
        'id': id,
        'in_production': inProduction,
        'languages': languages,
        'last_air_date': lastAirDate,
        'last_episode_to_air': lastEpisodeToAir?.toJson(),
        'name': name,
        'next_episode_to_air': nextEpisodeToAir,
        'networks': networks?.map((e) => e.toJson()).toList(),
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies':
            productionCompanies?.map((e) => e.toJson()).toList(),
        'production_countries':
            productionCountries?.map((e) => e.toJson()).toList(),
        'seasons': seasons?.map((e) => e.toJson()).toList(),
        'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'type': type,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  @override
  List<Object?> get props {
    return [
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
      type,
      voteAverage,
      voteCount,
    ];
  }
}
