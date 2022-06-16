import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TVSeries extends Equatable {
  TVSeries({
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

  TVSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  int id;
  List<int>? genreIds;
  String? name;
  String? backdropPath;
  String? firstAirDate;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

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
