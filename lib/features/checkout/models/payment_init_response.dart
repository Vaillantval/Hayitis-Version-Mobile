// lib/features/checkout/models/payment_init_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_init_response.freezed.dart';
part 'payment_init_response.g.dart';

@freezed
class PaymentInitResponse with _$PaymentInitResponse {
  const factory PaymentInitResponse({
    required String method,
    @JsonKey(name: 'order_id')       required int orderId,
    // Stripe
    @JsonKey(name: 'client_secret')  String? clientSecret,
    @JsonKey(name: 'public_key')     String? publicKey,
    @JsonKey(name: 'amount_htg')     double? amountHtg,
    @JsonKey(name: 'amount_usd')     double? amountUsd,
    // MonCash
    @JsonKey(name: 'redirect_url')   String? redirectUrl,
    @JsonKey(name: 'payment_token')  String? paymentToken,
    // MonCash + NatCash
    double? amount,
    // NatCash
    String? message,
    String? reference,
  }) = _PaymentInitResponse;

  factory PaymentInitResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentInitResponseFromJson(json);
}
