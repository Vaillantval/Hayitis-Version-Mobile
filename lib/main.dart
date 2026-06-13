// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/notifications/fcm_service.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

// Clé publique Stripe — remplacer par votre vraie clé
const _stripePublishableKey = 'pk_test_51RpxSNPpdmD78VzAKB9TOWaUFjK3XaYNdXKII13sU6OhRpoMKHiw4Eai9uwEnEf79S7gjEukppEUCGoK2Shxl4Zt000aPs7OUH';

// Handler background — délégué au service FCM (top-level requis)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async =>
    firebaseMessagingBackgroundHandler(msg);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Internationalisation (dates en français)
  await initializeDateFormatting('fr', null);

  // Firebase — initialiser avant tout
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FCM — écoute foreground/background/terminée + suppression notif système en foreground
  await FcmService.initialize();

  // Stripe
  Stripe.publishableKey = _stripePublishableKey;
  await Stripe.instance.applySettings();

  runApp(const ProviderScope(child: HayitisApp()));
}

class HayitisApp extends ConsumerWidget {
  const HayitisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: "Hayiti's",
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('fr'),
      supportedLocales: const [Locale('fr'), Locale('en')],
    );
  }
}
