// lib/features/profile/screens/edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../auth/providers/auth_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _firstCtrl = TextEditingController();
  final _lastCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _isLoading  = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    if (profile != null) {
      _firstCtrl.text = profile.firstName;
      _lastCtrl.text  = profile.lastName;
      _emailCtrl.text = profile.email;
      _phoneCtrl.text = profile.phone ?? '';
    }
  }

  @override
  void dispose() {
    for (final c in [_firstCtrl, _lastCtrl, _emailCtrl, _phoneCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authProvider.notifier).updateProfile({
        'first_name': _firstCtrl.text.trim(),
        'last_name':  _lastCtrl.text.trim(),
        'email':      _emailCtrl.text.trim(),
        'phone':      _phoneCtrl.text.trim(),
      });
      Fluttertoast.showToast(msg: 'Profil mis à jour !');
      if (mounted) context.pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier le profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Row(children: [
            Expanded(child: CustomTextField(label: 'Prénom', controller: _firstCtrl)),
            const SizedBox(width: 12),
            Expanded(child: CustomTextField(label: 'Nom', controller: _lastCtrl)),
          ]),
          const SizedBox(height: 16),
          CustomTextField(label: 'Email', controller: _emailCtrl, keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email_outlined),
          const SizedBox(height: 16),
          CustomTextField(label: 'Téléphone', controller: _phoneCtrl, keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined),
          const SizedBox(height: 24),
          CustomButton(label: 'Sauvegarder', onPressed: _save, isLoading: _isLoading),
        ]),
      ),
    );
  }
}
