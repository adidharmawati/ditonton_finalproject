import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tvseries_event.dart';
part 'detail_tvseries_state.dart';

class DetailTVSeriesBloc
    extends Bloc<DetailTVSeriesEvent, DetailTVSeriesState> {
  final GetTVSeriesDetail _getTvSeriesDetail;

  DetailTVSeriesBloc(this._getTvSeriesDetail) : super(DetailTVSeriesEmpty()) {
    on<OnDetailTVSeriesShow>(
      (event, emit) async {
        final id = event.id;

        emit(DetailTVSeriesLoading());
        final result = await _getTvSeriesDetail.execute(id);

        result.fold(
          (failure) {
            emit(DetailTVSeriesError(failure.message));
          },
          (data) {
            emit(DetailTvSeriesHasData(data));
          },
        );
      },
    );
  }
}

