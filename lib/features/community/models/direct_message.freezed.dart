// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direct_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DirectMessage _$DirectMessageFromJson(Map<String, dynamic> json) {
  return _DirectMessage.fromJson(json);
}

/// @nodoc
mixin _$DirectMessage {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_from_client')
  bool get isFromClient => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;

  /// Serializes this DirectMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectMessageCopyWith<DirectMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectMessageCopyWith<$Res> {
  factory $DirectMessageCopyWith(
    DirectMessage value,
    $Res Function(DirectMessage) then,
  ) = _$DirectMessageCopyWithImpl<$Res, DirectMessage>;
  @useResult
  $Res call({
    int id,
    String content,
    @JsonKey(name: 'is_from_client') bool isFromClient,
    @JsonKey(name: 'created_at') DateTime createdAt,
    List<String> attachments,
  });
}

/// @nodoc
class _$DirectMessageCopyWithImpl<$Res, $Val extends DirectMessage>
    implements $DirectMessageCopyWith<$Res> {
  _$DirectMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isFromClient = null,
    Object? createdAt = null,
    Object? attachments = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            isFromClient:
                null == isFromClient
                    ? _value.isFromClient
                    : isFromClient // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            attachments:
                null == attachments
                    ? _value.attachments
                    : attachments // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DirectMessageImplCopyWith<$Res>
    implements $DirectMessageCopyWith<$Res> {
  factory _$$DirectMessageImplCopyWith(
    _$DirectMessageImpl value,
    $Res Function(_$DirectMessageImpl) then,
  ) = __$$DirectMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String content,
    @JsonKey(name: 'is_from_client') bool isFromClient,
    @JsonKey(name: 'created_at') DateTime createdAt,
    List<String> attachments,
  });
}

/// @nodoc
class __$$DirectMessageImplCopyWithImpl<$Res>
    extends _$DirectMessageCopyWithImpl<$Res, _$DirectMessageImpl>
    implements _$$DirectMessageImplCopyWith<$Res> {
  __$$DirectMessageImplCopyWithImpl(
    _$DirectMessageImpl _value,
    $Res Function(_$DirectMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isFromClient = null,
    Object? createdAt = null,
    Object? attachments = null,
  }) {
    return _then(
      _$DirectMessageImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        isFromClient:
            null == isFromClient
                ? _value.isFromClient
                : isFromClient // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        attachments:
            null == attachments
                ? _value._attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectMessageImpl implements _DirectMessage {
  const _$DirectMessageImpl({
    required this.id,
    required this.content,
    @JsonKey(name: 'is_from_client') this.isFromClient = false,
    @JsonKey(name: 'created_at') required this.createdAt,
    final List<String> attachments = const [],
  }) : _attachments = attachments;

  factory _$DirectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectMessageImplFromJson(json);

  @override
  final int id;
  @override
  final String content;
  @override
  @JsonKey(name: 'is_from_client')
  final bool isFromClient;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'DirectMessage(id: $id, content: $content, isFromClient: $isFromClient, createdAt: $createdAt, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isFromClient, isFromClient) ||
                other.isFromClient == isFromClient) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    content,
    isFromClient,
    createdAt,
    const DeepCollectionEquality().hash(_attachments),
  );

  /// Create a copy of DirectMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectMessageImplCopyWith<_$DirectMessageImpl> get copyWith =>
      __$$DirectMessageImplCopyWithImpl<_$DirectMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectMessageImplToJson(this);
  }
}

abstract class _DirectMessage implements DirectMessage {
  const factory _DirectMessage({
    required final int id,
    required final String content,
    @JsonKey(name: 'is_from_client') final bool isFromClient,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    final List<String> attachments,
  }) = _$DirectMessageImpl;

  factory _DirectMessage.fromJson(Map<String, dynamic> json) =
      _$DirectMessageImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  @JsonKey(name: 'is_from_client')
  bool get isFromClient;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  List<String> get attachments;

  /// Create a copy of DirectMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectMessageImplCopyWith<_$DirectMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SupportConversation _$SupportConversationFromJson(Map<String, dynamic> json) {
  return _SupportConversation.fromJson(json);
}

/// @nodoc
mixin _$SupportConversation {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  String? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_at')
  DateTime? get lastAt => throw _privateConstructorUsedError;

  /// Serializes this SupportConversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupportConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupportConversationCopyWith<SupportConversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportConversationCopyWith<$Res> {
  factory $SupportConversationCopyWith(
    SupportConversation value,
    $Res Function(SupportConversation) then,
  ) = _$SupportConversationCopyWithImpl<$Res, SupportConversation>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'client_name') String clientName,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_at') DateTime? lastAt,
  });
}

/// @nodoc
class _$SupportConversationCopyWithImpl<$Res, $Val extends SupportConversation>
    implements $SupportConversationCopyWith<$Res> {
  _$SupportConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupportConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? unreadCount = null,
    Object? lastMessage = freezed,
    Object? lastAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            clientName:
                null == clientName
                    ? _value.clientName
                    : clientName // ignore: cast_nullable_to_non_nullable
                        as String,
            unreadCount:
                null == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastAt:
                freezed == lastAt
                    ? _value.lastAt
                    : lastAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SupportConversationImplCopyWith<$Res>
    implements $SupportConversationCopyWith<$Res> {
  factory _$$SupportConversationImplCopyWith(
    _$SupportConversationImpl value,
    $Res Function(_$SupportConversationImpl) then,
  ) = __$$SupportConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'client_name') String clientName,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_at') DateTime? lastAt,
  });
}

/// @nodoc
class __$$SupportConversationImplCopyWithImpl<$Res>
    extends _$SupportConversationCopyWithImpl<$Res, _$SupportConversationImpl>
    implements _$$SupportConversationImplCopyWith<$Res> {
  __$$SupportConversationImplCopyWithImpl(
    _$SupportConversationImpl _value,
    $Res Function(_$SupportConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? unreadCount = null,
    Object? lastMessage = freezed,
    Object? lastAt = freezed,
  }) {
    return _then(
      _$SupportConversationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        clientName:
            null == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                    as String,
        unreadCount:
            null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastAt:
            freezed == lastAt
                ? _value.lastAt
                : lastAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SupportConversationImpl implements _SupportConversation {
  const _$SupportConversationImpl({
    required this.id,
    @JsonKey(name: 'client_name') required this.clientName,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    @JsonKey(name: 'last_message') this.lastMessage,
    @JsonKey(name: 'last_at') this.lastAt,
  });

  factory _$SupportConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupportConversationImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'client_name')
  final String clientName;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'last_message')
  final String? lastMessage;
  @override
  @JsonKey(name: 'last_at')
  final DateTime? lastAt;

  @override
  String toString() {
    return 'SupportConversation(id: $id, clientName: $clientName, unreadCount: $unreadCount, lastMessage: $lastMessage, lastAt: $lastAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupportConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastAt, lastAt) || other.lastAt == lastAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clientName,
    unreadCount,
    lastMessage,
    lastAt,
  );

  /// Create a copy of SupportConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupportConversationImplCopyWith<_$SupportConversationImpl> get copyWith =>
      __$$SupportConversationImplCopyWithImpl<_$SupportConversationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SupportConversationImplToJson(this);
  }
}

abstract class _SupportConversation implements SupportConversation {
  const factory _SupportConversation({
    required final int id,
    @JsonKey(name: 'client_name') required final String clientName,
    @JsonKey(name: 'unread_count') final int unreadCount,
    @JsonKey(name: 'last_message') final String? lastMessage,
    @JsonKey(name: 'last_at') final DateTime? lastAt,
  }) = _$SupportConversationImpl;

  factory _SupportConversation.fromJson(Map<String, dynamic> json) =
      _$SupportConversationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'client_name')
  String get clientName;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  @JsonKey(name: 'last_message')
  String? get lastMessage;
  @override
  @JsonKey(name: 'last_at')
  DateTime? get lastAt;

  /// Create a copy of SupportConversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupportConversationImplCopyWith<_$SupportConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
