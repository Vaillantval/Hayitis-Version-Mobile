// lib/features/reviews/models/review.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required int id,
    required int product,
    required int author,
    @JsonKey(name: 'author_name') required String authorName,
    required int rating,
    required String comment,
    @JsonKey(name: 'created_at')  required DateTime createdAt,
    @JsonKey(name: 'updated_at')  required DateTime updatedAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
