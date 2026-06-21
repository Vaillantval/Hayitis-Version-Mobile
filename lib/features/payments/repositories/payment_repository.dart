// lib/features/payments/repositories/payment_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../../checkout/models/payment_init_response.dart';

class PaymentRepository {
  final Dio _dio = ApiClient.instance;

  Future<PaymentInitResponse> initiate({
    required int orderId,
    required String method,
  }) async {
    try {
      final response = await _dio.post(Endpoints.paymentInitiate, data: {
        'order_id':       orderId,
        'payment_method': method,
      });
      final root = response.data as Map<String, dynamic>;
      return PaymentInitResponse.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<bool> verify({required int orderId, String? transactionId}) async {
    try {
      final response = await _dio.post(Endpoints.paymentVerify, data: {
        'order_id': orderId,
        if (transactionId != null) 'transaction_id': transactionId,
      });
      final data = response.data as Map<String, dynamic>;
      return data['success'] == true;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
