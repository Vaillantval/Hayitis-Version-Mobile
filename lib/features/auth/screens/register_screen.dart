// lib/features/auth/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey     = GlobalKey<FormState>();
  final _firstCtrl   = TextEditingController();
  final _lastCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _userCtrl    = TextEditingController();
  final _passCtrl    = TextEditingController();
  final _pass2Ctrl   = TextEditingController();
  bool _agreedTerms  = false;

  @override
  void dispose() {
    for (final c in [_firstCtrl, _lastCtrl, _emailCtrl, _userCtrl, _passCtrl, _pass2Ctrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedTerms) {
      Fluttertoast.showToast(msg: 'Veuillez accepter les conditions d\'utilisation');
      return;
    }
    try {
      await ref.read(authProvider.notifier).register(
        username:  _userCtrl.text.trim(),
        email:     _emailCtrl.text.trim(),
        firstName: _firstCtrl.text.trim(),
        lastName:  _lastCtrl.text.trim(),
        password:  _passCtrl.text,
        password2: _pass2Ctrl.text,
      );
      if (mounted) context.go('/home');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Créer un compte')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(children: [
                Expanded(child: CustomTextField(label: 'Prénom', controller: _firstCtrl,
                    validator: (v) => v == null || v.isEmpty ? 'Requis' : null)),
                const SizedBox(width: 12),
                Expanded(child: CustomTextField(label: 'Nom', controller: _lastCtrl,
                    validator: (v) => v == null || v.isEmpty ? 'Requis' : null)),
              ]),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Requis';
                  if (!v.contains('@')) return 'Email invalide';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nom d\'utilisateur',
                controller: _userCtrl,
                prefixIcon: Icons.person_outline,
                validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mot de passe',
                controller: _passCtrl,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Requis';
                  if (v.length < 8) return 'Minimum 8 caractères';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirmer le mot de passe',
                controller: _pass2Ctrl,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                validator: (v) {
                  if (v != _passCtrl.text) return 'Les mots de passe ne correspondent pas';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _agreedTerms,
                onChanged: (v) => setState(() => _agreedTerms = v ?? false),
                title: const Text('J\'accepte les conditions d\'utilisation',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 24),
              CustomButton(label: 'Créer mon compte', onPressed: _register, isLoading: isLoading),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Déjà un compte ? ', style: TextStyle(fontFamily: 'Poppins')),
                  GestureDetector(
                    onTap: () => context.go('/auth/login'),
                    child: const Text('Se connecter',
                        style: TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
