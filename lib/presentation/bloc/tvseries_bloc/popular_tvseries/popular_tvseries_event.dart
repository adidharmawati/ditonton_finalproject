part of 'popular_tvseries_bloc.dart';

abstract class PopularTVSeriesEvent extends Equatable {
  const PopularTVSeriesEvent();
}

class OnPopularTvSeriesShow extends PopularTVSeriesEvent {
  @override
  List<Object?> get props => [];
}
