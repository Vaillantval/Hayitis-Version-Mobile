// lib/features/wishlist/models/wishlist_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../products/models/product.dart';

part 'wishlist_item.freezed.dart';
part 'wishlist_item.g.dart';

@freezed
class WishlistItem with _$WishlistItem {
  const factory WishlistItem({
    required int id,
    required Product product,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _WishlistItem;

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemFromJson(json);
}
