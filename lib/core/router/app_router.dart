// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/products/screens/home_screen.dart';
import '../../features/products/screens/shop_list_screen.dart';
import '../../features/products/screens/product_detail_screen.dart';
import '../../features/products/screens/review_form_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/checkout/screens/checkout_screen.dart';
import '../../features/checkout/screens/moncash_webview_screen.dart';
import '../../features/checkout/screens/offline_confirm_screen.dart';
import '../../features/orders/screens/order_list_screen.dart';
import '../../features/orders/screens/order_detail_screen.dart';
import '../../features/orders/screens/order_tracking_screen.dart';
import '../../features/wishlist/screens/wishlist_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/change_password_screen.dart';
import '../../features/addresses/screens/address_list_screen.dart';
import '../../features/addresses/screens/address_form_screen.dart';
import '../../features/misc/screens/faq_screen.dart';
import '../../features/misc/screens/contact_screen.dart';
import '../../features/misc/screens/about_screen.dart';
import '../../features/admin/screens/admin_shell_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/admin/screens/admin_product_list_screen.dart';
import '../../features/admin/screens/admin_product_form_screen.dart';
import '../../features/products/models/product.dart';
import '../../features/admin/screens/admin_order_list_screen.dart';
import '../../features/admin/screens/admin_order_detail_screen.dart';
import '../../features/admin/screens/admin_customer_list_screen.dart';
import '../../features/admin/screens/admin_customer_detail_screen.dart';
import '../../features/admin/screens/admin_inventory_screen.dart';
import '../../features/admin/screens/admin_reports_screen.dart';
import '../../features/admin/screens/admin_category_list_screen.dart';

import '../../features/community/screens/community_screen.dart';
import '../../features/community/screens/support_screen.dart';
import '../notifications/fcm_service.dart';
import '../shell/main_shell.dart';

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

final _protectedRoutes = [
  '/checkout',
  '/orders',
];

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  return GoRouter(
    navigatorKey: FcmService.navigatorKey,
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.isLoggedIn;
      final path = state.matchedLocation;

      final needsAuth = _protectedRoutes.any((r) => path.startsWith(r));
      if (needsAuth && !isLoggedIn) {
        return '/auth/login';
      }

      if (path.startsWith('/admin')) {
        final profile = authState.profile;
        if (!isLoggedIn) return '/auth/login';
        if (profile != null && !profile.isStaff) return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),

      GoRoute(path: '/auth/login',    builder: (_, state) => LoginScreen(redirect: state.uri.queryParameters['redirect'])),
      GoRoute(path: '/auth/register', builder: (_, __) => const RegisterScreen()),

      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/shop', builder: (_, state) {
            final q        = state.uri.queryParameters['q'];
            final category = state.uri.queryParameters['category'];
            return ShopListScreen(initialQuery: q, initialCategory: category);
          }),
          GoRoute(
            path: '/products/:slug',
            builder: (_, state) => ProductDetailScreen(slug: state.pathParameters['slug']!),
          ),
          GoRoute(
            path: '/products/:slug/reviews',
            builder: (_, state) => ReviewFormScreen(productSlug: state.pathParameters['slug']!),
          ),
          GoRoute(path: '/cart',     builder: (_, __) => const CartScreen()),
          GoRoute(path: '/wishlist',   builder: (_, __) => const WishlistScreen()),
          GoRoute(path: '/community', builder: (_, __) => const CommunityScreen()),
          GoRoute(path: '/profile',   builder: (_, __) => const ProfileScreen()),
        ],
      ),

      GoRoute(path: '/checkout',              builder: (_, __) => const CheckoutScreen()),
      GoRoute(
        path: '/checkout/moncash',
        builder: (_, state) {
          final url     = state.uri.queryParameters['url']!;
          final orderId = int.parse(state.uri.queryParameters['orderId']!);
          return MonCashWebViewScreen(redirectUrl: url, orderId: orderId);
        },
      ),
      GoRoute(
        path: '/checkout/offline-confirm',
        builder: (_, state) {
          final orderId = int.parse(state.uri.queryParameters['orderId']!);
          return OfflineConfirmScreen(orderId: orderId);
        },
      ),

      GoRoute(path: '/orders',     builder: (_, __) => const OrderListScreen()),
      GoRoute(
        path: '/orders/:id',
        builder: (_, state) => OrderDetailScreen(orderId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(path: '/track', builder: (_, state) {
        final id    = state.uri.queryParameters['id'];
        final email = state.uri.queryParameters['email'];
        return OrderTrackingScreen(initialId: id, initialEmail: email);
      }),

      GoRoute(path: '/profile/edit',     builder: (_, __) => const EditProfileScreen()),
      GoRoute(path: '/profile/password', builder: (_, __) => const ChangePasswordScreen()),
      GoRoute(path: '/profile/addresses', builder: (_, __) => const AddressListScreen()),
      GoRoute(path: '/profile/addresses/new', builder: (_, __) => const AddressFormScreen()),
      GoRoute(
        path: '/profile/addresses/:id/edit',
        builder: (_, state) => AddressFormScreen(addressId: int.parse(state.pathParameters['id']!)),
      ),

      GoRoute(path: '/faq',     builder: (_, __) => const FaqScreen()),
      GoRoute(path: '/contact', builder: (_, __) => const ContactScreen()),
      GoRoute(path: '/about',   builder: (_, __) => const AboutScreen()),

      GoRoute(
        path: '/chat',
        redirect: (_, __) => '/community/support',
      ),
      GoRoute(path: '/community/support', builder: (_, __) => const SupportScreen()),

      // Admin routes
      ShellRoute(
        builder: (context, state, child) => AdminShellScreen(child: child),
        routes: [
          GoRoute(path: '/admin',           redirect: (_, __) => '/admin/dashboard'),
          GoRoute(path: '/admin/dashboard', builder: (_, __) => const AdminDashboardScreen()),
          GoRoute(path: '/admin/products',  builder: (_, __) => const AdminProductListScreen()),
          GoRoute(path: '/admin/products/new', builder: (_, __) => const AdminProductFormScreen()),
          GoRoute(
            path: '/admin/products/:id/edit',
            builder: (_, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return AdminProductFormScreen(
                productId: int.parse(state.pathParameters['id']!),
                initialProduct: extra?['product'] as Product?,
                initialCategoryIds: (extra?['categoryIds'] as List<int>?) ?? const [],
              );
            },
          ),
          GoRoute(path: '/admin/orders',    builder: (_, __) => const AdminOrderListScreen()),
          GoRoute(
            path: '/admin/orders/:id',
            builder: (_, state) => AdminOrderDetailScreen(orderId: int.parse(state.pathParameters['id']!)),
          ),
          GoRoute(path: '/admin/customers', builder: (_, __) => const AdminCustomerListScreen()),
          GoRoute(
            path: '/admin/customers/:id',
            builder: (_, state) => AdminCustomerDetailScreen(customerId: int.parse(state.pathParameters['id']!)),
          ),
          GoRoute(path: '/admin/categories', builder: (_, __) => const AdminCategoryListScreen()),
          GoRoute(path: '/admin/inventory', builder: (_, __) => const AdminInventoryScreen()),
          GoRoute(path: '/admin/reports',   builder: (_, __) => const AdminReportsScreen()),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page introuvable: ${state.error}')),
    ),
  );
});
