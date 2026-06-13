// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'billing_address')
  String get billingAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipping_address')
  String get shippingAddress => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get taxe => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_cost')
  double get orderCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_cost_ttc')
  double get orderCostTtc => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paid')
  bool get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'carrier_name')
  String get carrierName => throw _privateConstructorUsedError;
  @JsonKey(name: 'carrier_price')
  double get carrierPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'stripe_payment_intent')
  String? get stripePaymentIntent => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_display')
  String get statusDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_details')
  List<OrderItem> get orderDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String? get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_proof_url')
  String? get paymentProofUrl => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'client_name') String clientName,
    @JsonKey(name: 'billing_address') String billingAddress,
    @JsonKey(name: 'shipping_address') String shippingAddress,
    int quantity,
    double taxe,
    @JsonKey(name: 'order_cost') double orderCost,
    @JsonKey(name: 'order_cost_ttc') double orderCostTtc,
    @JsonKey(name: 'is_paid') bool isPaid,
    @JsonKey(name: 'carrier_name') String carrierName,
    @JsonKey(name: 'carrier_price') double carrierPrice,
    @JsonKey(name: 'payment_method') String paymentMethod,
    @JsonKey(name: 'stripe_payment_intent') String? stripePaymentIntent,
    String status,
    @JsonKey(name: 'status_display') String statusDisplay,
    @JsonKey(name: 'order_details') List<OrderItem> orderDetails,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @JsonKey(name: 'payment_proof_url') String? paymentProofUrl,
  });
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? billingAddress = null,
    Object? shippingAddress = null,
    Object? quantity = null,
    Object? taxe = null,
    Object? orderCost = null,
    Object? orderCostTtc = null,
    Object? isPaid = null,
    Object? carrierName = null,
    Object? carrierPrice = null,
    Object? paymentMethod = null,
    Object? stripePaymentIntent = freezed,
    Object? status = null,
    Object? statusDisplay = null,
    Object? orderDetails = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? paymentStatus = freezed,
    Object? paymentProofUrl = freezed,
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
            billingAddress:
                null == billingAddress
                    ? _value.billingAddress
                    : billingAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            shippingAddress:
                null == shippingAddress
                    ? _value.shippingAddress
                    : shippingAddress // ignore: cast_nullable_to_non_nullable
                        as String,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            taxe:
                null == taxe
                    ? _value.taxe
                    : taxe // ignore: cast_nullable_to_non_nullable
                        as double,
            orderCost:
                null == orderCost
                    ? _value.orderCost
                    : orderCost // ignore: cast_nullable_to_non_nullable
                        as double,
            orderCostTtc:
                null == orderCostTtc
                    ? _value.orderCostTtc
                    : orderCostTtc // ignore: cast_nullable_to_non_nullable
                        as double,
            isPaid:
                null == isPaid
                    ? _value.isPaid
                    : isPaid // ignore: cast_nullable_to_non_nullable
                        as bool,
            carrierName:
                null == carrierName
                    ? _value.carrierName
                    : carrierName // ignore: cast_nullable_to_non_nullable
                        as String,
            carrierPrice:
                null == carrierPrice
                    ? _value.carrierPrice
                    : carrierPrice // ignore: cast_nullable_to_non_nullable
                        as double,
            paymentMethod:
                null == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String,
            stripePaymentIntent:
                freezed == stripePaymentIntent
                    ? _value.stripePaymentIntent
                    : stripePaymentIntent // ignore: cast_nullable_to_non_nullable
                        as String?,
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
            orderDetails:
                null == orderDetails
                    ? _value.orderDetails
                    : orderDetails // ignore: cast_nullable_to_non_nullable
                        as List<OrderItem>,
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
            paymentStatus:
                freezed == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentProofUrl:
                freezed == paymentProofUrl
                    ? _value.paymentProofUrl
                    : paymentProofUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'client_name') String clientName,
    @JsonKey(name: 'billing_address') String billingAddress,
    @JsonKey(name: 'shipping_address') String shippingAddress,
    int quantity,
    double taxe,
    @JsonKey(name: 'order_cost') double orderCost,
    @JsonKey(name: 'order_cost_ttc') double orderCostTtc,
    @JsonKey(name: 'is_paid') bool isPaid,
    @JsonKey(name: 'carrier_name') String carrierName,
    @JsonKey(name: 'carrier_price') double carrierPrice,
    @JsonKey(name: 'payment_method') String paymentMethod,
    @JsonKey(name: 'stripe_payment_intent') String? stripePaymentIntent,
    String status,
    @JsonKey(name: 'status_display') String statusDisplay,
    @JsonKey(name: 'order_details') List<OrderItem> orderDetails,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @JsonKey(name: 'payment_proof_url') String? paymentProofUrl,
  });
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? billingAddress = null,
    Object? shippingAddress = null,
    Object? quantity = null,
    Object? taxe = null,
    Object? orderCost = null,
    Object? orderCostTtc = null,
    Object? isPaid = null,
    Object? carrierName = null,
    Object? carrierPrice = null,
    Object? paymentMethod = null,
    Object? stripePaymentIntent = freezed,
    Object? status = null,
    Object? statusDisplay = null,
    Object? orderDetails = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? paymentStatus = freezed,
    Object? paymentProofUrl = freezed,
  }) {
    return _then(
      _$OrderImpl(
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
        billingAddress:
            null == billingAddress
                ? _value.billingAddress
                : billingAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        shippingAddress:
            null == shippingAddress
                ? _value.shippingAddress
                : shippingAddress // ignore: cast_nullable_to_non_nullable
                    as String,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        taxe:
            null == taxe
                ? _value.taxe
                : taxe // ignore: cast_nullable_to_non_nullable
                    as double,
        orderCost:
            null == orderCost
                ? _value.orderCost
                : orderCost // ignore: cast_nullable_to_non_nullable
                    as double,
        orderCostTtc:
            null == orderCostTtc
                ? _value.orderCostTtc
                : orderCostTtc // ignore: cast_nullable_to_non_nullable
                    as double,
        isPaid:
            null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                    as bool,
        carrierName:
            null == carrierName
                ? _value.carrierName
                : carrierName // ignore: cast_nullable_to_non_nullable
                    as String,
        carrierPrice:
            null == carrierPrice
                ? _value.carrierPrice
                : carrierPrice // ignore: cast_nullable_to_non_nullable
                    as double,
        paymentMethod:
            null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String,
        stripePaymentIntent:
            freezed == stripePaymentIntent
                ? _value.stripePaymentIntent
                : stripePaymentIntent // ignore: cast_nullable_to_non_nullable
                    as String?,
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
        orderDetails:
            null == orderDetails
                ? _value._orderDetails
                : orderDetails // ignore: cast_nullable_to_non_nullable
                    as List<OrderItem>,
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
        paymentStatus:
            freezed == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentProofUrl:
            freezed == paymentProofUrl
                ? _value.paymentProofUrl
                : paymentProofUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.id,
    @JsonKey(name: 'client_name') required this.clientName,
    @JsonKey(name: 'billing_address') required this.billingAddress,
    @JsonKey(name: 'shipping_address') required this.shippingAddress,
    required this.quantity,
    required this.taxe,
    @JsonKey(name: 'order_cost') required this.orderCost,
    @JsonKey(name: 'order_cost_ttc') required this.orderCostTtc,
    @JsonKey(name: 'is_paid') required this.isPaid,
    @JsonKey(name: 'carrier_name') required this.carrierName,
    @JsonKey(name: 'carrier_price') required this.carrierPrice,
    @JsonKey(name: 'payment_method') required this.paymentMethod,
    @JsonKey(name: 'stripe_payment_intent') this.stripePaymentIntent,
    required this.status,
    @JsonKey(name: 'status_display') required this.statusDisplay,
    @JsonKey(name: 'order_details') required final List<OrderItem> orderDetails,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'payment_status') this.paymentStatus,
    @JsonKey(name: 'payment_proof_url') this.paymentProofUrl,
  }) : _orderDetails = orderDetails;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'client_name')
  final String clientName;
  @override
  @JsonKey(name: 'billing_address')
  final String billingAddress;
  @override
  @JsonKey(name: 'shipping_address')
  final String shippingAddress;
  @override
  final int quantity;
  @override
  final double taxe;
  @override
  @JsonKey(name: 'order_cost')
  final double orderCost;
  @override
  @JsonKey(name: 'order_cost_ttc')
  final double orderCostTtc;
  @override
  @JsonKey(name: 'is_paid')
  final bool isPaid;
  @override
  @JsonKey(name: 'carrier_name')
  final String carrierName;
  @override
  @JsonKey(name: 'carrier_price')
  final double carrierPrice;
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @override
  @JsonKey(name: 'stripe_payment_intent')
  final String? stripePaymentIntent;
  @override
  final String status;
  @override
  @JsonKey(name: 'status_display')
  final String statusDisplay;
  final List<OrderItem> _orderDetails;
  @override
  @JsonKey(name: 'order_details')
  List<OrderItem> get orderDetails {
    if (_orderDetails is EqualUnmodifiableListView) return _orderDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderDetails);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @override
  @JsonKey(name: 'payment_proof_url')
  final String? paymentProofUrl;

  @override
  String toString() {
    return 'Order(id: $id, clientName: $clientName, billingAddress: $billingAddress, shippingAddress: $shippingAddress, quantity: $quantity, taxe: $taxe, orderCost: $orderCost, orderCostTtc: $orderCostTtc, isPaid: $isPaid, carrierName: $carrierName, carrierPrice: $carrierPrice, paymentMethod: $paymentMethod, stripePaymentIntent: $stripePaymentIntent, status: $status, statusDisplay: $statusDisplay, orderDetails: $orderDetails, createdAt: $createdAt, updatedAt: $updatedAt, paymentStatus: $paymentStatus, paymentProofUrl: $paymentProofUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.billingAddress, billingAddress) ||
                other.billingAddress == billingAddress) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.taxe, taxe) || other.taxe == taxe) &&
            (identical(other.orderCost, orderCost) ||
                other.orderCost == orderCost) &&
            (identical(other.orderCostTtc, orderCostTtc) ||
                other.orderCostTtc == orderCostTtc) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.carrierName, carrierName) ||
                other.carrierName == carrierName) &&
            (identical(other.carrierPrice, carrierPrice) ||
                other.carrierPrice == carrierPrice) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.stripePaymentIntent, stripePaymentIntent) ||
                other.stripePaymentIntent == stripePaymentIntent) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusDisplay, statusDisplay) ||
                other.statusDisplay == statusDisplay) &&
            const DeepCollectionEquality().equals(
              other._orderDetails,
              _orderDetails,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentProofUrl, paymentProofUrl) ||
                other.paymentProofUrl == paymentProofUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    clientName,
    billingAddress,
    shippingAddress,
    quantity,
    taxe,
    orderCost,
    orderCostTtc,
    isPaid,
    carrierName,
    carrierPrice,
    paymentMethod,
    stripePaymentIntent,
    status,
    statusDisplay,
    const DeepCollectionEquality().hash(_orderDetails),
    createdAt,
    updatedAt,
    paymentStatus,
    paymentProofUrl,
  ]);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    required final int id,
    @JsonKey(name: 'client_name') required final String clientName,
    @JsonKey(name: 'billing_address') required final String billingAddress,
    @JsonKey(name: 'shipping_address') required final String shippingAddress,
    required final int quantity,
    required final double taxe,
    @JsonKey(name: 'order_cost') required final double orderCost,
    @JsonKey(name: 'order_cost_ttc') required final double orderCostTtc,
    @JsonKey(name: 'is_paid') required final bool isPaid,
    @JsonKey(name: 'carrier_name') required final String carrierName,
    @JsonKey(name: 'carrier_price') required final double carrierPrice,
    @JsonKey(name: 'payment_method') required final String paymentMethod,
    @JsonKey(name: 'stripe_payment_intent') final String? stripePaymentIntent,
    required final String status,
    @JsonKey(name: 'status_display') required final String statusDisplay,
    @JsonKey(name: 'order_details') required final List<OrderItem> orderDetails,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    @JsonKey(name: 'payment_status') final String? paymentStatus,
    @JsonKey(name: 'payment_proof_url') final String? paymentProofUrl,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'client_name')
  String get clientName;
  @override
  @JsonKey(name: 'billing_address')
  String get billingAddress;
  @override
  @JsonKey(name: 'shipping_address')
  String get shippingAddress;
  @override
  int get quantity;
  @override
  double get taxe;
  @override
  @JsonKey(name: 'order_cost')
  double get orderCost;
  @override
  @JsonKey(name: 'order_cost_ttc')
  double get orderCostTtc;
  @override
  @JsonKey(name: 'is_paid')
  bool get isPaid;
  @override
  @JsonKey(name: 'carrier_name')
  String get carrierName;
  @override
  @JsonKey(name: 'carrier_price')
  double get carrierPrice;
  @override
  @JsonKey(name: 'payment_method')
  String get paymentMethod;
  @override
  @JsonKey(name: 'stripe_payment_intent')
  String? get stripePaymentIntent;
  @override
  String get status;
  @override
  @JsonKey(name: 'status_display')
  String get statusDisplay;
  @override
  @JsonKey(name: 'order_details')
  List<OrderItem> get orderDetails;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'payment_status')
  String? get paymentStatus;
  @override
  @JsonKey(name: 'payment_proof_url')
  String? get paymentProofUrl;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
