// lib/features/cart/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';
import '../models/local_cart_item.dart';
import '../repositories/cart_repository.dart';
import '../../auth/providers/auth_provider.dart';

final cartRepositoryProvider = Provider<CartRepository>((_) => CartRepository());

// ── Server cart (authenticated) ────────────────────────────────────────────

class CartNotifier extends StateNotifier<AsyncValue<Cart?>> {
  final CartRepository _repo;

  CartNotifier(this._repo) : super(const AsyncValue.data(null));

  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repo.getCart());
  }

  Future<void> addItem(int productId, int quantity, {int? priceId}) async {
    final cart = await _repo.addToCart(productId, quantity, priceId: priceId);
    state = AsyncValue.data(cart);
  }

  Future<void> updateItem(int itemId, int quantity) async {
    if (quantity == 0) {
      await removeItem(itemId);
      return;
    }
    final cart = await _repo.updateCartItem(itemId, quantity);
    state = AsyncValue.data(cart);
  }

  Future<void> removeItem(int itemId) async {
    final cart = await _repo.removeCartItem(itemId);
    state = AsyncValue.data(cart);
  }

  Future<void> clear() async {
    await _repo.clearCart();
    state = const AsyncValue.data(null);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, AsyncValue<Cart?>>((ref) {
  return CartNotifier(ref.read(cartRepositoryProvider));
});

// ── Guest (local) cart ──────────────────────────────────────────────────────

const _kGuestCartKey = 'guest_cart_items';

class GuestCartNotifier extends StateNotifier<List<LocalCartItem>> {
  GuestCartNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kGuestCartKey);
    if (raw != null) {
      try {
        state = LocalCartItem.decodeList(raw);
      } catch (_) {
        state = [];
      }
    }
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kGuestCartKey, LocalCartItem.encodeList(state));
  }

  Future<void> add(LocalCartItem item) async {
    final idx = state.indexWhere((e) => e.productId == item.productId);
    if (idx >= 0) {
      final updated = List<LocalCartItem>.from(state);
      updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity + item.quantity);
      state = updated;
    } else {
      state = [...state, item];
    }
    await _persist();
  }

  Future<void> update(int productId, int quantity) async {
    if (quantity <= 0) {
      await remove(productId);
      return;
    }
    state = state.map((e) => e.productId == productId ? e.copyWith(quantity: quantity) : e).toList();
    await _persist();
  }

  Future<void> remove(int productId) async {
    state = state.where((e) => e.productId != productId).toList();
    await _persist();
  }

  Future<void> clear() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kGuestCartKey);
  }

  /// Merge guest cart into server cart after login, then clear local.
  Future<void> syncToServer(CartRepository repo) async {
    for (final item in state) {
      try {
        await repo.addToCart(item.productId, item.quantity);
      } catch (_) {
        // Skip items that fail (e.g. out of stock)
      }
    }
    await clear();
  }
}

final guestCartProvider = StateNotifierProvider<GuestCartNotifier, List<LocalCartItem>>((ref) {
  return GuestCartNotifier();
});

// ── Unified count for nav badge ─────────────────────────────────────────────

final cartCountProvider = Provider<int>((ref) {
  final isLoggedIn = ref.watch(authProvider).isLoggedIn;
  if (isLoggedIn) {
    return ref.watch(cartProvider).valueOrNull?.totalItems ?? 0;
  }
  return ref.watch(guestCartProvider).fold(0, (sum, item) => sum + item.quantity);
});
