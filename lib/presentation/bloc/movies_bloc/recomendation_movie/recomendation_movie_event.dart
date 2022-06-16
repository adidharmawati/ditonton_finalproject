part of 'recomendation_movie_bloc.dart';

abstract class RecomendationMovieEvent extends Equatable {
  const RecomendationMovieEvent();
}

class OnRecomendationMovieShow extends RecomendationMovieEvent {
  final int id;

  OnRecomendationMovieShow(this.id);

  @override
  List<Object?> get props => [];
}
