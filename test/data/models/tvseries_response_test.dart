import 'dart:convert';

import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries_reesponse.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TVSeriesModel(
    backdropPath: "/jO803koX4pYjGuxjOkLytCusuJm.jpg",
    firstAirDate: "2010-11-08",
    genreIds: [10767, 35, 10763],
    id: 32415,
    name: "Conan",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Conan",
    overview:
        "A late night television talk show hosted by  Conan O'Brien.",
    popularity: 72.987,
    posterPath: "/oQxrvUhP3ycwnlxIrIMQ9Z3kleq.jpg",
    voteAverage: 7.2,
    voteCount: 166,
  );
  final tTvSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tvseries_airing_today.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
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
            "backdrop_path": "/jO803koX4pYjGuxjOkLytCusuJm.jpg",
            "first_air_date": "2010-11-08",
            "genre_ids": [10767, 35, 10763],
            "id": 32415,
            "name": "Conan",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Conan",
            "overview":
                "A late night television talk show hosted by  Conan O'Brien.",
            "popularity": 72.987,
            "poster_path": "/oQxrvUhP3ycwnlxIrIMQ9Z3kleq.jpg",
            "vote_average": 7.2,
            "vote_count": 166
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
