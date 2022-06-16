part of 'watchlist_tvseries_bloc.dart';

abstract class WatchlistTVSeriesEvent extends Equatable {
  const WatchlistTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnWatchlistTVSeries extends WatchlistTVSeriesEvent {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeries extends WatchlistTVSeriesEvent {
  final int id;

  WatchlistTVSeries(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail movie;

  InsertWatchlistTVSeries(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail movie;

  DeleteWatchlistTVSeries(this.movie);

  @override
  List<Object> get props => [movie];
}
