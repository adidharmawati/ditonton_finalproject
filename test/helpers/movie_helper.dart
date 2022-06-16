import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movies_bloc/detail_movie/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_bloc/recomendation_movie/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMovieEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMovieState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

class FakePopularMoviesEvent extends Fake implements PopularMovieEvent {}

class FakePopularMoviesState extends Fake implements PopularMovieState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedMovieEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMovieState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class FakeMovieDetailEvent extends Fake implements DetailMovieEvent {}

class FakeMovieDetailState extends Fake implements DetailMovieState {}

class FakeDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class FakeMovieRecommendationsEvent extends Fake
    implements RecomendationMovieEvent {}

class FakeMovieRecommendationsState extends Fake
    implements RecomendationMovieState {}

class FakeMovieRecommendationsBloc
    extends MockBloc<RecomendationMovieEvent, RecomendationMovieState>
    implements RecomendationMovieBloc {}

class FakeWatchlistMoviesEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}
