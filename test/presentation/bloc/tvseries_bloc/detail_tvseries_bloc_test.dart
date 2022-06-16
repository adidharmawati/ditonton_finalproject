import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/detail_tvseries/detail_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late DetailTVSeriesBloc detailTvSeriesBloc;
  late MockGetTVSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTVSeriesDetail();
    detailTvSeriesBloc = DetailTVSeriesBloc(mockGetTvSeriesDetail);
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

  group('bloc detail tv series testing', () {
    test('initial state should be empty', () {
      expect(detailTvSeriesBloc.state, DetailTVSeriesEmpty());
    });

    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnDetailTVSeriesShow(tId)),
      expect: () => [
        DetailTVSeriesLoading(),
        DetailTvSeriesHasData(testTvSeriesDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        return OnDetailTVSeriesShow(tId).props;
      },
    );

    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnDetailTVSeriesShow(tId)),
      expect: () => [
        DetailTVSeriesLoading(),
        DetailTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => DetailTVSeriesLoading(),
    );
  });
}