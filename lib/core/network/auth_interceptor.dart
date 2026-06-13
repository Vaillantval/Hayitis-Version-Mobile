// lib/core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import 'endpoints.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;

  AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;
    if (!Endpoints.isPublicRoute(path)) {
      final token = await SecureStorage.getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      final refreshed = await _tryRefresh();
      _isRefreshing = false;

      if (refreshed) {
        try {
          final retryResponse = await _retry(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          await _logout();
        }
      } else {
        await _logout();
      }
    }
    handler.next(err);
  }

  Future<bool> _tryRefresh() async {
    try {
      final refreshToken = await SecureStorage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        Endpoints.baseUrl + Endpoints.tokenRefresh,
        data: {'refresh': refreshToken},
        options: Options(headers: {}),
      );

      final newAccess = response.data['access'] as String?;
      if (newAccess != null) {
        await SecureStorage.updateAccessToken(newAccess);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final token = await SecureStorage.getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );
    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> _logout() async {
    await SecureStorage.clearAll();
    // Le router écoutera l'état auth et redirigera
  }
}
