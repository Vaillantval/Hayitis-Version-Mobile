// lib/features/wishlist/screens/wishlist_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_state.dart';
import '../../../shared/widgets/star_rating.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../auth/providers/auth_provider.dart';
import '../../products/models/product.dart';
import '../providers/wishlist_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authProvider).isLoggedIn;

    if (!isLoggedIn) {
      return _GuestWishlistView();
    }

    final wishlistAsync = ref.watch(wishlistProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mes Favoris')),
      body: wishlistAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
            message: e.toString(),
            onRetry: () => ref.read(wishlistProvider.notifier).load()),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.favorite_outline,
              title: 'Aucun favori',
              subtitle: 'Ajoutez des produits à vos favoris pour les retrouver facilement',
              ctaLabel: 'Explorer la boutique',
              onCta: () => context.go('/shop'),
            );
          }
          return Column(
            children: [
              _WishlistHeader(count: items.length),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _WishlistCard(
                    product: items[i].product,
                    onRemove: () => ref.read(wishlistProvider.notifier).remove(items[i].id),
                    onTap: () => context.push('/products/${items[i].product.slug}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GuestWishlistView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(guestWishlistProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mes Favoris')),
      body: items.isEmpty
          ? EmptyState(
              icon: Icons.favorite_outline,
              title: 'Aucun favori',
              subtitle: 'Ajoutez des produits à vos favoris pour les retrouver facilement',
              ctaLabel: 'Explorer la boutique',
              onCta: () => context.go('/shop'),
            )
          : Column(
              children: [
                _WishlistHeader(
                  count: items.length,
                  onClear: () => ref.read(guestWishlistProvider.notifier).clear(),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _WishlistCard(
                      product: items[i],
                      onRemove: () => ref.read(guestWishlistProvider.notifier).remove(items[i].id),
                      onTap: () => context.push('/products/${items[i].slug}'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────────

class _WishlistHeader extends StatelessWidget {
  final int count;
  final VoidCallback? onClear;
  const _WishlistHeader({required this.count, this.onClear});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(children: [
              const Icon(Icons.favorite, color: AppColors.error, size: 14),
              const SizedBox(width: 4),
              Text('$count article${count > 1 ? 's' : ''}',
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.error)),
            ]),
          ),
          const Spacer(),
          if (onClear != null)
            TextButton.icon(
              onPressed: onClear,
              icon: const Icon(Icons.delete_sweep_outlined, size: 16),
              label: const Text('Tout supprimer', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(foregroundColor: AppColors.textMuted),
            ),
        ],
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onTap;
  const _WishlistCard({required this.product, required this.onRemove, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final rawUrl = product.images.isNotEmpty ? product.images.first.image : null;
    final imageUrl = rawUrl == null ? null
        : rawUrl.startsWith('http') ? rawUrl
        : 'https://hayitis.com$rawUrl';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 14, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl, width: 110, height: 110, fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => _WishImgPlaceholder(),
                    )
                  : _WishImgPlaceholder(),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.brand != null && product.brand!.isNotEmpty)
                      Text(
                        product.brand!.toUpperCase(),
                        style: const TextStyle(fontFamily: 'Poppins', fontSize: 9, fontWeight: FontWeight.w700,
                            color: AppColors.primary, letterSpacing: 0.8),
                      ),
                    Text(
                      product.name,
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13, height: 1.3),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatPrice(product.price, product.currency),
                      style: const TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    if (product.compareAtPrice > product.price) ...[
                      Text(
                        formatPrice(product.compareAtPrice, product.currency),
                        style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted,
                            fontSize: 11, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                    if (product.ratingAverage != null && product.ratingCount > 0) ...[
                      const SizedBox(height: 4),
                      Row(children: [
                        StarRating(rating: product.ratingAverage!, size: 11),
                        const SizedBox(width: 4),
                        Text('(${product.ratingCount})',
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, color: AppColors.textMuted)),
                      ]),
                    ],
                  ],
                ),
              ),
            ),
            // Remove button
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, color: AppColors.error, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishImgPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110, height: 110, color: const Color(0xFFF0F4F8),
      child: const Center(child: Icon(Icons.image_outlined, color: Color(0xFFCBD5E0), size: 36)),
    );
  }
}
