import 'package:films_viewer/data/db/database.dart';

class MovieCardModel {
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
  final String? language;
  final int? runtime;
  const MovieCardModel({
    required this.id,
    required this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
    this.description,
    this.language,
    this.runtime,
  });
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
