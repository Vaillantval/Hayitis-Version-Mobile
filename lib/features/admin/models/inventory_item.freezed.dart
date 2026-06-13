// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) {
  return _InventoryItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryItem {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock')
  int get stockQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'solde_price')
  double get soldePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'regular_price')
  double get regularPrice => throw _privateConstructorUsedError;

  /// Serializes this InventoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryItemCopyWith<InventoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryItemCopyWith<$Res> {
  factory $InventoryItemCopyWith(
    InventoryItem value,
    $Res Function(InventoryItem) then,
  ) = _$InventoryItemCopyWithImpl<$Res, InventoryItem>;
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    @JsonKey(name: 'stock') int stockQuantity,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'solde_price') double soldePrice,
    @JsonKey(name: 'regular_price') double regularPrice,
  });
}

/// @nodoc
class _$InventoryItemCopyWithImpl<$Res, $Val extends InventoryItem>
    implements $InventoryItemCopyWith<$Res> {
  _$InventoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? stockQuantity = null,
    Object? isAvailable = null,
    Object? soldePrice = null,
    Object? regularPrice = null,
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
            stockQuantity:
                null == stockQuantity
                    ? _value.stockQuantity
                    : stockQuantity // ignore: cast_nullable_to_non_nullable
                        as int,
            isAvailable:
                null == isAvailable
                    ? _value.isAvailable
                    : isAvailable // ignore: cast_nullable_to_non_nullable
                        as bool,
            soldePrice:
                null == soldePrice
                    ? _value.soldePrice
                    : soldePrice // ignore: cast_nullable_to_non_nullable
                        as double,
            regularPrice:
                null == regularPrice
                    ? _value.regularPrice
                    : regularPrice // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryItemImplCopyWith<$Res>
    implements $InventoryItemCopyWith<$Res> {
  factory _$$InventoryItemImplCopyWith(
    _$InventoryItemImpl value,
    $Res Function(_$InventoryItemImpl) then,
  ) = __$$InventoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    @JsonKey(name: 'stock') int stockQuantity,
    @JsonKey(name: 'is_available') bool isAvailable,
    @JsonKey(name: 'solde_price') double soldePrice,
    @JsonKey(name: 'regular_price') double regularPrice,
  });
}

/// @nodoc
class __$$InventoryItemImplCopyWithImpl<$Res>
    extends _$InventoryItemCopyWithImpl<$Res, _$InventoryItemImpl>
    implements _$$InventoryItemImplCopyWith<$Res> {
  __$$InventoryItemImplCopyWithImpl(
    _$InventoryItemImpl _value,
    $Res Function(_$InventoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? stockQuantity = null,
    Object? isAvailable = null,
    Object? soldePrice = null,
    Object? regularPrice = null,
  }) {
    return _then(
      _$InventoryItemImpl(
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
        stockQuantity:
            null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                    as int,
        isAvailable:
            null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                    as bool,
        soldePrice:
            null == soldePrice
                ? _value.soldePrice
                : soldePrice // ignore: cast_nullable_to_non_nullable
                    as double,
        regularPrice:
            null == regularPrice
                ? _value.regularPrice
                : regularPrice // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryItemImpl implements _InventoryItem {
  const _$InventoryItemImpl({
    required this.id,
    required this.name,
    required this.slug,
    @JsonKey(name: 'stock') required this.stockQuantity,
    @JsonKey(name: 'is_available') required this.isAvailable,
    @JsonKey(name: 'solde_price') required this.soldePrice,
    @JsonKey(name: 'regular_price') required this.regularPrice,
  });

  factory _$InventoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryItemImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  @JsonKey(name: 'stock')
  final int stockQuantity;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey(name: 'solde_price')
  final double soldePrice;
  @override
  @JsonKey(name: 'regular_price')
  final double regularPrice;

  @override
  String toString() {
    return 'InventoryItem(id: $id, name: $name, slug: $slug, stockQuantity: $stockQuantity, isAvailable: $isAvailable, soldePrice: $soldePrice, regularPrice: $regularPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.soldePrice, soldePrice) ||
                other.soldePrice == soldePrice) &&
            (identical(other.regularPrice, regularPrice) ||
                other.regularPrice == regularPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    stockQuantity,
    isAvailable,
    soldePrice,
    regularPrice,
  );

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryItemImplCopyWith<_$InventoryItemImpl> get copyWith =>
      __$$InventoryItemImplCopyWithImpl<_$InventoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryItemImplToJson(this);
  }
}

abstract class _InventoryItem implements InventoryItem {
  const factory _InventoryItem({
    required final int id,
    required final String name,
    required final String slug,
    @JsonKey(name: 'stock') required final int stockQuantity,
    @JsonKey(name: 'is_available') required final bool isAvailable,
    @JsonKey(name: 'solde_price') required final double soldePrice,
    @JsonKey(name: 'regular_price') required final double regularPrice,
  }) = _$InventoryItemImpl;

  factory _InventoryItem.fromJson(Map<String, dynamic> json) =
      _$InventoryItemImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  @JsonKey(name: 'stock')
  int get stockQuantity;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  @JsonKey(name: 'solde_price')
  double get soldePrice;
  @override
  @JsonKey(name: 'regular_price')
  double get regularPrice;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryItemImplCopyWith<_$InventoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
