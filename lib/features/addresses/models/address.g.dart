// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      street: json['street'] as String,
      codePostal: json['code_postal'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      phone: json['phone'] as String,
      moreDetails: json['more_details'] as String?,
      adressType: json['adress_type'] as String,
      isDefault: json['is_default'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'street': instance.street,
      'code_postal': instance.codePostal,
      'city': instance.city,
      'country': instance.country,
      'phone': instance.phone,
      'more_details': instance.moreDetails,
      'adress_type': instance.adressType,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
