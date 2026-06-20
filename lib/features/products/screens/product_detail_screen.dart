// lib/features/products/screens/product_detail_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../models/product_detail.dart';
import '../models/product_price.dart';
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
  ProductPrice? _selectedVariant;

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

  void _initVariant(ProductDetail product) {
    if (_selectedVariant == null && product.prices.isNotEmpty) {
      _selectedVariant = product.prices.first;
    }
  }

  double _displayPrice(ProductDetail product) =>
      _selectedVariant?.price ?? product.price;

  double? _displayOldPrice(ProductDetail product) {
    if (_selectedVariant != null) {
      final r = _selectedVariant!.regularPrice;
      return (r != null && r > _selectedVariant!.price) ? r : null;
    }
    return product.compareAtPrice > product.price ? product.compareAtPrice : null;
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productDetailProvider(widget.slug));

    return productAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: ErrorState(message: e.toString())),
      data: (product) {
        _initVariant(product);
        final reviewsAsync  = ref.watch(reviewsProvider(product.id));
        final relatedAsync  = ref.watch(relatedProductsProvider(widget.slug));
        final isInWishlist  = ref.watch(isInWishlistProvider(product.id));
        final tabCount = 1 + (product.moreDescription != null ? 1 : 0) + (product.additionalInfo != null ? 1 : 0);
        if (_tabCtrl.length != tabCount) {
          _tabCtrl.dispose();
          _tabCtrl = TabController(length: tabCount, vsync: this);
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              // ── Gallery header ──────────────────────────────────────────
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
                          bottom: 12, left: 0, right: 0,
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand + badges
                      if (product.brand != null)
                        Text(product.brand!,
                            style: const TextStyle(color: AppColors.textMuted, fontFamily: 'Poppins', fontSize: 12)),
                      const SizedBox(height: 4),
                      // Product badges
                      Wrap(spacing: 6, children: [
                        if (product.isNewArrival)    _Badge('Nouveau',       AppColors.success),
                        if (product.isBestSeller)    _Badge('Best Seller',   const Color(0xFFF57F17)),
                        if (product.isSpecialOffer)  _Badge('Offre spéciale', AppColors.error),
                        if (product.isFeatured)      _Badge('Vedette',       Colors.blue),
                      ]),
                      if (product.isNewArrival || product.isBestSeller || product.isSpecialOffer || product.isFeatured)
                        const SizedBox(height: 8),

                      // Title
                      Text(product.name, style: const TextStyle(
                          fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 10),

                      // ── Price variants (pills) or simple price ──────────
                      if (product.prices.isNotEmpty) ...[
                        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                          Text(
                            _formatPrice(_displayPrice(product), product.currency),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 24,
                                fontWeight: FontWeight.w800, color: AppColors.primary),
                          ),
                          if (_displayOldPrice(product) != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              _formatPrice(_displayOldPrice(product)!, product.currency),
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 15,
                                  color: AppColors.textMuted,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ]),
                        const SizedBox(height: 12),
                        Text('Format / Taille',
                            style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.dark)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: product.prices.map((p) {
                            final active = _selectedVariant?.id == p.id;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedVariant = p),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: active ? AppColors.primary.withValues(alpha: 0.08) : Colors.white,
                                  border: Border.all(
                                    color: active ? AppColors.primary : const Color(0xFFFFCDD2),
                                    width: active ? 2 : 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: active ? [BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.15),
                                    blurRadius: 8, offset: const Offset(0, 3),
                                  )] : null,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (p.label.isNotEmpty)
                                      Text(p.label, style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w700,
                                          color: active ? AppColors.primary : AppColors.dark)),
                                    Text(_formatPrice(p.price, product.currency),
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w800,
                                            color: AppColors.primary)),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ] else
                        PriceText(
                          price: product.price,
                          compareAtPrice: product.compareAtPrice > product.price ? product.compareAtPrice : null,
                          currency: product.currency,
                          fontSize: 20,
                        ),

                      const SizedBox(height: 12),

                      // Stock + rating
                      Row(children: [
                        if (product.ratingAverage != null) ...[
                          StarRating(rating: product.ratingAverage!),
                          const SizedBox(width: 4),
                          Text('(${product.ratingCount})',
                              style: const TextStyle(color: AppColors.textMuted, fontFamily: 'Poppins')),
                          const SizedBox(width: 12),
                        ],
                        if (!product.inStock)
                          const _StatusChip('Épuisé', AppColors.error)
                        else if (product.stockQuantity < 5)
                          _StatusChip('Stock faible (${product.stockQuantity})', AppColors.warning)
                        else
                          const _StatusChip('En stock', AppColors.success),
                      ]),

                      const SizedBox(height: 16),

                      // ── Tabs (description / détails / infos) ───────────
                      TabBar(
                        controller: _tabCtrl,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.textMuted,
                        indicatorColor: AppColors.primary,
                        labelStyle: const TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13),
                        tabs: [
                          const Tab(text: 'Description'),
                          if (product.moreDescription != null) const Tab(text: 'Détails'),
                          if (product.additionalInfo != null)  const Tab(text: 'Ingrédients'),
                        ],
                      ),
                      _AnimatedTabView(
                        controller: _tabCtrl,
                        children: [
                          _TabContent(product.description),
                          if (product.moreDescription != null) _TabContent(product.moreDescription!),
                          if (product.additionalInfo != null)  _TabContent(product.additionalInfo!),
                        ],
                      ),

                      const Divider(height: 32),

                      // ── Reviews ─────────────────────────────────────────
                      const Text('Avis clients',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      reviewsAsync.when(
                        loading: () => const LoadingShimmer(height: 80),
                        error: (_, __) => const SizedBox(),
                        data: (reviews) => reviews.isEmpty
                            ? const Text('Aucun avis pour ce produit',
                                style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted))
                            : Column(children: reviews.take(3).map((r) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(children: [
                                Text(r.authorName,
                                    style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                const SizedBox(width: 8),
                                StarRating(rating: r.rating.toDouble(), size: 14),
                              ]),
                              subtitle: Text(r.comment,
                                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                            )).toList()),
                      ),

                      // ── Produits similaires ──────────────────────────────
                      relatedAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (related) {
                          if (related.isEmpty) return const SizedBox.shrink();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(height: 32),
                              const Text('Produits similaires',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 220,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemCount: related.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemBuilder: (_, i) => _RelatedCard(product: related[i]),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom action bar ──────────────────────────────────────────
          bottomSheet: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [
                      IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null),
                      Text('$_quantity',
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16)),
                      IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: product.inStock ? () => setState(() => _quantity++) : null),
                    ]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: product.inStock
                          ? () async {
                              final isLoggedIn = ref.read(authProvider).isLoggedIn;
                              try {
                                if (isLoggedIn) {
                                  await ref.read(cartProvider.notifier).addItem(
                                      product.id, _quantity, priceId: _selectedVariant?.id);
                                } else {
                                  final imageUrl = product.images.isNotEmpty
                                      ? product.images.first.image : null;
                                  await ref.read(guestCartProvider.notifier).add(LocalCartItem(
                                    productId: product.id,
                                    name: product.name,
                                    price: _displayPrice(product),
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
                      child: const Text('Panier',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                    ),
                  ),
                ]),
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
                              await ref.read(cartProvider.notifier).addItem(
                                  product.id, _quantity, priceId: _selectedVariant?.id);
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

String _formatPrice(double amount, String currency) {
  if (currency == 'HTG') {
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');
    return '$formatted G';
  }
  return '$currency ${amount.toStringAsFixed(2)}';
}

// ── Helper widgets ────────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text,
          style: TextStyle(fontFamily: 'Poppins', fontSize: 11,
              fontWeight: FontWeight.w700, color: color)),
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
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: TextStyle(color: color, fontFamily: 'Poppins', fontSize: 12,
              fontWeight: FontWeight.w600)),
    );
  }
}

class _TabContent extends StatelessWidget {
  final String text;
  const _TabContent(this.text);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 13,
              color: AppColors.textMuted, height: 1.7)),
    );
  }
}

class _AnimatedTabView extends StatelessWidget {
  final TabController controller;
  final List<Widget> children;
  const _AnimatedTabView({required this.controller, required this.children});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80, maxHeight: 200),
      child: TabBarView(controller: controller, children: children),
    );
  }
}

class _RelatedCard extends StatelessWidget {
  final Product product;
  const _RelatedCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/products/${product.slug}'),
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: product.images.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.images.first.image,
                      width: 140, height: 140, fit: BoxFit.cover,
                      placeholder: (_, __) => const LoadingShimmer(height: 140),
                    )
                  : Container(width: 140, height: 140, color: const Color(0xFFE2E8F0),
                      child: const Icon(Icons.image, color: AppColors.textMuted)),
            ),
            const SizedBox(height: 6),
            Text(product.name,
                maxLines: 2, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            PriceText(price: product.price, currency: product.currency, fontSize: 12),
          ],
        ),
      ),
    );
  }
}
