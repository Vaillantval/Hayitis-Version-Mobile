import 'package:freezed_annotation/freezed_annotation.dart';
part 'community_notification.freezed.dart';
part 'community_notification.g.dart';

@freezed
class CommunityNotification with _$CommunityNotification {
  const factory CommunityNotification({
    required int id,
    required String type,
    @JsonKey(name: 'actor_name') required String actorName,
    required String message,
    @JsonKey(name: 'is_read')   @Default(false) bool isRead,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _CommunityNotification;
  factory CommunityNotification.fromJson(Map<String, dynamic> json) =>
      _$CommunityNotificationFromJson(json);
}
