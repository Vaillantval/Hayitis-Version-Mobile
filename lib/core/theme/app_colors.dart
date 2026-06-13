// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Palette Hayiti's
  static const primary     = Color(0xFFC62828); // rouge sombre (CTA, accents)
  static const primaryDark = Color(0xFFB71C1C); // rouge hover
  static const dark        = Color(0xFF1C1410); // brun-noir chaud (appBar, splash)
  static const background  = Color(0xFFFFF8F0); // crème chaud (fond global)
  static const surface     = Color(0xFFFFFAF6); // surface cartes
  static const cardBorder  = Color(0xFFEDE0D8); // bordure cartes
  static const accent      = Color(0xFFFFCDD2); // rose clair (chips, badges)
  static const accentLight = Color(0xFFFFF0EC); // rose très clair (fond pill)
  static const success     = Color(0xFF2E7D32);
  static const warning     = Color(0xFFF9A825);
  static const error       = Color(0xFFEF4444);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textMuted   = Color(0xFF9E9E9E);
  static const textSecond  = Color(0xFF616161);

  // Statuts commandes
  static const statusPending    = Color(0xFFF9A825);
  static const statusProcessing = Color(0xFF3B82F6);
  static const statusShipped    = Color(0xFF8B5CF6);
  static const statusDelivered  = Color(0xFF2E7D32);
  static const statusCanceled   = Color(0xFFEF4444);

  // MonCash
  static const moncash = Color(0xFFE52329);
}
