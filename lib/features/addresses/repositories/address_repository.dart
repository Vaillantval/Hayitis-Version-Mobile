// lib/features/addresses/repositories/address_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/address.dart';

class AddressRepository {
  final Dio _dio = ApiClient.instance;

  Future<List<Address>> getAddresses() async {
    try {
      final response = await _dio.get(Endpoints.addresses);
      final root = response.data as Map<String, dynamic>;
      return (root['data'] as List)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Address> createAddress(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(Endpoints.addresses, data: data);
      final root = response.data as Map<String, dynamic>;
      return Address.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Address> updateAddress(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(Endpoints.addressDetail(id), data: data);
      final root = response.data as Map<String, dynamic>;
      return Address.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      await _dio.delete(Endpoints.addressDetail(id));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> setDefaultAddress(int id) async {
    try {
      await _dio.patch(Endpoints.addressDefault(id));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
