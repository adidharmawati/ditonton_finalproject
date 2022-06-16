part of 'detail_tvseries_bloc.dart';

abstract class DetailTVSeriesEvent extends Equatable {
  const DetailTVSeriesEvent();
}

class OnDetailTVSeriesShow extends DetailTVSeriesEvent {
  final int id;

  OnDetailTVSeriesShow(this.id);

  @override
  List<Object> get props => [];
}
