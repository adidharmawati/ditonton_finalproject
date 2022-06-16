part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMovieEmpty extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieLoading extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieError extends WatchlistMovieState {
  String message;
  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class InsertWatchlist extends WatchlistMovieState {
  final bool status;

  InsertWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class MessageWatchlist extends WatchlistMovieState {
  final String message;

  MessageWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
