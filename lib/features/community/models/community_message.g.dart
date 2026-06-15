// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MsgProductImpl _$$MsgProductImplFromJson(Map<String, dynamic> json) =>
    _$MsgProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String? ?? '',
      price: json['price'] as String? ?? '',
    );

Map<String, dynamic> _$$MsgProductImplToJson(_$MsgProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'price': instance.price,
    };

_$MsgReplyToImpl _$$MsgReplyToImplFromJson(Map<String, dynamic> json) =>
    _$MsgReplyToImpl(
      id: (json['id'] as num).toInt(),
      authorName: json['author_name'] as String? ?? '',
      excerpt: json['excerpt'] as String? ?? '',
    );

Map<String, dynamic> _$$MsgReplyToImplToJson(_$MsgReplyToImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_name': instance.authorName,
      'excerpt': instance.excerpt,
    };

_$CommunityMessageImpl _$$CommunityMessageImplFromJson(
  Map<String, dynamic> json,
) => _$CommunityMessageImpl(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String? ?? '',
  authorName: json['author_name'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
  isPinned: json['is_pinned'] as bool? ?? false,
  isDeleted: json['is_deleted'] as bool? ?? false,
  isStaff: json['is_staff'] as bool? ?? false,
  isOwn: json['is_own'] as bool? ?? false,
  canModerate: json['can_moderate'] as bool? ?? false,
  replyTo:
      json['reply_to'] == null
          ? null
          : MsgReplyTo.fromJson(json['reply_to'] as Map<String, dynamic>),
  product:
      json['product'] == null
          ? null
          : MsgProduct.fromJson(json['product'] as Map<String, dynamic>),
  audio: json['audio'] as String?,
  audioDuration: (json['audio_duration'] as num?)?.toInt() ?? 0,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  reactions:
      (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  myReactions:
      (json['my_reactions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CommunityMessageImplToJson(
  _$CommunityMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'author_name': instance.authorName,
  'created_at': instance.createdAt.toIso8601String(),
  'is_pinned': instance.isPinned,
  'is_deleted': instance.isDeleted,
  'is_staff': instance.isStaff,
  'is_own': instance.isOwn,
  'can_moderate': instance.canModerate,
  'reply_to': instance.replyTo,
  'product': instance.product,
  'audio': instance.audio,
  'audio_duration': instance.audioDuration,
  'attachments': instance.attachments,
  'reactions': instance.reactions,
  'my_reactions': instance.myReactions,
};
