// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MsgProduct _$MsgProductFromJson(Map<String, dynamic> json) {
  return _MsgProduct.fromJson(json);
}

/// @nodoc
mixin _$MsgProduct {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get image =>
      throw _privateConstructorUsedError; // Backend always sends a pre-formatted display string (e.g. "1 500.00 G"), never a raw number.
  String get price => throw _privateConstructorUsedError;

  /// Serializes this MsgProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MsgProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MsgProductCopyWith<MsgProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MsgProductCopyWith<$Res> {
  factory $MsgProductCopyWith(
    MsgProduct value,
    $Res Function(MsgProduct) then,
  ) = _$MsgProductCopyWithImpl<$Res, MsgProduct>;
  @useResult
  $Res call({int id, String name, String slug, String image, String price});
}

/// @nodoc
class _$MsgProductCopyWithImpl<$Res, $Val extends MsgProduct>
    implements $MsgProductCopyWith<$Res> {
  _$MsgProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MsgProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? image = null,
    Object? price = null,
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
            image:
                null == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MsgProductImplCopyWith<$Res>
    implements $MsgProductCopyWith<$Res> {
  factory _$$MsgProductImplCopyWith(
    _$MsgProductImpl value,
    $Res Function(_$MsgProductImpl) then,
  ) = __$$MsgProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String slug, String image, String price});
}

/// @nodoc
class __$$MsgProductImplCopyWithImpl<$Res>
    extends _$MsgProductCopyWithImpl<$Res, _$MsgProductImpl>
    implements _$$MsgProductImplCopyWith<$Res> {
  __$$MsgProductImplCopyWithImpl(
    _$MsgProductImpl _value,
    $Res Function(_$MsgProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MsgProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? image = null,
    Object? price = null,
  }) {
    return _then(
      _$MsgProductImpl(
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
        image:
            null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MsgProductImpl implements _MsgProduct {
  const _$MsgProductImpl({
    required this.id,
    this.name = '',
    this.slug = '',
    this.image = '',
    this.price = '',
  });

  factory _$MsgProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$MsgProductImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String slug;
  @override
  @JsonKey()
  final String image;
  // Backend always sends a pre-formatted display string (e.g. "1 500.00 G"), never a raw number.
  @override
  @JsonKey()
  final String price;

  @override
  String toString() {
    return 'MsgProduct(id: $id, name: $name, slug: $slug, image: $image, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MsgProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug, image, price);

  /// Create a copy of MsgProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MsgProductImplCopyWith<_$MsgProductImpl> get copyWith =>
      __$$MsgProductImplCopyWithImpl<_$MsgProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MsgProductImplToJson(this);
  }
}

abstract class _MsgProduct implements MsgProduct {
  const factory _MsgProduct({
    required final int id,
    final String name,
    final String slug,
    final String image,
    final String price,
  }) = _$MsgProductImpl;

  factory _MsgProduct.fromJson(Map<String, dynamic> json) =
      _$MsgProductImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String get image; // Backend always sends a pre-formatted display string (e.g. "1 500.00 G"), never a raw number.
  @override
  String get price;

  /// Create a copy of MsgProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MsgProductImplCopyWith<_$MsgProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MsgReplyTo _$MsgReplyToFromJson(Map<String, dynamic> json) {
  return _MsgReplyTo.fromJson(json);
}

/// @nodoc
mixin _$MsgReplyTo {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'author')
  String get authorName => throw _privateConstructorUsedError;
  String get excerpt => throw _privateConstructorUsedError;

  /// Serializes this MsgReplyTo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MsgReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MsgReplyToCopyWith<MsgReplyTo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MsgReplyToCopyWith<$Res> {
  factory $MsgReplyToCopyWith(
    MsgReplyTo value,
    $Res Function(MsgReplyTo) then,
  ) = _$MsgReplyToCopyWithImpl<$Res, MsgReplyTo>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'author') String authorName,
    String excerpt,
  });
}

/// @nodoc
class _$MsgReplyToCopyWithImpl<$Res, $Val extends MsgReplyTo>
    implements $MsgReplyToCopyWith<$Res> {
  _$MsgReplyToCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MsgReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorName = null,
    Object? excerpt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            authorName:
                null == authorName
                    ? _value.authorName
                    : authorName // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MsgReplyToImplCopyWith<$Res>
    implements $MsgReplyToCopyWith<$Res> {
  factory _$$MsgReplyToImplCopyWith(
    _$MsgReplyToImpl value,
    $Res Function(_$MsgReplyToImpl) then,
  ) = __$$MsgReplyToImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'author') String authorName,
    String excerpt,
  });
}

/// @nodoc
class __$$MsgReplyToImplCopyWithImpl<$Res>
    extends _$MsgReplyToCopyWithImpl<$Res, _$MsgReplyToImpl>
    implements _$$MsgReplyToImplCopyWith<$Res> {
  __$$MsgReplyToImplCopyWithImpl(
    _$MsgReplyToImpl _value,
    $Res Function(_$MsgReplyToImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MsgReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorName = null,
    Object? excerpt = null,
  }) {
    return _then(
      _$MsgReplyToImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        authorName:
            null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
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
class _$MsgReplyToImpl implements _MsgReplyTo {
  const _$MsgReplyToImpl({
    required this.id,
    @JsonKey(name: 'author') this.authorName = '',
    this.excerpt = '',
  });

  factory _$MsgReplyToImpl.fromJson(Map<String, dynamic> json) =>
      _$$MsgReplyToImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'author')
  final String authorName;
  @override
  @JsonKey()
  final String excerpt;

  @override
  String toString() {
    return 'MsgReplyTo(id: $id, authorName: $authorName, excerpt: $excerpt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MsgReplyToImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, authorName, excerpt);

  /// Create a copy of MsgReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MsgReplyToImplCopyWith<_$MsgReplyToImpl> get copyWith =>
      __$$MsgReplyToImplCopyWithImpl<_$MsgReplyToImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MsgReplyToImplToJson(this);
  }
}

abstract class _MsgReplyTo implements MsgReplyTo {
  const factory _MsgReplyTo({
    required final int id,
    @JsonKey(name: 'author') final String authorName,
    final String excerpt,
  }) = _$MsgReplyToImpl;

  factory _MsgReplyTo.fromJson(Map<String, dynamic> json) =
      _$MsgReplyToImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'author')
  String get authorName;
  @override
  String get excerpt;

  /// Create a copy of MsgReplyTo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MsgReplyToImplCopyWith<_$MsgReplyToImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommunityMessage _$CommunityMessageFromJson(Map<String, dynamic> json) {
  return _CommunityMessage.fromJson(json);
}

/// @nodoc
mixin _$CommunityMessage {
  int get id =>
      throw _privateConstructorUsedError; // content can be null on soft-deleted messages
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_name')
  String get authorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_pinned')
  bool get isPinned => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_staff')
  bool get isStaff => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_own')
  bool get isOwn => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_moderate')
  bool get canModerate => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to')
  MsgReplyTo? get replyTo => throw _privateConstructorUsedError;
  MsgProduct? get product => throw _privateConstructorUsedError;
  String? get audio => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_duration')
  int get audioDuration => throw _privateConstructorUsedError;
  List<String> get attachments =>
      throw _privateConstructorUsedError; // API returns {"❤️": 3} — dict emoji → count
  Map<String, int> get reactions => throw _privateConstructorUsedError;
  @JsonKey(name: 'my_reactions')
  List<String> get myReactions => throw _privateConstructorUsedError;

  /// Serializes this CommunityMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityMessageCopyWith<CommunityMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityMessageCopyWith<$Res> {
  factory $CommunityMessageCopyWith(
    CommunityMessage value,
    $Res Function(CommunityMessage) then,
  ) = _$CommunityMessageCopyWithImpl<$Res, CommunityMessage>;
  @useResult
  $Res call({
    int id,
    String content,
    @JsonKey(name: 'author_name') String authorName,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'is_pinned') bool isPinned,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    @JsonKey(name: 'is_staff') bool isStaff,
    @JsonKey(name: 'is_own') bool isOwn,
    @JsonKey(name: 'can_moderate') bool canModerate,
    @JsonKey(name: 'reply_to') MsgReplyTo? replyTo,
    MsgProduct? product,
    String? audio,
    @JsonKey(name: 'audio_duration') int audioDuration,
    List<String> attachments,
    Map<String, int> reactions,
    @JsonKey(name: 'my_reactions') List<String> myReactions,
  });

  $MsgReplyToCopyWith<$Res>? get replyTo;
  $MsgProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$CommunityMessageCopyWithImpl<$Res, $Val extends CommunityMessage>
    implements $CommunityMessageCopyWith<$Res> {
  _$CommunityMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorName = null,
    Object? createdAt = null,
    Object? isPinned = null,
    Object? isDeleted = null,
    Object? isStaff = null,
    Object? isOwn = null,
    Object? canModerate = null,
    Object? replyTo = freezed,
    Object? product = freezed,
    Object? audio = freezed,
    Object? audioDuration = null,
    Object? attachments = null,
    Object? reactions = null,
    Object? myReactions = null,
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
            authorName:
                null == authorName
                    ? _value.authorName
                    : authorName // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isPinned:
                null == isPinned
                    ? _value.isPinned
                    : isPinned // ignore: cast_nullable_to_non_nullable
                        as bool,
            isDeleted:
                null == isDeleted
                    ? _value.isDeleted
                    : isDeleted // ignore: cast_nullable_to_non_nullable
                        as bool,
            isStaff:
                null == isStaff
                    ? _value.isStaff
                    : isStaff // ignore: cast_nullable_to_non_nullable
                        as bool,
            isOwn:
                null == isOwn
                    ? _value.isOwn
                    : isOwn // ignore: cast_nullable_to_non_nullable
                        as bool,
            canModerate:
                null == canModerate
                    ? _value.canModerate
                    : canModerate // ignore: cast_nullable_to_non_nullable
                        as bool,
            replyTo:
                freezed == replyTo
                    ? _value.replyTo
                    : replyTo // ignore: cast_nullable_to_non_nullable
                        as MsgReplyTo?,
            product:
                freezed == product
                    ? _value.product
                    : product // ignore: cast_nullable_to_non_nullable
                        as MsgProduct?,
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
            reactions:
                null == reactions
                    ? _value.reactions
                    : reactions // ignore: cast_nullable_to_non_nullable
                        as Map<String, int>,
            myReactions:
                null == myReactions
                    ? _value.myReactions
                    : myReactions // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MsgReplyToCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $MsgReplyToCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
  }

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MsgProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $MsgProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommunityMessageImplCopyWith<$Res>
    implements $CommunityMessageCopyWith<$Res> {
  factory _$$CommunityMessageImplCopyWith(
    _$CommunityMessageImpl value,
    $Res Function(_$CommunityMessageImpl) then,
  ) = __$$CommunityMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String content,
    @JsonKey(name: 'author_name') String authorName,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'is_pinned') bool isPinned,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    @JsonKey(name: 'is_staff') bool isStaff,
    @JsonKey(name: 'is_own') bool isOwn,
    @JsonKey(name: 'can_moderate') bool canModerate,
    @JsonKey(name: 'reply_to') MsgReplyTo? replyTo,
    MsgProduct? product,
    String? audio,
    @JsonKey(name: 'audio_duration') int audioDuration,
    List<String> attachments,
    Map<String, int> reactions,
    @JsonKey(name: 'my_reactions') List<String> myReactions,
  });

  @override
  $MsgReplyToCopyWith<$Res>? get replyTo;
  @override
  $MsgProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$CommunityMessageImplCopyWithImpl<$Res>
    extends _$CommunityMessageCopyWithImpl<$Res, _$CommunityMessageImpl>
    implements _$$CommunityMessageImplCopyWith<$Res> {
  __$$CommunityMessageImplCopyWithImpl(
    _$CommunityMessageImpl _value,
    $Res Function(_$CommunityMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorName = null,
    Object? createdAt = null,
    Object? isPinned = null,
    Object? isDeleted = null,
    Object? isStaff = null,
    Object? isOwn = null,
    Object? canModerate = null,
    Object? replyTo = freezed,
    Object? product = freezed,
    Object? audio = freezed,
    Object? audioDuration = null,
    Object? attachments = null,
    Object? reactions = null,
    Object? myReactions = null,
  }) {
    return _then(
      _$CommunityMessageImpl(
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
        authorName:
            null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isPinned:
            null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                    as bool,
        isDeleted:
            null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                    as bool,
        isStaff:
            null == isStaff
                ? _value.isStaff
                : isStaff // ignore: cast_nullable_to_non_nullable
                    as bool,
        isOwn:
            null == isOwn
                ? _value.isOwn
                : isOwn // ignore: cast_nullable_to_non_nullable
                    as bool,
        canModerate:
            null == canModerate
                ? _value.canModerate
                : canModerate // ignore: cast_nullable_to_non_nullable
                    as bool,
        replyTo:
            freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                    as MsgReplyTo?,
        product:
            freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                    as MsgProduct?,
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
        reactions:
            null == reactions
                ? _value._reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                    as Map<String, int>,
        myReactions:
            null == myReactions
                ? _value._myReactions
                : myReactions // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityMessageImpl implements _CommunityMessage {
  const _$CommunityMessageImpl({
    required this.id,
    this.content = '',
    @JsonKey(name: 'author_name') this.authorName = '',
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'is_pinned') this.isPinned = false,
    @JsonKey(name: 'is_deleted') this.isDeleted = false,
    @JsonKey(name: 'is_staff') this.isStaff = false,
    @JsonKey(name: 'is_own') this.isOwn = false,
    @JsonKey(name: 'can_moderate') this.canModerate = false,
    @JsonKey(name: 'reply_to') this.replyTo,
    this.product,
    this.audio,
    @JsonKey(name: 'audio_duration') this.audioDuration = 0,
    final List<String> attachments = const [],
    final Map<String, int> reactions = const {},
    @JsonKey(name: 'my_reactions') final List<String> myReactions = const [],
  }) : _attachments = attachments,
       _reactions = reactions,
       _myReactions = myReactions;

  factory _$CommunityMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityMessageImplFromJson(json);

  @override
  final int id;
  // content can be null on soft-deleted messages
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'author_name')
  final String authorName;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'is_pinned')
  final bool isPinned;
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  @JsonKey(name: 'is_staff')
  final bool isStaff;
  @override
  @JsonKey(name: 'is_own')
  final bool isOwn;
  @override
  @JsonKey(name: 'can_moderate')
  final bool canModerate;
  @override
  @JsonKey(name: 'reply_to')
  final MsgReplyTo? replyTo;
  @override
  final MsgProduct? product;
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

  // API returns {"❤️": 3} — dict emoji → count
  final Map<String, int> _reactions;
  // API returns {"❤️": 3} — dict emoji → count
  @override
  @JsonKey()
  Map<String, int> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  final List<String> _myReactions;
  @override
  @JsonKey(name: 'my_reactions')
  List<String> get myReactions {
    if (_myReactions is EqualUnmodifiableListView) return _myReactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myReactions);
  }

  @override
  String toString() {
    return 'CommunityMessage(id: $id, content: $content, authorName: $authorName, createdAt: $createdAt, isPinned: $isPinned, isDeleted: $isDeleted, isStaff: $isStaff, isOwn: $isOwn, canModerate: $canModerate, replyTo: $replyTo, product: $product, audio: $audio, audioDuration: $audioDuration, attachments: $attachments, reactions: $reactions, myReactions: $myReactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isStaff, isStaff) || other.isStaff == isStaff) &&
            (identical(other.isOwn, isOwn) || other.isOwn == isOwn) &&
            (identical(other.canModerate, canModerate) ||
                other.canModerate == canModerate) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.audio, audio) || other.audio == audio) &&
            (identical(other.audioDuration, audioDuration) ||
                other.audioDuration == audioDuration) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._myReactions,
              _myReactions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    content,
    authorName,
    createdAt,
    isPinned,
    isDeleted,
    isStaff,
    isOwn,
    canModerate,
    replyTo,
    product,
    audio,
    audioDuration,
    const DeepCollectionEquality().hash(_attachments),
    const DeepCollectionEquality().hash(_reactions),
    const DeepCollectionEquality().hash(_myReactions),
  );

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityMessageImplCopyWith<_$CommunityMessageImpl> get copyWith =>
      __$$CommunityMessageImplCopyWithImpl<_$CommunityMessageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityMessageImplToJson(this);
  }
}

abstract class _CommunityMessage implements CommunityMessage {
  const factory _CommunityMessage({
    required final int id,
    final String content,
    @JsonKey(name: 'author_name') final String authorName,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'is_pinned') final bool isPinned,
    @JsonKey(name: 'is_deleted') final bool isDeleted,
    @JsonKey(name: 'is_staff') final bool isStaff,
    @JsonKey(name: 'is_own') final bool isOwn,
    @JsonKey(name: 'can_moderate') final bool canModerate,
    @JsonKey(name: 'reply_to') final MsgReplyTo? replyTo,
    final MsgProduct? product,
    final String? audio,
    @JsonKey(name: 'audio_duration') final int audioDuration,
    final List<String> attachments,
    final Map<String, int> reactions,
    @JsonKey(name: 'my_reactions') final List<String> myReactions,
  }) = _$CommunityMessageImpl;

  factory _CommunityMessage.fromJson(Map<String, dynamic> json) =
      _$CommunityMessageImpl.fromJson;

  @override
  int get id; // content can be null on soft-deleted messages
  @override
  String get content;
  @override
  @JsonKey(name: 'author_name')
  String get authorName;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'is_pinned')
  bool get isPinned;
  @override
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @override
  @JsonKey(name: 'is_staff')
  bool get isStaff;
  @override
  @JsonKey(name: 'is_own')
  bool get isOwn;
  @override
  @JsonKey(name: 'can_moderate')
  bool get canModerate;
  @override
  @JsonKey(name: 'reply_to')
  MsgReplyTo? get replyTo;
  @override
  MsgProduct? get product;
  @override
  String? get audio;
  @override
  @JsonKey(name: 'audio_duration')
  int get audioDuration;
  @override
  List<String> get attachments; // API returns {"❤️": 3} — dict emoji → count
  @override
  Map<String, int> get reactions;
  @override
  @JsonKey(name: 'my_reactions')
  List<String> get myReactions;

  /// Create a copy of CommunityMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityMessageImplCopyWith<_$CommunityMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
