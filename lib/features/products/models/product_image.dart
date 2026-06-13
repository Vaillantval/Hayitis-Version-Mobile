// lib/features/products/models/product_image.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_image.freezed.dart';
part 'product_image.g.dart';

@freezed
class ProductImage with _$ProductImage {
  const factory ProductImage({
    required int id,
    required String image,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
}
