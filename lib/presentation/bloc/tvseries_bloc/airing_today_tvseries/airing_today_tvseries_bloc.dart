import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_tvseries_event.dart';
part 'airing_today_tvseries_state.dart';

class AiringTodayTVSeriesBloc
    extends Bloc<AiringTodayTVSeriesEvent, AiringTodayTVSeriesState> {
  final GetAiringTodayTVSeries _getAiringTodayTvSeries;

  AiringTodayTVSeriesBloc(this._getAiringTodayTvSeries)
      : super(AiringTodayTVSeriesEmpty()) {
    on<OnAiringTodayTVSeriesShow>((event, emit) async {
      emit(AiringTodayTVSeriesLoading());
      final result = await _getAiringTodayTvSeries.execute();

      result.fold(
        (failure) {
          emit(AiringTodayTVSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(AiringTodayTVSeriesEmpty());
          } else {
            emit(AiringTodayTVSeriesHasData(data));
          }
        },
      );
    });
  }
}
