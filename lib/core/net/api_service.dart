import 'package:dio/dio.dart';
import 'package:plotify/core/constatns/constants.dart';
import 'package:plotify/core/model/movie.dart';

import '../model/movies.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio =
      dio ??
          Dio(
            BaseOptions(
              baseUrl: AppConstants.baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              headers: {'Accept': 'application/json'},
              responseType: ResponseType.json,
            ),
          );

  Future<Movies> getSearchMovies(String query, {int page = 1}) async {
    try {
      Response response = await _dio.get(
        Endpoints.movies,
          queryParameters: { "q": query, "page": page}
      );

      if (response.statusCode == 200) {
        return Movies.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("Failed to connect to server");
      }
    } catch (exception) {
      throw Exception("Failed to fetch search movies: $exception");
    }
  }

  Future<Movies> getMovies(int page) async {
    try {
      Response response = await _dio.get(
          Endpoints.movies,
          queryParameters: {"page": page}
      );
      if (response.statusCode == 200) {
        return Movies.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("Failed to connect to server");
      }
    } catch (exception) {
      throw Exception("Failed to fetch movies: $exception");
    }
  }

  Future<Movie> getMovieById(int id) async {
    try {
      Response response = await _dio.get(
        "${Endpoints.movies}/$id"
      );
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("Failed to connect to server");
      }
    } catch (exception) {
      throw Exception("Failed to fetch movie: $exception");
    }
  }

}
