// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CategoryBrief _$CategoryBriefFromJson(Map<String, dynamic> json) {
  return _CategoryBrief.fromJson(json);
}

/// @nodoc
mixin _$CategoryBrief {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;

  /// Serializes this CategoryBrief to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryBriefCopyWith<CategoryBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryBriefCopyWith<$Res> {
  factory $CategoryBriefCopyWith(
    CategoryBrief value,
    $Res Function(CategoryBrief) then,
  ) = _$CategoryBriefCopyWithImpl<$Res, CategoryBrief>;
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class _$CategoryBriefCopyWithImpl<$Res, $Val extends CategoryBrief>
    implements $CategoryBriefCopyWith<$Res> {
  _$CategoryBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? slug = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryBriefImplCopyWith<$Res>
    implements $CategoryBriefCopyWith<$Res> {
  factory _$$CategoryBriefImplCopyWith(
    _$CategoryBriefImpl value,
    $Res Function(_$CategoryBriefImpl) then,
  ) = __$$CategoryBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class __$$CategoryBriefImplCopyWithImpl<$Res>
    extends _$CategoryBriefCopyWithImpl<$Res, _$CategoryBriefImpl>
    implements _$$CategoryBriefImplCopyWith<$Res> {
  __$$CategoryBriefImplCopyWithImpl(
    _$CategoryBriefImpl _value,
    $Res Function(_$CategoryBriefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? slug = null}) {
    return _then(
      _$CategoryBriefImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryBriefImpl implements _CategoryBrief {
  const _$CategoryBriefImpl({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory _$CategoryBriefImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryBriefImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;

  @override
  String toString() {
    return 'CategoryBrief(id: $id, name: $name, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  /// Create a copy of CategoryBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryBriefImplCopyWith<_$CategoryBriefImpl> get copyWith =>
      __$$CategoryBriefImplCopyWithImpl<_$CategoryBriefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryBriefImplToJson(this);
  }
}

abstract class _CategoryBrief implements CategoryBrief {
  const factory _CategoryBrief({
    required final int id,
    required final String name,
    required final String slug,
  }) = _$CategoryBriefImpl;

  factory _CategoryBrief.fromJson(Map<String, dynamic> json) =
      _$CategoryBriefImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;

  /// Create a copy of CategoryBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryBriefImplCopyWith<_$CategoryBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mega')
  bool get isMega => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_count')
  int get productCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? image,
    String? description,
    @JsonKey(name: 'is_mega') bool isMega,
    @JsonKey(name: 'product_count') int productCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? image = freezed,
    Object? description = freezed,
    Object? isMega = null,
    Object? productCount = null,
    Object? createdAt = freezed,
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
                freezed == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            isMega:
                null == isMega
                    ? _value.isMega
                    : isMega // ignore: cast_nullable_to_non_nullable
                        as bool,
            productCount:
                null == productCount
                    ? _value.productCount
                    : productCount // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
    _$CategoryImpl value,
    $Res Function(_$CategoryImpl) then,
  ) = __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String? image,
    String? description,
    @JsonKey(name: 'is_mega') bool isMega,
    @JsonKey(name: 'product_count') int productCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
    _$CategoryImpl _value,
    $Res Function(_$CategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? image = freezed,
    Object? description = freezed,
    Object? isMega = null,
    Object? productCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CategoryImpl(
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
            freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        isMega:
            null == isMega
                ? _value.isMega
                : isMega // ignore: cast_nullable_to_non_nullable
                    as bool,
        productCount:
            null == productCount
                ? _value.productCount
                : productCount // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl implements _Category {
  const _$CategoryImpl({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.description,
    @JsonKey(name: 'is_mega') this.isMega = false,
    @JsonKey(name: 'product_count') this.productCount = 0,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? image;
  @override
  final String? description;
  @override
  @JsonKey(name: 'is_mega')
  final bool isMega;
  @override
  @JsonKey(name: 'product_count')
  final int productCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, slug: $slug, image: $image, description: $description, isMega: $isMega, productCount: $productCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isMega, isMega) || other.isMega == isMega) &&
            (identical(other.productCount, productCount) ||
                other.productCount == productCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    image,
    description,
    isMega,
    productCount,
    createdAt,
  );

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(this);
  }
}

abstract class _Category implements Category {
  const factory _Category({
    required final int id,
    required final String name,
    required final String slug,
    final String? image,
    final String? description,
    @JsonKey(name: 'is_mega') final bool isMega,
    @JsonKey(name: 'product_count') final int productCount,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get image;
  @override
  String? get description;
  @override
  @JsonKey(name: 'is_mega')
  bool get isMega;
  @override
  @JsonKey(name: 'product_count')
  int get productCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
