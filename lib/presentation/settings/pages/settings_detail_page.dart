import 'package:films_viewer/components/buttons/primary_button.dart';
import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/components/widgets/film_tile.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:films_viewer/presentation/settings/bloc/detail_setting_bloc.dart';
import 'package:films_viewer/presentation/settings/bloc/detail_setting_event.dart';
import 'package:films_viewer/presentation/settings/bloc/detail_setting_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SettingsDetailPage extends StatelessWidget {
  SettingsDetailPage({required this.model, Key? key}) : super(key: key);
  static const path = '/detailSettings';
  late MovieCardModel model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailSettingBloc>(
      lazy: false,
      create: (_) => DetailSettingBloc()..add(ClearDetailPageEvent()),
      child: SettingsDetailPageContent(model),
    );
  }
}

// ignore: must_be_immutable
class SettingsDetailPageContent extends StatefulWidget {
  late MovieCardModel model;
  SettingsDetailPageContent(this.model, {Key? key}) : super(key: key);
  @override
  _SettingsDetailPageContentState createState() =>
      _SettingsDetailPageContentState();
}

class _SettingsDetailPageContentState extends State<SettingsDetailPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<DetailSettingBloc, DetailSettingState>(
                buildWhen: (oldState, newState) =>
                    oldState.model != newState.model,
                builder: (context, state) {
                  if (state.model != null) {
                    return FilmTile(
                      id: state.model?.id ?? 0,
                      title: state.model?.title ?? '',
                      picture: state.model?.picture ?? MovieQuery.pisecImageUrl,
                      voteAverage: state.model?.voteAverage ?? 0,
                      releaseDate: state.model?.releaseDate ?? '',
                      description: state.model?.description ?? '',
                      language: state.model?.language,
                      checkable: false,
                    );
                  } else {
                    return const Text(
                      MovieLocal.noDataTitle,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Verdana',
                          fontSize: 23),
                    );
                  }
                }),
            PrimaryButton(MovieLocal.getDataButtonTitle, onPressed: () {
              context.read<DetailSettingBloc>().add(
                    SaveDetailPageEvent(model: widget.model),
                  );
            }),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.arrow_back),
                    Text('Back'),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
