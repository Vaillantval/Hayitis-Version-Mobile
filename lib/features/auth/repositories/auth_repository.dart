// lib/features/auth/repositories/auth_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../../../core/notifications/fcm_service.dart';
import '../../../core/storage/secure_storage.dart';
import '../models/auth_tokens.dart';
import '../models/user_profile.dart';

class AuthRepository {
  final Dio _dio = ApiClient.instance;

  Future<({AuthTokens tokens, UserProfile profile})> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(Endpoints.login, data: {
        'username': username,
        'password': password,
      });
      final root    = response.data as Map<String, dynamic>;
      final inner   = root['data'] as Map<String, dynamic>;
      final tokens  = AuthTokens.fromJson(inner['tokens'] as Map<String, dynamic>);
      final profile = UserProfile.fromJson(inner['user'] as Map<String, dynamic>);
      await SecureStorage.saveTokens(
        access: tokens.access,
        refresh: tokens.refresh,
      );
      // FCM — enregistrer le token et écouter les rafraîchissements
      await FcmService.requestPermission();
      await FcmService.registerToken();
      FcmService.listenTokenRefresh();
      return (tokens: tokens, profile: profile);
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<({AuthTokens tokens, UserProfile profile})> register({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String password2,
  }) async {
    try {
      final response = await _dio.post(Endpoints.register, data: {
        'username':   username,
        'email':      email,
        'first_name': firstName,
        'last_name':  lastName,
        'password':   password,
        'password2':  password2,
        'agree_terms': true,
      });
      final root   = response.data as Map<String, dynamic>;
      final inner  = root['data'] as Map<String, dynamic>;
      final tokens = AuthTokens.fromJson(inner['tokens'] as Map<String, dynamic>);
      await SecureStorage.saveTokens(
        access: tokens.access,
        refresh: tokens.refresh,
      );
      final profile = await getProfile();
      // FCM — enregistrer le token et écouter les rafraîchissements
      await FcmService.requestPermission();
      await FcmService.registerToken();
      FcmService.listenTokenRefresh();
      return (tokens: tokens, profile: profile);
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> logout() async {
    try {
      final refresh = await SecureStorage.getRefreshToken();
      await _dio.post(Endpoints.logout, data: {'refresh': refresh});
    } catch (_) {}
    await SecureStorage.clearAll();
  }

  Future<UserProfile> getProfile() async {
    try {
      final response = await _dio.get(Endpoints.me);
      final root = response.data as Map<String, dynamic>;
      return UserProfile.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<UserProfile> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(Endpoints.me, data: data);
      final root = response.data as Map<String, dynamic>;
      return UserProfile.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      await _dio.post(Endpoints.changePassword, data: {
        'old_password':  oldPassword,
        'new_password':  newPassword,
        'new_password2': newPassword2,
      });
    } on DioException catch (e) {
      throw ApiException.fromJson(
        e.response?.data as Map<String, dynamic>? ?? {},
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> sendFcmToken(String token) async {
    try {
      await _dio.post(Endpoints.fcmToken, data: {'fcm_token': token});
    } catch (_) {}
  }
}
