import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

class TvSeriesModel extends Equatable {
  const TvSeriesModel({
    this.posterPath,
    this.popularity,
    this.id,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  final String? posterPath;
  final double? popularity;
  final int? id;
  final String? backdropPath;
  final double? voteAverage;
  final String? overview;
  final String? firstAirDate;
  final List<String>? originCountry;
  final List<int>? genreIds;
  final String? originalLanguage;
  final int? voteCount;
  final String? name;
  final String? originalName;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        posterPath: json['poster_path'] as String?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        id: json['id'] as int?,
        backdropPath: json['backdrop_path'] as String?,
        voteAverage: (json['vote_average'] as num?)?.toDouble(),
        overview: json['overview'] as String?,
        firstAirDate: json['first_air_date'] as String?,
        originCountry: json['origin_country']?.cast<String>(),
        genreIds: json['genre_ids']?.cast<int>(),
        originalLanguage: json['original_language'] as String?,
        voteCount: json['vote_count'] as int?,
        name: json['name'] as String?,
        originalName: json['original_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'poster_path': posterPath,
        'popularity': popularity,
        'id': id,
        'backdrop_path': backdropPath,
        'vote_average': voteAverage,
        'overview': overview,
        'first_air_date': firstAirDate,
        'origin_country': originCountry,
        'genre_ids': genreIds,
        'original_language': originalLanguage,
        'vote_count': voteCount,
        'name': name,
        'original_name': originalName,
      };

  TvSeries toEntity() {
    return TvSeries(
        posterPath: posterPath,
        popularity: popularity,
        id: id,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        overview: overview,
        firstAirDate: firstAirDate,
        originCountry: originCountry,
        genreIds: genreIds,
        originalLanguage: originalLanguage,
        voteCount: voteCount,
        name: name,
        originalName: originalName);
  }

  @override
  List<Object?> get props {
    return [
      posterPath,
      popularity,
      id,
      backdropPath,
      voteAverage,
      overview,
      firstAirDate,
      originCountry,
      genreIds,
      originalLanguage,
      voteCount,
      name,
      originalName,
    ];
  }
}
