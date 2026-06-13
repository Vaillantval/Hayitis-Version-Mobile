// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_init_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaymentInitResponse _$PaymentInitResponseFromJson(Map<String, dynamic> json) {
  return _PaymentInitResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentInitResponse {
  String get method => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  int get orderId => throw _privateConstructorUsedError; // Stripe
  @JsonKey(name: 'client_secret')
  String? get clientSecret => throw _privateConstructorUsedError;
  @JsonKey(name: 'public_key')
  String? get publicKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_htg')
  double? get amountHtg => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_usd')
  double? get amountUsd => throw _privateConstructorUsedError; // MonCash
  @JsonKey(name: 'redirect_url')
  String? get redirectUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_token')
  String? get paymentToken => throw _privateConstructorUsedError; // MonCash + NatCash
  double? get amount => throw _privateConstructorUsedError; // NatCash
  String? get message => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;

  /// Serializes this PaymentInitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentInitResponseCopyWith<PaymentInitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentInitResponseCopyWith<$Res> {
  factory $PaymentInitResponseCopyWith(
    PaymentInitResponse value,
    $Res Function(PaymentInitResponse) then,
  ) = _$PaymentInitResponseCopyWithImpl<$Res, PaymentInitResponse>;
  @useResult
  $Res call({
    String method,
    @JsonKey(name: 'order_id') int orderId,
    @JsonKey(name: 'client_secret') String? clientSecret,
    @JsonKey(name: 'public_key') String? publicKey,
    @JsonKey(name: 'amount_htg') double? amountHtg,
    @JsonKey(name: 'amount_usd') double? amountUsd,
    @JsonKey(name: 'redirect_url') String? redirectUrl,
    @JsonKey(name: 'payment_token') String? paymentToken,
    double? amount,
    String? message,
    String? reference,
  });
}

/// @nodoc
class _$PaymentInitResponseCopyWithImpl<$Res, $Val extends PaymentInitResponse>
    implements $PaymentInitResponseCopyWith<$Res> {
  _$PaymentInitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? orderId = null,
    Object? clientSecret = freezed,
    Object? publicKey = freezed,
    Object? amountHtg = freezed,
    Object? amountUsd = freezed,
    Object? redirectUrl = freezed,
    Object? paymentToken = freezed,
    Object? amount = freezed,
    Object? message = freezed,
    Object? reference = freezed,
  }) {
    return _then(
      _value.copyWith(
            method:
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            orderId:
                null == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as int,
            clientSecret:
                freezed == clientSecret
                    ? _value.clientSecret
                    : clientSecret // ignore: cast_nullable_to_non_nullable
                        as String?,
            publicKey:
                freezed == publicKey
                    ? _value.publicKey
                    : publicKey // ignore: cast_nullable_to_non_nullable
                        as String?,
            amountHtg:
                freezed == amountHtg
                    ? _value.amountHtg
                    : amountHtg // ignore: cast_nullable_to_non_nullable
                        as double?,
            amountUsd:
                freezed == amountUsd
                    ? _value.amountUsd
                    : amountUsd // ignore: cast_nullable_to_non_nullable
                        as double?,
            redirectUrl:
                freezed == redirectUrl
                    ? _value.redirectUrl
                    : redirectUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentToken:
                freezed == paymentToken
                    ? _value.paymentToken
                    : paymentToken // ignore: cast_nullable_to_non_nullable
                        as String?,
            amount:
                freezed == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as double?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            reference:
                freezed == reference
                    ? _value.reference
                    : reference // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentInitResponseImplCopyWith<$Res>
    implements $PaymentInitResponseCopyWith<$Res> {
  factory _$$PaymentInitResponseImplCopyWith(
    _$PaymentInitResponseImpl value,
    $Res Function(_$PaymentInitResponseImpl) then,
  ) = __$$PaymentInitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String method,
    @JsonKey(name: 'order_id') int orderId,
    @JsonKey(name: 'client_secret') String? clientSecret,
    @JsonKey(name: 'public_key') String? publicKey,
    @JsonKey(name: 'amount_htg') double? amountHtg,
    @JsonKey(name: 'amount_usd') double? amountUsd,
    @JsonKey(name: 'redirect_url') String? redirectUrl,
    @JsonKey(name: 'payment_token') String? paymentToken,
    double? amount,
    String? message,
    String? reference,
  });
}

/// @nodoc
class __$$PaymentInitResponseImplCopyWithImpl<$Res>
    extends _$PaymentInitResponseCopyWithImpl<$Res, _$PaymentInitResponseImpl>
    implements _$$PaymentInitResponseImplCopyWith<$Res> {
  __$$PaymentInitResponseImplCopyWithImpl(
    _$PaymentInitResponseImpl _value,
    $Res Function(_$PaymentInitResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? orderId = null,
    Object? clientSecret = freezed,
    Object? publicKey = freezed,
    Object? amountHtg = freezed,
    Object? amountUsd = freezed,
    Object? redirectUrl = freezed,
    Object? paymentToken = freezed,
    Object? amount = freezed,
    Object? message = freezed,
    Object? reference = freezed,
  }) {
    return _then(
      _$PaymentInitResponseImpl(
        method:
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        orderId:
            null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as int,
        clientSecret:
            freezed == clientSecret
                ? _value.clientSecret
                : clientSecret // ignore: cast_nullable_to_non_nullable
                    as String?,
        publicKey:
            freezed == publicKey
                ? _value.publicKey
                : publicKey // ignore: cast_nullable_to_non_nullable
                    as String?,
        amountHtg:
            freezed == amountHtg
                ? _value.amountHtg
                : amountHtg // ignore: cast_nullable_to_non_nullable
                    as double?,
        amountUsd:
            freezed == amountUsd
                ? _value.amountUsd
                : amountUsd // ignore: cast_nullable_to_non_nullable
                    as double?,
        redirectUrl:
            freezed == redirectUrl
                ? _value.redirectUrl
                : redirectUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentToken:
            freezed == paymentToken
                ? _value.paymentToken
                : paymentToken // ignore: cast_nullable_to_non_nullable
                    as String?,
        amount:
            freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as double?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        reference:
            freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentInitResponseImpl implements _PaymentInitResponse {
  const _$PaymentInitResponseImpl({
    required this.method,
    @JsonKey(name: 'order_id') required this.orderId,
    @JsonKey(name: 'client_secret') this.clientSecret,
    @JsonKey(name: 'public_key') this.publicKey,
    @JsonKey(name: 'amount_htg') this.amountHtg,
    @JsonKey(name: 'amount_usd') this.amountUsd,
    @JsonKey(name: 'redirect_url') this.redirectUrl,
    @JsonKey(name: 'payment_token') this.paymentToken,
    this.amount,
    this.message,
    this.reference,
  });

  factory _$PaymentInitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentInitResponseImplFromJson(json);

  @override
  final String method;
  @override
  @JsonKey(name: 'order_id')
  final int orderId;
  // Stripe
  @override
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @override
  @JsonKey(name: 'public_key')
  final String? publicKey;
  @override
  @JsonKey(name: 'amount_htg')
  final double? amountHtg;
  @override
  @JsonKey(name: 'amount_usd')
  final double? amountUsd;
  // MonCash
  @override
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;
  @override
  @JsonKey(name: 'payment_token')
  final String? paymentToken;
  // MonCash + NatCash
  @override
  final double? amount;
  // NatCash
  @override
  final String? message;
  @override
  final String? reference;

  @override
  String toString() {
    return 'PaymentInitResponse(method: $method, orderId: $orderId, clientSecret: $clientSecret, publicKey: $publicKey, amountHtg: $amountHtg, amountUsd: $amountUsd, redirectUrl: $redirectUrl, paymentToken: $paymentToken, amount: $amount, message: $message, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentInitResponseImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.amountHtg, amountHtg) ||
                other.amountHtg == amountHtg) &&
            (identical(other.amountUsd, amountUsd) ||
                other.amountUsd == amountUsd) &&
            (identical(other.redirectUrl, redirectUrl) ||
                other.redirectUrl == redirectUrl) &&
            (identical(other.paymentToken, paymentToken) ||
                other.paymentToken == paymentToken) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    method,
    orderId,
    clientSecret,
    publicKey,
    amountHtg,
    amountUsd,
    redirectUrl,
    paymentToken,
    amount,
    message,
    reference,
  );

  /// Create a copy of PaymentInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentInitResponseImplCopyWith<_$PaymentInitResponseImpl> get copyWith =>
      __$$PaymentInitResponseImplCopyWithImpl<_$PaymentInitResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentInitResponseImplToJson(this);
  }
}

abstract class _PaymentInitResponse implements PaymentInitResponse {
  const factory _PaymentInitResponse({
    required final String method,
    @JsonKey(name: 'order_id') required final int orderId,
    @JsonKey(name: 'client_secret') final String? clientSecret,
    @JsonKey(name: 'public_key') final String? publicKey,
    @JsonKey(name: 'amount_htg') final double? amountHtg,
    @JsonKey(name: 'amount_usd') final double? amountUsd,
    @JsonKey(name: 'redirect_url') final String? redirectUrl,
    @JsonKey(name: 'payment_token') final String? paymentToken,
    final double? amount,
    final String? message,
    final String? reference,
  }) = _$PaymentInitResponseImpl;

  factory _PaymentInitResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentInitResponseImpl.fromJson;

  @override
  String get method;
  @override
  @JsonKey(name: 'order_id')
  int get orderId; // Stripe
  @override
  @JsonKey(name: 'client_secret')
  String? get clientSecret;
  @override
  @JsonKey(name: 'public_key')
  String? get publicKey;
  @override
  @JsonKey(name: 'amount_htg')
  double? get amountHtg;
  @override
  @JsonKey(name: 'amount_usd')
  double? get amountUsd; // MonCash
  @override
  @JsonKey(name: 'redirect_url')
  String? get redirectUrl;
  @override
  @JsonKey(name: 'payment_token')
  String? get paymentToken; // MonCash + NatCash
  @override
  double? get amount; // NatCash
  @override
  String? get message;
  @override
  String? get reference;

  /// Create a copy of PaymentInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentInitResponseImplCopyWith<_$PaymentInitResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
