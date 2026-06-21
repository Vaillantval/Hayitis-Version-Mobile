// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: (json['id'] as num).toInt(),
      street: json['street'] as String,
      city: json['city'] as String,
      phone: json['phone'] as String?,
      moreDetails: json['more_details'] as String?,
      adressType: json['adress_type'] as String,
      isDefault: json['is_default'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      fullName: json['full_name'] as String? ?? '',
      name: json['name'] as String? ?? '',
      codePostal: json['code_postal'] as String? ?? '',
      country: json['country'] as String? ?? 'Haiti',
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'street': instance.street,
      'city': instance.city,
      'phone': instance.phone,
      'more_details': instance.moreDetails,
      'adress_type': instance.adressType,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'full_name': instance.fullName,
      'name': instance.name,
      'code_postal': instance.codePostal,
      'country': instance.country,
    };
