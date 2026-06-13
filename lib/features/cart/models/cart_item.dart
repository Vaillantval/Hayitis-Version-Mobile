// lib/features/cart/models/cart_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../products/models/product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int id,
    required Product product,
    required int quantity,
    required double subtotal,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
