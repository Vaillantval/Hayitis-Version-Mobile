// lib/features/orders/models/order.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required int id,
    @JsonKey(name: 'client_name')      required String clientName,
    @JsonKey(name: 'billing_address')  required String billingAddress,
    @JsonKey(name: 'shipping_address') required String shippingAddress,
    required int quantity,
    required double taxe,
    @JsonKey(name: 'order_cost')       required double orderCost,
    @JsonKey(name: 'order_cost_ttc')   required double orderCostTtc,
    @JsonKey(name: 'is_paid')          required bool isPaid,
    @JsonKey(name: 'carrier_name')     required String carrierName,
    @JsonKey(name: 'carrier_price')    required double carrierPrice,
    @JsonKey(name: 'payment_method')   required String paymentMethod,
    @JsonKey(name: 'stripe_payment_intent') String? stripePaymentIntent,
    required String status,
    @JsonKey(name: 'status_display')   required String statusDisplay,
    @JsonKey(name: 'order_details')    required List<OrderItem> orderDetails,
    @JsonKey(name: 'created_at')       required DateTime createdAt,
    @JsonKey(name: 'updated_at')       required DateTime updatedAt,
    @JsonKey(name: 'payment_status')    String? paymentStatus,
    @JsonKey(name: 'payment_proof_url') String? paymentProofUrl,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
