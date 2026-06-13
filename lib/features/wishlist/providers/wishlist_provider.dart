// lib/features/wishlist/providers/wishlist_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/providers/auth_provider.dart';
import '../../products/models/product.dart';
import '../models/wishlist_item.dart';
import '../repositories/wishlist_repository.dart';

final wishlistRepositoryProvider = Provider<WishlistRepository>((_) => WishlistRepository());

// ── Server wishlist (authenticated) ────────────────────────────────────────

class WishlistNotifier extends StateNotifier<AsyncValue<List<WishlistItem>>> {
  final WishlistRepository _repo;

  WishlistNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repo.getWishlist());
  }

  Future<void> add(int productId) async {
    await _repo.addToWishlist(productId);
    await load();
  }

  Future<void> remove(int wishlistItemId) async {
    await _repo.removeFromWishlist(wishlistItemId);
    state = AsyncValue.data(
      state.valueOrNull?.where((i) => i.id != wishlistItemId).toList() ?? [],
    );
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, AsyncValue<List<WishlistItem>>>((ref) {
  return WishlistNotifier(ref.read(wishlistRepositoryProvider));
});

// ── Guest (local) wishlist ──────────────────────────────────────────────────

const _kGuestWishlistKey = 'guest_wishlist_items';

class GuestWishlistNotifier extends StateNotifier<List<Product>> {
  GuestWishlistNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kGuestWishlistKey);
    if (raw != null) {
      try {
        state = (jsonDecode(raw) as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        state = [];
      }
    }
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _kGuestWishlistKey, jsonEncode(state.map((p) => p.toJson()).toList()));
  }

  Future<void> add(Product product) async {
    if (state.any((p) => p.id == product.id)) return;
    state = [...state, product];
    await _persist();
  }

  Future<void> remove(int productId) async {
    state = state.where((p) => p.id != productId).toList();
    await _persist();
  }

  Future<void> clear() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kGuestWishlistKey);
  }

  /// Sync guest wishlist to server after login, then clear local.
  Future<void> syncToServer(WishlistRepository repo) async {
    for (final product in state) {
      try {
        await repo.addToWishlist(product.id);
      } catch (_) {
        // Skip on error
      }
    }
    await clear();
  }
}

final guestWishlistProvider =
    StateNotifierProvider<GuestWishlistNotifier, List<Product>>((ref) {
  return GuestWishlistNotifier();
});

// ── Unified "is in wishlist" check ─────────────────────────────────────────

final isInWishlistProvider = Provider.family<bool, int>((ref, productId) {
  final isLoggedIn = ref.watch(authProvider).isLoggedIn;
  if (isLoggedIn) {
    final wishlist = ref.watch(wishlistProvider).valueOrNull ?? [];
    return wishlist.any((w) => w.product.id == productId);
  }
  return ref.watch(guestWishlistProvider).any((p) => p.id == productId);
});
