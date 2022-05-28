import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/domain/models/home_model.dart';
import 'package:films_viewer/presentation/home/bloc/home_bloc.dart';
import 'package:films_viewer/presentation/home/bloc/home_event.dart';
import 'package:films_viewer/presentation/home/bloc/home_state.dart';
import 'package:films_viewer/presentation/home/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);
  static const String path = '/favouritePage';
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (oldState, newState) =>
                  oldState.favouritesMovies != newState.favouritesMovies,
              builder: (context, state) {
                return FutureBuilder<HomeModel?>(
                    future: state.data,
                    builder:
                        (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: data.data?.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              bool isFavourite = false;
                              if (state.favouritesMovies?.isNotEmpty == true) {
                                var moviesFavourite = state.favouritesMovies
                                    ?.firstWhereOrNull((element) =>
                                        element?.id ==
                                        data.data?.results?[index].id);
                                if (moviesFavourite != null) {
                                  isFavourite = true;
                                }
                              }
                              if (isFavourite) {
                                return MovieCard(
                                  textButton: MovieLocal.deleteFromFavourites,
                                  onClickFavourite: () {
                                    context.read<HomeBloc>().add(
                                          ChangedFavourites(
                                              model:
                                                  data.data?.results?[index]),
                                        );
                                  },
                                  movieCardModel: data.data?.results?[index],
                                  key: ValueKey<int>(
                                      data.data?.results?[index].id ?? -1),
                                );
                              } else {
                                return const Text('');
                              }
                            }),
                      );
                    });
              })
        ],
      ),
    );
  }
}
