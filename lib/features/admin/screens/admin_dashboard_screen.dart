// lib/features/admin/screens/admin_dashboard_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/price_formatter.dart';
import '../providers/admin_provider.dart';
import 'admin_shell_screen.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.invalidate(adminDashboardProvider);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(adminDashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => AdminShellScreen.scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(adminDashboardProvider)),
        ],
      ),
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
        data: (dashboard) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KPI Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _KpiCard('Commandes totales', '${dashboard.totalOrders}', Icons.receipt, AppColors.primary),
                  _KpiCard('En attente', '${dashboard.pendingOrders}', Icons.hourglass_empty, AppColors.warning),
                  _KpiCard('Revenus', formatPrice(dashboard.totalRevenue, 'HTG'), Icons.attach_money, AppColors.success),
                  _KpiCard('Clients', '${dashboard.totalCustomers}', Icons.people, AppColors.statusProcessing),
                ],
              ),
              const SizedBox(height: 24),

              // Graphe revenus 30 jours
              const Text('Revenus — 30 derniers jours', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Card(child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: dashboard.revenueChart.isEmpty
                      ? const Center(child: Text('Aucune donnée', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)))
                      : LineChart(LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: dashboard.revenueChart.asMap().entries
                                  .map((e) => FlSpot(e.key.toDouble(), e.value.amount))
                                  .toList(),
                              isCurved: true,
                              color: AppColors.primary,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(show: true, color: AppColors.primary.withValues(alpha: 0.1)),
                            ),
                          ],
                        )),
                ),
              )),
              const SizedBox(height: 24),

              // Top produits
              const Text('Top Produits', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Card(child: Column(
                children: dashboard.topProducts.take(5).map((p) => ListTile(
                  leading: const CircleAvatar(backgroundColor: AppColors.primary, child: Icon(Icons.star, color: Colors.white, size: 16)),
                  title: Text(p.name, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                  trailing: Text('${p.sales} ventes', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
                )).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _KpiCard(this.label, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          CircleAvatar(radius: 20, backgroundColor: color.withValues(alpha: 0.1), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 10),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(value, style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: color)),
            ],
          )),
        ]),
      ),
    );
  }
}
