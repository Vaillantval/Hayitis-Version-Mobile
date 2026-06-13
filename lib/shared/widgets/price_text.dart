// lib/shared/widgets/price_text.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../utils/price_formatter.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? compareAtPrice;
  final String currency;
  final double fontSize;

  const PriceText({
    super.key,
    required this.price,
    this.compareAtPrice,
    this.currency = 'HTG',
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = compareAtPrice != null && compareAtPrice! > price;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          formatPrice(price, currency),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 8),
          Text(
            formatPrice(compareAtPrice!, currency),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: fontSize - 2,
              color: AppColors.textMuted,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}
