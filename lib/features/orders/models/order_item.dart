// lib/features/orders/models/order_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item.freezed.dart';
part 'order_item.g.dart';

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required int id,
    @JsonKey(name: 'product_name')        required String productName,
    @JsonKey(name: 'product_description') required String productDescription,
    @JsonKey(name: 'solde_price')   required double soldePrice,
    @JsonKey(name: 'regular_price') required double regularPrice,
    required int quantity,
    required double taxe,
    @JsonKey(name: 'sub_total_ht')  required double subTotalHt,
    @JsonKey(name: 'sub_total_ttc') required double subTotalTtc,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
