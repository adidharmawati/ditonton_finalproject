part of 'detail_tvseries_bloc.dart';

abstract class DetailTVSeriesState extends Equatable {
  const DetailTVSeriesState();

  @override
  List<Object> get props => [];
}

class DetailTvSeriesHasData extends DetailTVSeriesState {
  final TVSeriesDetail result;

  DetailTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class DetailTVSeriesEmpty extends DetailTVSeriesState {
  @override
  List<Object> get props => [];
}

class DetailTVSeriesLoading extends DetailTVSeriesState {
  @override
  List<Object> get props => [];
}

class DetailTVSeriesError extends DetailTVSeriesState {
  String message;
  DetailTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

