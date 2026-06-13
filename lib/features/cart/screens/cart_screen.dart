// lib/features/cart/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_state.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/local_cart_item.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authProvider).isLoggedIn) {
        ref.read(cartProvider.notifier).load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(authProvider).isLoggedIn;

    if (!isLoggedIn) {
      return _GuestCartView();
    }

    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mon Panier'),
        actions: [
          cartAsync.valueOrNull?.items.isNotEmpty == true
              ? TextButton(
                  onPressed: () async {
                    await ref.read(cartProvider.notifier).clear();
                    Fluttertoast.showToast(msg: 'Panier vidé');
                  },
                  child: const Text('Vider', style: TextStyle(color: Colors.white)),
                )
              : const SizedBox(),
        ],
      ),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(message: e.toString(), onRetry: () => ref.read(cartProvider.notifier).load()),
        data: (cart) {
          if (cart == null || cart.items.isEmpty) {
            return EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'Votre panier est vide',
              subtitle: 'Découvrez nos produits et ajoutez-les à votre panier',
              ctaLabel: 'Continuer mes achats',
              onCta: () => context.go('/shop'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final item = cart.items[i];
                    final rawUrl = item.product.images.isNotEmpty ? item.product.images.first.image : null;
                    final imageUrl = rawUrl == null ? null
                        : rawUrl.startsWith('http') ? rawUrl
                        : 'https://hayitis.com$rawUrl';
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: imageUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: imageUrl, width: 80, height: 80, fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) => _CartImagePlaceholder(),
                                    )
                                  : _CartImagePlaceholder(),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13)),
                                  const SizedBox(height: 6),
                                  Text(formatPrice(item.product.price, item.product.currency),
                                      style: const TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  Row(children: [
                                    _QtyButton(
                                      icon: Icons.remove,
                                      onTap: () => ref.read(cartProvider.notifier).updateItem(item.id, item.quantity - 1),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text('${item.quantity}',
                                          style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 15)),
                                    ),
                                    _QtyButton(
                                      icon: Icons.add,
                                      onTap: () => ref.read(cartProvider.notifier).updateItem(item.id, item.quantity + 1),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => ref.read(cartProvider.notifier).removeItem(item.id),
                              child: Container(
                                width: 34, height: 34,
                                decoration: BoxDecoration(
                                  color: AppColors.error.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.delete_outline, color: AppColors.error, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
                ),
                child: Column(
                  children: [
                    _SummaryRow('Sous-total HT', formatPrice(cart.subtotalHt, cart.currency)),
                    const SizedBox(height: 4),
                    _SummaryRow('Taxes', formatPrice(cart.taxAmount, cart.currency)),
                    const Divider(),
                    _SummaryRow('Total TTC', formatPrice(cart.subtotalTtc, cart.currency), isBold: true),
                    const SizedBox(height: 12),
                    CustomButton(label: 'Commander', onPressed: () => context.push('/checkout')),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Guest cart view ─────────────────────────────────────────────────────────

class _GuestCartView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(guestCartProvider);
    final double total = items.fold(0, (s, i) => s + i.price * i.quantity);
    final String currency = items.isNotEmpty ? items.first.currency : 'HTG';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mon Panier'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: () => ref.read(guestCartProvider.notifier).clear(),
              child: const Text('Vider', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: items.isEmpty
          ? EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'Votre panier est vide',
              subtitle: 'Découvrez nos produits et ajoutez-les à votre panier',
              ctaLabel: 'Continuer mes achats',
              onCta: () => context.go('/shop'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _GuestCartItemTile(items[i]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
                  ),
                  child: Column(
                    children: [
                      _SummaryRow('Total estimé', formatPrice(total, currency), isBold: true),
                      const SizedBox(height: 4),
                      Text('Connectez-vous pour finaliser votre commande',
                          style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      CustomButton(
                        label: 'Se connecter pour commander',
                        onPressed: () => context.push('/auth/login?redirect=/cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _GuestCartItemTile extends ConsumerWidget {
  final LocalCartItem item;
  const _GuestCartItemTile(this.item);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: item.imageUrl!, width: 80, height: 80, fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => _CartImagePlaceholder(),
                    )
                  : _CartImagePlaceholder(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Text(formatPrice(item.price, item.currency),
                      style: const TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: () => ref.read(guestCartProvider.notifier).update(item.productId, item.quantity - 1),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('${item.quantity}',
                          style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 15)),
                    ),
                    _QtyButton(
                      icon: Icons.add,
                      onTap: () => ref.read(guestCartProvider.notifier).update(item.productId, item.quantity + 1),
                    ),
                  ]),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => ref.read(guestCartProvider.notifier).remove(item.productId),
              child: Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.delete_outline, color: AppColors.error, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, height: 80,
      color: const Color(0xFFF0F4F8),
      child: const Center(child: Icon(Icons.image_outlined, color: Color(0xFFCBD5E0), size: 32)),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _SummaryRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      fontSize: isBold ? 16 : 14,
      color: isBold ? AppColors.textPrimary : AppColors.textMuted,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }
}
