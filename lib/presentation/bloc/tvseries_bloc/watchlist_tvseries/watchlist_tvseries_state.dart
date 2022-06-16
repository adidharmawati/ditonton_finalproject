part of 'watchlist_tvseries_bloc.dart';

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final List<TVSeries> result;

  WatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  String message;
  WatchlistTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class InsertWatchlist extends WatchlistTVSeriesState {
  final bool status;

  InsertWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class MessageWatchlist extends WatchlistTVSeriesState {
  final String message;

  MessageWatchlist(this.message);

  @override
  List<Object> get props => [message];
}