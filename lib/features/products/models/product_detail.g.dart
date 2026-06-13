// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductDetailImpl _$$ProductDetailImplFromJson(Map<String, dynamic> json) =>
    _$ProductDetailImpl(
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
      moreDescription: json['more_description'] as String?,
      additionalInfo: json['additional_info'] as String?,
      brand: json['brand'] as String?,
      isBestSeller: json['is_best_seller'] as bool,
      isFeatured: json['is_featured'] as bool,
      isNewArrival: json['is_new_arrival'] as bool,
      isSpecialOffer: json['is_special_offer'] as bool,
      categories:
          (json['categories'] as List<dynamic>)
              .map((e) => CategoryBrief.fromJson(e as Map<String, dynamic>))
              .toList(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ProductDetailImplToJson(_$ProductDetailImpl instance) =>
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
      'more_description': instance.moreDescription,
      'additional_info': instance.additionalInfo,
      'brand': instance.brand,
      'is_best_seller': instance.isBestSeller,
      'is_featured': instance.isFeatured,
      'is_new_arrival': instance.isNewArrival,
      'is_special_offer': instance.isSpecialOffer,
      'categories': instance.categories,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
