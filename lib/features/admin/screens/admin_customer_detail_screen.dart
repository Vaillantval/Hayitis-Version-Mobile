// lib/features/admin/screens/admin_customer_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../orders/models/order.dart';
import '../repositories/admin_repository.dart';

class AdminCustomerDetailScreen extends StatefulWidget {
  final int customerId;
  const AdminCustomerDetailScreen({super.key, required this.customerId});

  @override
  State<AdminCustomerDetailScreen> createState() => _AdminCustomerDetailScreenState();
}

class _AdminCustomerDetailScreenState extends State<AdminCustomerDetailScreen> {
  Map<String, dynamic>? _data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final data = await AdminRepository().getCustomerDetail(widget.customerId);
      setState(() => _data = data);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_data == null) return const Scaffold(body: Center(child: Text('Client introuvable')));

    final orders = (_data!['orders'] as List? ?? []).map((e) => Order.fromJson(e as Map<String, dynamic>)).toList();
    final profile = _data!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('${profile['first_name']} ${profile['last_name']}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _InfoRow('Email', profile['email'] ?? '-'),
              _InfoRow('Téléphone', profile['phone'] ?? '-'),
              _InfoRow('Inscription', formatDate(DateTime.tryParse(profile['date_joined'] ?? '') ?? DateTime.now())),
              _InfoRow('FCM Token', profile['fcm_token'] != null ? 'Configuré' : 'Non configuré'),
            ]),
          )),
          const SizedBox(height: 16),
          const Text('Commandes', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...orders.map((o) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Row(children: [
                Text('#${o.id}', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                OrderStatusBadge(status: o.status),
              ]),
              subtitle: Text(formatDate(o.createdAt), style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 12)),
              trailing: Text(formatPrice(o.orderCostTtc, 'HTG'), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: AppColors.primary)),
              onTap: () => context.push('/admin/orders/${o.id}'),
            ),
          )),
        ]),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
      Text(value, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
    ]),
  );
}
