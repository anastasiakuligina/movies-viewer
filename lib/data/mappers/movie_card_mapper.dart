import 'package:films_viewer/data/dtos/movie_card_dto.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';

extension MovieCardFromDTOToDomain on MovieCardDTO {
  MovieCardModel toDomain() {
    return MovieCardModel(
      id: show?.id ?? 0,
      title: show?.title ?? '',
      picture: show?.picture?.original ?? '',
      releaseDate: show?.releaseDate,
      voteAverage: score,
      description: show?.description,
      language: show?.language,
      runtime: show?.runtime,
    );
  }
}
