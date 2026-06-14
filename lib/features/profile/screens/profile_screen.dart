// lib/features/profile/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/models/user_profile.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static String _avatarInitials(UserProfile? profile) {
    if (profile == null) return '?';
    final f = profile.firstName.isNotEmpty ? profile.firstName[0] : '';
    final l = profile.lastName.isNotEmpty ? profile.lastName[0] : '';
    final initials = '$f$l'.toUpperCase();
    if (initials.isNotEmpty) return initials;
    return profile.username.isNotEmpty ? profile.username[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final profile = authState.profile;

    if (!authState.isLoggedIn) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Mon Profil')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(Icons.person_outline, size: 44, color: AppColors.primary),
              ),
              const SizedBox(height: 20),
              const Text('Vous n\'êtes pas connecté',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Connectez-vous pour accéder à votre profil, vos commandes et bien plus.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () => context.push('/auth/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Se connecter', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.push('/auth/register'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Créer un compte', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mon Profil')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Column(children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    _avatarInitials(profile),
                    style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile != null ? '${profile.firstName} ${profile.lastName}' : '-',
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(profile?.email ?? '-', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
                if (profile?.isStaff == true)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: const Text('Administrateur', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
              ]),
            ),
            const SizedBox(height: 12),
            _MenuSection(title: 'Mes achats', items: [
              _MenuItem(Icons.receipt_long_outlined, 'Mes commandes', () => context.push('/orders')),
              _MenuItem(Icons.favorite_outline, 'Mes favoris', () => context.go('/wishlist')),
              if (profile?.isStaff != true)
                _MenuItem(Icons.support_agent_outlined, 'Contacter le support', () => context.push('/community/support')),
            ]),
            const SizedBox(height: 12),
            _MenuSection(title: 'Mon compte', items: [
              _MenuItem(Icons.person_outline, 'Modifier le profil', () => context.push('/profile/edit')),
              _MenuItem(Icons.location_on_outlined, 'Mes adresses', () => context.push('/profile/addresses')),
              _MenuItem(Icons.lock_outline, 'Changer le mot de passe', () => context.push('/profile/password')),
            ]),
            const SizedBox(height: 12),
            _MenuSection(title: 'À propos', items: [
              _MenuItem(Icons.help_outline, 'FAQ', () => context.push('/faq')),
              _MenuItem(Icons.mail_outline, 'Contact', () => context.push('/contact')),
              _MenuItem(Icons.info_outline, 'À propos', () => context.push('/about')),
            ]),
            if (profile?.isStaff == true) ...[
              const SizedBox(height: 12),
              _MenuSection(title: 'Administration', items: [
                _MenuItem(Icons.admin_panel_settings_outlined, 'Back Office', () => context.push('/admin/dashboard'), color: AppColors.primary),
                _MenuItem(Icons.inbox_outlined, 'Boîte de support', () => context.push('/community/support'), color: AppColors.primary),
              ]),
            ],
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (context.mounted) context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Se déconnecter', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: items.asMap().entries.map((e) {
              final isLast = e.key == items.length - 1;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(e.value.icon, color: e.value.color ?? AppColors.dark),
                    title: Text(e.value.label, style: TextStyle(fontFamily: 'Poppins', color: e.value.color)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: e.value.onTap,
                  ),
                  if (!isLast) const Divider(height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _MenuItem(this.icon, this.label, this.onTap, {this.color});
}
