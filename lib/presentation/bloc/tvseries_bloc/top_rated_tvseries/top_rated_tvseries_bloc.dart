import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tvseries_event.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTVSeries _getTopRatedTvSeries;

  TopRatedTVSeriesBloc(this._getTopRatedTvSeries)
      : super(TopRatedTVSeriesEmpty()) {
    on<OnTopRatedTvSeriesShow>((event, emit) async {
      emit(TopRatedTVSeriesLoading());
      final result = await _getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TopRatedTVSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(TopRatedTVSeriesEmpty());
          } else {
            emit(TopRatedTVSeriesHasData(data));
          }
        },
      );
    });
  }
}
