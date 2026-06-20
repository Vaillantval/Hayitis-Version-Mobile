import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_price.freezed.dart';
part 'product_price.g.dart';

@freezed
class ProductPrice with _$ProductPrice {
  const factory ProductPrice({
    required int id,
    @Default('') String label,
    required double price,
    @JsonKey(name: 'regular_price') double? regularPrice,
    @Default(0) int order,
  }) = _ProductPrice;

  factory ProductPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductPriceFromJson(json);
}
