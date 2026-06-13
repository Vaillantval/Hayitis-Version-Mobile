// lib/features/admin/screens/admin_order_list_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../orders/models/order.dart';
import '../repositories/admin_repository.dart';
import 'admin_shell_screen.dart';

class AdminOrderListScreen extends StatefulWidget {
  const AdminOrderListScreen({super.key});

  @override
  State<AdminOrderListScreen> createState() => _AdminOrderListScreenState();
}

class _AdminOrderListScreenState extends State<AdminOrderListScreen> {
  List<Order> _orders = [];
  bool _isLoading = true;
  String? _filterStatus;
  String _search = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final orders = await AdminRepository().getAdminOrders(
        status: _filterStatus,
        search: _search.isEmpty ? null : _search,
      );
      setState(() => _orders = orders);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged(String v) {
    _search = v;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), _load);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => AdminShellScreen.scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('Commandes'),
      ),
      body: Column(children: [
        // Barre de recherche
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Rechercher (#id ou nom client)...',
              prefixIcon: const Icon(Icons.search),
              filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
        ),
        // Filtres statut
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(children: [
            _chip('Tous',          null),
            const SizedBox(width: 8),
            _chip('En attente',    'pending'),
            const SizedBox(width: 8),
            _chip('En traitement', 'processing'),
            const SizedBox(width: 8),
            _chip('Expédiée',      'shipped'),
            const SizedBox(width: 8),
            _chip('Livrée',        'delivered'),
            const SizedBox(width: 8),
            _chip('Annulée',       'canceled'),
          ]),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _orders.isEmpty
                  ? const Center(child: Text('Aucune commande', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)))
                  : RefreshIndicator(
                      onRefresh: _load,
                      color: AppColors.primary,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        itemCount: _orders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final o = _orders[i];
                          return Card(child: ListTile(
                            title: Row(children: [
                              Text('#${o.id}', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                              const SizedBox(width: 8),
                              OrderStatusBadge(status: o.status),
                            ]),
                            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(o.clientName, style: const TextStyle(fontFamily: 'Poppins')),
                              Text(formatDate(o.createdAt), style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 12)),
                            ]),
                            trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(formatPrice(o.orderCostTtc, 'HTG'), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: AppColors.primary)),
                              Text(o.isPaid ? 'Payé' : 'Impayé',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: o.isPaid ? AppColors.success : AppColors.warning)),
                            ]),
                            onTap: () => context.push('/admin/orders/${o.id}'),
                          ));
                        },
                      ),
                    ),
        ),
      ]),
    );
  }

  Color _chipColor(String? status) => switch (status) {
    'pending'    => AppColors.statusPending,
    'processing' => AppColors.statusProcessing,
    'shipped'    => AppColors.statusShipped,
    'delivered'  => AppColors.statusDelivered,
    'canceled'   => AppColors.statusCanceled,
    _            => AppColors.dark,
  };

  Widget _chip(String label, String? status) {
    final isSelected = _filterStatus == status;
    final color = _chipColor(status);
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : color,
        ),
      ),
      selected: isSelected,
      backgroundColor: color.withValues(alpha: 0.10),
      selectedColor: color,
      checkmarkColor: Colors.white,
      showCheckmark: isSelected,
      side: BorderSide(color: color, width: 1.2),
      onSelected: (_) {
        setState(() => _filterStatus = status);
        _load();
      },
    );
  }
}
