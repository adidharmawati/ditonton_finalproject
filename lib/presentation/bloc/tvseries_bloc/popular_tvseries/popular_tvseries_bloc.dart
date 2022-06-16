import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTVSeries _getPopularTvSeries;

  PopularTVSeriesBloc(this._getPopularTvSeries)
      : super(PopularTVSeriesEmpty()) {
    on<OnPopularTvSeriesShow>((event, emit) async {
      emit(PopularTVSeriesLoading());
      final result = await _getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(PopularTVSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(PopularTVSeriesEmpty());
          } else {
            emit(PopularTVSeriesHasData(data));
          }
        },
      );
    });
  }
}