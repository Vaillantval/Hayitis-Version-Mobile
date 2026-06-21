// lib/features/wishlist/repositories/wishlist_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/wishlist_item.dart';

class WishlistRepository {
  final Dio _dio = ApiClient.instance;

  Future<List<WishlistItem>> getWishlist() async {
    try {
      final response = await _dio.get(Endpoints.wishlist);
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> addToWishlist(int productId) async {
    try {
      await _dio.post(Endpoints.wishlistAdd, data: {'product_id': productId});
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> removeFromWishlist(int wishlistItemId) async {
    try {
      await _dio.delete(Endpoints.wishlistRemove(wishlistItemId));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
