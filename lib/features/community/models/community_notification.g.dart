// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityNotificationImpl _$$CommunityNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityNotificationImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  actorName: json['actor_name'] as String,
  message: json['message'] as String,
  isRead: json['is_read'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$CommunityNotificationImplToJson(
  _$CommunityNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'actor_name': instance.actorName,
  'message': instance.message,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
};
