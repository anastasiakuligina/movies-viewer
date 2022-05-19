import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/components/delayed_action.dart';
import 'package:films_viewer/domain/models/home_model.dart';
import 'package:films_viewer/presentation/home/bloc/home_bloc.dart';
import 'package:films_viewer/presentation/home/bloc/home_event.dart';
import 'package:films_viewer/presentation/home/bloc/home_state.dart';
import 'package:films_viewer/presentation/home/movie_card.dart';
import 'package:films_viewer/presentation/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);
  static const String path = '/movies';
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    SettingsPage.path,
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: MovieColors.backgroundBlackColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: TextField(
                controller: textController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: MovieLocal.search,
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: _onSearchFieldTextChanged,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (oldState, newState) =>
                    oldState.data != newState.data ||
                    oldState.favouritesMovies != newState.favouritesMovies,
                builder: (context, state) {
                  return FutureBuilder<HomeModel?>(
                    future: state.data,
                    builder:
                        (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                      return data.connectionState != ConnectionState.done
                          ? const Center(child: CircularProgressIndicator())
                          : data.hasData
                              ? data.data?.results?.isNotEmpty == true
                                  ? Expanded(
                                      child: RefreshIndicator(
                                        child: ListView.builder(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            bool isFavourite = false;
                                            if (state.favouritesMovies
                                                    ?.isNotEmpty ==
                                                true) {
                                              var moviesFavourite = state
                                                  .favouritesMovies
                                                  ?.firstWhereOrNull(
                                                      (element) =>
                                                          element?.id ==
                                                          data
                                                              .data
                                                              ?.results?[index]
                                                              .id);
                                              if (moviesFavourite != null) {
                                                isFavourite = true;
                                              }
                                            }
                                            return MovieCard(
                                              textButton: (isFavourite)
                                                  ? MovieLocal
                                                      .deleteFromFavourites
                                                  : MovieLocal.addInFavourites,
                                              onClickFavourite: () {
                                                context.read<HomeBloc>().add(
                                                      ChangedFavourites(
                                                          model: data.data
                                                                  ?.results?[
                                                              index]),
                                                    );
                                              },
                                              movieCardModel:
                                                  data.data?.results?[index],
                                              key: ValueKey<int>(data.data
                                                      ?.results?[index].id ??
                                                  -1),
                                            );
                                          },
                                          itemCount:
                                              data.data?.results?.length ?? 0,
                                        ),
                                        onRefresh: _onRefresh,
                                      ),
                                    )
                                  : const _Empty()
                              : const _Error();
                    },
                  );
                })
          ],
        ),
      ),
    );
  }

  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      context.read<HomeBloc>().add(SearchChangedEvent(search: text));
    });
  }

  Future<void> _onRefresh() async {
    DelayedAction.run(() {
      context.read<HomeBloc>().add(PullToRefreshEvent());
    });
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.pisecImageUrl,
      fit: BoxFit.cover,
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.nothingImageUrl,
      fit: BoxFit.cover,
    );
  }
}
