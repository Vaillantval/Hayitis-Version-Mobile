// lib/features/orders/models/order_tracking.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_tracking.freezed.dart';
part 'order_tracking.g.dart';

@freezed
class OrderTracking with _$OrderTracking {
  const factory OrderTracking({
    required int id,
    required String status,
    @JsonKey(name: 'status_display')   required String statusDisplay,
    @JsonKey(name: 'is_paid')          required bool isPaid,
    @JsonKey(name: 'payment_method')   required String paymentMethod,
    @JsonKey(name: 'carrier_name')     required String carrierName,
    @JsonKey(name: 'shipping_address') required String shippingAddress,
    @JsonKey(name: 'items_count')      required int itemsCount,
    @JsonKey(name: 'order_cost_ttc')   required double orderCostTtc,
    @JsonKey(name: 'created_at')       required DateTime createdAt,
    @JsonKey(name: 'updated_at')       required DateTime updatedAt,
  }) = _OrderTracking;

  factory OrderTracking.fromJson(Map<String, dynamic> json) =>
      _$OrderTrackingFromJson(json);
}
