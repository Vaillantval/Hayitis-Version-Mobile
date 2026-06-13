// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      compareAtPrice: (json['compare_at_price'] as num).toDouble(),
      currency: json['currency'] as String,
      images:
          (json['images'] as List<dynamic>)
              .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList(),
      category:
          json['category'] == null
              ? null
              : CategoryBrief.fromJson(
                json['category'] as Map<String, dynamic>,
              ),
      inStock: json['in_stock'] as bool,
      stockQuantity: (json['stock_quantity'] as num).toInt(),
      ratingAverage: (json['rating_average'] as num?)?.toDouble(),
      ratingCount: (json['rating_count'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      brand: json['brand'] as String?,
      moreDescription: json['more_description'] as String?,
      additionalInfo: json['additional_info'] as String?,
      isFeatured: json['is_featured'] as bool? ?? false,
      isNewArrival: json['is_new_arrival'] as bool? ?? false,
      isBestSeller: json['is_best_seller'] as bool? ?? false,
      isSpecialOffer: json['is_special_offer'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'price': instance.price,
      'compare_at_price': instance.compareAtPrice,
      'currency': instance.currency,
      'images': instance.images,
      'category': instance.category,
      'in_stock': instance.inStock,
      'stock_quantity': instance.stockQuantity,
      'rating_average': instance.ratingAverage,
      'rating_count': instance.ratingCount,
      'created_at': instance.createdAt.toIso8601String(),
      'brand': instance.brand,
      'more_description': instance.moreDescription,
      'additional_info': instance.additionalInfo,
      'is_featured': instance.isFeatured,
      'is_new_arrival': instance.isNewArrival,
      'is_best_seller': instance.isBestSeller,
      'is_special_offer': instance.isSpecialOffer,
    };
