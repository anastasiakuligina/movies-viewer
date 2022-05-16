import 'package:dio/dio.dart';
import 'package:films_viewer/data/dtos/movie_card_dto.dart';
import 'package:films_viewer/domain/models/home_model.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/data/mappers/movie_card_mapper.dart';
import 'package:films_viewer/components/dialogs/error_dialog.dart';

class MoviesRepository {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

  static Future<HomeModel?> loadData(
    BuildContext context, {
    required String q,
  }) async {
    try {
      const String url = MovieQuery.baseUrl;
      final Response<dynamic> response = await _dio.get<List<dynamic>>(
        url,
        queryParameters: <String, dynamic>{'q': q},
      );
      final dtos = <MovieCardDTO>[];
      final responseList = response.data as List<dynamic>;
      for (final data in responseList) {
        dtos.add(MovieCardDTO.fromJson(data as Map<String, dynamic>));
      }

      final movieModels = <MovieCardModel>[];
      for (final dto in dtos) {
        movieModels.add(dto.toDomain());
      }

      final HomeModel model = HomeModel(results: movieModels);
      return model;
    } on DioError catch (error) {
      final statusCode = error.response?.statusCode;
      showErrorDialog(context, error: statusCode?.toString() ?? '');
      return null;
    }
  }
}
