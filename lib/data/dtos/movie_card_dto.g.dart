// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCardDTO _$MovieCardDTOFromJson(Map<String, dynamic> json) => MovieCardDTO(
      score: (json['score'] as num?)?.toDouble(),
      show: json['show'] == null
          ? null
          : MovieCardDataDTO.fromJson(json['show'] as Map<String, dynamic>),
    );

// ignore: unused_element
Map<String, dynamic> _$MovieCardDTOToJson(MovieCardDTO instance) =>
    <String, dynamic>{
      'score': instance.score,
      'show': instance.show,
    };

MovieCardDataDTO _$MovieCardDataDTOFromJson(Map<String, dynamic> json) =>
    MovieCardDataDTO(
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? '',
      picture: json['image'] == null
          ? null
          : MovieCardDataImageDTO.fromJson(
              json['image'] as Map<String, dynamic>),
      releaseDate: json['premiered'] as String?,
      description: json['summary'] as String?,
      language: json['language'] as String?,
      runtime: json['runtime'] as int?,
    );

// ignore: unused_element
Map<String, dynamic> _$MovieCardDataDTOToJson(MovieCardDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'image': instance.picture,
      'premiered': instance.releaseDate,
      'summary': instance.description,
      'language': instance.language,
      'runtime': instance.runtime,
    };

MovieCardDataImageDTO _$MovieCardDataImageDTOFromJson(
        Map<String, dynamic> json) =>
    MovieCardDataImageDTO(
      original: json['original'] as String? ?? '',
    );

// ignore: unused_element
Map<String, dynamic> _$MovieCardDataImageDTOToJson(
        MovieCardDataImageDTO instance) =>
    <String, dynamic>{
      'original': instance.original,
    };
