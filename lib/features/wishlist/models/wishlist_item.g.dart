// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistItemImpl _$$WishlistItemImplFromJson(Map<String, dynamic> json) =>
    _$WishlistItemImpl(
      id: (json['id'] as num).toInt(),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$WishlistItemImplToJson(_$WishlistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'created_at': instance.createdAt.toIso8601String(),
    };
