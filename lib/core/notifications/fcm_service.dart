// lib/core/notifications/fcm_service.dart
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/repositories/auth_repository.dart';

// Handler background — OBLIGATOIREMENT top-level (hors de toute classe)
// Le compilateur release le conserve grâce à @pragma
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Pas de navigation ici — pas de BuildContext disponible
}

// ─────────────────────────────────────────────────────────────────────────────

class FcmService {
  FcmService._();

  /// NavigatorKey partagé avec GoRouter.
  /// Permet de naviguer depuis n'importe quel contexte sans BuildContext explicite.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static StreamSubscription<String>? _tokenRefreshSub;

  // ─── Initialisation ────────────────────────────────────────────────────────

  /// À appeler une seule fois depuis main(), après Firebase.initializeApp().
  static Future<void> initialize() async {
    // Supprimer la notification système en foreground — on affiche le banner in-app
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    // FOREGROUND — banner in-app personnalisé
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // BACKGROUND — app en arrière-plan, utilisateur tape la notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _navigateFromData(message.data);
    });

    // TERMINÉE — app fermée, utilisateur tape la notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigateFromData(message.data);
        });
      }
    });
  }

  static void _onForegroundMessage(RemoteMessage message) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;
    _showInAppBanner(overlay, message);
  }

  // ─── Permission Android 13+ ────────────────────────────────────────────────

  static Future<bool> requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  // ─── Token FCM → backend ───────────────────────────────────────────────────

  /// Enregistre le token FCM courant via POST /api/auth/fcm-token/
  static Future<void> registerToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        debugPrint('FCM: token indisponible (émulateur ?)');
        return;
      }
      await AuthRepository().sendFcmToken(token);
    } catch (e) {
      debugPrint('FCM: erreur enregistrement token — $e');
    }
  }

  /// Écoute les rafraîchissements de token (réinstallation, effacement données).
  static void listenTokenRefresh() {
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub =
        FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      AuthRepository().sendFcmToken(newToken);
    });
  }

  /// À appeler au logout pour libérer la souscription.
  static void stopListeningTokenRefresh() {
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
  }

  // ─── Banner in-app (foreground uniquement) ─────────────────────────────────

  static void _showInAppBanner(OverlayState overlay, RemoteMessage message) {
    final title = message.data['title'] as String? ?? message.notification?.title ?? '';
    final body  = message.data['body']  as String? ?? message.notification?.body  ?? '';
    final type = message.data['type'] as String? ?? '';

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _FcmBanner(
        title: title,
        body: body,
        color: _colorForType(type),
        icon: _iconForType(type),
        onTap: () {
          entry.remove();
          _navigateFromData(message.data);
        },
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);

    // Auto-fermeture après 4 secondes
    Future.delayed(const Duration(seconds: 4), () {
      if (entry.mounted) entry.remove();
    });
  }

  // ─── Navigation ────────────────────────────────────────────────────────────

  static void _navigateFromData(Map<String, dynamic> data) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null || !ctx.mounted) return;

    final type = data['type'] as String? ?? '';

    switch (type) {
      case 'new_order':
      case 'order_status':
      case 'payment_verified':
        final id = int.tryParse(data['order_id']?.toString() ?? '');
        if (id != null) ctx.push('/orders/$id');

      case 'new_product':
        final slug = data['slug'] as String? ?? '';
        if (slug.isNotEmpty) ctx.push('/products/$slug');

      case 'new_order_admin':
      case 'proof_submitted':
        final id = int.tryParse(data['order_id']?.toString() ?? '');
        if (id != null) {
          // Le routeur GoRouter redirige vers /home si l'utilisateur n'est pas staff
          ctx.push('/admin/orders/$id');
        }

      default:
        ctx.go('/home');
    }
  }

  // ─── Helpers couleur & icône ───────────────────────────────────────────────

  static Color _colorForType(String type) => switch (type) {
        'new_order'        => const Color(0xFF4CAF50), // vert
        'order_status'     => const Color(0xFF2196F3), // bleu
        'payment_verified' => const Color(0xFF009688), // sarcelle
        'new_product'      => const Color(0xFFFF5722), // orange foncé
        'new_order_admin'  => const Color(0xFF9C27B0), // violet
        'proof_submitted'  => const Color(0xFFFFC107), // ambre
        _                  => const Color(0xFF607D8B), // bleu-gris
      };

  static IconData _iconForType(String type) => switch (type) {
        'new_order'        => Icons.shopping_bag_outlined,
        'order_status'     => Icons.local_shipping_outlined,
        'payment_verified' => Icons.verified_outlined,
        'new_product'      => Icons.new_releases_outlined,
        'new_order_admin'  => Icons.admin_panel_settings_outlined,
        'proof_submitted'  => Icons.receipt_long_outlined,
        _                  => Icons.notifications_outlined,
      };
}

// ─────────────────────────────────────────────────────────────────────────────
// Widget banner in-app
// ─────────────────────────────────────────────────────────────────────────────

class _FcmBanner extends StatelessWidget {
  final String title;
  final String body;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _FcmBanner({
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 8,
      left: 12,
      right: 12,
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border(left: BorderSide(color: color, width: 4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(icon, color: color, size: 26),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      if (body.isNotEmpty)
                        Text(
                          body,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 14, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
