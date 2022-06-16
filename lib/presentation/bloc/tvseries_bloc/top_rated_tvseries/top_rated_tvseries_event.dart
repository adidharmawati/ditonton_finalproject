part of 'top_rated_tvseries_bloc.dart';

abstract class TopRatedTVSeriesEvent extends Equatable {
  const TopRatedTVSeriesEvent();
}

class OnTopRatedTvSeriesShow extends TopRatedTVSeriesEvent {
  @override
  List<Object?> get props => [];
}
