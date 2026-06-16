import 'package:freezed_annotation/freezed_annotation.dart';
part 'community_message.freezed.dart';
part 'community_message.g.dart';

@freezed
class MsgProduct with _$MsgProduct {
  const factory MsgProduct({
    required int id,
    @Default('') String name,
    @Default('') String slug,
    @Default('') String image,
    // Backend always sends a pre-formatted display string (e.g. "1 500.00 G"), never a raw number.
    @Default('') String price,
  }) = _MsgProduct;
  factory MsgProduct.fromJson(Map<String, dynamic> json) => _$MsgProductFromJson(json);
}

@freezed
class MsgReplyTo with _$MsgReplyTo {
  const factory MsgReplyTo({
    required int id,
    @JsonKey(name: 'author') @Default('') String authorName,
    @Default('') String excerpt,
  }) = _MsgReplyTo;
  factory MsgReplyTo.fromJson(Map<String, dynamic> json) => _$MsgReplyToFromJson(json);
}

@freezed
class CommunityMessage with _$CommunityMessage {
  const factory CommunityMessage({
    required int id,
    // content can be null on soft-deleted messages
    @Default('') String content,
    @JsonKey(name: 'author_name')  @Default('') String authorName,
    @JsonKey(name: 'created_at')   required DateTime createdAt,
    @JsonKey(name: 'is_pinned')    @Default(false) bool isPinned,
    @JsonKey(name: 'is_deleted')   @Default(false) bool isDeleted,
    @JsonKey(name: 'is_staff')     @Default(false) bool isStaff,
    @JsonKey(name: 'is_own')       @Default(false) bool isOwn,
    @JsonKey(name: 'can_moderate') @Default(false) bool canModerate,
    @JsonKey(name: 'reply_to')     MsgReplyTo? replyTo,
    MsgProduct? product,
    String? audio,
    @JsonKey(name: 'audio_duration') @Default(0) int audioDuration,
    @Default([]) List<String> attachments,
    // API returns {"❤️": 3} — dict emoji → count
    @Default({}) Map<String, int> reactions,
    @JsonKey(name: 'my_reactions') @Default([]) List<String> myReactions,
  }) = _CommunityMessage;
  factory CommunityMessage.fromJson(Map<String, dynamic> json) => _$CommunityMessageFromJson(json);
}
