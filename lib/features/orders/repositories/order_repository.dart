// lib/features/orders/repositories/order_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/order.dart';
import '../models/order_tracking.dart';

class OrderRepository {
  final Dio _dio = ApiClient.instance;

  Future<List<Order>> getOrders({int page = 1}) async {
    try {
      final response = await _dio.get(Endpoints.orders, queryParameters: {'page': page});
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Order> createOrder({
    required List<Map<String, dynamic>> items,
    required String paymentMethod,
    required Map<String, dynamic> deliveryAddress,
    String? notes,
  }) async {
    try {
      final response = await _dio.post(Endpoints.orders, data: {
        'items':            items,
        'payment_method':   paymentMethod,
        'delivery_address': deliveryAddress,
        if (notes != null) 'notes': notes,
      });
      final root = response.data as Map<String, dynamic>;
      return Order.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Order> getOrderDetail(int id) async {
    try {
      final response = await _dio.get(Endpoints.orderDetail(id));
      final root = response.data as Map<String, dynamic>;
      return Order.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> cancelOrder(int id) async {
    try {
      await _dio.post(Endpoints.orderCancel(id));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<OrderTracking> trackOrder(int id, String email) async {
    try {
      final response = await _dio.get(
        Endpoints.orderTrack(id),
        queryParameters: {'email': email},
        options: Options(headers: {}),
      );
      final root = response.data as Map<String, dynamic>;
      return OrderTracking.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
