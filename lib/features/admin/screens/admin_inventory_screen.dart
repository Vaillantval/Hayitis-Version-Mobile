// lib/features/admin/screens/admin_inventory_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/admin_provider.dart';
import '../repositories/admin_repository.dart';
import 'admin_shell_screen.dart';

class AdminInventoryScreen extends ConsumerStatefulWidget {
  const AdminInventoryScreen({super.key});

  @override
  ConsumerState<AdminInventoryScreen> createState() => _AdminInventoryScreenState();
}

class _AdminInventoryScreenState extends ConsumerState<AdminInventoryScreen> {
  int _threshold = 10;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(adminInventoryProvider(_threshold));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => AdminShellScreen.scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('Inventaire'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            const Text('Seuil d\'alerte :', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
            const SizedBox(width: 12),
            SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: '$_threshold',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(isDense: true),
                onChanged: (v) {
                  final val = int.tryParse(v);
                  if (val != null) setState(() => _threshold = val);
                },
              ),
            ),
          ]),
        ),
        Expanded(
          child: inventoryAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur: $e')),
            data: (items) => items.isEmpty
                ? const Center(child: Text('Tous les produits ont un stock suffisant', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final item = items[i];
                      _controllers.putIfAbsent(item.id, () => TextEditingController(text: '${item.stockQuantity}'));
                      return Card(child: ListTile(
                        title: Text(item.name, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                        subtitle: Text('Stock actuel', style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.textMuted)),
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              controller: _controllers[item.id],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              style: TextStyle(color: item.stockQuantity < _threshold ? AppColors.error : AppColors.textPrimary, fontFamily: 'Poppins'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.save, color: AppColors.primary),
                            onPressed: () async {
                              final newStock = int.tryParse(_controllers[item.id]?.text ?? '');
                              if (newStock == null) return;
                              try {
                                await AdminRepository().updateInventory(item.id, newStock);
                                Fluttertoast.showToast(msg: 'Stock mis à jour');
                                ref.invalidate(adminInventoryProvider(_threshold));
                              } catch (e) {
                                Fluttertoast.showToast(msg: e.toString());
                              }
                            },
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
}
