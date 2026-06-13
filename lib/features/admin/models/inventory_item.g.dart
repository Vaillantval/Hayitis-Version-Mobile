// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryItemImpl _$$InventoryItemImplFromJson(Map<String, dynamic> json) =>
    _$InventoryItemImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      stockQuantity: (json['stock'] as num).toInt(),
      isAvailable: json['is_available'] as bool,
      soldePrice: (json['solde_price'] as num).toDouble(),
      regularPrice: (json['regular_price'] as num).toDouble(),
    );

Map<String, dynamic> _$$InventoryItemImplToJson(_$InventoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'stock': instance.stockQuantity,
      'is_available': instance.isAvailable,
      'solde_price': instance.soldePrice,
      'regular_price': instance.regularPrice,
    };
