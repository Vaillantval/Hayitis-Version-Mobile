// lib/features/auth/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../core/notifications/fcm_service.dart';
import '../../../core/storage/secure_storage.dart';
import '../models/user_profile.dart';
import '../repositories/auth_repository.dart';

class AuthState {
  final bool isLoggedIn;
  final UserProfile? profile;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isLoggedIn = false,
    this.profile,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    UserProfile? profile,
    bool? isLoading,
    String? error,
    bool clearProfile = false,
  }) => AuthState(
    isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    profile:    clearProfile ? null : (profile ?? this.profile),
    isLoading:  isLoading ?? this.isLoading,
    error:      error,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AuthState()) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    state = state.copyWith(isLoading: true);
    try {
      final token = await SecureStorage.getAccessToken();
      if (token != null && !JwtDecoder.isExpired(token)) {
        final profile = await _repo.getProfile();
        state = state.copyWith(isLoggedIn: true, profile: profile, isLoading: false);
      } else {
        await _tryRefreshAndLoad();
      }
    } catch (_) {
      state = state.copyWith(isLoggedIn: false, isLoading: false, clearProfile: true);
    }
  }

  Future<void> _tryRefreshAndLoad() async {
    try {
      final refresh = await SecureStorage.getRefreshToken();
      if (refresh == null || JwtDecoder.isExpired(refresh)) {
        state = state.copyWith(isLoggedIn: false, isLoading: false, clearProfile: true);
        return;
      }
      final profile = await _repo.getProfile();
      state = state.copyWith(isLoggedIn: true, profile: profile, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoggedIn: false, isLoading: false, clearProfile: true);
    }
  }

  Future<void> login({required String username, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repo.login(username: username, password: password);
      state = state.copyWith(isLoggedIn: true, profile: result.profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String password2,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repo.register(
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        password2: password2,
      );
      state = state.copyWith(isLoggedIn: true, profile: result.profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    FcmService.stopListeningTokenRefresh();
    await _repo.logout();
    state = const AuthState();
  }

  Future<void> refreshProfile() async {
    try {
      final profile = await _repo.getProfile();
      state = state.copyWith(profile: profile);
    } catch (_) {}
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final profile = await _repo.updateProfile(data);
    state = state.copyWith(profile: profile);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

final userProfileProvider = Provider<UserProfile?>((ref) {
  return ref.watch(authProvider).profile;
});
