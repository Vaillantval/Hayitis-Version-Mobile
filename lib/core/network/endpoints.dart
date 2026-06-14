// lib/core/network/endpoints.dart

class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://hayitis.com/api';

  // Auth
  static const String register       = '/auth/register/';
  static const String login          = '/auth/login/';
  static const String logout         = '/auth/logout/';
  static const String tokenRefresh   = '/auth/token/refresh/';
  static const String me             = '/auth/me/';
  static const String changePassword = '/auth/change-password/';
  static const String fcmToken       = '/auth/fcm-token/';

  // Products
  static const String products       = '/products/';
  static const String productsSearch = '/products/search/';
  static const String featured       = '/products/featured/';
  static const String newArrivals    = '/products/new-arrivals/';
  static const String onSale         = '/products/on-sale/';
  static String productDetail(String slug) => '/products/$slug/';

  // Categories
  static const String categories     = '/categories/';
  static String categoryDetail(String slug) => '/categories/$slug/';

  // Cart
  static const String cart           = '/cart/';
  static const String cartAdd        = '/cart/add/';
  static String cartUpdate(int itemId) => '/cart/update/$itemId/';
  static String cartRemove(int itemId) => '/cart/remove/$itemId/';
  static const String cartClear      = '/cart/clear/';

  // Orders
  static const String orders         = '/orders/';
  static String orderDetail(int id) => '/orders/$id/';
  static String orderCancel(int id)       => '/orders/$id/cancel/';
  static String orderPaymentProof(int id) => '/orders/$id/payment-proof/';
  static String orderTrack(int id)  => '/orders/$id/track/';

  // Payments
  static const String paymentInitiate = '/payments/initiate/';
  static const String paymentVerify   = '/payments/verify/';
  static const String paymentOffline  = '/payments/offline/';

  // Reviews
  static const String reviews        = '/reviews/';
  static String reviewDetail(int id) => '/reviews/$id/';

  // Wishlist
  static const String wishlist       = '/wishlist/';
  static const String wishlistAdd    = '/wishlist/add/';
  static String wishlistRemove(int id) => '/wishlist/remove/$id/';

  // Addresses
  static const String addresses      = '/addresses/';
  static String addressDetail(int id)  => '/addresses/$id/';
  static String addressDefault(int id) => '/addresses/$id/default/';

  // Admin
  static const String adminDashboard  = '/admin/dashboard/';
  static const String adminProducts   = '/admin/products/';
  static String adminProductDetail(int id) => '/admin/products/$id/';
  static String adminProductImages(int id) => '/admin/products/$id/images/';
  static const String adminOrders     = '/admin/orders/';
  static String adminOrderDetail(int id)  => '/admin/orders/$id/';
  static String adminOrderStatus(int id)  => '/admin/orders/$id/status/';
  static const String adminCustomers  = '/admin/customers/';
  static String adminCustomerDetail(int id) => '/admin/customers/$id/';
  static const String adminCategories = '/admin/categories/';
  static String adminCategoryDetail(int id) => '/admin/categories/$id/';
  static const String adminInventory  = '/admin/inventory/';
  static String adminInventoryDetail(int id) => '/admin/inventory/$id/';
  static const String adminReportsSales     = '/admin/reports/sales/';
  static const String adminReportsProducts  = '/admin/reports/products/';
  static const String adminReportsCustomers = '/admin/reports/customers/';

  // Sliders (hero carousel)
  static const String sliders = '/sliders/';

  // Community
  static const String communityChannels              = '/community/channels/';
  static String communityMessages(String slug)       => '/community/channels/$slug/messages/';
  static String communitySubscribe(String slug)      => '/community/channels/$slug/subscribe/';
  static String communityLock(String slug)           => '/community/channels/$slug/lock/';
  static String communityMessageAction(int pk)       => '/community/messages/$pk/';
  static String communityReact(int pk)               => '/community/messages/$pk/react/';
  static String communityBan(int pk)                 => '/community/messages/$pk/ban-author/';
  static String communityMute(int pk)                => '/community/messages/$pk/mute-author/';
  static const String communityNotifications         = '/community/notifications/';
  static const String communityUsersSearch           = '/community/users/search/';
  static const String communitySupport                   = '/community/support/messages/';
  static const String communitySupportInbox              = '/community/support/inbox/';
  static String communitySupportConversationFeed(int id) => '/community/support/inbox/$id/messages/';
  static String communitySupportConversationPost(int id) => '/community/support/inbox/$id/messages/';

  // Routes publiques (pas d'injection du token)
  static const List<String> publicRoutes = [
    '/auth/login/',
    '/auth/register/',
    '/auth/token/refresh/',
  ];

  static bool isPublicRoute(String path) {
    // Admin routes always require authentication
    if (path.contains('/admin/')) return false;
    return publicRoutes.any((r) => path.contains(r)) ||
        path.contains('/products/') ||
        path.contains('/categories/') ||
        (path.contains('/orders/') && path.contains('/track/'));
  }
}
