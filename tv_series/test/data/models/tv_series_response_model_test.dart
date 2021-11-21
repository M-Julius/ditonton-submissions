import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      posterPath: "/path.jpg",
      popularity: 47.432451,
      id: 1,
      backdropPath: "/path.jpg",
      voteAverage: 5.04,
      overview: "overview.",
      firstAirDate: "2010-06-08",
      originCountry: ["US"],
      genreIds: [1, 2, 3],
      originalLanguage: "en",
      voteCount: 133,
      name: "Name",
      originalName: "Original Name");
  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path.jpg",
            "popularity": 47.432451,
            "id": 1,
            "backdrop_path": "/path.jpg",
            "vote_average": 5.04,
            "overview": "overview.",
            "first_air_date": "2010-06-08",
            "origin_country": ["US"],
            "genre_ids": [1, 2, 3],
            "original_language": "en",
            "vote_count": 133,
            "name": "Name",
            "original_name": "Original Name"
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
