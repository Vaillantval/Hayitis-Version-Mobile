import 'package:freezed_annotation/freezed_annotation.dart';
part 'channel.freezed.dart';
part 'channel.g.dart';

@freezed
class Channel with _$Channel {
  const factory Channel({
    required int id,
    required String name,
    required String slug,
    String? description,
    @Default('💬') String emoji,
    @Default('#C62828') String color,
    String? image,
    @JsonKey(name: 'can_write')    @Default(false) bool canWrite,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,
    @JsonKey(name: 'read_access')  @Default('public') String readAccess,
    @JsonKey(name: 'write_access') @Default('open')   String writeAccess,
  }) = _Channel;
  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);
}
