import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/created_by.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/last_episode_to_air.dart';
import 'package:tv_series/domain/entities/network_tv_series.dart';
import 'package:tv_series/domain/entities/production_company.dart';
import 'package:tv_series/domain/entities/production_country.dart';
import 'package:tv_series/domain/entities/spoken_langauge.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  popularity: 47.432451,
  id: 31917,
  backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
  voteAverage: 5.04,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  firstAirDate: "2010-06-08",
  originCountry: const ["US"],
  genreIds: const [18, 9648],
  originalLanguage: "en",
  voteCount: 133,
  name: "Pretty Little Liars",
  originalName: "Pretty Little Liars",
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
    backdropPath: "backdrop_path",
    createdBy: [
      CreatedBy(
          creditId: '1', gender: 1, name: 'Name', profilePath: 'profilePath')
    ],
    episodeRunTime: [60],
    firstAirDate: "2011-04-17",
    genres: [Genre(id: 1, name: 'Action')],
    homepage: "http://google.com",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2019-05-19",
    lastEpisodeToAir: LastEpisodeToAir(
        airDate: "2019-05-19",
        episodeNumber: 6,
        id: 1,
        name: "Name",
        overview:
            "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.",
        productionCode: "806",
        seasonNumber: 8,
        stillPath: "stillPath",
        voteAverage: 4.8,
        voteCount: 106),
    name: "name",
    nextEpisodeToAir: null,
    networks: [
      NetworkTvSeries(
          name: "HBO",
          id: 49,
          logoPath: "/tuomPhY2UtuPTqqFnKMVHvSb724.png",
          originCountry: "US")
    ],
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "originalName",
    overview: "overview",
    popularity: 369.594,
    posterPath: "posterPath",
    productionCompanies: [
      ProductionCompany(
          id: 76043,
          logoPath: "logoPath",
          name: "Revolution Sun Studios",
          originCountry: "US")
    ],
    productionCountries: [
      ProductionCountry(iso31661: "GB", name: "United Kingdom")
    ],
    seasons: [
      SeasonModel(
        airDate: "2010-12-05",
        episodeCount: 64,
        id: 3627,
        name: "Specials",
        overview: "sas",
        posterPath: "posterPath",
        seasonNumber: 0,
      )
    ],
    spokenLanguages: [
      SpokenLanguage(
        englishName: "English",
        iso6391: "en",
        name: "English",
      )
    ],
    status: "Ended",
    tagline: "Winter Is Coming",
    voteAverage: 8.3,
    voteCount: 11504);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
