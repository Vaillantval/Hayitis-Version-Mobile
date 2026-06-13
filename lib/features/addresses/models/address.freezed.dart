// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_postal')
  String get codePostal => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_details')
  String? get moreDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'adress_type')
  String get adressType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'full_name') String fullName,
    String street,
    @JsonKey(name: 'code_postal') String codePostal,
    String city,
    String country,
    String phone,
    @JsonKey(name: 'more_details') String? moreDetails,
    @JsonKey(name: 'adress_type') String adressType,
    @JsonKey(name: 'is_default') bool isDefault,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? street = null,
    Object? codePostal = null,
    Object? city = null,
    Object? country = null,
    Object? phone = null,
    Object? moreDetails = freezed,
    Object? adressType = null,
    Object? isDefault = null,
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
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            fullName:
                null == fullName
                    ? _value.fullName
                    : fullName // ignore: cast_nullable_to_non_nullable
                        as String,
            street:
                null == street
                    ? _value.street
                    : street // ignore: cast_nullable_to_non_nullable
                        as String,
            codePostal:
                null == codePostal
                    ? _value.codePostal
                    : codePostal // ignore: cast_nullable_to_non_nullable
                        as String,
            city:
                null == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String,
            country:
                null == country
                    ? _value.country
                    : country // ignore: cast_nullable_to_non_nullable
                        as String,
            phone:
                null == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String,
            moreDetails:
                freezed == moreDetails
                    ? _value.moreDetails
                    : moreDetails // ignore: cast_nullable_to_non_nullable
                        as String?,
            adressType:
                null == adressType
                    ? _value.adressType
                    : adressType // ignore: cast_nullable_to_non_nullable
                        as String,
            isDefault:
                null == isDefault
                    ? _value.isDefault
                    : isDefault // ignore: cast_nullable_to_non_nullable
                        as bool,
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
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
    _$AddressImpl value,
    $Res Function(_$AddressImpl) then,
  ) = __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'full_name') String fullName,
    String street,
    @JsonKey(name: 'code_postal') String codePostal,
    String city,
    String country,
    String phone,
    @JsonKey(name: 'more_details') String? moreDetails,
    @JsonKey(name: 'adress_type') String adressType,
    @JsonKey(name: 'is_default') bool isDefault,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
    _$AddressImpl _value,
    $Res Function(_$AddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? street = null,
    Object? codePostal = null,
    Object? city = null,
    Object? country = null,
    Object? phone = null,
    Object? moreDetails = freezed,
    Object? adressType = null,
    Object? isDefault = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AddressImpl(
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
        fullName:
            null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                    as String,
        street:
            null == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                    as String,
        codePostal:
            null == codePostal
                ? _value.codePostal
                : codePostal // ignore: cast_nullable_to_non_nullable
                    as String,
        city:
            null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String,
        country:
            null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                    as String,
        phone:
            null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String,
        moreDetails:
            freezed == moreDetails
                ? _value.moreDetails
                : moreDetails // ignore: cast_nullable_to_non_nullable
                    as String?,
        adressType:
            null == adressType
                ? _value.adressType
                : adressType // ignore: cast_nullable_to_non_nullable
                    as String,
        isDefault:
            null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                    as bool,
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
class _$AddressImpl implements _Address {
  const _$AddressImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'full_name') required this.fullName,
    required this.street,
    @JsonKey(name: 'code_postal') required this.codePostal,
    required this.city,
    required this.country,
    required this.phone,
    @JsonKey(name: 'more_details') this.moreDetails,
    @JsonKey(name: 'adress_type') required this.adressType,
    @JsonKey(name: 'is_default') required this.isDefault,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String street;
  @override
  @JsonKey(name: 'code_postal')
  final String codePostal;
  @override
  final String city;
  @override
  final String country;
  @override
  final String phone;
  @override
  @JsonKey(name: 'more_details')
  final String? moreDetails;
  @override
  @JsonKey(name: 'adress_type')
  final String adressType;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Address(id: $id, name: $name, fullName: $fullName, street: $street, codePostal: $codePostal, city: $city, country: $country, phone: $phone, moreDetails: $moreDetails, adressType: $adressType, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.codePostal, codePostal) ||
                other.codePostal == codePostal) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.moreDetails, moreDetails) ||
                other.moreDetails == moreDetails) &&
            (identical(other.adressType, adressType) ||
                other.adressType == adressType) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
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
    name,
    fullName,
    street,
    codePostal,
    city,
    country,
    phone,
    moreDetails,
    adressType,
    isDefault,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(this);
  }
}

abstract class _Address implements Address {
  const factory _Address({
    required final int id,
    required final String name,
    @JsonKey(name: 'full_name') required final String fullName,
    required final String street,
    @JsonKey(name: 'code_postal') required final String codePostal,
    required final String city,
    required final String country,
    required final String phone,
    @JsonKey(name: 'more_details') final String? moreDetails,
    @JsonKey(name: 'adress_type') required final String adressType,
    @JsonKey(name: 'is_default') required final bool isDefault,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get street;
  @override
  @JsonKey(name: 'code_postal')
  String get codePostal;
  @override
  String get city;
  @override
  String get country;
  @override
  String get phone;
  @override
  @JsonKey(name: 'more_details')
  String? get moreDetails;
  @override
  @JsonKey(name: 'adress_type')
  String get adressType;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
