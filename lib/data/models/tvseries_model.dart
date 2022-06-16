import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TVSeriesModel extends Equatable {
  TVSeriesModel({
    required this.id,
    required this.genreIds,
    required this.name,
    required this.backdropPath,
    required this.firstAirDate,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  int id;
  List<int> genreIds;
  String name;
  String? backdropPath;
  String? firstAirDate;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  double voteAverage;
  int voteCount;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
        id: json["id"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"],
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "name": name,
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVSeries toEntity() {
    return TVSeries(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originCountry: this.originCountry,
      originalName: this.originalName,
      originalLanguage: this.originalLanguage,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }


  @override
  List<Object?> get props => [
        id,
        genreIds,
        name,
        backdropPath,
        firstAirDate,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}