part of 'recomendation_movie_bloc.dart';

abstract class RecomendationMovieState extends Equatable {
  const RecomendationMovieState();

  @override
  List<Object> get props => [];
}

class RecomendationMovieHasData extends RecomendationMovieState {
  final List<Movie> result;

  RecomendationMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class RecomendationMovieEmpty extends RecomendationMovieState {
  @override
  List<Object> get props => [];
}

class RecomendationMovieLoading extends RecomendationMovieState {
  @override
  List<Object> get props => [];
}

class RecomendationMovieError extends RecomendationMovieState {
  String message;
  RecomendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}

