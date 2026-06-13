// lib/features/orders/screens/order_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/widgets/error_state.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../payments/repositories/payment_repository.dart';
import '../providers/order_provider.dart';
import '../repositories/order_repository.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final int orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  bool _verifying = false;

  Future<void> _verifyPayment(int orderId) async {
    setState(() => _verifying = true);
    try {
      // Try to verify — if backend already received MonCash callback, it will confirm
      await PaymentRepository().verify(orderId: orderId);
      ref.invalidate(orderDetailProvider(orderId));
      Fluttertoast.showToast(msg: 'Paiement confirmé !');
    } catch (e) {
      // If verify fails (e.g. transaction_id missing), just refresh order status
      ref.invalidate(orderDetailProvider(orderId));
      Fluttertoast.showToast(msg: 'Statut actualisé — paiement en attente de confirmation MonCash.');
    } finally {
      if (mounted) setState(() => _verifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderDetailProvider(widget.orderId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Commande #${widget.orderId}')),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(message: e.toString(), onRetry: () => ref.invalidate(orderDetailProvider(widget.orderId))),
        data: (order) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              Card(child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Commande #${order.id}', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(formatDate(order.createdAt), style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
                    ]),
                    OrderStatusBadge(status: order.status),
                  ],
                ),
              )),
              const SizedBox(height: 12),

              // Articles
              _SectionTitle('Articles (${order.orderDetails.length})'),
              Card(child: Column(
                children: order.orderDetails.map((item) => ListTile(
                  title: Text(item.productName, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  subtitle: Text('x${item.quantity}', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
                  trailing: Text(formatPrice(item.subTotalTtc, 'HTG'), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                )).toList(),
              )),
              const SizedBox(height: 12),

              // Adresses
              _SectionTitle('Adresses'),
              Card(child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _AddressRow('Facturation', order.billingAddress),
                  const Divider(),
                  _AddressRow('Livraison', order.shippingAddress),
                ]),
              )),
              const SizedBox(height: 12),

              // Récapitulatif
              _SectionTitle('Récapitulatif'),
              Card(child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  _SummaryRow('Sous-total HT', formatPrice(order.orderCost, 'HTG')),
                  _SummaryRow('Taxes', formatPrice(order.taxe, 'HTG')),
                  _SummaryRow('Livraison', formatPrice(order.carrierPrice, 'HTG')),
                  const Divider(),
                  _SummaryRow('Total TTC', formatPrice(order.orderCostTtc + order.carrierPrice, 'HTG'), isBold: true),
                ]),
              )),
              const SizedBox(height: 12),

              // Paiement
              _SectionTitle('Paiement'),
              Card(child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.paymentMethod, style: const TextStyle(fontFamily: 'Poppins')),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: order.isPaid ? AppColors.success.withValues(alpha: 0.1) : AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.isPaid ? 'Payé' : 'Non payé',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: order.isPaid ? AppColors.success : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 24),

              // Actions
              if (order.status == 'pending' &&
                  !order.isPaid &&
                  order.paymentMethod.toLowerCase().contains('moncash')) ...[
                CustomButton(
                  label: 'Vérifier mon paiement MonCash',
                  isLoading: _verifying,
                  onPressed: _verifying ? null : () => _verifyPayment(order.id),
                ),
                const SizedBox(height: 12),
              ],
              if (order.status == 'pending')
                CustomButton(
                  label: 'Annuler la commande',
                  isOutlined: true,
                  color: AppColors.error,
                  onPressed: () async {
                    try {
                      await OrderRepository().cancelOrder(order.id);
                      ref.invalidate(orderDetailProvider(order.id));
                      Fluttertoast.showToast(msg: 'Commande annulée');
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                ),
              const SizedBox(height: 12),
              CustomButton(
                label: 'Suivre ma commande',
                isOutlined: true,
                onPressed: () => context.push('/track?id=${order.id}'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text("Besoin d'aide pour cette commande ?"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => context.push('/chat?orderId=${order.id}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600)),
  );
}

class _AddressRow extends StatelessWidget {
  final String label;
  final String address;
  const _AddressRow(this.label, this.address);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textMuted)),
      const SizedBox(height: 4),
      Text(address, style: const TextStyle(fontFamily: 'Poppins')),
    ],
  );
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _SummaryRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontFamily: 'Poppins', color: isBold ? AppColors.textPrimary : AppColors.textMuted, fontWeight: isBold ? FontWeight.w700 : FontWeight.w400)),
        Text(value, style: TextStyle(fontFamily: 'Poppins', fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: isBold ? AppColors.primary : AppColors.textPrimary)),
      ],
    ),
  );
}
