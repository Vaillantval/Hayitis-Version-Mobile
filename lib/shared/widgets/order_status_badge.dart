// lib/shared/widgets/order_status_badge.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;
  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'pending'    => (AppColors.statusPending,    'En attente'),
      'processing' => (AppColors.statusProcessing, 'En traitement'),
      'shipped'    => (AppColors.statusShipped,    'Expédiée'),
      'delivered'  => (AppColors.statusDelivered,  'Livrée'),
      'canceled'   => (AppColors.statusCanceled,   'Annulée'),
      _            => (AppColors.textMuted,         status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
