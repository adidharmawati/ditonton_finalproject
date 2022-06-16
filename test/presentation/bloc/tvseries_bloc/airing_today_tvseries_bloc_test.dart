import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/airing_today_tvseries/airing_today_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTVSeries])
void main() {
  late AiringTodayTVSeriesBloc airingTodayTvSeriesBloc;
  late MockGetAiringTodayTVSeries mockGetAiringTodayTvSeries;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTVSeries();
    airingTodayTvSeriesBloc =
        AiringTodayTVSeriesBloc(mockGetAiringTodayTvSeries);
  });

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

  group('bloc airing today tv series testing', () {
    test('initial state should be empty', () {
      expect(airingTodayTvSeriesBloc.state, AiringTodayTVSeriesEmpty());
    });

    blocTest<AiringTodayTVSeriesBloc, AiringTodayTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodayTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return airingTodayTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnAiringTodayTVSeriesShow()),
      expect: () => [
        AiringTodayTVSeriesLoading(),
        AiringTodayTVSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTvSeries.execute());
        return OnAiringTodayTVSeriesShow().props;
      },
    );

    blocTest<AiringTodayTVSeriesBloc, AiringTodayTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetAiringTodayTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return airingTodayTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnAiringTodayTVSeriesShow()),
      expect: () => [
        AiringTodayTVSeriesLoading(),
        AiringTodayTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => AiringTodayTVSeriesLoading(),
    );
  });
}