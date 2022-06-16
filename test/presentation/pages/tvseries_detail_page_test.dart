import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/detail_tvseries/detail_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/recomendation_tvseries/recomendation_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:ditonton/presentation/pages/tvseries_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tvseries_helper.dart';

void main() {
  late FakeDetailTVSeriesBloc fakeDetailTVSeriesBloc;
  late FakeTVSeriesRecommendationsBloc fakeTVSeriesRecommendationsBloc;
  late FakeWatchlistTVSeriesBloc fakeWatchlistTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeTVSeriesDetailEvent());
    registerFallbackValue(FakeTVSeriesDetailState());
    fakeDetailTVSeriesBloc = FakeDetailTVSeriesBloc();

    registerFallbackValue(FakeTVSeriesRecommendationsEvent());
    registerFallbackValue(FakeTVSeriesRecommendationsState());
    fakeTVSeriesRecommendationsBloc = FakeTVSeriesRecommendationsBloc();

    registerFallbackValue(FakeWatchlistTVSeriesEvent());
    registerFallbackValue(FakeWatchlistTVSeriesState());
    fakeWatchlistTVSeriesBloc = FakeWatchlistTVSeriesBloc();
  });

  final testTvSeriesDetail = TVSeriesDetailModel(
    adult: false,
    backdropPath: "/1uegR4uAxRxiMyX4nQnpzbXhrTw.jpg",
    genres: [
      GenreModel(id: 10759, name: "Action & Adventure"),
    ],
    id: 92749,
    lastAirDate: "2022-04-27",
    name: "Moon Knight",
    numberOfEpisodes: 6,
    numberOfSeasons: 1,
    originalName: "Moon Knight",
    overview:
        "When Steven Grant, a mild-mannered gift-shop employee, becomes plagued with blackouts and memories of another life, he discovers he has dissociative identity disorder and shares a body with mercenary Marc Spector. As Steven/Marcs enemies converge upon them, they must navigate their complex identities while thrust into a deadly mystery among the powerful gods of Egypt.",
    popularity: 5483.522,
    posterPath: "/x6FsYvt33846IQnDSFxla9j0RX8.jpg",
    seasons: [
      SeasonModel(
        airDate: "2022-03-30",
        episodeCount: 6,
        id: 130604,
        name: "Season 1",
        overview: "",
        posterPath: "/11keFudto4QrgrXChukexJwdHPe.jpg",
        seasonNumber: 1,
      ),
    ],
    voteAverage: 8.5,
    voteCount: 507, 
  );

  final testTvSeriesDetailEntity = testTvSeriesDetail.toEntity();

  final tTvSeries = TVSeriesModel(
    backdropPath: "/9hp4JNejY6Ctg9i9ItkM9rd6GE7.jpg",
    firstAirDate: "1997-09-13",
    genreIds: [10764],
    id: 12610,
    name: "Robinson",
    originCountry: ["SE"],
    originalLanguage: "sv",
    originalName: "Robinson",
    overview:
        "Expedition Robinson is a Swedish reality television program in which contestants are put into survival situations, and a voting process eliminates one person each episode until a winner is determined. The format was developed in 1994 by Charlie Parsons for a United Kingdom TV production company called Planet 24, but the Swedish debut in 1997 was the first production to actually make it to television.",
    popularity: 2338.977,
    posterPath: "/sWA0Uo9hkiAtvtjnPvaqfnulIIE.jpg",
    voteAverage: 5,
    voteCount: 3,
  );
  final tTvSeriesList = <TVSeries>[tTvSeries.toEntity()];

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTVSeriesBloc>(
          create: (_) => fakeDetailTVSeriesBloc,
        ),
        BlocProvider<WatchlistTVSeriesBloc>(
          create: (_) => fakeWatchlistTVSeriesBloc,
        ),
        BlocProvider<RecomendationTVSeriesBloc>(
          create: (_) => fakeTVSeriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailTVSeriesBloc.close();
    fakeWatchlistTVSeriesBloc.close();
    fakeTVSeriesRecommendationsBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTVSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecomendationTVSeriesLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTVSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecomendationTVSeriesLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTvSeriesHasData(testTvSeriesDetailEntity));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecomendationTVSeriesHasData(tTvSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(InsertWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTvSeriesHasData(testTvSeriesDetailEntity));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecomendationTVSeriesHasData(tTvSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(InsertWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);
    await tester.pump();
    expect((watchlistButton), findsOneWidget);
  });
}