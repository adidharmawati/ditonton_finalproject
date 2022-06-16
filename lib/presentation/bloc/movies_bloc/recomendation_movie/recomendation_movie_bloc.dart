import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recomendation_movie_event.dart';
part 'recomendation_movie_state.dart';

class RecomendationMovieBloc
    extends Bloc<RecomendationMovieEvent, RecomendationMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecomendationMovieBloc(this._getMovieRecommendations)
      : super(RecomendationMovieEmpty()) {
    on<OnRecomendationMovieShow>((event, emit) async {
      final id = event.id;

      emit(RecomendationMovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(RecomendationMovieError(failure.message));
        },
        (data) {
          emit(RecomendationMovieHasData(data));
        },
      );
    });
  }
}
