// lib/features/products/models/category.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class CategoryBrief with _$CategoryBrief {
  const factory CategoryBrief({
    required int id,
    required String name,
    required String slug,
  }) = _CategoryBrief;

  factory CategoryBrief.fromJson(Map<String, dynamic> json) =>
      _$CategoryBriefFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    required String slug,
    String? image,
    String? description,
    @JsonKey(name: 'is_mega')       @Default(false) bool isMega,
    @JsonKey(name: 'product_count') @Default(0)     int productCount,
    @JsonKey(name: 'created_at')    DateTime? createdAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
