// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderTrackingImpl _$$OrderTrackingImplFromJson(Map<String, dynamic> json) =>
    _$OrderTrackingImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      statusDisplay: json['status_display'] as String,
      isPaid: json['is_paid'] as bool,
      paymentMethod: json['payment_method'] as String,
      carrierName: json['carrier_name'] as String,
      shippingAddress: json['shipping_address'] as String,
      itemsCount: (json['items_count'] as num).toInt(),
      orderCostTtc: (json['order_cost_ttc'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$OrderTrackingImplToJson(_$OrderTrackingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'status_display': instance.statusDisplay,
      'is_paid': instance.isPaid,
      'payment_method': instance.paymentMethod,
      'carrier_name': instance.carrierName,
      'shipping_address': instance.shippingAddress,
      'items_count': instance.itemsCount,
      'order_cost_ttc': instance.orderCostTtc,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
