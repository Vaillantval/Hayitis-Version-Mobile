// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'compare_at_price')
  double get compareAtPrice => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<ProductImage> get images => throw _privateConstructorUsedError;
  CategoryBrief? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_stock')
  bool get inStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_average')
  double? get ratingAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_count')
  int get ratingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_description')
  String? get moreDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_info')
  String? get additionalInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_new_arrival')
  bool get isNewArrival => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_best_seller')
  bool get isBestSeller => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_special_offer')
  bool get isSpecialOffer => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String description,
    double price,
    @JsonKey(name: 'compare_at_price') double compareAtPrice,
    String currency,
    List<ProductImage> images,
    CategoryBrief? category,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'stock_quantity') int stockQuantity,
    @JsonKey(name: 'rating_average') double? ratingAverage,
    @JsonKey(name: 'rating_count') int ratingCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    String? brand,
    @JsonKey(name: 'more_description') String? moreDescription,
    @JsonKey(name: 'additional_info') String? additionalInfo,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'is_new_arrival') bool isNewArrival,
    @JsonKey(name: 'is_best_seller') bool isBestSeller,
    @JsonKey(name: 'is_special_offer') bool isSpecialOffer,
  });

  $CategoryBriefCopyWith<$Res>? get category;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = null,
    Object? price = null,
    Object? compareAtPrice = null,
    Object? currency = null,
    Object? images = null,
    Object? category = freezed,
    Object? inStock = null,
    Object? stockQuantity = null,
    Object? ratingAverage = freezed,
    Object? ratingCount = null,
    Object? createdAt = null,
    Object? brand = freezed,
    Object? moreDescription = freezed,
    Object? additionalInfo = freezed,
    Object? isFeatured = null,
    Object? isNewArrival = null,
    Object? isBestSeller = null,
    Object? isSpecialOffer = null,
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
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            compareAtPrice:
                null == compareAtPrice
                    ? _value.compareAtPrice
                    : compareAtPrice // ignore: cast_nullable_to_non_nullable
                        as double,
            currency:
                null == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String,
            images:
                null == images
                    ? _value.images
                    : images // ignore: cast_nullable_to_non_nullable
                        as List<ProductImage>,
            category:
                freezed == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as CategoryBrief?,
            inStock:
                null == inStock
                    ? _value.inStock
                    : inStock // ignore: cast_nullable_to_non_nullable
                        as bool,
            stockQuantity:
                null == stockQuantity
                    ? _value.stockQuantity
                    : stockQuantity // ignore: cast_nullable_to_non_nullable
                        as int,
            ratingAverage:
                freezed == ratingAverage
                    ? _value.ratingAverage
                    : ratingAverage // ignore: cast_nullable_to_non_nullable
                        as double?,
            ratingCount:
                null == ratingCount
                    ? _value.ratingCount
                    : ratingCount // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            brand:
                freezed == brand
                    ? _value.brand
                    : brand // ignore: cast_nullable_to_non_nullable
                        as String?,
            moreDescription:
                freezed == moreDescription
                    ? _value.moreDescription
                    : moreDescription // ignore: cast_nullable_to_non_nullable
                        as String?,
            additionalInfo:
                freezed == additionalInfo
                    ? _value.additionalInfo
                    : additionalInfo // ignore: cast_nullable_to_non_nullable
                        as String?,
            isFeatured:
                null == isFeatured
                    ? _value.isFeatured
                    : isFeatured // ignore: cast_nullable_to_non_nullable
                        as bool,
            isNewArrival:
                null == isNewArrival
                    ? _value.isNewArrival
                    : isNewArrival // ignore: cast_nullable_to_non_nullable
                        as bool,
            isBestSeller:
                null == isBestSeller
                    ? _value.isBestSeller
                    : isBestSeller // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSpecialOffer:
                null == isSpecialOffer
                    ? _value.isSpecialOffer
                    : isSpecialOffer // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryBriefCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryBriefCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String slug,
    String description,
    double price,
    @JsonKey(name: 'compare_at_price') double compareAtPrice,
    String currency,
    List<ProductImage> images,
    CategoryBrief? category,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'stock_quantity') int stockQuantity,
    @JsonKey(name: 'rating_average') double? ratingAverage,
    @JsonKey(name: 'rating_count') int ratingCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    String? brand,
    @JsonKey(name: 'more_description') String? moreDescription,
    @JsonKey(name: 'additional_info') String? additionalInfo,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'is_new_arrival') bool isNewArrival,
    @JsonKey(name: 'is_best_seller') bool isBestSeller,
    @JsonKey(name: 'is_special_offer') bool isSpecialOffer,
  });

  @override
  $CategoryBriefCopyWith<$Res>? get category;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = null,
    Object? price = null,
    Object? compareAtPrice = null,
    Object? currency = null,
    Object? images = null,
    Object? category = freezed,
    Object? inStock = null,
    Object? stockQuantity = null,
    Object? ratingAverage = freezed,
    Object? ratingCount = null,
    Object? createdAt = null,
    Object? brand = freezed,
    Object? moreDescription = freezed,
    Object? additionalInfo = freezed,
    Object? isFeatured = null,
    Object? isNewArrival = null,
    Object? isBestSeller = null,
    Object? isSpecialOffer = null,
  }) {
    return _then(
      _$ProductImpl(
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
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        compareAtPrice:
            null == compareAtPrice
                ? _value.compareAtPrice
                : compareAtPrice // ignore: cast_nullable_to_non_nullable
                    as double,
        currency:
            null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String,
        images:
            null == images
                ? _value._images
                : images // ignore: cast_nullable_to_non_nullable
                    as List<ProductImage>,
        category:
            freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as CategoryBrief?,
        inStock:
            null == inStock
                ? _value.inStock
                : inStock // ignore: cast_nullable_to_non_nullable
                    as bool,
        stockQuantity:
            null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                    as int,
        ratingAverage:
            freezed == ratingAverage
                ? _value.ratingAverage
                : ratingAverage // ignore: cast_nullable_to_non_nullable
                    as double?,
        ratingCount:
            null == ratingCount
                ? _value.ratingCount
                : ratingCount // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        brand:
            freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                    as String?,
        moreDescription:
            freezed == moreDescription
                ? _value.moreDescription
                : moreDescription // ignore: cast_nullable_to_non_nullable
                    as String?,
        additionalInfo:
            freezed == additionalInfo
                ? _value.additionalInfo
                : additionalInfo // ignore: cast_nullable_to_non_nullable
                    as String?,
        isFeatured:
            null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                    as bool,
        isNewArrival:
            null == isNewArrival
                ? _value.isNewArrival
                : isNewArrival // ignore: cast_nullable_to_non_nullable
                    as bool,
        isBestSeller:
            null == isBestSeller
                ? _value.isBestSeller
                : isBestSeller // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSpecialOffer:
            null == isSpecialOffer
                ? _value.isSpecialOffer
                : isSpecialOffer // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    @JsonKey(name: 'compare_at_price') this.compareAtPrice = 0.0,
    required this.currency,
    required final List<ProductImage> images,
    this.category,
    @JsonKey(name: 'in_stock') required this.inStock,
    @JsonKey(name: 'stock_quantity') required this.stockQuantity,
    @JsonKey(name: 'rating_average') this.ratingAverage,
    @JsonKey(name: 'rating_count') required this.ratingCount,
    @JsonKey(name: 'created_at') required this.createdAt,
    this.brand,
    @JsonKey(name: 'more_description') this.moreDescription,
    @JsonKey(name: 'additional_info') this.additionalInfo,
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'is_new_arrival') this.isNewArrival = false,
    @JsonKey(name: 'is_best_seller') this.isBestSeller = false,
    @JsonKey(name: 'is_special_offer') this.isSpecialOffer = false,
  }) : _images = images;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String description;
  @override
  final double price;
  @override
  @JsonKey(name: 'compare_at_price')
  final double compareAtPrice;
  @override
  final String currency;
  final List<ProductImage> _images;
  @override
  List<ProductImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final CategoryBrief? category;
  @override
  @JsonKey(name: 'in_stock')
  final bool inStock;
  @override
  @JsonKey(name: 'stock_quantity')
  final int stockQuantity;
  @override
  @JsonKey(name: 'rating_average')
  final double? ratingAverage;
  @override
  @JsonKey(name: 'rating_count')
  final int ratingCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final String? brand;
  @override
  @JsonKey(name: 'more_description')
  final String? moreDescription;
  @override
  @JsonKey(name: 'additional_info')
  final String? additionalInfo;
  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @override
  @JsonKey(name: 'is_new_arrival')
  final bool isNewArrival;
  @override
  @JsonKey(name: 'is_best_seller')
  final bool isBestSeller;
  @override
  @JsonKey(name: 'is_special_offer')
  final bool isSpecialOffer;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, slug: $slug, description: $description, price: $price, compareAtPrice: $compareAtPrice, currency: $currency, images: $images, category: $category, inStock: $inStock, stockQuantity: $stockQuantity, ratingAverage: $ratingAverage, ratingCount: $ratingCount, createdAt: $createdAt, brand: $brand, moreDescription: $moreDescription, additionalInfo: $additionalInfo, isFeatured: $isFeatured, isNewArrival: $isNewArrival, isBestSeller: $isBestSeller, isSpecialOffer: $isSpecialOffer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.ratingAverage, ratingAverage) ||
                other.ratingAverage == ratingAverage) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.moreDescription, moreDescription) ||
                other.moreDescription == moreDescription) &&
            (identical(other.additionalInfo, additionalInfo) ||
                other.additionalInfo == additionalInfo) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isNewArrival, isNewArrival) ||
                other.isNewArrival == isNewArrival) &&
            (identical(other.isBestSeller, isBestSeller) ||
                other.isBestSeller == isBestSeller) &&
            (identical(other.isSpecialOffer, isSpecialOffer) ||
                other.isSpecialOffer == isSpecialOffer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    slug,
    description,
    price,
    compareAtPrice,
    currency,
    const DeepCollectionEquality().hash(_images),
    category,
    inStock,
    stockQuantity,
    ratingAverage,
    ratingCount,
    createdAt,
    brand,
    moreDescription,
    additionalInfo,
    isFeatured,
    isNewArrival,
    isBestSeller,
    isSpecialOffer,
  ]);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    required final int id,
    required final String name,
    required final String slug,
    required final String description,
    required final double price,
    @JsonKey(name: 'compare_at_price') final double compareAtPrice,
    required final String currency,
    required final List<ProductImage> images,
    final CategoryBrief? category,
    @JsonKey(name: 'in_stock') required final bool inStock,
    @JsonKey(name: 'stock_quantity') required final int stockQuantity,
    @JsonKey(name: 'rating_average') final double? ratingAverage,
    @JsonKey(name: 'rating_count') required final int ratingCount,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    final String? brand,
    @JsonKey(name: 'more_description') final String? moreDescription,
    @JsonKey(name: 'additional_info') final String? additionalInfo,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'is_new_arrival') final bool isNewArrival,
    @JsonKey(name: 'is_best_seller') final bool isBestSeller,
    @JsonKey(name: 'is_special_offer') final bool isSpecialOffer,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String get description;
  @override
  double get price;
  @override
  @JsonKey(name: 'compare_at_price')
  double get compareAtPrice;
  @override
  String get currency;
  @override
  List<ProductImage> get images;
  @override
  CategoryBrief? get category;
  @override
  @JsonKey(name: 'in_stock')
  bool get inStock;
  @override
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity;
  @override
  @JsonKey(name: 'rating_average')
  double? get ratingAverage;
  @override
  @JsonKey(name: 'rating_count')
  int get ratingCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  String? get brand;
  @override
  @JsonKey(name: 'more_description')
  String? get moreDescription;
  @override
  @JsonKey(name: 'additional_info')
  String? get additionalInfo;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured;
  @override
  @JsonKey(name: 'is_new_arrival')
  bool get isNewArrival;
  @override
  @JsonKey(name: 'is_best_seller')
  bool get isBestSeller;
  @override
  @JsonKey(name: 'is_special_offer')
  bool get isSpecialOffer;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
