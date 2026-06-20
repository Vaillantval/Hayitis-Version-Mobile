// lib/features/cart/repositories/cart_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/cart.dart';

class CartRepository {
  final Dio _dio = ApiClient.instance;

  Future<Cart> getCart() async {
    try {
      final response = await _dio.get(Endpoints.cart);
      final root = response.data as Map<String, dynamic>;
      return Cart.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Cart> addToCart(int productId, int quantity, {int? priceId}) async {
    try {
      final response = await _dio.post(Endpoints.cartAdd, data: {
        'product_id': productId,
        'quantity':   quantity,
        if (priceId != null) 'price_id': priceId,
      });
      final root = response.data as Map<String, dynamic>;
      return Cart.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Cart> updateCartItem(int itemId, int quantity) async {
    try {
      final response = await _dio.patch(Endpoints.cartUpdate(itemId), data: {'quantity': quantity});
      final root = response.data as Map<String, dynamic>;
      return Cart.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Cart> removeCartItem(int itemId) async {
    try {
      final response = await _dio.delete(Endpoints.cartRemove(itemId));
      final root = response.data as Map<String, dynamic>;
      return Cart.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> clearCart() async {
    try {
      await _dio.delete(Endpoints.cartClear);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }
}
