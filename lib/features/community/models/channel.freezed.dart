// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return _Channel.fromJson(json);
}

/// @nodoc
mixin _$Channel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_write')
  bool get canWrite => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_following')
  bool get isFollowing => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_access')
  String get readAccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'write_access')
  String get writeAccess => throw _privateConstructorUsedError;

  /// Serializes this Channel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res, Channel>;
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? description,
    String emoji,
    String color,
    String? image,
    @JsonKey(name: 'can_write') bool canWrite,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'read_access') String readAccess,
    @JsonKey(name: 'write_access') String writeAccess,
  });
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res, $Val extends Channel>
    implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? emoji = null,
    Object? color = null,
    Object? image = freezed,
    Object? canWrite = null,
    Object? isFollowing = null,
    Object? readAccess = null,
    Object? writeAccess = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            slug:
                null == slug
                    ? _value.slug
                    : slug // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            emoji:
                null == emoji
                    ? _value.emoji
                    : emoji // ignore: cast_nullable_to_non_nullable
                        as String,
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as String,
            image:
                freezed == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String?,
            canWrite:
                null == canWrite
                    ? _value.canWrite
                    : canWrite // ignore: cast_nullable_to_non_nullable
                        as bool,
            isFollowing:
                null == isFollowing
                    ? _value.isFollowing
                    : isFollowing // ignore: cast_nullable_to_non_nullable
                        as bool,
            readAccess:
                null == readAccess
                    ? _value.readAccess
                    : readAccess // ignore: cast_nullable_to_non_nullable
                        as String,
            writeAccess:
                null == writeAccess
                    ? _value.writeAccess
                    : writeAccess // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChannelImplCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$$ChannelImplCopyWith(
    _$ChannelImpl value,
    $Res Function(_$ChannelImpl) then,
  ) = __$$ChannelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? description,
    String emoji,
    String color,
    String? image,
    @JsonKey(name: 'can_write') bool canWrite,
    @JsonKey(name: 'is_following') bool isFollowing,
    @JsonKey(name: 'read_access') String readAccess,
    @JsonKey(name: 'write_access') String writeAccess,
  });
}

/// @nodoc
class __$$ChannelImplCopyWithImpl<$Res>
    extends _$ChannelCopyWithImpl<$Res, _$ChannelImpl>
    implements _$$ChannelImplCopyWith<$Res> {
  __$$ChannelImplCopyWithImpl(
    _$ChannelImpl _value,
    $Res Function(_$ChannelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? emoji = null,
    Object? color = null,
    Object? image = freezed,
    Object? canWrite = null,
    Object? isFollowing = null,
    Object? readAccess = null,
    Object? writeAccess = null,
  }) {
    return _then(
      _$ChannelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        slug:
            null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        emoji:
            null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                    as String,
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as String,
        image:
            freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String?,
        canWrite:
            null == canWrite
                ? _value.canWrite
                : canWrite // ignore: cast_nullable_to_non_nullable
                    as bool,
        isFollowing:
            null == isFollowing
                ? _value.isFollowing
                : isFollowing // ignore: cast_nullable_to_non_nullable
                    as bool,
        readAccess:
            null == readAccess
                ? _value.readAccess
                : readAccess // ignore: cast_nullable_to_non_nullable
                    as String,
        writeAccess:
            null == writeAccess
                ? _value.writeAccess
                : writeAccess // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelImpl implements _Channel {
  const _$ChannelImpl({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.emoji = '💬',
    this.color = '#C62828',
    this.image,
    @JsonKey(name: 'can_write') this.canWrite = false,
    @JsonKey(name: 'is_following') this.isFollowing = false,
    @JsonKey(name: 'read_access') this.readAccess = 'public',
    @JsonKey(name: 'write_access') this.writeAccess = 'open',
  });

  factory _$ChannelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  @JsonKey()
  final String emoji;
  @override
  @JsonKey()
  final String color;
  @override
  final String? image;
  @override
  @JsonKey(name: 'can_write')
  final bool canWrite;
  @override
  @JsonKey(name: 'is_following')
  final bool isFollowing;
  @override
  @JsonKey(name: 'read_access')
  final String readAccess;
  @override
  @JsonKey(name: 'write_access')
  final String writeAccess;

  @override
  String toString() {
    return 'Channel(id: $id, name: $name, slug: $slug, description: $description, emoji: $emoji, color: $color, image: $image, canWrite: $canWrite, isFollowing: $isFollowing, readAccess: $readAccess, writeAccess: $writeAccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.canWrite, canWrite) ||
                other.canWrite == canWrite) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.readAccess, readAccess) ||
                other.readAccess == readAccess) &&
            (identical(other.writeAccess, writeAccess) ||
                other.writeAccess == writeAccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    description,
    emoji,
    color,
    image,
    canWrite,
    isFollowing,
    readAccess,
    writeAccess,
  );

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelImplCopyWith<_$ChannelImpl> get copyWith =>
      __$$ChannelImplCopyWithImpl<_$ChannelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelImplToJson(this);
  }
}

abstract class _Channel implements Channel {
  const factory _Channel({
    required final int id,
    required final String name,
    required final String slug,
    final String? description,
    final String emoji,
    final String color,
    final String? image,
    @JsonKey(name: 'can_write') final bool canWrite,
    @JsonKey(name: 'is_following') final bool isFollowing,
    @JsonKey(name: 'read_access') final String readAccess,
    @JsonKey(name: 'write_access') final String writeAccess,
  }) = _$ChannelImpl;

  factory _Channel.fromJson(Map<String, dynamic> json) = _$ChannelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get description;
  @override
  String get emoji;
  @override
  String get color;
  @override
  String? get image;
  @override
  @JsonKey(name: 'can_write')
  bool get canWrite;
  @override
  @JsonKey(name: 'is_following')
  bool get isFollowing;
  @override
  @JsonKey(name: 'read_access')
  String get readAccess;
  @override
  @JsonKey(name: 'write_access')
  String get writeAccess;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelImplCopyWith<_$ChannelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
