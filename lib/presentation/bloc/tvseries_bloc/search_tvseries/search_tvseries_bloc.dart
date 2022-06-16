import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tvseries_event.dart';
part 'search_tvseries_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries _searchTvSeries;

  SearchTVSeriesBloc(this._searchTvSeries) : super(SearchTVSeriesEmpty()) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    }

    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTVSeriesLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchTVSeriesError(failure.message));
        },
        (data) {
          emit(SearchTVSeriesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

