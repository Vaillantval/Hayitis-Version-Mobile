// lib/features/addresses/models/address.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required int id,
    required String name,
    @JsonKey(name: 'full_name')    required String fullName,
    required String street,
    @JsonKey(name: 'code_postal')  required String codePostal,
    required String city,
    required String country,
    required String phone,
    @JsonKey(name: 'more_details') String? moreDetails,
    @JsonKey(name: 'adress_type') required String adressType,
    @JsonKey(name: 'is_default')  required bool isDefault,
    @JsonKey(name: 'created_at')  required DateTime createdAt,
    @JsonKey(name: 'updated_at')  required DateTime updatedAt,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
