import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../../../features/cart/providers/cart_provider.dart';
import '../../../shared/widgets/product_card.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import '../../../shared/widgets/error_state.dart';
import '../models/slider.dart';
import '../providers/product_provider.dart';

// ── Home screen ───────────────────────────────────────────────────────────────

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured   = ref.watch(featuredProductsProvider);
    final categories = ref.watch(categoriesProvider);
    final slides     = ref.watch(slidersProvider);
    final auth       = ref.watch(authProvider);
    final cartCount  = ref.watch(cartCountProvider);
    final firstName  = auth.profile?.firstName ?? auth.profile?.username ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(slidersProvider);
          ref.invalidate(featuredProductsProvider);
          ref.invalidate(categoriesProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [

            // ── Sticky header ──────────────────────────────────────────────
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                firstName: firstName,
                cartCount: cartCount,
                topPadding: MediaQuery.of(context).padding.top,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ── Hero slider ─────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: slides.when(
                loading: () => _HeroShimmer(),
                error:   (_, __) => _StaticHeroBanner(),
                data:    (list) => list.isEmpty
                    ? _StaticHeroBanner()
                    : _ApiHeroBanner(slides: list),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // ── Catégories ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Catégories',
                onSeeAll: () => context.push('/shop'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: categories.when(
                  loading: () => _ChipsShimmer(),
                  error:   (_, __) => const SizedBox.shrink(),
                  data: (cats) => ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cats.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final cat = cats[i];
                      final imgUrl = cat.image == null ? null
                          : cat.image!.startsWith('http') ? cat.image
                          : 'https://hayitis.com${cat.image}';
                      return _CategoryChip(
                        name: cat.name,
                        slug: cat.slug,
                        imageUrl: imgUrl,
                        count: cat.productCount,
                      );
                    },
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // ── Promo strip ─────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _PromoStrip(onTap: () => context.push('/shop?on_sale=true')),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ── Produits vedettes ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Produits vedettes',
                onSeeAll: () => context.push('/shop'),
              ),
            ),
            featured.when(
              loading: () => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate(
                    const [ProductCardShimmer(), ProductCardShimmer(), ProductCardShimmer(), ProductCardShimmer()],
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.68),
                ),
              ),
              error: (_, __) => const SliverToBoxAdapter(
                child: ErrorState(message: 'Impossible de charger les produits'),
              ),
              data: (products) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => ProductCard(product: products[i]),
                    childCount: products.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.68),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 36)),

            // ── Section Communauté ──────────────────────────────────────────
            SliverToBoxAdapter(child: _CommunitySectionHeader(
              onJoin: () => context.go('/community'),
            )),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverToBoxAdapter(child: _CommunityInviteCard(
              onTap: () => context.go('/community'),
            )),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ── Témoignages ─────────────────────────────────────────────────
            SliverToBoxAdapter(child: _SectionHeader(
              title: 'Ce qu\'ils en disent',
              onSeeAll: () => context.go('/community'),
            )),
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
            const SliverToBoxAdapter(child: _TestimonialCarousel()),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

// ── Sticky header ─────────────────────────────────────────────────────────────

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String firstName;
  final int cartCount;
  final double topPadding;
  const _StickyHeaderDelegate({
    required this.firstName,
    required this.cartCount,
    required this.topPadding,
  });

  @override double get minExtent => topPadding + 56;
  @override double get maxExtent => topPadding + (firstName.isEmpty ? 86 : 106);

  @override
  bool shouldRebuild(_StickyHeaderDelegate old) =>
      old.firstName != firstName || old.cartCount != cartCount || old.topPadding != topPadding;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final range = (maxExtent - minExtent).clamp(1.0, double.infinity);
    final t = (shrinkOffset / range).clamp(0.0, 1.0);
    final collapsed = shrinkOffset >= range * 0.85;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.dark,
        boxShadow: overlapsContent
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 8, offset: const Offset(0, 2))]
            : null,
      ),
      padding: EdgeInsets.fromLTRB(20, topPadding + 10, 16, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Top row always visible
        Row(children: [
          Text("Hayiti's",
            style: GoogleFonts.playfairDisplay(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
          const Spacer(),
          _TopBtn(icon: Icons.search_rounded, onTap: () => context.push('/shop')),
          const SizedBox(width: 8),
          _TopBtn(icon: Icons.notifications_none_rounded, onTap: () => context.go('/community')),
          const SizedBox(width: 8),
          _CartBtn(count: cartCount, onTap: () => context.push('/cart')),
        ]),

        // Greeting — fades out when collapsed
        if (!collapsed && firstName.isNotEmpty) ...[
          const SizedBox(height: 10),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: (1 - t * 2).clamp(0.0, 1.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Bonjour, $firstName 👋',
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              Text("Qu'est-ce qui vous fait envie ?",
                style: GoogleFonts.nunito(color: Colors.white54, fontSize: 12)),
            ]),
          ),
        ] else if (!collapsed && firstName.isEmpty) ...[
          const SizedBox(height: 8),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: (1 - t * 2).clamp(0.0, 1.0),
            child: Text("Bienvenue chez Hayiti's 🌴",
              style: GoogleFonts.nunito(color: Colors.white60, fontSize: 12)),
          ),
        ],

        // Inline search bar when fully collapsed
        if (collapsed) ...[
          const SizedBox(height: 6),
          _InlineSearch(onTap: () => context.push('/shop')),
        ],
      ]),
    );
  }
}

class _TopBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _TopBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    ),
  );
}

class _CartBtn extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _CartBtn({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Stack(clipBehavior: Clip.none, children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18),
      ),
      if (count > 0)
        Positioned(
          top: -4, right: -4,
          child: Container(
            width: 16, height: 16,
            decoration: const BoxDecoration(
              color: AppColors.primary, shape: BoxShape.circle),
            child: Center(
              child: Text(count > 9 ? '9+' : '$count',
                style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
            ),
          ),
        ),
    ]),
  );
}

class _InlineSearch extends StatelessWidget {
  final VoidCallback onTap;
  const _InlineSearch({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(17),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        const Icon(Icons.search_rounded, color: Colors.white54, size: 16),
        const SizedBox(width: 8),
        Text('Rechercher...', style: GoogleFonts.nunito(color: Colors.white38, fontSize: 13)),
      ]),
    ),
  );
}

// ── API Hero Banner (real slides) ─────────────────────────────────────────────

class _ApiHeroBanner extends StatefulWidget {
  final List<HeroSlide> slides;
  const _ApiHeroBanner({required this.slides});

  @override
  State<_ApiHeroBanner> createState() => _ApiHeroBannerState();
}

class _ApiHeroBannerState extends State<_ApiHeroBanner> {
  final _ctrl = PageController(viewportFraction: 0.92);
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.slides.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted) return;
        _ctrl.animateToPage(
          (_current + 1) % widget.slides.length,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  String _resolveRoute(String link) {
    // Convert Django-style /shop/ → /shop
    final path = link.replaceAll(RegExp(r'/$'), '');
    if (path.isEmpty) return '/home';
    if (path.startsWith('/')) return path;
    return '/$path';
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 195,
        child: PageView.builder(
          controller: _ctrl,
          onPageChanged: (i) => setState(() => _current = i),
          itemCount: widget.slides.length,
          itemBuilder: (_, i) {
            final slide = widget.slides[i];
            return GestureDetector(
              onTap: () {
                try { context.push(_resolveRoute(slide.buttonLink)); } catch (_) {}
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.dark,
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(fit: StackFit.expand, children: [
                  // Image background
                  CachedNetworkImage(
                    imageUrl: slide.image,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.dark),
                    errorWidget: (_, __, ___) => _SlideColorFallback(index: i),
                  ),

                  // Dark gradient overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.35),
                          Colors.black.withValues(alpha: 0.75),
                        ],
                        stops: const [0.3, 0.6, 1.0],
                      ),
                    ),
                  ),

                  // Text content
                  Positioned(
                    left: 20, right: 20, bottom: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(slide.title,
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white, fontSize: 22,
                            fontWeight: FontWeight.w700, height: 1.2,
                            shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                          )),
                        if (slide.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(slide.description,
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(color: Colors.white70, fontSize: 12)),
                        ],
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(slide.buttonText,
                            style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),

                  // Slide count badge top-right
                  if (widget.slides.length > 1)
                    Positioned(
                      top: 12, right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('${i + 1}/${widget.slides.length}',
                          style: GoogleFonts.nunito(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
                    ),
                ]),
              ),
            );
          },
        ),
      ),

      // Dot indicators
      if (widget.slides.length > 1) ...[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.slides.length, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: _current == i ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: _current == i ? AppColors.primary : const Color(0xFFD1C4C4),
              borderRadius: BorderRadius.circular(3),
            ),
          )),
        ),
      ],
    ]);
  }
}

// Fallback colored slide when no image
class _SlideColorFallback extends StatelessWidget {
  final int index;
  const _SlideColorFallback({required this.index});

  static const _colors = [
    Color(0xFFC62828), Color(0xFF1C1410), Color(0xFF4A1942),
    Color(0xFF1A237E), Color(0xFF004D40),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = _colors[index % _colors.length];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [bg, Color.lerp(bg, Colors.black, 0.3)!],
        ),
      ),
    );
  }
}

// ── Static fallback banner (no API slides) ───────────────────────────────────

class _StaticHeroBanner extends StatefulWidget {
  @override
  State<_StaticHeroBanner> createState() => _StaticHeroBannerState();
}

class _StaticHeroBannerState extends State<_StaticHeroBanner> {
  final _ctrl = PageController(viewportFraction: 0.92);
  int _current = 0;
  Timer? _timer;

  static const _banners = [
    _BannerData(bg: Color(0xFFC62828), tag: 'OFFRES SPÉCIALES',
      title: 'Jusqu\'à\n-30% off',  sub: 'Sur une sélection de produits',
      cta: 'Découvrir', route: '/shop?on_sale=true', emoji: '🏷️'),
    _BannerData(bg: Color(0xFF1C1410), tag: 'NOUVEAUTÉS',
      title: 'Fraîcheur\nhaïtienne', sub: 'Les dernières arrivées du marché',
      cta: 'Voir tout', route: '/shop?ordering=-created_at', emoji: '✨'),
    _BannerData(bg: Color(0xFF4A1942), tag: 'BEST-SELLERS',
      title: 'Nos\nfavoris', sub: 'Les produits les plus appréciés',
      cta: 'Explorer', route: '/shop', emoji: '⭐'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      _ctrl.animateToPage((_current + 1) % _banners.length,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
    });
  }

  @override
  void dispose() { _timer?.cancel(); _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 195,
        child: PageView.builder(
          controller: _ctrl,
          onPageChanged: (i) => setState(() => _current = i),
          itemCount: _banners.length,
          itemBuilder: (_, i) {
            final b = _banners[i];
            return GestureDetector(
              onTap: () => context.push(b.route),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: b.bg, borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAlias,
                child: Stack(children: [
                  // Background circles
                  Positioned(right: -40, top: -40,
                    child: Container(width: 200, height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle))),
                  Positioned(right: 30, bottom: -30,
                    child: Container(width: 120, height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05), shape: BoxShape.circle))),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20)),
                        child: Text(b.tag, style: GoogleFonts.nunito(
                          fontSize: 9, fontWeight: FontWeight.w800,
                          color: Colors.white, letterSpacing: 1.2)),
                      ),
                      const SizedBox(height: 10),
                      Text(b.title, style: GoogleFonts.playfairDisplay(
                        fontSize: 26, fontWeight: FontWeight.w700,
                        color: Colors.white, height: 1.15)),
                      const SizedBox(height: 5),
                      Text(b.sub, style: GoogleFonts.nunito(fontSize: 11, color: Colors.white70)),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Text(b.cta, style: GoogleFonts.nunito(
                          fontSize: 12, fontWeight: FontWeight.w700, color: b.bg)),
                      ),
                    ]),
                  ),
                  Positioned(right: 18, top: 16,
                    child: Text(b.emoji, style: const TextStyle(fontSize: 52))),
                ]),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_banners.length, (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _current == i ? 20 : 6, height: 6,
          decoration: BoxDecoration(
            color: _current == i ? AppColors.primary : const Color(0xFFD1C4C4),
            borderRadius: BorderRadius.circular(3)),
        ))),
    ]);
  }
}

class _BannerData {
  final Color bg;
  final String tag, title, sub, cta, route, emoji;
  const _BannerData({required this.bg, required this.tag, required this.title,
    required this.sub, required this.cta, required this.route, required this.emoji});
}

// ── Category chip ─────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  final String name, slug;
  final String? imageUrl;
  final int count;
  const _CategoryChip({required this.name, required this.slug, this.imageUrl, required this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/shop?category=$slug'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (imageUrl != null) ...[
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!, width: 22, height: 22, fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(Icons.category, size: 14, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(name, style: GoogleFonts.nunito(
            fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark)),
          if (count > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('$count',
                style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
            ),
          ],
        ]),
      ),
    );
  }
}

// ── Promo strip ───────────────────────────────────────────────────────────────

class _PromoStrip extends StatelessWidget {
  final VoidCallback onTap;
  const _PromoStrip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1410), Color(0xFF3E2723)],
            begin: Alignment.centerLeft, end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
            child: Text('SOLDES',
              style: GoogleFonts.nunito(color: Colors.white, fontSize: 10,
                fontWeight: FontWeight.w800, letterSpacing: 1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Jusqu\'à -30% sélectionnés',
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
              Text('Profitez des offres du moment',
                style: GoogleFonts.nunito(color: Colors.white54, fontSize: 11)),
            ]),
          ),
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary, shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
          ),
        ]),
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 12),
      child: Row(
        children: [
          Container(width: 4, height: 20,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 10),
          Text(title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.dark)),
          const Spacer(),
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Voir tout', style: GoogleFonts.nunito(
                fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
              const SizedBox(width: 2),
              const Icon(Icons.arrow_forward_ios_rounded, size: 10),
            ]),
          ),
        ],
      ),
    );
  }
}

// ── Community section ─────────────────────────────────────────────────────────

class _CommunitySectionHeader extends StatelessWidget {
  final VoidCallback onJoin;
  const _CommunitySectionHeader({required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
      child: Row(children: [
        Container(width: 4, height: 20,
          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text('Communauté',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.dark)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
          child: Text('EN DIRECT',
            style: GoogleFonts.nunito(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
        ),
        const Spacer(),
        TextButton(
          onPressed: onJoin,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Rejoindre', style: GoogleFonts.nunito(
              fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_forward_ios_rounded, size: 10),
          ]),
        ),
      ]),
    );
  }
}

class _CommunityInviteCard extends StatelessWidget {
  final VoidCallback onTap;
  const _CommunityInviteCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1410), Color(0xFFC62828)],
            begin: Alignment.centerLeft, end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.18),
            blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Row(children: [
          // Icon cluster
          Stack(children: [
            Container(width: 52, height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12), shape: BoxShape.circle)),
            const Positioned(top: 0, left: 0,
              child: Text('💬', style: TextStyle(fontSize: 24))),
            const Positioned(bottom: 0, right: 0,
              child: Text('🌴', style: TextStyle(fontSize: 18))),
          ]),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rejoignez la communauté',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Partagez, discutez et restez connecté avec la famille Hayiti\'s.',
              style: GoogleFonts.nunito(color: Colors.white70, fontSize: 11, height: 1.4)),
            const SizedBox(height: 10),
            Row(children: [
              _CommunityPill(icon: Icons.people_outline, label: 'Channels'),
              const SizedBox(width: 8),
              _CommunityPill(icon: Icons.support_agent, label: 'Support'),
            ]),
          ])),
          const SizedBox(width: 12),
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
          ),
        ]),
      ),
    );
  }
}

class _CommunityPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CommunityPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.white70, size: 11),
      const SizedBox(width: 4),
      Text(label, style: GoogleFonts.nunito(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
    ]),
  );
}

// ── Testimonial carousel ──────────────────────────────────────────────────────

class _TestimonialCarousel extends StatefulWidget {
  const _TestimonialCarousel();

  @override
  State<_TestimonialCarousel> createState() => _TestimonialCarouselState();
}

class _TestimonialCarouselState extends State<_TestimonialCarousel> {
  final _ctrl = PageController(viewportFraction: 0.88);
  int _current = 0;
  Timer? _timer;

  static const _testimonials = [
    _Testimonial(
      name: 'Marie-Louise F.',
      location: 'Port-au-Prince',
      text: 'Les produits sont authentiques et d\'une qualité remarquable. La livraison a été rapide et le service client très réactif !',
      rating: 5,
      initials: 'ML',
      color: Color(0xFFC62828),
    ),
    _Testimonial(
      name: 'Jean-Baptiste M.',
      location: 'Pétion-Ville',
      text: 'J\'adore Hayiti\'s ! On retrouve vraiment les saveurs haïtiennes. Les épices sont fraîches et les prix sont raisonnables.',
      rating: 5,
      initials: 'JB',
      color: Color(0xFF1C1410),
    ),
    _Testimonial(
      name: 'Claudette R.',
      location: 'Cap-Haïtien',
      text: 'Excellent service et produits de grande qualité. Je recommande à tous ceux qui cherchent des produits haïtiens authentiques.',
      rating: 5,
      initials: 'CR',
      color: Color(0xFF4A1942),
    ),
    _Testimonial(
      name: 'Pierre-Louis D.',
      location: 'Jacmel',
      text: 'La communauté est super active ! J\'adore pouvoir discuter avec d\'autres clients et partager des recettes.',
      rating: 5,
      initials: 'PL',
      color: Color(0xFF1A237E),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted) return;
      _ctrl.animateToPage(
        (_current + 1) % _testimonials.length,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() { _timer?.cancel(); _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 175,
        child: PageView.builder(
          controller: _ctrl,
          onPageChanged: (i) => setState(() => _current = i),
          itemCount: _testimonials.length,
          itemBuilder: (_, i) => _TestimonialCard(t: _testimonials[i]),
        ),
      ),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_testimonials.length, (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _current == i ? 20 : 6, height: 6,
          decoration: BoxDecoration(
            color: _current == i ? AppColors.primary : const Color(0xFFD1C4C4),
            borderRadius: BorderRadius.circular(3)),
        ))),
    ]);
  }
}

class _TestimonialCard extends StatelessWidget {
  final _Testimonial t;
  const _TestimonialCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Stars
        Row(children: List.generate(t.rating, (_) =>
          const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 14))),
        const SizedBox(height: 8),
        // Quote
        Text('"${t.text}"',
          maxLines: 3, overflow: TextOverflow.ellipsis,
          style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textSecond, height: 1.5,
            fontStyle: FontStyle.italic)),
        const Spacer(),
        // Author row
        Row(children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(color: t.color, shape: BoxShape.circle),
            child: Center(child: Text(t.initials,
              style: GoogleFonts.nunito(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800))),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.name, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.dark)),
            Text(t.location, style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
          ]),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10)),
            child: Text('Vérifié', style: GoogleFonts.nunito(
              fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.primary)),
          ),
        ]),
      ]),
    );
  }
}

class _Testimonial {
  final String name, location, text, initials;
  final int rating;
  final Color color;
  const _Testimonial({
    required this.name, required this.location, required this.text,
    required this.initials, required this.rating, required this.color,
  });
}

// ── Shimmer placeholders ──────────────────────────────────────────────────────

class _HeroShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LoadingShimmer(height: 195, borderRadius: 20),
    );
  }
}

class _ChipsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (_, __) => LoadingShimmer(width: 90, height: 44, borderRadius: 22),
    );
  }
}
