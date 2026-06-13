// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommunityNotification _$CommunityNotificationFromJson(
  Map<String, dynamic> json,
) {
  return _CommunityNotification.fromJson(json);
}

/// @nodoc
mixin _$CommunityNotification {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'actor_name')
  String get actorName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CommunityNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityNotificationCopyWith<CommunityNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityNotificationCopyWith<$Res> {
  factory $CommunityNotificationCopyWith(
    CommunityNotification value,
    $Res Function(CommunityNotification) then,
  ) = _$CommunityNotificationCopyWithImpl<$Res, CommunityNotification>;
  @useResult
  $Res call({
    int id,
    String type,
    @JsonKey(name: 'actor_name') String actorName,
    String message,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$CommunityNotificationCopyWithImpl<
  $Res,
  $Val extends CommunityNotification
>
    implements $CommunityNotificationCopyWith<$Res> {
  _$CommunityNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? actorName = null,
    Object? message = null,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            actorName:
                null == actorName
                    ? _value.actorName
                    : actorName // ignore: cast_nullable_to_non_nullable
                        as String,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            isRead:
                null == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityNotificationImplCopyWith<$Res>
    implements $CommunityNotificationCopyWith<$Res> {
  factory _$$CommunityNotificationImplCopyWith(
    _$CommunityNotificationImpl value,
    $Res Function(_$CommunityNotificationImpl) then,
  ) = __$$CommunityNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    @JsonKey(name: 'actor_name') String actorName,
    String message,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$CommunityNotificationImplCopyWithImpl<$Res>
    extends
        _$CommunityNotificationCopyWithImpl<$Res, _$CommunityNotificationImpl>
    implements _$$CommunityNotificationImplCopyWith<$Res> {
  __$$CommunityNotificationImplCopyWithImpl(
    _$CommunityNotificationImpl _value,
    $Res Function(_$CommunityNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? actorName = null,
    Object? message = null,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$CommunityNotificationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        actorName:
            null == actorName
                ? _value.actorName
                : actorName // ignore: cast_nullable_to_non_nullable
                    as String,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        isRead:
            null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityNotificationImpl implements _CommunityNotification {
  const _$CommunityNotificationImpl({
    required this.id,
    required this.type,
    @JsonKey(name: 'actor_name') required this.actorName,
    required this.message,
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$CommunityNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityNotificationImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  @JsonKey(name: 'actor_name')
  final String actorName;
  @override
  final String message;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'CommunityNotification(id: $id, type: $type, actorName: $actorName, message: $message, isRead: $isRead, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, actorName, message, isRead, createdAt);

  /// Create a copy of CommunityNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityNotificationImplCopyWith<_$CommunityNotificationImpl>
  get copyWith =>
      __$$CommunityNotificationImplCopyWithImpl<_$CommunityNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityNotificationImplToJson(this);
  }
}

abstract class _CommunityNotification implements CommunityNotification {
  const factory _CommunityNotification({
    required final int id,
    required final String type,
    @JsonKey(name: 'actor_name') required final String actorName,
    required final String message,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$CommunityNotificationImpl;

  factory _CommunityNotification.fromJson(Map<String, dynamic> json) =
      _$CommunityNotificationImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(name: 'actor_name')
  String get actorName;
  @override
  String get message;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of CommunityNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityNotificationImplCopyWith<_$CommunityNotificationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
