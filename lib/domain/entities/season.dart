import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
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
