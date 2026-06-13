// lib/features/products/models/product.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_image.dart';
import 'category.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required String slug,
    required String description,
    required double price,
    @JsonKey(name: 'compare_at_price') required double compareAtPrice,
    required String currency,
    required List<ProductImage> images,
    CategoryBrief? category,
    @JsonKey(name: 'in_stock')       required bool inStock,
    @JsonKey(name: 'stock_quantity') required int stockQuantity,
    @JsonKey(name: 'rating_average') double? ratingAverage,
    @JsonKey(name: 'rating_count')   required int ratingCount,
    @JsonKey(name: 'created_at')     required DateTime createdAt,
    String? brand,
    @JsonKey(name: 'more_description') String? moreDescription,
    @JsonKey(name: 'additional_info')  String? additionalInfo,
    @JsonKey(name: 'is_featured')      @Default(false) bool isFeatured,
    @JsonKey(name: 'is_new_arrival')   @Default(false) bool isNewArrival,
    @JsonKey(name: 'is_best_seller')   @Default(false) bool isBestSeller,
    @JsonKey(name: 'is_special_offer') @Default(false) bool isSpecialOffer,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
