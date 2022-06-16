import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tvseries_event.dart';
part 'watchlist_tvseries_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  final GetWatchlistTVSeries _getWatchlistTvSeries;
  final GetWatchListTVSeriesStatus _getWatchListTvSeriesStatus;
  final RemoveWatchlistTVSeries _removeWatchlistTvSeries;
  final SaveWatchlistTVSeries _saveWatchlistTvSeries;

  WatchlistTVSeriesBloc(
    this._getWatchlistTvSeries,
    this._getWatchListTvSeriesStatus,
    this._removeWatchlistTvSeries,
    this._saveWatchlistTvSeries,
  ) : super(WatchlistTVSeriesEmpty()) {
    on<OnWatchlistTVSeries>((event, emit) async {
      emit(WatchlistTVSeriesLoading());

      final result = await _getWatchlistTvSeries.execute();

      result.fold(
        (failure) {
          emit(WatchlistTVSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(WatchlistTVSeriesEmpty());
          } else {
            emit(WatchlistTVSeriesHasData(data));
          }
        },
      );
    });

    on<WatchlistTVSeries>((event, emit) async {
      final id = event.id;

      final result = await _getWatchListTvSeriesStatus.execute(id);

      emit(InsertWatchlist(result));
    });

    on<InsertWatchlistTVSeries>((event, emit) async {
      emit(WatchlistTVSeriesLoading());
      final movie = event.movie;

      final result = await _saveWatchlistTvSeries.execute(movie);

      result.fold(
        (failure) {
          emit(WatchlistTVSeriesError(failure.message));
        },
        (message) {
          emit(MessageWatchlist(message));
        },
      );
    });

    on<DeleteWatchlistTVSeries>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlistTvSeries.execute(movie);

      result.fold(
        (failure) {
          emit(WatchlistTVSeriesError(failure.message));
        },
        (message) {
          emit(MessageWatchlist(message));
        },
      );
    });
  }
}