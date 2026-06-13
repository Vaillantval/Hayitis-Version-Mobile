// lib/features/orders/screens/order_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_state.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../../shared/utils/date_formatter.dart';
import '../models/order.dart';
import '../repositories/order_repository.dart';

class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({super.key});

  @override
  ConsumerState<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends ConsumerState<OrderListScreen> {
  final _pagingController = PagingController<int, Order>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final orders = await OrderRepository().getOrders(page: pageKey);
      if (orders.length < 20) {
        _pagingController.appendLastPage(orders);
      } else {
        _pagingController.appendPage(orders, pageKey + 1);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mes commandes')),
      body: PagedListView<int, Order>(
        pagingController: _pagingController,
        padding: const EdgeInsets.all(16),
        builderDelegate: PagedChildBuilderDelegate<Order>(
          itemBuilder: (_, order, __) => _OrderCard(order: order),
          firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
          noItemsFoundIndicatorBuilder: (_) => const EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'Aucune commande',
            subtitle: 'Vous n\'avez pas encore passé de commande',
          ),
          firstPageErrorIndicatorBuilder: (_) => ErrorState(
            onRetry: _pagingController.refresh,
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/orders/${order.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Commande #${order.id}',
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15)),
                  OrderStatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(formatDate(order.createdAt), style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatPrice(order.orderCostTtc, 'HTG'),
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: AppColors.primary, fontSize: 16)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: order.isPaid ? AppColors.success.withValues(alpha: 0.1) : AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order.isPaid ? 'Payé' : 'En attente',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: order.isPaid ? AppColors.success : AppColors.warning,
                      ),
                    ),
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
