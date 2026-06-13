// lib/shared/utils/date_formatter.dart
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMMM yyyy', 'fr').format(date);
}

String formatDateTime(DateTime date) {
  return DateFormat('d MMM yyyy à HH:mm', 'fr').format(date);
}

String formatRelative(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);
  if (diff.inDays == 0) return 'Aujourd\'hui';
  if (diff.inDays == 1) return 'Hier';
  if (diff.inDays < 7)  return 'Il y a ${diff.inDays} jours';
  return formatDate(date);
}
