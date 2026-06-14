import 'package:freezed_annotation/freezed_annotation.dart';
part 'direct_message.freezed.dart';
part 'direct_message.g.dart';

@freezed
class DirectMessage with _$DirectMessage {
  const factory DirectMessage({
    required int id,
    required String content,
    @JsonKey(name: 'is_from_client') @Default(false) bool isFromClient,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default([]) List<String> attachments,
  }) = _DirectMessage;
  factory DirectMessage.fromJson(Map<String, dynamic> json) => _$DirectMessageFromJson(json);
}

@freezed
class SupportConversation with _$SupportConversation {
  const factory SupportConversation({
    required int id,
    @JsonKey(name: 'client_name') required String clientName,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_at') DateTime? lastAt,
  }) = _SupportConversation;
  factory SupportConversation.fromJson(Map<String, dynamic> json) =>
      _$SupportConversationFromJson(json);
}
