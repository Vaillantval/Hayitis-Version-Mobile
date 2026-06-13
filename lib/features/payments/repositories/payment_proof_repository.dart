// lib/features/payments/repositories/payment_proof_repository.dart
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';

class PaymentProofRepository {
  final Dio _dio = ApiClient.instance;

  Future<void> uploadProof({required int orderId, required File file}) async {
    try {
      final formData = FormData.fromMap({
        'order_id': orderId,
        'payment_proof': await MultipartFile.fromFile(
          file.path,
          filename: 'proof_order_$orderId.jpg',
        ),
      });
      await _dio.post(
        Endpoints.paymentOffline,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }
}
