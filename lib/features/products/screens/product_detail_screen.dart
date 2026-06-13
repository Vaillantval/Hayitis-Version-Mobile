// lib/features/products/screens/product_detail_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/price_text.dart';
import '../../../shared/widgets/star_rating.dart';
import '../../../shared/widgets/error_state.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import '../../auth/providers/auth_provider.dart';
import '../../cart/models/local_cart_item.dart';
import '../../cart/providers/cart_provider.dart';
import '../../reviews/providers/review_provider.dart';
import '../models/product.dart';
import '../../wishlist/providers/wishlist_provider.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String slug;
  const ProductDetailScreen({super.key, required this.slug});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int _quantity = 1;
  int _imageIndex = 0;
  bool _buyingNow = false;
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productDetailProvider(widget.slug));

    return productAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: ErrorState(message: e.toString())),
      data: (product) {
        final reviewsAsync  = ref.watch(reviewsProvider(product.id));
        final isInWishlist  = ref.watch(isInWishlistProvider(product.id));

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                actions: [
                  IconButton(
                    icon: Icon(isInWishlist ? Icons.favorite : Icons.favorite_outline,
                        color: isInWishlist ? AppColors.error : Colors.white),
                    onPressed: () {
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
                          ref.read(guestWishlistProvider.notifier).add(
                            Product.fromJson(jsonDecode(jsonEncode(product.toJson())) as Map<String, dynamic>),
                          );
                        }
                      }
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      if (product.images.isNotEmpty)
                        PageView.builder(
                          itemCount: product.images.length,
                          onPageChanged: (i) => setState(() => _imageIndex = i),
                          itemBuilder: (_, i) => CachedNetworkImage(
                            imageUrl: product.images[i].image,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const LoadingShimmer(height: double.infinity),
                          ),
                        )
                      else
                        Container(color: const Color(0xFFE2E8F0),
                            child: const Icon(Icons.image, size: 80, color: AppColors.textMuted)),
                      if (product.images.length > 1)
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(product.images.length, (i) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _imageIndex == i ? 20 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _imageIndex == i ? AppColors.primary : Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            )),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.brand != null)
                        Text(product.brand!, style: const TextStyle(color: AppColors.textMuted, fontFamily: 'Poppins')),
                      Text(product.name,
                          style: const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      PriceText(price: product.price, compareAtPrice: product.compareAtPrice > product.price ? product.compareAtPrice : null, currency: product.currency, fontSize: 20),
                      const SizedBox(height: 8),
                      Row(children: [
                        if (product.ratingAverage != null) ...[
                          StarRating(rating: product.ratingAverage!),
                          const SizedBox(width: 4),
                          Text('(${product.ratingCount})', style: const TextStyle(color: AppColors.textMuted, fontFamily: 'Poppins')),
                          const SizedBox(width: 16),
                        ],
                        if (!product.inStock)
                          const _StatusChip('Épuisé', AppColors.error)
                        else if (product.stockQuantity < 5)
                          const _StatusChip('Stock faible', AppColors.warning)
                        else
                          const _StatusChip('En stock', AppColors.success),
                      ]),
                      const SizedBox(height: 16),
                      TabBar(
                        controller: _tabCtrl,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.textMuted,
                        indicatorColor: AppColors.primary,
                        labelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13),
                        tabs: const [Tab(text: 'Description'), Tab(text: 'Détails'), Tab(text: 'Infos')],
                      ),
                      SizedBox(
                        height: 120,
                        child: TabBarView(
                          controller: _tabCtrl,
                          children: [
                            SingleChildScrollView(padding: const EdgeInsets.all(8),
                                child: Text(product.description, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13))),
                            SingleChildScrollView(padding: const EdgeInsets.all(8),
                                child: Text(product.moreDescription ?? '-', style: const TextStyle(fontFamily: 'Poppins', fontSize: 13))),
                            SingleChildScrollView(padding: const EdgeInsets.all(8),
                                child: Text(product.additionalInfo ?? '-', style: const TextStyle(fontFamily: 'Poppins', fontSize: 13))),
                          ],
                        ),
                      ),
                      const Divider(),
                      const Text('Avis clients', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      reviewsAsync.when(
                        loading: () => const LoadingShimmer(height: 80),
                        error: (_, __) => const SizedBox(),
                        data: (reviews) => reviews.isEmpty
                            ? const Text('Aucun avis pour ce produit', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted))
                            : Column(children: reviews.take(3).map((r) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(children: [
                                Text(r.authorName, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                const SizedBox(width: 8),
                                StarRating(rating: r.rating.toDouble(), size: 14),
                              ]),
                              subtitle: Text(r.comment, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                            )).toList()),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(icon: const Icon(Icons.remove), onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null),
                          Text('$_quantity', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16)),
                          IconButton(icon: const Icon(Icons.add), onPressed: product.inStock ? () => setState(() => _quantity++) : null),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: product.inStock
                            ? () async {
                                final isLoggedIn = ref.read(authProvider).isLoggedIn;
                                try {
                                  if (isLoggedIn) {
                                    await ref.read(cartProvider.notifier).addItem(product.id, _quantity);
                                  } else {
                                    final imageUrl = product.images.isNotEmpty ? product.images.first.image : null;
                                    await ref.read(guestCartProvider.notifier).add(LocalCartItem(
                                      productId: product.id,
                                      name: product.name,
                                      price: product.price,
                                      currency: product.currency,
                                      imageUrl: imageUrl,
                                      quantity: _quantity,
                                    ));
                                  }
                                  Fluttertoast.showToast(msg: 'Ajouté au panier !');
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dark,
                          minimumSize: const Size(0, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Panier', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: _buyingNow
                        ? const SizedBox(width: 18, height: 18,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.flash_on, size: 18),
                    label: Text(
                      _buyingNow ? 'Chargement...' : 'Acheter maintenant',
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    ),
                    onPressed: product.inStock && !_buyingNow
                        ? () async {
                            final isLoggedIn = ref.read(authProvider).isLoggedIn;
                            if (!isLoggedIn) {
                              context.push('/auth/login?redirect=/products/${product.slug}');
                              return;
                            }
                            setState(() => _buyingNow = true);
                            try {
                              await ref.read(cartProvider.notifier).addItem(product.id, _quantity);
                              if (context.mounted) context.push('/checkout');
                            } catch (e) {
                              Fluttertoast.showToast(msg: e.toString());
                            } finally {
                              if (mounted) setState(() => _buyingNow = false);
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(0, 52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: color, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
