// lib/features/admin/screens/admin_shell_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class AdminShellScreen extends StatefulWidget {
  final Widget child;
  const AdminShellScreen({super.key, required this.child});

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<AdminShellScreen> createState() => _AdminShellScreenState();
}

class _AdminShellScreenState extends State<AdminShellScreen> {
  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/admin/dashboard'))  return 0;
    if (location.startsWith('/admin/products'))   return 1;
    if (location.startsWith('/admin/orders'))     return 2;
    if (location.startsWith('/admin/customers'))  return 3;
    if (location.startsWith('/admin/categories')) return 4;
    if (location.startsWith('/admin/inventory'))  return 5;
    if (location.startsWith('/admin/reports'))    return 6;
    if (location == '/community/support')         return 7;
    if (location.startsWith('/community'))        return 8;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _selectedIndex(context);

    return Scaffold(
      key: AdminShellScreen.scaffoldKey,
      body: widget.child,
      drawer: NavigationDrawer(
        selectedIndex: index,
        onDestinationSelected: (i) {
          Navigator.pop(context);
          switch (i) {
            case 0: context.go('/admin/dashboard');   break;
            case 1: context.go('/admin/products');    break;
            case 2: context.go('/admin/orders');      break;
            case 3: context.go('/admin/customers');   break;
            case 4: context.go('/admin/categories');  break;
            case 5: context.go('/admin/inventory');   break;
            case 6: context.go('/admin/reports');     break;
            case 7: context.go('/community/support'); break;
            case 8: context.go('/community');         break;
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 4),
            child: Row(children: [
              const Icon(Icons.admin_panel_settings, color: AppColors.primary, size: 22),
              const SizedBox(width: 8),
              const Text('Back Office', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w700)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                context.go('/profile');
              },
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Retour à l\'app', style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textMuted,
                side: const BorderSide(color: AppColors.textMuted),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          const Divider(height: 1),
          const NavigationDrawerDestination(icon: Icon(Icons.dashboard_outlined),    selectedIcon: Icon(Icons.dashboard),    label: Text('Dashboard')),
          const NavigationDrawerDestination(icon: Icon(Icons.inventory_2_outlined),  selectedIcon: Icon(Icons.inventory_2),  label: Text('Produits')),
          const NavigationDrawerDestination(icon: Icon(Icons.receipt_outlined),      selectedIcon: Icon(Icons.receipt),      label: Text('Commandes')),
          const NavigationDrawerDestination(icon: Icon(Icons.people_outline),        selectedIcon: Icon(Icons.people),       label: Text('Clients')),
          const NavigationDrawerDestination(icon: Icon(Icons.category_outlined),     selectedIcon: Icon(Icons.category),     label: Text('Catégories')),
          const NavigationDrawerDestination(icon: Icon(Icons.warehouse_outlined),    selectedIcon: Icon(Icons.warehouse),    label: Text('Inventaire')),
          const NavigationDrawerDestination(icon: Icon(Icons.bar_chart_outlined),    selectedIcon: Icon(Icons.bar_chart),    label: Text('Rapports')),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 8, 16, 4),
            child: Text('Communauté', style: TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
          ),
          const NavigationDrawerDestination(icon: Icon(Icons.inbox_outlined),        selectedIcon: Icon(Icons.inbox),        label: Text('Boîte de support')),
          const NavigationDrawerDestination(icon: Icon(Icons.groups_outlined),       selectedIcon: Icon(Icons.groups),       label: Text('Communauté')),
        ],
      ),
    );
  }
}
