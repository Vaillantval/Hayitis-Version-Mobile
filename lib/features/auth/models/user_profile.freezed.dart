// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_staff')
  bool get isStaff => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'fcm_token')
  String? get fcmToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_joined')
  DateTime get dateJoined => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    int id,
    String username,
    String email,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    @JsonKey(name: 'is_staff') bool isStaff,
    String? phone,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    @JsonKey(name: 'date_joined') DateTime dateJoined,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? isStaff = null,
    Object? phone = freezed,
    Object? fcmToken = freezed,
    Object? dateJoined = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            username:
                null == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
            isStaff:
                null == isStaff
                    ? _value.isStaff
                    : isStaff // ignore: cast_nullable_to_non_nullable
                        as bool,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            fcmToken:
                freezed == fcmToken
                    ? _value.fcmToken
                    : fcmToken // ignore: cast_nullable_to_non_nullable
                        as String?,
            dateJoined:
                null == dateJoined
                    ? _value.dateJoined
                    : dateJoined // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String username,
    String email,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    @JsonKey(name: 'is_staff') bool isStaff,
    String? phone,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    @JsonKey(name: 'date_joined') DateTime dateJoined,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? isStaff = null,
    Object? phone = freezed,
    Object? fcmToken = freezed,
    Object? dateJoined = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        username:
            null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
        isStaff:
            null == isStaff
                ? _value.isStaff
                : isStaff // ignore: cast_nullable_to_non_nullable
                    as bool,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        fcmToken:
            freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                    as String?,
        dateJoined:
            null == dateJoined
                ? _value.dateJoined
                : dateJoined // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    required this.username,
    required this.email,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
    @JsonKey(name: 'is_staff') required this.isStaff,
    this.phone,
    @JsonKey(name: 'fcm_token') this.fcmToken,
    @JsonKey(name: 'date_joined') required this.dateJoined,
  });

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String username;
  @override
  final String email;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  @JsonKey(name: 'is_staff')
  final bool isStaff;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  @override
  @JsonKey(name: 'date_joined')
  final DateTime dateJoined;

  @override
  String toString() {
    return 'UserProfile(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, isStaff: $isStaff, phone: $phone, fcmToken: $fcmToken, dateJoined: $dateJoined)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.isStaff, isStaff) || other.isStaff == isStaff) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    email,
    firstName,
    lastName,
    isStaff,
    phone,
    fcmToken,
    dateJoined,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final int id,
    required final String username,
    required final String email,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
    @JsonKey(name: 'is_staff') required final bool isStaff,
    final String? phone,
    @JsonKey(name: 'fcm_token') final String? fcmToken,
    @JsonKey(name: 'date_joined') required final DateTime dateJoined,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  int get id;
  @override
  String get username;
  @override
  String get email;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  @JsonKey(name: 'is_staff')
  bool get isStaff;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'fcm_token')
  String? get fcmToken;
  @override
  @JsonKey(name: 'date_joined')
  DateTime get dateJoined;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
