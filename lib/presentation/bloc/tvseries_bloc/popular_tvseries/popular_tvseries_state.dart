part of 'popular_tvseries_bloc.dart';

abstract class PopularTVSeriesState extends Equatable {
  const PopularTVSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTVSeriesHasData extends PopularTVSeriesState {
  final List<TVSeries> result;

  PopularTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTVSeriesEmpty extends PopularTVSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTVSeriesLoading extends PopularTVSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTVSeriesError extends PopularTVSeriesState {
  final String message;

  PopularTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}


