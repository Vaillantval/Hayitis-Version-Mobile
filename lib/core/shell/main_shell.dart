// lib/core/shell/main_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/cart/providers/cart_provider.dart';
import '../theme/app_colors.dart';

class MainShell extends ConsumerWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home'))      return 0;
    if (location.startsWith('/shop'))      return 1;
    if (location.startsWith('/cart'))      return 2;
    if (location.startsWith('/community')) return 3;
    if (location.startsWith('/profile'))   return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount  = ref.watch(cartCountProvider);
    final index      = _selectedIndex(context);
    final location   = GoRouterState.of(context).matchedLocation;
    final onSupport  = location == '/community/support';

    return Scaffold(
      body: child,

      // ── FAB Contact admin ──────────────────────────────────────────────
      floatingActionButton: onSupport ? null : _SupportFab(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          switch (i) {
            case 0: context.go('/home');      break;
            case 1: context.go('/shop');      break;
            case 2: context.go('/cart');      break;
            case 3: context.go('/community'); break;
            case 4: context.go('/profile');   break;
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Accueil'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Boutique'),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            activeIcon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Panier',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined), activeIcon: Icon(Icons.groups), label: 'Communauté'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// ── Support FAB ───────────────────────────────────────────────────────────────

class _SupportFab extends StatefulWidget {
  @override
  State<_SupportFab> createState() => _SupportFabState();
}

class _SupportFabState extends State<_SupportFab>
    with TickerProviderStateMixin {
  // Entrée + collapse
  late final AnimationController _entryCtrl;
  late final Animation<double> _entryScale;
  // Sonar ping (boucle infinie)
  late final AnimationController _pingCtrl;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _entryScale = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutBack);
    _entryCtrl.forward();

    _pingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _pingCtrl.dispose();
    super.dispose();
  }

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _entryScale,
      child: _expanded
          ? _ExpandedFab(onClose: _toggle)
          : _CollapsedFab(pingCtrl: _pingCtrl, onTap: _toggle),
    );
  }
}

class _CollapsedFab extends StatelessWidget {
  final AnimationController pingCtrl;
  final VoidCallback onTap;
  const _CollapsedFab({required this.pingCtrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80, height: 80,
        child: Stack(alignment: Alignment.center, children: [
          // Anneau 1 — décalé
          AnimatedBuilder(
            animation: pingCtrl,
            builder: (_, __) {
              final t = pingCtrl.value;
              return Transform.scale(
                scale: 1.0 + t * 0.9,
                child: Opacity(
                  opacity: (1 - t).clamp(0.0, 0.5),
                  child: Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  ),
                ),
              );
            },
          ),
          // Anneau 2 — décalé de 0.4 pour chevauchement
          AnimatedBuilder(
            animation: pingCtrl,
            builder: (_, __) {
              final t = ((pingCtrl.value + 0.4) % 1.0);
              return Transform.scale(
                scale: 1.0 + t * 0.9,
                child: Opacity(
                  opacity: (1 - t).clamp(0.0, 0.35),
                  child: Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  ),
                ),
              );
            },
          ),
          // Bouton principal avec légère pulsation
          AnimatedBuilder(
            animation: pingCtrl,
            builder: (_, child) {
              final pulse = 1.0 + (pingCtrl.value < 0.5
                  ? pingCtrl.value * 0.06
                  : (1 - pingCtrl.value) * 0.06);
              return Transform.scale(scale: pulse, child: child);
            },
            child: Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.45),
                    blurRadius: 14, offset: const Offset(0, 5)),
                ],
              ),
              child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 26),
            ),
          ),
        ]),
      ),
    );
  }
}

class _ExpandedFab extends StatelessWidget {
  final VoidCallback onClose;
  const _ExpandedFab({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Option 1 — Support DM
        _FabOption(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'Contacter le support',
          onTap: () { onClose(); context.push('/community/support'); },
        ),
        const SizedBox(height: 10),
        // Option 2 — Canal Communauté
        _FabOption(
          icon: Icons.groups_outlined,
          label: 'Communauté',
          onTap: () { onClose(); context.push('/community'); },
        ),
        const SizedBox(height: 14),
        // Bouton fermer
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppColors.dark,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: const Icon(Icons.close_rounded, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}

class _FabOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _FabOption({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 3))],
            ),
            child: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 10),
          // Icon bubble
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 10, offset: const Offset(0, 3))],
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
