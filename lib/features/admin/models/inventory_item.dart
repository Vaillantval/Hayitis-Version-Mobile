// lib/features/admin/models/inventory_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

@freezed
class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required int id,
    required String name,
    required String slug,
    @JsonKey(name: 'stock')        required int stockQuantity,
    @JsonKey(name: 'is_available') required bool isAvailable,
    @JsonKey(name: 'solde_price')   required double soldePrice,
    @JsonKey(name: 'regular_price') required double regularPrice,
  }) = _InventoryItem;

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
}
