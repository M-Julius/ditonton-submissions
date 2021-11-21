import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/created_by_model.dart';
import 'package:tv_series/data/models/genre_model.dart';
import 'package:tv_series/data/models/last_episode_to_air_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

import 'network_model.dart';
import 'production_company_model.dart';
import 'production_country_model.dart';
import 'spoken_language_model.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
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
  final LastEpisodeToAirModel? lastEpisodeToAir;
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
  final List<ProductionCompanyModel>? productionCompanies;
  final List<ProductionCountryModel>? productionCountries;
  final List<SeasonModel>? seasons;
  final List<SpokenLanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final double? voteAverage;
  final int? voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        backdropPath: json['backdrop_path'] as String?,
        createdBy: List<CreatedByModel>.from(
          json["created_by"].map((x) => CreatedByModel.fromJson(x)),
        ),
        episodeRunTime: json['episode_run_time'].cast<int>(),
        firstAirDate: json['first_air_date'] as String?,
        genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x)),
        ),
        homepage: json['homepage'] as String?,
        id: json['id'] as int?,
        inProduction: json['in_production'] as bool?,
        languages: json['languages'].cast<String>(),
        lastAirDate: json['last_air_date'] as String?,
        lastEpisodeToAir: json['last_episode_to_air'] == null
            ? null
            : LastEpisodeToAirModel.fromJson(
                json['last_episode_to_air'] as Map<String, dynamic>),
        name: json['name'] as String?,
        nextEpisodeToAir: json['next_episode_to_air'] as dynamic,
        networks: (json['networks'] as List<dynamic>?)
            ?.map((e) => NetworkModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        numberOfEpisodes: json['number_of_episodes'] as int?,
        numberOfSeasons: json['number_of_seasons'] as int?,
        originCountry: json['origin_country'].cast<String>(),
        originalLanguage: json['original_language'] as String?,
        originalName: json['original_name'] as String?,
        overview: json['overview'] as String?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        posterPath: json['poster_path'] as String?,
        productionCompanies: List<ProductionCompanyModel>.from(
          json["production_companies"].map(
            (x) => ProductionCompanyModel.fromJson(x),
          ),
        ),
        productionCountries: List<ProductionCountryModel>.from(
          json["production_countries"].map(
            (x) => ProductionCountryModel.fromJson(x),
          ),
        ),
        seasons: List<SeasonModel>.from(
            json['seasons'].map((x) => SeasonModel.fromJson(x))),
        spokenLanguages: List<SpokenLanguageModel>.from(
          json["spoken_languages"].map(
            (x) => SpokenLanguageModel.fromJson(x),
          ),
        ),
        status: json['status'] as String?,
        tagline: json['tagline'] as String?,
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
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: backdropPath,
      createdBy: createdBy?.map((e) => e.toEntity()).toList(),
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: genres?.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      languages: languages,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name,
      nextEpisodeToAir: nextEpisodeToAir,
      networks: networks?.map((e) => e.toEntity()).toList(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies:
          productionCompanies?.map((e) => e.toEntity()).toList(),
      productionCountries:
          productionCountries?.map((e) => e.toEntity()).toList(),
      spokenLanguages: spokenLanguages?.map((e) => e.toEntity()).toList(),
      status: status,
      tagline: tagline,
      voteAverage: voteAverage,
      voteCount: voteCount,
      seasons: seasons,
    );
  }

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
      voteAverage,
      voteCount,
    ];
  }
}
