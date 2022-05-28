import 'package:films_viewer/components/buttons/primary_button.dart';
import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:films_viewer/components/locals/locals.dart';

class SettingsArgument {
  final MovieCardModel? model;
  final bool? isFavorite;
  SettingsArgument(this.model, this.isFavorite);
}

// ignore: must_be_immutable
class MovieCard extends StatelessWidget {
  final MovieCardModel? movieCardModel;
  final VoidCallback? onClickFavourite;
  final String? textButton;
  late bool? isFavorite;
  MovieCard({
    this.isFavorite,
    this.movieCardModel,
    this.onClickFavourite,
    this.textButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          SettingsArgument settingsArgument =
              SettingsArgument(movieCardModel, isFavorite);
          Navigator.pushNamed(context, '/detail', arguments: settingsArgument);
        },
        child: Container(
          width: 300,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black54.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: MovieColors.cardBlackColor,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${movieCardModel?.picture}',
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) =>
                        Image.network(MovieQuery.pisecImageUrl),
                    cacheManager: MoviePictures.pictureCache,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Text(
                  '${movieCardModel?.title} (${movieCardModel?.releaseDate})',
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                _voteAverage(context, movieCardModel?.voteAverage ?? 0),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                '${context.locale.language}: ${movieCardModel?.movieLanguage().toPrettyString()}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                  '${context.locale.runtime}: ${movieCardModel?.runtime.toString()} ${context.locale.min}'),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Html(data: movieCardModel?.description ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: PrimaryButton(textButton ?? '', onPressed: () {
                  onClickFavourite?.call();
                }),
              ),
            ],
          ),
        ));
  }

  String _voteAverage(BuildContext context, double voteAverage) {
    final prefix = context.locale.ratingPrefix;
    final suffix = context.locale.ratingSuffix;
    final _voteAverage = (voteAverage * 10).toInt();
    return '$prefix $_voteAverage $suffix';
  }
}
