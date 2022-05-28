import 'package:films_viewer/data/db/database.dart';

enum Language { english, spanish, unknown }

abstract class CardModel {
  int id;
  String title;
  String? picture;
  double? voteAverage;
  String? releaseDate;
  String? description;
  String? language;
  int? runtime;
  bool? isFavorite;
  CardModel(
      this.id,
      this.title,
      this.picture,
      this.voteAverage,
      this.releaseDate,
      this.description,
      this.language,
      this.runtime,
      this.isFavorite);
}

class MovieCardModel extends CardModel with MovieLanguage {
  MovieCardModel(
      {required int id,
      required String title,
      String? picture,
      double? voteAverage,
      String? releaseDate,
      String? description,
      String? language,
      int? runtime,
      bool? isFavorite})
      : super(id, title, picture ?? '', voteAverage, releaseDate, description,
            language, runtime, isFavorite);
}

extension MovieCardModelToDatabase on MovieCardModel {
  MovieTableData toDatabase() {
    return MovieTableData(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
    );
  }
}

extension MovieTableDataToDomain on MovieTableData {
  MovieCardModel toDomain() {
    return MovieCardModel(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
    );
  }
}

mixin MovieLanguage on CardModel {
  Language movieLanguage() {
    Language currentLanguage = Language.unknown;
    for (var element in Language.values) {
      if (element.name == language?.toLowerCase()) currentLanguage = element;
    }
    return currentLanguage;
  }
}

extension LanguageToRusString on Language {
  String toPrettyString() {
    switch (this) {
      case Language.english:
        return 'Английский';
      case Language.spanish:
        return 'Испанский';
      default:
        return 'Неизвестный';
    }
  }
}
