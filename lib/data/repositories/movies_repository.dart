import 'package:dio/dio.dart';
import 'package:films_viewer/data/dtos/movie_card_dto.dart';
import 'package:films_viewer/domain/models/home_model.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/data/mappers/movie_card_mapper.dart';
import 'package:films_viewer/data/repositories/interceptors/dio_error_interceptor.dart';

class MoviesRepository {
  final Function(String, String) onErrorHandler;
  late final Dio _dio;
  MoviesRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);
  }
  Future<HomeModel?> loadData({
    required String q,
  }) async {
    // try {
    const String url = MovieQuery.baseUrl;
    final response = await _dio.get<List<dynamic>>(
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
  }
}
