// lib/features/addresses/screens/address_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/empty_state.dart';
import '../providers/address_provider.dart';

class AddressListScreen extends ConsumerWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesAsync = ref.watch(addressProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mes adresses')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push('/profile/addresses/new'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: addressesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Erreur de chargement')),
        data: (addresses) {
          if (addresses.isEmpty) {
            return EmptyState(
              icon: Icons.location_on_outlined,
              title: 'Aucune adresse',
              subtitle: 'Ajoutez une adresse de livraison',
              ctaLabel: 'Ajouter une adresse',
              onCta: () => context.push('/profile/addresses/new'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final addr = addresses[i];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                  title: Row(children: [
                    Text(addr.name, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                    if (addr.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                        child: const Text('Défaut', style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.success)),
                      ),
                    ],
                  ]),
                  subtitle: Text('${addr.street}, ${addr.city}', style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, color: AppColors.textMuted)),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) async {
                      switch (v) {
                        case 'edit':
                          context.push('/profile/addresses/${addr.id}/edit');
                          break;
                        case 'default':
                          await ref.read(addressProvider.notifier).setDefault(addr.id);
                          Fluttertoast.showToast(msg: 'Adresse définie par défaut');
                          break;
                        case 'delete':
                          await ref.read(addressProvider.notifier).delete(addr.id);
                          Fluttertoast.showToast(msg: 'Adresse supprimée');
                          break;
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit',    child: Text('Modifier')),
                      PopupMenuItem(value: 'default', child: Text('Définir par défaut')),
                      PopupMenuItem(value: 'delete',  child: Text('Supprimer', style: TextStyle(color: AppColors.error))),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
