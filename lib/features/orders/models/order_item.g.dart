// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: (json['id'] as num).toInt(),
      productName: json['product_name'] as String,
      productDescription: json['product_description'] as String,
      soldePrice: (json['solde_price'] as num).toDouble(),
      regularPrice: (json['regular_price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      taxe: (json['taxe'] as num).toDouble(),
      subTotalHt: (json['sub_total_ht'] as num).toDouble(),
      subTotalTtc: (json['sub_total_ttc'] as num).toDouble(),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_description': instance.productDescription,
      'solde_price': instance.soldePrice,
      'regular_price': instance.regularPrice,
      'quantity': instance.quantity,
      'taxe': instance.taxe,
      'sub_total_ht': instance.subTotalHt,
      'sub_total_ttc': instance.subTotalTtc,
    };
