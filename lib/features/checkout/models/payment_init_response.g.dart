// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_init_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentInitResponseImpl _$$PaymentInitResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentInitResponseImpl(
  method: json['method'] as String,
  orderId: (json['order_id'] as num).toInt(),
  clientSecret: json['client_secret'] as String?,
  publicKey: json['public_key'] as String?,
  amountHtg: (json['amount_htg'] as num?)?.toDouble(),
  amountUsd: (json['amount_usd'] as num?)?.toDouble(),
  redirectUrl: json['redirect_url'] as String?,
  paymentToken: json['payment_token'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  message: json['message'] as String?,
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$$PaymentInitResponseImplToJson(
  _$PaymentInitResponseImpl instance,
) => <String, dynamic>{
  'method': instance.method,
  'order_id': instance.orderId,
  'client_secret': instance.clientSecret,
  'public_key': instance.publicKey,
  'amount_htg': instance.amountHtg,
  'amount_usd': instance.amountUsd,
  'redirect_url': instance.redirectUrl,
  'payment_token': instance.paymentToken,
  'amount': instance.amount,
  'message': instance.message,
  'reference': instance.reference,
};
