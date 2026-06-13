// lib/shared/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../features/products/models/product.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/wishlist/providers/wishlist_provider.dart';
import 'loading_shimmer.dart';
import 'price_text.dart';
import 'star_rating.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final bool showWishlist;

  const ProductCard({super.key, required this.product, this.showWishlist = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInWishlist = ref.watch(isInWishlistProvider(product.id));
    final rawUrl = product.images.isNotEmpty ? product.images.first.image : null;
    final imageUrl = rawUrl == null ? null
        : rawUrl.startsWith('http') ? rawUrl
        : 'https://hayitis.com$rawUrl';

    return GestureDetector(
      onTap: () => context.push('/products/${product.slug}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          memCacheWidth: 400,
                          placeholder: (_, __) => const LoadingShimmer(height: double.infinity),
                          errorWidget: (_, __, ___) => _ImagePlaceholder(),
                        )
                      : _ImagePlaceholder(),
                ),
                // Gradient overlay at bottom of image
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withValues(alpha: 0.22), Colors.transparent],
                      ),
                    ),
                  ),
                ),
                // Badges top-left
                Positioned(
                  top: 8,
                  left: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.inStock == false)
                        _Badge('Épuisé', AppColors.error),
                      if (product.inStock && product.stockQuantity < 5 && product.stockQuantity > 0)
                        _Badge('Stock faible', AppColors.warning),
                    ],
                  ),
                ),
                // Discount badge top-right
                if (product.compareAtPrice > product.price)
                  Positioned(
                    top: 8,
                    right: showWishlist ? 46 : 8,
                    child: _Badge(
                      '-${(((product.compareAtPrice - product.price) / product.compareAtPrice) * 100).round()}%',
                      AppColors.error,
                    ),
                  ),
                // Wishlist button
                if (showWishlist)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        final isLoggedIn = ref.read(authProvider).isLoggedIn;
                        if (isLoggedIn) {
                          if (isInWishlist) {
                            final wishlist = ref.read(wishlistProvider).valueOrNull ?? [];
                            final item = wishlist.where((w) => w.product.id == product.id).firstOrNull;
                            if (item != null) ref.read(wishlistProvider.notifier).remove(item.id);
                          } else {
                            ref.read(wishlistProvider.notifier).add(product.id);
                          }
                        } else {
                          if (isInWishlist) {
                            ref.read(guestWishlistProvider.notifier).remove(product.id);
                          } else {
                            ref.read(guestWishlistProvider.notifier).add(product);
                          }
                        }
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 8),
                          ],
                        ),
                        child: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_outline,
                          color: isInWishlist ? AppColors.error : AppColors.textMuted,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.brand != null && product.brand!.isNotEmpty)
                    Text(
                      product.brand!.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: PriceText(
                      price: product.price,
                      compareAtPrice: product.compareAtPrice > product.price ? product.compareAtPrice : null,
                      currency: product.currency,
                      fontSize: 14,
                    ),
                  ),
                  if (product.ratingAverage != null && product.ratingCount > 0) ...[
                    const SizedBox(height: 4),
                    Row(children: [
                      StarRating(rating: product.ratingAverage!, size: 11),
                      const SizedBox(width: 3),
                      Text('(${product.ratingCount})',
                          style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, color: AppColors.textMuted)),
                    ]),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F4F8),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 48, color: Color(0xFFCBD5E0)),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
    );
  }
}
