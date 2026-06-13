// lib/shared/widgets/error_state.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'custom_button.dart';

class ErrorState extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorState({super.key, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              message ?? 'Une erreur est survenue.',
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: 160,
                child: CustomButton(label: 'Réessayer', onPressed: onRetry, icon: Icons.refresh),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
