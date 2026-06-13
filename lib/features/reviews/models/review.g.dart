// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  id: (json['id'] as num).toInt(),
  product: (json['product'] as num).toInt(),
  author: (json['author'] as num).toInt(),
  authorName: json['author_name'] as String,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'author': instance.author,
      'author_name': instance.authorName,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
