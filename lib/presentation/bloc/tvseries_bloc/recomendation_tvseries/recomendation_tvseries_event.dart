part of 'recomendation_tvseries_bloc.dart';

abstract class RecomendationTVSeriesEvent extends Equatable {
  const RecomendationTVSeriesEvent();
}

class OnRecomendationTVSeriesShow extends RecomendationTVSeriesEvent {
  final int id;

  OnRecomendationTVSeriesShow(this.id);

  @override
  List<Object?> get props => [];
}
