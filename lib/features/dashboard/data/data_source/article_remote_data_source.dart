import 'package:crimson_cycle/config/constants/api_endpoint.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/http_service.dart';
import 'package:crimson_cycle/features/dashboard/data/model/article_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleDataSourceProvider = Provider<ArticleDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  return ArticleDataSource(dio);
});

class ArticleDataSource {
  final Dio _dio;
  ArticleDataSource(this._dio);

  // Get data from articles with pagination
  Future<Either<Failure, List<Article>>> getArticles(int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getArticles,
        queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limitPage,
        },
      );
      if (response.data is Map<String, dynamic> &&
          response.data['articles'] is List) {
        final data = response.data['articles'] as List;
        final articles = data
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(articles);
      } else {
        // Handle unexpected response format
        return Left(Failure(
          error: 'Invalid response format',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
