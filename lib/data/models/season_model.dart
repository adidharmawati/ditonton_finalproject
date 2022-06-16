import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.seasonNumber,
    required this.airDate,
    required this.overview,
    required this.posterPath,
  });

  final int id;
  final String name;
  final int episodeCount;
  final int seasonNumber;
  final String? airDate;
  final String? overview;
  final String? posterPath;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        episodeCount: json["episode_count"],
        seasonNumber: json["season_number"],
        airDate: json["air_date"],
        overview: json["overview"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "episode_count": episodeCount,
        "season_number": seasonNumber,
        "air_date": airDate,
        "overview": overview,
        "poster_path": posterPath,
      };

  Season toEntity() {
    return Season(
      id: this.id,
      name: this.name,
      episodeCount: this.episodeCount,
      seasonNumber: this.seasonNumber,
      airDate: this.airDate,
      overview: this.overview,
      posterPath: this.posterPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        seasonNumber,
        airDate,
        overview,
        posterPath,
      ];
}
