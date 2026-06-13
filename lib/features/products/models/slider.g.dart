// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeroSlideImpl _$$HeroSlideImplFromJson(Map<String, dynamic> json) =>
    _$HeroSlideImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      buttonText: json['button_text'] as String,
      buttonLink: json['button_link'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$HeroSlideImplToJson(_$HeroSlideImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'button_text': instance.buttonText,
      'button_link': instance.buttonLink,
      'image': instance.image,
    };
