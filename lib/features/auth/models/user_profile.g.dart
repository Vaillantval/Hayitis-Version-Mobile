// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      isStaff: json['is_staff'] as bool,
      phone: json['phone'] as String?,
      fcmToken: json['fcm_token'] as String?,
      dateJoined: DateTime.parse(json['date_joined'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_staff': instance.isStaff,
      'phone': instance.phone,
      'fcm_token': instance.fcmToken,
      'date_joined': instance.dateJoined.toIso8601String(),
    };
