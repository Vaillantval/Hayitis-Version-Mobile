// lib/features/cart/models/cart.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  const factory Cart({
    required List<CartItem> items,
    @JsonKey(name: 'subtotal_ht')  required double subtotalHt,
    @JsonKey(name: 'tax_rate')     required double taxRate,
    @JsonKey(name: 'tax_amount')   required double taxAmount,
    @JsonKey(name: 'subtotal_ttc') required double subtotalTtc,
    @JsonKey(name: 'total_items')  required int totalItems,
    required String currency,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
