// lib/features/admin/screens/admin_product_list_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/price_formatter.dart';
import '../repositories/admin_repository.dart';
import '../../products/models/product.dart';
import 'admin_shell_screen.dart';

class AdminProductListScreen extends StatefulWidget {
  const AdminProductListScreen({super.key});

  @override
  State<AdminProductListScreen> createState() => _AdminProductListScreenState();
}

class _AdminProductListScreenState extends State<AdminProductListScreen> {
  List<Product> _products = [];
  final Map<int, List<int>> _categoryIds = {};
  bool _isLoading = true;
  String _search = '';
  bool? _filterInStock;
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
      _categoryIds.clear();
      final products = await AdminRepository().getAdminProducts(
        search: _search.isEmpty ? null : _search,
        inStock: _filterInStock,
        outCategoryIds: _categoryIds,
      );
      setState(() => _products = products);
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

  Future<void> _confirmDelete(Product p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supprimer le produit', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
        content: Text('Supprimer « ${p.name} » ? Cette action est irréversible.', style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await AdminRepository().deleteProduct(p.id);
      setState(() => _products.removeWhere((x) => x.id == p.id));
      Fluttertoast.showToast(msg: 'Produit supprimé');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
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
        title: const Text('Produits'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push('/admin/products/new').then((_) => _load()),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(children: [
        // Barre de recherche
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Rechercher un produit...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
        ),
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(children: [
            _chip('Tous',          null),
            const SizedBox(width: 8),
            _chip('En stock',      true),
            const SizedBox(width: 8),
            _chip('Indisponibles', false),
          ]),
        ),
        // Liste
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _products.isEmpty
                  ? const Center(child: Text('Aucun produit', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)))
                  : RefreshIndicator(
                      onRefresh: _load,
                      color: AppColors.primary,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        itemCount: _products.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final p = _products[i];
                          return Card(child: ListTile(
                            title: Text(p.name, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            subtitle: Row(children: [
                              Text(formatPrice(p.price, p.currency), style: const TextStyle(fontFamily: 'Poppins', color: AppColors.primary, fontWeight: FontWeight.w600)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: p.inStock ? AppColors.success.withValues(alpha: 0.15) : AppColors.error.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  p.inStock ? 'Disponible' : 'Indisponible',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 10, color: p.inStock ? AppColors.success : AppColors.error, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ]),
                            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                              Text('Stock: ${p.stockQuantity}',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12,
                                      color: p.stockQuantity < 5 ? AppColors.error : AppColors.textMuted)),
                              PopupMenuButton<String>(
                                onSelected: (v) {
                                  if (v == 'edit')   context.push('/admin/products/${p.id}/edit', extra: {'product': p, 'categoryIds': _categoryIds[p.id] ?? []}).then((_) => _load());
                                  if (v == 'delete') _confirmDelete(p);
                                },
                                itemBuilder: (_) => const [
                                  PopupMenuItem(value: 'edit',   child: Text('Modifier')),
                                  PopupMenuItem(value: 'delete', child: Text('Supprimer', style: TextStyle(color: AppColors.error))),
                                ],
                              ),
                            ]),
                          ));
                        },
                      ),
                    ),
        ),
      ]),
    );
  }

  Widget _chip(String label, bool? value) {
    final isSelected = _filterInStock == value;
    return FilterChip(
      label: Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12)),
      selected: isSelected,
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      checkmarkColor: AppColors.primary,
      onSelected: (_) {
        setState(() => _filterInStock = value);
        _load();
      },
    );
  }
}
