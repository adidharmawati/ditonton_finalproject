import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/detail_tvseries/detail_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/recomendation_tvseries/recomendation_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries_bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvseries';

  final int id;
  TVSeriesDetailPage({required this.id});

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTVSeriesBloc>().add(OnDetailTVSeriesShow(widget.id));
      context
          .read<RecomendationTVSeriesBloc>()
          .add(OnRecomendationTVSeriesShow(widget.id));
      context.read<WatchlistTVSeriesBloc>().add(WatchlistTVSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchlistStatus =
        context.select<WatchlistTVSeriesBloc, bool>((value) {
      if (value.state is InsertWatchlist) {
        return (value.state as InsertWatchlist).status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<DetailTVSeriesBloc, DetailTVSeriesState>(
        builder: (context, state) {
          if (state is DetailTVSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvSeriesHasData) {
            final tvSeries = state.result;
            return SafeArea(
              child: DetailContent(
                tvSeries,
                watchlistStatus,
              ),
            );
          } else if (state is DetailTVSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVSeriesDetail tvSeries;
  late bool isAddedWatchlist;

  DetailContent(this.tvSeries, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context.read<WatchlistTVSeriesBloc>().add(
                                      InsertWatchlistTVSeries(widget.tvSeries));
                                } else {
                                  context.read<WatchlistTVSeriesBloc>().add(
                                      DeleteWatchlistTVSeries(widget.tvSeries));
                                }

                                final state =
                                    BlocProvider.of<WatchlistTVSeriesBloc>(
                                            context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String removeMessage = "Removed from Watchlist";

                                if (state is InsertWatchlist) {
                                  final isAdded = state.status;
                                  if (isAdded == false) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                } else {
                                  if (!widget.isAddedWatchlist) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                }

                                if (message == insertMessage ||
                                    message == removeMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      action: SnackBarAction(
                                        label: 'See Watchlist',
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              WatchlistTVSeriesPage.ROUTE_NAME);
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Text(
                              _showSeasonEpisode(
                                  widget.tvSeries.numberOfSeasons,
                                  widget.tvSeries.numberOfEpisodes),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecomendationTVSeriesBloc,
                                RecomendationTVSeriesState>(
                              builder: (context, state) {
                                if (state is RecomendationTVSeriesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecomendationTVSeriesError) {
                                  return Text(state.message);
                                } else if (state
                                    is RecomendationTVSeriesHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else {
                                  return Text('There is no recommendations');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showSeasonEpisode(int numberOfSeason, int numberOsEpisode) {
    return '${numberOfSeason} season, ${numberOsEpisode} episode';
  }
}
