import 'package:json_annotation/json_annotation.dart';

part 'movie_card_dto.g.dart';

@JsonSerializable()
class MovieCardDTO {
  @JsonKey(name: 'score')
  final double? score;

  @JsonKey(name: 'show')
  final MovieCardDataDTO? show;

  MovieCardDTO({
    this.score,
    this.show,
  });

  factory MovieCardDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieCardDTOFromJson(json);
}

@JsonSerializable()
class MovieCardDataDTO {
  MovieCardDataDTO({
    required this.id,
    required this.title,
    required this.picture,
    this.releaseDate,
    this.description,
    this.language,
    this.runtime,
  });
  factory MovieCardDataDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieCardDataDTOFromJson(json);

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'name', defaultValue: '')
  final String title;

  @JsonKey(name: 'image')
  final MovieCardDataImageDTO? picture;

  @JsonKey(name: 'premiered')
  final String? releaseDate;

  @JsonKey(name: 'summary')
  final String? description;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'runtime')
  final int? runtime;
}

@JsonSerializable()
class MovieCardDataImageDTO {
  @JsonKey(name: 'original', defaultValue: '')
  final String? original;

  MovieCardDataImageDTO({
    this.original,
  });

  factory MovieCardDataImageDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieCardDataImageDTOFromJson(json);
}
