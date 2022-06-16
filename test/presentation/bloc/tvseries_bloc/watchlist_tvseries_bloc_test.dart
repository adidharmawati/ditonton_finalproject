import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tvseries_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTVSeries,
  GetWatchListTVSeriesStatus,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries,
])
void main() {
  late WatchlistTVSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTvSeries;
  late MockGetWatchListTVSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockSaveWatchlistTVSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTVSeries();
    mockGetWatchListTvSeriesStatus = MockGetWatchListTVSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTVSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTVSeries();
    watchlistTvSeriesBloc = WatchlistTVSeriesBloc(
      mockGetWatchlistTvSeries,
      mockGetWatchListTvSeriesStatus,
      mockRemoveWatchlistTvSeries,
      mockSaveWatchlistTvSeries,
    );
  });

  final tId = 1;

  final testTvSeriesDetail = TVSeriesDetail(
    adult: false,
    backdropPath: "/1uegR4uAxRxiMyX4nQnpzbXhrTw.jpg",
    genres: [
      Genre(id: 10759, name: "Action & Adventure"),
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
      Season(
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

  final tTvSeries = TVSeries(
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
  final tTvSeriesList = <TVSeries>[tTvSeries];

  group('bloc watch list tv series testing', () {
    test('initial state should be empty', () {
      expect(watchlistTvSeriesBloc.state, WatchlistTVSeriesEmpty());
    });

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTVSeries()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
        return OnWatchlistTVSeries().props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTVSeries()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('bloc status watch list tv series testing', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTVSeries(tId)),
      expect: () => [InsertWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListTvSeriesStatus.execute(tId));
        return WatchlistTVSeries(tId).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTVSeries(tId)),
      expect: () => [InsertWatchlist(false)],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('bloc add watch list tv series testing', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        MessageWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        return InsertWatchlistTVSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistTVSeries(testTvSeriesDetail),
    );
  });

  group('bloc remove watch list tv series testing', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        MessageWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        return DeleteWatchlistTVSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistTVSeriesError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistTVSeries(testTvSeriesDetail),
    );
  });
}