// lib/features/profile/screens/change_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../auth/providers/auth_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _oldCtrl    = TextEditingController();
  final _newCtrl    = TextEditingController();
  final _new2Ctrl   = TextEditingController();
  bool _isLoading   = false;

  @override
  void dispose() {
    _oldCtrl.dispose(); _newCtrl.dispose(); _new2Ctrl.dispose();
    super.dispose();
  }

  Future<void> _change() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).changePassword(
        oldPassword:  _oldCtrl.text,
        newPassword:  _newCtrl.text,
        newPassword2: _new2Ctrl.text,
      );
      Fluttertoast.showToast(msg: 'Mot de passe modifié !');
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
      appBar: AppBar(title: const Text('Changer le mot de passe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            CustomTextField(
              label: 'Mot de passe actuel',
              controller: _oldCtrl,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Nouveau mot de passe',
              controller: _newCtrl,
              obscureText: true,
              prefixIcon: Icons.lock_reset,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Requis';
                if (v.length < 8) return 'Minimum 8 caractères';
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Confirmer le nouveau mot de passe',
              controller: _new2Ctrl,
              obscureText: true,
              prefixIcon: Icons.lock_reset,
              validator: (v) => v != _newCtrl.text ? 'Les mots de passe ne correspondent pas' : null,
            ),
            const SizedBox(height: 24),
            CustomButton(label: 'Modifier', onPressed: _change, isLoading: _isLoading),
          ]),
        ),
      ),
    );
  }
}
