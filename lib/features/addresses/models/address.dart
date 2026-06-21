// lib/features/addresses/models/address.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required int id,
    required String street,
    required String city,
    String? phone,
    @JsonKey(name: 'more_details') String? moreDetails,
    @JsonKey(name: 'adress_type')  required String adressType,
    @JsonKey(name: 'is_default')   @Default(false) bool isDefault,
    @JsonKey(name: 'created_at')   required DateTime createdAt,
    @JsonKey(name: 'updated_at')   required DateTime updatedAt,
    // Encore renvoyé par le backend, mais optionnel (retiré du formulaire)
    @JsonKey(name: 'full_name') @Default('') String fullName,
    // Plus renvoyés par le backend — valeurs par défaut pour éviter le crash
    @Default('') String name,
    @JsonKey(name: 'code_postal') @Default('') String codePostal,
    @Default('Haiti') String country,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
