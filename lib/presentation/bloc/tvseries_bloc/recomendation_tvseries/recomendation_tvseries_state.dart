part of 'recomendation_tvseries_bloc.dart';

abstract class RecomendationTVSeriesState extends Equatable {
  const RecomendationTVSeriesState();

  @override
  List<Object> get props => [];
}

class RecomendationTVSeriesHasData extends RecomendationTVSeriesState {
  final List<TVSeries> result;

  RecomendationTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class RecomendationTVSeriesEmpty extends RecomendationTVSeriesState {
  @override
  List<Object> get props => [];
}

class RecomendationTVSeriesLoading extends RecomendationTVSeriesState {
  @override
  List<Object> get props => [];
}

class RecomendationTVSeriesError extends RecomendationTVSeriesState {
  String message;
  RecomendationTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

