import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recomendation.dart';
import 'package:equatable/equatable.dart';

part 'recomendation_tvseries_event.dart';
part 'recomendation_tvseries_state.dart';

class RecomendationTVSeriesBloc
    extends Bloc<RecomendationTVSeriesEvent, RecomendationTVSeriesState> {
  final GetTVSeriesRecommendation _getTvSeriesRecommendations;

  RecomendationTVSeriesBloc(this._getTvSeriesRecommendations)
      : super(RecomendationTVSeriesEmpty()) {
    on<OnRecomendationTVSeriesShow>((event, emit) async {
      final id = event.id;

      emit(RecomendationTVSeriesLoading());
      final result = await _getTvSeriesRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(RecomendationTVSeriesError(failure.message));
        },
        (data) {
          emit(RecomendationTVSeriesHasData(data));
        },
      );
    });
  }
}
