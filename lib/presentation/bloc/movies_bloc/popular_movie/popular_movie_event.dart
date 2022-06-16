part of 'popular_movie_bloc.dart';

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();
}

class OnPopularMovieShow extends PopularMovieEvent {
  @override
  List<Object?> get props => [];
}
