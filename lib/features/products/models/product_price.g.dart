// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPriceImpl _$$ProductPriceImplFromJson(Map<String, dynamic> json) =>
    _$ProductPriceImpl(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      regularPrice: (json['regular_price'] as num?)?.toDouble(),
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductPriceImplToJson(_$ProductPriceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'price': instance.price,
      'regular_price': instance.regularPrice,
      'order': instance.order,
    };
