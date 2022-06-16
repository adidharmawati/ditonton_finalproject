part of 'search_tvseries_bloc.dart';

abstract class SearchTVSeriesEvent extends Equatable {
  const SearchTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchTVSeriesEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
