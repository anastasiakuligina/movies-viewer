import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/components/delayed_action.dart';
import 'package:films_viewer/data/repositories/movies_repository.dart';
import 'package:films_viewer/domain/models/home_model.dart';
import 'package:films_viewer/presentation/home/movie_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();
  Future<HomeModel?>? dataLoadingState;
  Future<void> _onRefresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  }

  @override
  void didChangeDependencies() {
    dataLoadingState ??=
        MoviesRepository.loadData(context, q: MovieQuery.initialQ);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            FutureBuilder<HomeModel?>(
              future: dataLoadingState,
              builder: (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                return data.connectionState != ConnectionState.done
                    ? const Center(child: CircularProgressIndicator())
                    : data.hasData
                        ? data.data?.results?.isNotEmpty == true
                            ? Expanded(
                                child: RefreshIndicator(
                                  child: ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MovieCard(
                                        movieCardModel:
                                            data.data?.results?[index],
                                        key: ValueKey<int>(
                                            data.data?.results?[index].id ??
                                                -1),
                                      );
                                    },
                                    itemCount: data.data?.results?.length ?? 0,
                                  ),
                                  onRefresh: _onRefresh,
                                ),
                              )
                            : const _Empty()
                        : const _Error();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      dataLoadingState = MoviesRepository.loadData(
        context,
        q: text.isNotEmpty ? text : MovieQuery.initialQ,
      );
      setState(() {});
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
