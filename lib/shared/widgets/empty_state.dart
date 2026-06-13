// lib/shared/widgets/empty_state.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'custom_button.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onCta;

  const EmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onCta,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 80, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                child: CustomButton(label: ctaLabel!, onPressed: onCta),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
