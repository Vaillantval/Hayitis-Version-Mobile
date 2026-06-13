// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryBriefImpl _$$CategoryBriefImplFromJson(Map<String, dynamic> json) =>
    _$CategoryBriefImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$$CategoryBriefImplToJson(_$CategoryBriefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
      isMega: json['is_mega'] as bool? ?? false,
      productCount: (json['product_count'] as num?)?.toInt() ?? 0,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'description': instance.description,
      'is_mega': instance.isMega,
      'product_count': instance.productCount,
      'created_at': instance.createdAt?.toIso8601String(),
    };
