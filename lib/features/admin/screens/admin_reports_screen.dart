// lib/features/admin/screens/admin_reports_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../repositories/admin_repository.dart';
import 'admin_shell_screen.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  Map<String, dynamic>? _salesData;
  Map<String, dynamic>? _productsData;
  Map<String, dynamic>? _customersData;
  String _period = 'monthly';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        AdminRepository().getSalesReport(period: _period),
        AdminRepository().getProductsReport(),
        AdminRepository().getCustomersReport(),
      ]);
      setState(() {
        _salesData     = results[0];
        _productsData  = results[1];
        _customersData = results[2];
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Extracts a list from various API response shapes
  List<dynamic> _extractList(Map<String, dynamic>? data, List<String> keys) {
    if (data == null) return [];
    for (final key in keys) {
      if (data[key] is List) return data[key] as List;
    }
    // Maybe the data itself is wrapped in another key
    for (final v in data.values) {
      if (v is List) return v;
    }
    return [];
  }

  dynamic _field(Map<String, dynamic> item, List<String> keys, {dynamic fallback = '-'}) {
    for (final key in keys) {
      if (item[key] != null) return item[key];
    }
    return fallback;
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
        title: const Text('Rapports'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
        ],
        bottom: TabBar(
          controller: _tabCtrl,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppColors.primary,
          tabs: const [Tab(text: 'Ventes'), Tab(text: 'Produits'), Tab(text: 'Clients')],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabCtrl,
              children: [
                _buildSalesTab(),
                _buildProductsTab(),
                _buildCustomersTab(),
              ],
            ),
    );
  }

  Widget _buildSalesTab() {
    final results = _extractList(_salesData, ['results', 'periods', 'breakdown', 'data', 'revenue_last_30_days']);
    final totalRevenue  = _salesData?['total_revenue'] ?? _salesData?['total'] ?? 0;
    final paidOrders    = _salesData?['total_orders'] ?? _salesData?['order_count'] ?? 0;
    final totalOrders   = _salesData?['total_orders_all'] ?? paidOrders;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Sélecteur période
        DropdownButtonFormField<String>(
          value: _period,
          decoration: InputDecoration(
            labelText: 'Période',
            filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: const [
            DropdownMenuItem(value: 'daily',   child: Text('Quotidien')),
            DropdownMenuItem(value: 'weekly',  child: Text('Hebdomadaire')),
            DropdownMenuItem(value: 'monthly', child: Text('Mensuel')),
          ],
          onChanged: (v) { setState(() => _period = v ?? 'monthly'); _load(); },
        ),
        const SizedBox(height: 16),

        // KPI résumé
        Row(children: [
          Expanded(child: _kpiCard('Total revenus', 'G ${(totalRevenue as num).toStringAsFixed(0)}', AppColors.primary)),
          const SizedBox(width: 12),
          Expanded(child: _kpiCard('Cmd payées', '$paidOrders', AppColors.success)),
          const SizedBox(width: 12),
          Expanded(child: _kpiCard('Total cmds', '$totalOrders', AppColors.statusProcessing)),
        ]),
        const SizedBox(height: 16),

        // Graphe
        if (results.isNotEmpty) ...[
          const Text('Évolution', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 200,
              child: BarChart(BarChartData(
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                barGroups: results.take(12).toList().asMap().entries.map((e) {
                  final amount = (_field(e.value as Map<String, dynamic>, ['amount', 'revenue', 'total', 'value'], fallback: 0) as num).toDouble();
                  return BarChartGroupData(x: e.key, barRods: [
                    BarChartRodData(toY: amount, color: AppColors.primary, width: 16, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
                  ]);
                }).toList(),
              )),
            ),
          )),
        ] else
          const Center(child: Padding(
            padding: EdgeInsets.all(32),
            child: Text('Aucune donnée pour cette période', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
          )),
      ]),
    );
  }

  Widget _buildProductsTab() {
    final results = _extractList(_productsData, ['results', 'products', 'top_products', 'data']);
    if (results.isEmpty) {
      return const Center(child: Text('Aucune donnée', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final p = results[i] as Map<String, dynamic>;
        final name  = _field(p, ['name', 'product_name', 'product'], fallback: '-');
        final sales = _field(p, ['total_qty', 'sales', 'total_sold', 'quantity', 'sold'], fallback: 0);
        return Card(child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Text('${i + 1}', style: const TextStyle(color: AppColors.primary, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          ),
          title: Text('$name', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          trailing: Text('$sales ventes', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
        ));
      },
    );
  }

  Widget _buildCustomersTab() {
    final results = _extractList(_customersData, ['results', 'customers', 'top_customers', 'data']);
    if (results.isEmpty) {
      return const Center(child: Text('Aucune donnée', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final c = results[i] as Map<String, dynamic>;
        final name   = _field(c, ['name', 'full_name', 'username', 'client_name'], fallback: '-');
        final email  = _field(c, ['email'], fallback: '-');
        final orders = _field(c, ['order_count', 'total_orders', 'orders'], fallback: 0);
        final spent  = _field(c, ['total_spent', 'total', 'revenue'], fallback: 0);
        return Card(child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.dark.withValues(alpha: 0.1),
            child: Text('${i + 1}', style: const TextStyle(color: AppColors.dark, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          ),
          title: Text('$name', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          subtitle: Text('$email', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 12)),
          trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('$orders cmd', style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted)),
            Text('G ${(spent as num).toStringAsFixed(0)}', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: AppColors.primary, fontSize: 12)),
          ]),
        ));
      },
    );
  }

  Widget _kpiCard(String label, String value, Color color) => Card(child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(children: [
      Text(value, style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w700, color: color)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted)),
    ]),
  ));
}
