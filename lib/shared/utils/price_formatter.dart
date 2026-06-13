// lib/shared/utils/price_formatter.dart
import 'package:intl/intl.dart';

String formatPrice(double amount, String currency) {
  final formatted = NumberFormat('#,##0.00', 'fr').format(amount);
  return currency == 'HTG' ? '$formatted G' : '$currency $formatted';
}
