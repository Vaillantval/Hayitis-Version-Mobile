// lib/core/network/api_error.dart
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String code;
  final String message;
  final int? statusCode;

  ApiException({
    required this.code,
    required this.message,
    this.statusCode,
  });

  factory ApiException.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    final error = json['error'] as Map<String, dynamic>?;
    final code = error?['code'] as String? ?? 'UNKNOWN';
    return ApiException(
      code: code,
      message: _friendlyMessage(code),
      statusCode: statusCode,
    );
  }

  factory ApiException.fromDio(DioException e) {
    final data = e.response?.data;
    return ApiException.fromJson(
      data is Map<String, dynamic> ? data : <String, dynamic>{},
      statusCode: e.response?.statusCode,
    );
  }

  static String _friendlyMessage(String code) => switch (code) {
    'OUT_OF_STOCK'           => 'Ce produit est épuisé.',
    'INSUFFICIENT_STOCK'     => 'Stock insuffisant pour cette quantité.',
    'ORDER_NOT_CANCELLABLE'  => 'Cette commande ne peut plus être annulée.',
    'PAYMENT_FAILED'         => 'Le paiement a échoué. Veuillez réessayer.',
    'INVALID_CREDENTIALS'    => 'Email ou mot de passe incorrect.',
    'TOKEN_EXPIRED'          => 'Session expirée, veuillez vous reconnecter.',
    'PERMISSION_DENIED'      => 'Accès non autorisé.',
    'UNVERIFIED_PURCHASE'    => 'Vous devez avoir acheté ce produit pour laisser un avis.',
    _                        => 'Une erreur est survenue. Veuillez réessayer.',
  };

  @override
  String toString() => 'ApiException($code): $message';
}
