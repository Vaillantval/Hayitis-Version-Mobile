// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../wishlist/providers/wishlist_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? redirect;
  const LoginScreen({super.key, this.redirect});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey   = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await ref.read(authProvider.notifier).login(
        username: _usernameCtrl.text.trim(),
        password: _passwordCtrl.text,
      );
      // Envoyer le FCM token après login
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await ref.read(authRepositoryProvider).sendFcmToken(fcmToken);
      }
      // Sync guest cart & wishlist to server
      await ref.read(guestCartProvider.notifier).syncToServer(ref.read(cartRepositoryProvider));
      await ref.read(guestWishlistProvider.notifier).syncToServer(ref.read(wishlistRepositoryProvider));
      if (mounted) context.go(widget.redirect ?? '/home');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 48),
                Image.asset(
                  'assets/images/logo_hayitis.PNG',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                const Text('Connectez-vous à votre compte',
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: AppColors.textMuted)),
                const SizedBox(height: 40),
                CustomTextField(
                  label: 'Email ou nom d\'utilisateur',
                  controller: _usernameCtrl,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Mot de passe',
                  controller: _passwordCtrl,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Se connecter',
                  onPressed: _login,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pas encore de compte ? ', style: TextStyle(fontFamily: 'Poppins')),
                    GestureDetector(
                      onTap: () => context.go('/auth/register'),
                      child: const Text('S\'inscrire',
                          style: TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
