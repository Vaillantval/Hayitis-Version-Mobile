// lib/features/orders/providers/order_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../repositories/order_repository.dart';

final orderRepositoryProvider = Provider<OrderRepository>((_) => OrderRepository());

final orderDetailProvider = FutureProvider.family<Order, int>((ref, id) {
  return ref.read(orderRepositoryProvider).getOrderDetail(id);
});
