import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/airing_today_tvseries/airing_today_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/detail_tvseries/detail_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/recomendation_tvseries/recomendation_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeOnTheAirNowTVSeriesEvent extends Fake
    implements AiringTodayTVSeriesEvent {}

class FakeOnTheAirNowTVSeriesState extends Fake
    implements AiringTodayTVSeriesEvent {}

class FakeOnTheAirNowTVSeriesBloc
    extends MockBloc<AiringTodayTVSeriesEvent, AiringTodayTVSeriesEvent>
    implements AiringTodayTVSeriesEvent {}

// Popular
class FakePopularTVSeriesEvent extends Fake implements PopularTVSeriesEvent {}

class FakePopularTVSeriesState extends Fake implements PopularTVSeriesState {}

class FakePopularTVSeriesBloc
    extends MockBloc<PopularTVSeriesEvent, PopularTVSeriesState>
    implements PopularTVSeriesBloc {}

// Top Rated
class FakeTopRatedTVSeriesEvent extends Fake implements TopRatedTVSeriesEvent {}

class FakeTopRatedTVSeriesState extends Fake implements TopRatedTVSeriesEvent {}

class FakeTopRatedTVSeriesBloc
    extends MockBloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState>
    implements TopRatedTVSeriesBloc {}

// Detail Tv Series
class FakeTVSeriesDetailEvent extends Fake implements DetailTVSeriesEvent {}

class FakeTVSeriesDetailState extends Fake implements DetailTVSeriesState {}

class FakeDetailTVSeriesBloc
    extends MockBloc<DetailTVSeriesEvent, DetailTVSeriesState>
    implements DetailTVSeriesBloc {}

// Recomendaion
class FakeTVSeriesRecommendationsEvent extends Fake
    implements RecomendationTVSeriesEvent {}

class FakeTVSeriesRecommendationsState extends Fake
    implements RecomendationTVSeriesState {}

class FakeTVSeriesRecommendationsBloc
    extends MockBloc<RecomendationTVSeriesEvent, RecomendationTVSeriesState>
    implements RecomendationTVSeriesBloc {}

// Watch List
class FakeWatchlistTVSeriesEvent extends Fake
    implements WatchlistTVSeriesEvent {}

class FakeWatchlistTVSeriesState extends Fake
    implements WatchlistTVSeriesState {}

class FakeWatchlistTVSeriesBloc
    extends MockBloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}