// lib/features/auth/models/user_profile.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String username,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name')  required String lastName,
    @JsonKey(name: 'is_staff')   required bool isStaff,
    String? phone,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    @JsonKey(name: 'date_joined') required DateTime dateJoined,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
