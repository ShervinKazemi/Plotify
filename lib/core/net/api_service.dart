
import 'package:dio/dio.dart';
import 'package:plotify/core/constants.dart';
import 'package:plotify/core/model/movies.dart';

/// Service class for API requests using Dio.
class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConstants.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 15),
                headers: {'Accept': 'application/json'},
                responseType: ResponseType.json,
              ),
            );

  Future<Movies> getMovies(int page) async {
    try {
      final response = await _dio.get(
        Endpoints.movies,
        queryParameters: {'page': page},
      );
      return Movies.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to fetch movies: \\${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
