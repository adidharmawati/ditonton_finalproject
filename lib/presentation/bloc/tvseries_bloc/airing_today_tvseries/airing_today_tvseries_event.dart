part of 'airing_today_tvseries_bloc.dart';

abstract class AiringTodayTVSeriesEvent extends Equatable {
  const AiringTodayTVSeriesEvent();
}

class OnAiringTodayTVSeriesShow extends AiringTodayTVSeriesEvent {
  @override
  List<Object?> get props => [];
}