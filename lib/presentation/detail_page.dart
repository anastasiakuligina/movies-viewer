import 'package:films_viewer/components/widgets/film_tile.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:films_viewer/presentation/home/movie_card.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  // DetailPage({required this.model, Key? key}) : super(key: key);
  DetailPage({required this.settingsArguments, Key? key}) : super(key: key);
  late MovieCardModel model;
  late SettingsArgument settingsArguments;
  late bool isFavorite;
  static const String routeName = '/detail';
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Детальная информация'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/detailSettings',
                      arguments: widget.settingsArguments);
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Column(children: [
          FilmTile(
            id: widget.settingsArguments.model?.id ?? 0,
            title: widget.settingsArguments.model?.title ?? '',
            picture: widget.settingsArguments.model?.picture,
            voteAverage: widget.settingsArguments.model?.voteAverage,
            releaseDate: widget.settingsArguments.model?.releaseDate,
            description: widget.settingsArguments.model?.description,
            language: widget.settingsArguments.model?.language,
            checkable: false,
            isFavorite: widget.settingsArguments.isFavorite ?? false,
          ),
        ]));
  }
}
