import 'package:cached_network_image/cached_network_image.dart';
import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class FilmTile extends StatelessWidget {
  FilmTile(
      {required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description,
      required this.language,
      required this.checkable,
      required this.isFavorite,
      Key? key})
      : super(key: key);
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
  final String? language;
  late bool checkable = false;
  late bool isFavorite = false;
  factory FilmTile.fromModel(
      {required MovieCardModel model, required bool checkable, Key? key}) {
    return FilmTile(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      description: model.description,
      language: model.language,
      checkable: checkable,
      isFavorite: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: CachedNetworkImage(
          imageUrl: '$picture',
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Image.network(MovieQuery.pisecImageUrl),
          cacheManager: MoviePictures.pictureCache,
        )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.star, color: Colors.yellow),
                      ),
                      Text(
                        _voteAverage(voteAverage ?? 0),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    '${MovieLocal.releaseDate}: $releaseDate',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Html(data: description ?? ''),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  color: (isFavorite) ? Colors.red : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _voteAverage(double voteAverage) {
    const prefix = MovieLocal.ratingPrefix;
    const suffix = MovieLocal.ratingSuffix;
    final _voteAverage = (voteAverage * 10).toInt();
    return '$prefix $_voteAverage $suffix';
  }
}
