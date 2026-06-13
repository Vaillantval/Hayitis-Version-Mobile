// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
  items:
      (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  subtotalHt: (json['subtotal_ht'] as num).toDouble(),
  taxRate: (json['tax_rate'] as num).toDouble(),
  taxAmount: (json['tax_amount'] as num).toDouble(),
  subtotalTtc: (json['subtotal_ttc'] as num).toDouble(),
  totalItems: (json['total_items'] as num).toInt(),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'subtotal_ht': instance.subtotalHt,
      'tax_rate': instance.taxRate,
      'tax_amount': instance.taxAmount,
      'subtotal_ttc': instance.subtotalTtc,
      'total_items': instance.totalItems,
      'currency': instance.currency,
    };
