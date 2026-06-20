// lib/features/products/models/product_detail.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_image.dart';
import 'product_price.dart';
import 'category.dart';

part 'product_detail.freezed.dart';
part 'product_detail.g.dart';

@freezed
class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    required int id,
    required String name,
    required String slug,
    required String description,
    required double price,
    @JsonKey(name: 'compare_at_price')  required double compareAtPrice,
    required String currency,
    required List<ProductImage> images,
    CategoryBrief? category,
    @JsonKey(name: 'in_stock')          required bool inStock,
    @JsonKey(name: 'stock_quantity')    required int stockQuantity,
    @JsonKey(name: 'rating_average')    double? ratingAverage,
    @JsonKey(name: 'rating_count')      required int ratingCount,
    @JsonKey(name: 'created_at')        required DateTime createdAt,
    @JsonKey(name: 'more_description')  String? moreDescription,
    @JsonKey(name: 'additional_info')   String? additionalInfo,
    String? brand,
    @JsonKey(name: 'is_best_seller')    required bool isBestSeller,
    @JsonKey(name: 'is_featured')       required bool isFeatured,
    @JsonKey(name: 'is_new_arrival')    required bool isNewArrival,
    @JsonKey(name: 'is_special_offer')  required bool isSpecialOffer,
    required List<CategoryBrief> categories,
    @JsonKey(name: 'updated_at')        required DateTime updatedAt,
    @Default([]) List<ProductPrice> prices,
  }) = _ProductDetail;

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);
}
