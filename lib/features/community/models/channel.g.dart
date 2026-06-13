// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelImpl _$$ChannelImplFromJson(Map<String, dynamic> json) =>
    _$ChannelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String? ?? '💬',
      color: json['color'] as String? ?? '#C62828',
      image: json['image'] as String?,
      canWrite: json['can_write'] as bool? ?? false,
      isFollowing: json['is_following'] as bool? ?? false,
      readAccess: json['read_access'] as String? ?? 'public',
      writeAccess: json['write_access'] as String? ?? 'open',
    );

Map<String, dynamic> _$$ChannelImplToJson(_$ChannelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'emoji': instance.emoji,
      'color': instance.color,
      'image': instance.image,
      'can_write': instance.canWrite,
      'is_following': instance.isFollowing,
      'read_access': instance.readAccess,
      'write_access': instance.writeAccess,
    };
