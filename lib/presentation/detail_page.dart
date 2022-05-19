import 'package:films_viewer/components/widgets/film_tile.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  DetailPage({required this.model, Key? key}) : super(key: key);
  late MovieCardModel model;
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
                      arguments: widget.model);
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Column(children: [
          FilmTile(
            id: widget.model.id,
            title: widget.model.title,
            picture: widget.model.picture,
            voteAverage: widget.model.voteAverage,
            releaseDate: widget.model.releaseDate,
            description: widget.model.description,
            language: widget.model.language,
            checkable: false,
          ),
        ]));
  }
}
