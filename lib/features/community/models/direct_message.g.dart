// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DmReplyToImpl _$$DmReplyToImplFromJson(Map<String, dynamic> json) =>
    _$DmReplyToImpl(
      id: (json['id'] as num).toInt(),
      senderName: json['sender'] as String? ?? '',
      excerpt: json['excerpt'] as String? ?? '',
    );

Map<String, dynamic> _$$DmReplyToImplToJson(_$DmReplyToImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.senderName,
      'excerpt': instance.excerpt,
    };

_$DirectMessageImpl _$$DirectMessageImplFromJson(Map<String, dynamic> json) =>
    _$DirectMessageImpl(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String? ?? '',
      isOwn: json['is_own'] as bool? ?? false,
      isAdmin: json['is_admin'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      replyTo:
          json['reply_to'] == null
              ? null
              : DmReplyTo.fromJson(json['reply_to'] as Map<String, dynamic>),
      audio: json['audio'] as String?,
      audioDuration: (json['audio_duration'] as num?)?.toInt() ?? 0,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$$DirectMessageImplToJson(_$DirectMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'is_own': instance.isOwn,
      'is_admin': instance.isAdmin,
      'created_at': instance.createdAt.toIso8601String(),
      'reply_to': instance.replyTo,
      'audio': instance.audio,
      'audio_duration': instance.audioDuration,
      'attachments': instance.attachments,
      'read': instance.read,
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
