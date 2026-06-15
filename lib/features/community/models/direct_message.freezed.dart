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

DmReplyTo _$DmReplyToFromJson(Map<String, dynamic> json) {
  return _DmReplyTo.fromJson(json);
}

/// @nodoc
mixin _$DmReplyTo {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender')
  String get senderName => throw _privateConstructorUsedError;
  String get excerpt => throw _privateConstructorUsedError;

  /// Serializes this DmReplyTo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DmReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DmReplyToCopyWith<DmReplyTo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DmReplyToCopyWith<$Res> {
  factory $DmReplyToCopyWith(DmReplyTo value, $Res Function(DmReplyTo) then) =
      _$DmReplyToCopyWithImpl<$Res, DmReplyTo>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'sender') String senderName,
    String excerpt,
  });
}

/// @nodoc
class _$DmReplyToCopyWithImpl<$Res, $Val extends DmReplyTo>
    implements $DmReplyToCopyWith<$Res> {
  _$DmReplyToCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DmReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderName = null,
    Object? excerpt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            senderName:
                null == senderName
                    ? _value.senderName
                    : senderName // ignore: cast_nullable_to_non_nullable
                        as String,
            excerpt:
                null == excerpt
                    ? _value.excerpt
                    : excerpt // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DmReplyToImplCopyWith<$Res>
    implements $DmReplyToCopyWith<$Res> {
  factory _$$DmReplyToImplCopyWith(
    _$DmReplyToImpl value,
    $Res Function(_$DmReplyToImpl) then,
  ) = __$$DmReplyToImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'sender') String senderName,
    String excerpt,
  });
}

/// @nodoc
class __$$DmReplyToImplCopyWithImpl<$Res>
    extends _$DmReplyToCopyWithImpl<$Res, _$DmReplyToImpl>
    implements _$$DmReplyToImplCopyWith<$Res> {
  __$$DmReplyToImplCopyWithImpl(
    _$DmReplyToImpl _value,
    $Res Function(_$DmReplyToImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DmReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderName = null,
    Object? excerpt = null,
  }) {
    return _then(
      _$DmReplyToImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        senderName:
            null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                    as String,
        excerpt:
            null == excerpt
                ? _value.excerpt
                : excerpt // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DmReplyToImpl implements _DmReplyTo {
  const _$DmReplyToImpl({
    required this.id,
    @JsonKey(name: 'sender') this.senderName = '',
    this.excerpt = '',
  });

  factory _$DmReplyToImpl.fromJson(Map<String, dynamic> json) =>
      _$$DmReplyToImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'sender')
  final String senderName;
  @override
  @JsonKey()
  final String excerpt;

  @override
  String toString() {
    return 'DmReplyTo(id: $id, senderName: $senderName, excerpt: $excerpt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DmReplyToImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, senderName, excerpt);

  /// Create a copy of DmReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DmReplyToImplCopyWith<_$DmReplyToImpl> get copyWith =>
      __$$DmReplyToImplCopyWithImpl<_$DmReplyToImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DmReplyToImplToJson(this);
  }
}

abstract class _DmReplyTo implements DmReplyTo {
  const factory _DmReplyTo({
    required final int id,
    @JsonKey(name: 'sender') final String senderName,
    final String excerpt,
  }) = _$DmReplyToImpl;

  factory _DmReplyTo.fromJson(Map<String, dynamic> json) =
      _$DmReplyToImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'sender')
  String get senderName;
  @override
  String get excerpt;

  /// Create a copy of DmReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DmReplyToImplCopyWith<_$DmReplyToImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectMessage _$DirectMessageFromJson(Map<String, dynamic> json) {
  return _DirectMessage.fromJson(json);
}

/// @nodoc
mixin _$DirectMessage {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_own')
  bool get isOwn => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_admin')
  bool get isAdmin => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to')
  DmReplyTo? get replyTo => throw _privateConstructorUsedError;
  String? get audio => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_duration')
  int get audioDuration => throw _privateConstructorUsedError;
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
    @JsonKey(name: 'is_own') bool isOwn,
    @JsonKey(name: 'is_admin') bool isAdmin,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'reply_to') DmReplyTo? replyTo,
    String? audio,
    @JsonKey(name: 'audio_duration') int audioDuration,
    List<String> attachments,
  });

  $DmReplyToCopyWith<$Res>? get replyTo;
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
    Object? isOwn = null,
    Object? isAdmin = null,
    Object? createdAt = null,
    Object? replyTo = freezed,
    Object? audio = freezed,
    Object? audioDuration = null,
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
            isOwn:
                null == isOwn
                    ? _value.isOwn
                    : isOwn // ignore: cast_nullable_to_non_nullable
                        as bool,
            isAdmin:
                null == isAdmin
                    ? _value.isAdmin
                    : isAdmin // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            replyTo:
                freezed == replyTo
                    ? _value.replyTo
                    : replyTo // ignore: cast_nullable_to_non_nullable
                        as DmReplyTo?,
            audio:
                freezed == audio
                    ? _value.audio
                    : audio // ignore: cast_nullable_to_non_nullable
                        as String?,
            audioDuration:
                null == audioDuration
                    ? _value.audioDuration
                    : audioDuration // ignore: cast_nullable_to_non_nullable
                        as int,
            attachments:
                null == attachments
                    ? _value.attachments
                    : attachments // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of DirectMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DmReplyToCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $DmReplyToCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
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
    @JsonKey(name: 'is_own') bool isOwn,
    @JsonKey(name: 'is_admin') bool isAdmin,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'reply_to') DmReplyTo? replyTo,
    String? audio,
    @JsonKey(name: 'audio_duration') int audioDuration,
    List<String> attachments,
  });

  @override
  $DmReplyToCopyWith<$Res>? get replyTo;
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
    Object? isOwn = null,
    Object? isAdmin = null,
    Object? createdAt = null,
    Object? replyTo = freezed,
    Object? audio = freezed,
    Object? audioDuration = null,
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
        isOwn:
            null == isOwn
                ? _value.isOwn
                : isOwn // ignore: cast_nullable_to_non_nullable
                    as bool,
        isAdmin:
            null == isAdmin
                ? _value.isAdmin
                : isAdmin // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        replyTo:
            freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                    as DmReplyTo?,
        audio:
            freezed == audio
                ? _value.audio
                : audio // ignore: cast_nullable_to_non_nullable
                    as String?,
        audioDuration:
            null == audioDuration
                ? _value.audioDuration
                : audioDuration // ignore: cast_nullable_to_non_nullable
                    as int,
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
    this.content = '',
    @JsonKey(name: 'is_own') this.isOwn = false,
    @JsonKey(name: 'is_admin') this.isAdmin = false,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'reply_to') this.replyTo,
    this.audio,
    @JsonKey(name: 'audio_duration') this.audioDuration = 0,
    final List<String> attachments = const [],
  }) : _attachments = attachments;

  factory _$DirectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectMessageImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'is_own')
  final bool isOwn;
  @override
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'reply_to')
  final DmReplyTo? replyTo;
  @override
  final String? audio;
  @override
  @JsonKey(name: 'audio_duration')
  final int audioDuration;
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
    return 'DirectMessage(id: $id, content: $content, isOwn: $isOwn, isAdmin: $isAdmin, createdAt: $createdAt, replyTo: $replyTo, audio: $audio, audioDuration: $audioDuration, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isOwn, isOwn) || other.isOwn == isOwn) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.audio, audio) || other.audio == audio) &&
            (identical(other.audioDuration, audioDuration) ||
                other.audioDuration == audioDuration) &&
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
    isOwn,
    isAdmin,
    createdAt,
    replyTo,
    audio,
    audioDuration,
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
    final String content,
    @JsonKey(name: 'is_own') final bool isOwn,
    @JsonKey(name: 'is_admin') final bool isAdmin,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'reply_to') final DmReplyTo? replyTo,
    final String? audio,
    @JsonKey(name: 'audio_duration') final int audioDuration,
    final List<String> attachments,
  }) = _$DirectMessageImpl;

  factory _DirectMessage.fromJson(Map<String, dynamic> json) =
      _$DirectMessageImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  @JsonKey(name: 'is_own')
  bool get isOwn;
  @override
  @JsonKey(name: 'is_admin')
  bool get isAdmin;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'reply_to')
  DmReplyTo? get replyTo;
  @override
  String? get audio;
  @override
  @JsonKey(name: 'audio_duration')
  int get audioDuration;
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
