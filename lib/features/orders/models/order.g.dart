// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: (json['id'] as num).toInt(),
  clientName: json['client_name'] as String,
  billingAddress: json['billing_address'] as String,
  shippingAddress: json['shipping_address'] as String,
  quantity: (json['quantity'] as num).toInt(),
  taxe: (json['taxe'] as num).toDouble(),
  orderCost: (json['order_cost'] as num).toDouble(),
  orderCostTtc: (json['order_cost_ttc'] as num).toDouble(),
  isPaid: json['is_paid'] as bool,
  carrierName: json['carrier_name'] as String,
  carrierPrice: (json['carrier_price'] as num).toDouble(),
  paymentMethod: json['payment_method'] as String,
  stripePaymentIntent: json['stripe_payment_intent'] as String?,
  status: json['status'] as String,
  statusDisplay: json['status_display'] as String,
  orderDetails:
      (json['order_details'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  paymentStatus: json['payment_status'] as String?,
  paymentProofUrl: json['payment_proof_url'] as String?,
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_name': instance.clientName,
      'billing_address': instance.billingAddress,
      'shipping_address': instance.shippingAddress,
      'quantity': instance.quantity,
      'taxe': instance.taxe,
      'order_cost': instance.orderCost,
      'order_cost_ttc': instance.orderCostTtc,
      'is_paid': instance.isPaid,
      'carrier_name': instance.carrierName,
      'carrier_price': instance.carrierPrice,
      'payment_method': instance.paymentMethod,
      'stripe_payment_intent': instance.stripePaymentIntent,
      'status': instance.status,
      'status_display': instance.statusDisplay,
      'order_details': instance.orderDetails,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'payment_status': instance.paymentStatus,
      'payment_proof_url': instance.paymentProofUrl,
    };
