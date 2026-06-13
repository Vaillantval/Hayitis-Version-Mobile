// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderTracking _$OrderTrackingFromJson(Map<String, dynamic> json) {
  return _OrderTracking.fromJson(json);
}

/// @nodoc
mixin _$OrderTracking {
  int get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_display')
  String get statusDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paid')
  bool get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'carrier_name')
  String get carrierName => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipping_address')
  String get shippingAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_count')
  int get itemsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_cost_ttc')
  double get orderCostTtc => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OrderTracking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderTrackingCopyWith<OrderTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTrackingCopyWith<$Res> {
  factory $OrderTrackingCopyWith(
    OrderTracking value,
    $Res Function(OrderTracking) then,
  ) = _$OrderTrackingCopyWithImpl<$Res, OrderTracking>;
  @useResult
  $Res call({
    int id,
    String status,
    @JsonKey(name: 'status_display') String statusDisplay,
    @JsonKey(name: 'is_paid') bool isPaid,
    @JsonKey(name: 'payment_method') String paymentMethod,
    @JsonKey(name: 'carrier_name') String carrierName,
    @JsonKey(name: 'shipping_address') String shippingAddress,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'order_cost_ttc') double orderCostTtc,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$OrderTrackingCopyWithImpl<$Res, $Val extends OrderTracking>
    implements $OrderTrackingCopyWith<$Res> {
  _$OrderTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? statusDisplay = null,
    Object? isPaid = null,
    Object? paymentMethod = null,
    Object? carrierName = null,
    Object? shippingAddress = null,
    Object? itemsCount = null,
    Object? orderCostTtc = null,
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
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            statusDisplay:
                null == statusDisplay
                    ? _value.statusDisplay
                    : statusDisplay // ignore: cast_nullable_to_non_nullable
                        as String,
            isPaid:
                null == isPaid
                    ? _value.isPaid
                    : isPaid // ignore: cast_nullable_to_non_nullable
                        as bool,
            paymentMethod:
                null == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String,
            carrierName:
                null == carrierName
                    ? _value.carrierName
                    : carrierName // ignore: cast_nullable_to_non_nullable
                        as String,
            shippingAddress:
                null == shippingAddress
                    ? _value.shippingAddress
                    : shippingAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            itemsCount:
                null == itemsCount
                    ? _value.itemsCount
                    : itemsCount // ignore: cast_nullable_to_non_nullable
                        as int,
            orderCostTtc:
                null == orderCostTtc
                    ? _value.orderCostTtc
                    : orderCostTtc // ignore: cast_nullable_to_non_nullable
                        as double,
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
abstract class _$$OrderTrackingImplCopyWith<$Res>
    implements $OrderTrackingCopyWith<$Res> {
  factory _$$OrderTrackingImplCopyWith(
    _$OrderTrackingImpl value,
    $Res Function(_$OrderTrackingImpl) then,
  ) = __$$OrderTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String status,
    @JsonKey(name: 'status_display') String statusDisplay,
    @JsonKey(name: 'is_paid') bool isPaid,
    @JsonKey(name: 'payment_method') String paymentMethod,
    @JsonKey(name: 'carrier_name') String carrierName,
    @JsonKey(name: 'shipping_address') String shippingAddress,
    @JsonKey(name: 'items_count') int itemsCount,
    @JsonKey(name: 'order_cost_ttc') double orderCostTtc,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$OrderTrackingImplCopyWithImpl<$Res>
    extends _$OrderTrackingCopyWithImpl<$Res, _$OrderTrackingImpl>
    implements _$$OrderTrackingImplCopyWith<$Res> {
  __$$OrderTrackingImplCopyWithImpl(
    _$OrderTrackingImpl _value,
    $Res Function(_$OrderTrackingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? statusDisplay = null,
    Object? isPaid = null,
    Object? paymentMethod = null,
    Object? carrierName = null,
    Object? shippingAddress = null,
    Object? itemsCount = null,
    Object? orderCostTtc = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$OrderTrackingImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        statusDisplay:
            null == statusDisplay
                ? _value.statusDisplay
                : statusDisplay // ignore: cast_nullable_to_non_nullable
                    as String,
        isPaid:
            null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                    as bool,
        paymentMethod:
            null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String,
        carrierName:
            null == carrierName
                ? _value.carrierName
                : carrierName // ignore: cast_nullable_to_non_nullable
                    as String,
        shippingAddress:
            null == shippingAddress
                ? _value.shippingAddress
                : shippingAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        itemsCount:
            null == itemsCount
                ? _value.itemsCount
                : itemsCount // ignore: cast_nullable_to_non_nullable
                    as int,
        orderCostTtc:
            null == orderCostTtc
                ? _value.orderCostTtc
                : orderCostTtc // ignore: cast_nullable_to_non_nullable
                    as double,
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
class _$OrderTrackingImpl implements _OrderTracking {
  const _$OrderTrackingImpl({
    required this.id,
    required this.status,
    @JsonKey(name: 'status_display') required this.statusDisplay,
    @JsonKey(name: 'is_paid') required this.isPaid,
    @JsonKey(name: 'payment_method') required this.paymentMethod,
    @JsonKey(name: 'carrier_name') required this.carrierName,
    @JsonKey(name: 'shipping_address') required this.shippingAddress,
    @JsonKey(name: 'items_count') required this.itemsCount,
    @JsonKey(name: 'order_cost_ttc') required this.orderCostTtc,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$OrderTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTrackingImplFromJson(json);

  @override
  final int id;
  @override
  final String status;
  @override
  @JsonKey(name: 'status_display')
  final String statusDisplay;
  @override
  @JsonKey(name: 'is_paid')
  final bool isPaid;
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @override
  @JsonKey(name: 'carrier_name')
  final String carrierName;
  @override
  @JsonKey(name: 'shipping_address')
  final String shippingAddress;
  @override
  @JsonKey(name: 'items_count')
  final int itemsCount;
  @override
  @JsonKey(name: 'order_cost_ttc')
  final double orderCostTtc;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'OrderTracking(id: $id, status: $status, statusDisplay: $statusDisplay, isPaid: $isPaid, paymentMethod: $paymentMethod, carrierName: $carrierName, shippingAddress: $shippingAddress, itemsCount: $itemsCount, orderCostTtc: $orderCostTtc, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTrackingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusDisplay, statusDisplay) ||
                other.statusDisplay == statusDisplay) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.carrierName, carrierName) ||
                other.carrierName == carrierName) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.orderCostTtc, orderCostTtc) ||
                other.orderCostTtc == orderCostTtc) &&
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
    status,
    statusDisplay,
    isPaid,
    paymentMethod,
    carrierName,
    shippingAddress,
    itemsCount,
    orderCostTtc,
    createdAt,
    updatedAt,
  );

  /// Create a copy of OrderTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTrackingImplCopyWith<_$OrderTrackingImpl> get copyWith =>
      __$$OrderTrackingImplCopyWithImpl<_$OrderTrackingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTrackingImplToJson(this);
  }
}

abstract class _OrderTracking implements OrderTracking {
  const factory _OrderTracking({
    required final int id,
    required final String status,
    @JsonKey(name: 'status_display') required final String statusDisplay,
    @JsonKey(name: 'is_paid') required final bool isPaid,
    @JsonKey(name: 'payment_method') required final String paymentMethod,
    @JsonKey(name: 'carrier_name') required final String carrierName,
    @JsonKey(name: 'shipping_address') required final String shippingAddress,
    @JsonKey(name: 'items_count') required final int itemsCount,
    @JsonKey(name: 'order_cost_ttc') required final double orderCostTtc,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$OrderTrackingImpl;

  factory _OrderTracking.fromJson(Map<String, dynamic> json) =
      _$OrderTrackingImpl.fromJson;

  @override
  int get id;
  @override
  String get status;
  @override
  @JsonKey(name: 'status_display')
  String get statusDisplay;
  @override
  @JsonKey(name: 'is_paid')
  bool get isPaid;
  @override
  @JsonKey(name: 'payment_method')
  String get paymentMethod;
  @override
  @JsonKey(name: 'carrier_name')
  String get carrierName;
  @override
  @JsonKey(name: 'shipping_address')
  String get shippingAddress;
  @override
  @JsonKey(name: 'items_count')
  int get itemsCount;
  @override
  @JsonKey(name: 'order_cost_ttc')
  double get orderCostTtc;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of OrderTracking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderTrackingImplCopyWith<_$OrderTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
