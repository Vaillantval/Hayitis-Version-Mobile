// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectMessageImpl _$$DirectMessageImplFromJson(Map<String, dynamic> json) =>
    _$DirectMessageImpl(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      isFromClient: json['is_from_client'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DirectMessageImplToJson(_$DirectMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'is_from_client': instance.isFromClient,
      'created_at': instance.createdAt.toIso8601String(),
      'attachments': instance.attachments,
    };

_$SupportConversationImpl _$$SupportConversationImplFromJson(
  Map<String, dynamic> json,
) => _$SupportConversationImpl(
  id: (json['id'] as num).toInt(),
  clientName: json['client_name'] as String,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  lastMessage: json['last_message'] as String?,
  lastAt:
      json['last_at'] == null
          ? null
          : DateTime.parse(json['last_at'] as String),
);

Map<String, dynamic> _$$SupportConversationImplToJson(
  _$SupportConversationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'client_name': instance.clientName,
  'unread_count': instance.unreadCount,
  'last_message': instance.lastMessage,
  'last_at': instance.lastAt?.toIso8601String(),
};
