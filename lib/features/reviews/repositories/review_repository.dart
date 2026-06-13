// lib/features/reviews/repositories/review_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/review.dart';

class ReviewRepository {
  final Dio _dio = ApiClient.instance;

  Future<List<Review>> getReviews(int productId) async {
    try {
      final response = await _dio.get(Endpoints.reviews, queryParameters: {'product': productId});
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Review> createReview({
    required int productId,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await _dio.post(Endpoints.reviews, data: {
        'product_id': productId,
        'rating':     rating,
        'comment':    comment,
      });
      final root = response.data as Map<String, dynamic>;
      return Review.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> deleteReview(int id) async {
    try {
      await _dio.delete(Endpoints.reviewDetail(id));
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }
}
