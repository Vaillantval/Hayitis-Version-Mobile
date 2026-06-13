// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  int get id => throw _privateConstructorUsedError;
  int get product => throw _privateConstructorUsedError;
  int get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_name')
  String get authorName => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call({
    int id,
    int product,
    int author,
    @JsonKey(name: 'author_name') String authorName,
    int rating,
    String comment,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? product = null,
    Object? author = null,
    Object? authorName = null,
    Object? rating = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            product:
                null == product
                    ? _value.product
                    : product // ignore: cast_nullable_to_non_nullable
                        as int,
            author:
                null == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as int,
            authorName:
                null == authorName
                    ? _value.authorName
                    : authorName // ignore: cast_nullable_to_non_nullable
                        as String,
            rating:
                null == rating
                    ? _value.rating
                    : rating // ignore: cast_nullable_to_non_nullable
                        as int,
            comment:
                null == comment
                    ? _value.comment
                    : comment // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
    _$ReviewImpl value,
    $Res Function(_$ReviewImpl) then,
  ) = __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int product,
    int author,
    @JsonKey(name: 'author_name') String authorName,
    int rating,
    String comment,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
    _$ReviewImpl _value,
    $Res Function(_$ReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? product = null,
    Object? author = null,
    Object? authorName = null,
    Object? rating = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ReviewImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        product:
            null == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                    as int,
        author:
            null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as int,
        authorName:
            null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                    as String,
        rating:
            null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                    as int,
        comment:
            null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl implements _Review {
  const _$ReviewImpl({
    required this.id,
    required this.product,
    required this.author,
    @JsonKey(name: 'author_name') required this.authorName,
    required this.rating,
    required this.comment,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  final int id;
  @override
  final int product;
  @override
  final int author;
  @override
  @JsonKey(name: 'author_name')
  final String authorName;
  @override
  final int rating;
  @override
  final String comment;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Review(id: $id, product: $product, author: $author, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    product,
    author,
    authorName,
    rating,
    comment,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(this);
  }
}

abstract class _Review implements Review {
  const factory _Review({
    required final int id,
    required final int product,
    required final int author,
    @JsonKey(name: 'author_name') required final String authorName,
    required final int rating,
    required final String comment,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$ReviewImpl;

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  int get id;
  @override
  int get product;
  @override
  int get author;
  @override
  @JsonKey(name: 'author_name')
  String get authorName;
  @override
  int get rating;
  @override
  String get comment;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
