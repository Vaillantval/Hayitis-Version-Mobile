// lib/features/admin/screens/admin_order_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../orders/models/order.dart';
import '../repositories/admin_repository.dart';

class AdminOrderDetailScreen extends StatefulWidget {
  final int orderId;
  const AdminOrderDetailScreen({super.key, required this.orderId});

  @override
  State<AdminOrderDetailScreen> createState() => _AdminOrderDetailScreenState();
}

class _AdminOrderDetailScreenState extends State<AdminOrderDetailScreen> {
  Order? _order;
  bool _isLoading = true;
  String? _newStatus;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final order = await AdminRepository().getAdminOrderDetail(widget.orderId);
      setState(() { _order = order; _newStatus = order.status; });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updateStatus() async {
    if (_newStatus == null || _newStatus == _order?.status) return;
    setState(() => _isUpdating = true);
    try {
      await AdminRepository().updateOrderStatus(widget.orderId, _newStatus!);
      Fluttertoast.showToast(msg: 'Statut mis à jour');
      await _load();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_order == null) return const Scaffold(body: Center(child: Text('Commande introuvable')));

    final order = _order!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Commande #${order.id}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // En-tête
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(order.clientName, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16)),
                OrderStatusBadge(status: order.status),
              ]),
              Text(formatDateTime(order.createdAt), style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
              const SizedBox(height: 8),
              Row(children: [
                Icon(order.isPaid ? Icons.check_circle : Icons.pending, color: order.isPaid ? AppColors.success : AppColors.warning, size: 16),
                const SizedBox(width: 4),
                Text(order.isPaid ? 'Payé' : 'Non payé', style: TextStyle(fontFamily: 'Poppins', color: order.isPaid ? AppColors.success : AppColors.warning, fontWeight: FontWeight.w500)),
                const SizedBox(width: 16),
                Text(order.paymentMethod, style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
              ]),
            ]),
          )),

          const SizedBox(height: 12),

          // Changer statut
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Changer le statut', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _newStatus,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'pending',    child: Text('En attente')),
                  DropdownMenuItem(value: 'processing', child: Text('En traitement')),
                  DropdownMenuItem(value: 'shipped',    child: Text('Expédiée')),
                  DropdownMenuItem(value: 'delivered',  child: Text('Livrée')),
                  DropdownMenuItem(value: 'canceled',   child: Text('Annulée')),
                ],
                onChanged: (v) => setState(() => _newStatus = v),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isUpdating ? null : _updateStatus,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: _isUpdating
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Valider le changement', style: TextStyle(fontFamily: 'Poppins')),
              ),
            ]),
          )),

          // Preuve de paiement hors ligne
          if (order.paymentMethod == 'Hors Ligne' && order.paymentProofUrl != null) ...[
            const SizedBox(height: 12),
            Card(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Preuve de paiement', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Voir la preuve'),
                  onPressed: () => _showPaymentProof(context, order.paymentProofUrl!),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.dark),
                ),
              ]),
            )),
          ],

          const SizedBox(height: 12),

          // Articles
          const Text('Articles', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(child: Column(
            children: order.orderDetails.map((item) => ListTile(
              title: Text(item.productName, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
              subtitle: Text('x${item.quantity}', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
              trailing: Text(formatPrice(item.subTotalTtc, 'HTG'), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
            )).toList(),
          )),

          const SizedBox(height: 12),
          Text('Total TTC: ${formatPrice(order.orderCostTtc, 'HTG')}',
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
        ]),
      ),
    );
  }

  void _showPaymentProof(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: InteractiveViewer(
          child: CachedNetworkImage(imageUrl: url, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
