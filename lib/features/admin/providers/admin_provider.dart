// lib/features/admin/providers/admin_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/admin_dashboard.dart';
import '../models/inventory_item.dart';
import '../repositories/admin_repository.dart';

final adminRepositoryProvider = Provider<AdminRepository>((_) => AdminRepository());

final adminDashboardProvider = FutureProvider<AdminDashboard>((ref) {
  return ref.read(adminRepositoryProvider).getDashboard();
});

final adminInventoryProvider = FutureProvider.family<List<InventoryItem>, int>((ref, threshold) {
  return ref.read(adminRepositoryProvider).getInventory(threshold: threshold);
});
