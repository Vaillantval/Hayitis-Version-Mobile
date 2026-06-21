// lib/features/addresses/screens/address_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../providers/address_provider.dart';

class AddressFormScreen extends ConsumerStatefulWidget {
  final int? addressId;
  const AddressFormScreen({super.key, this.addressId});

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  final _streetCtrl  = TextEditingController();
  final _cityCtrl    = TextEditingController();
  final _phoneCtrl   = TextEditingController();
  final _detailsCtrl = TextEditingController();
  String _adressType = 'shipping';
  bool _isLoading    = false;

  @override
  void initState() {
    super.initState();
    if (widget.addressId != null) {
      final addresses = ref.read(addressProvider).valueOrNull ?? [];
      final addr = addresses.where((a) => a.id == widget.addressId).firstOrNull;
      if (addr != null) {
        _streetCtrl.text   = addr.street;
        _cityCtrl.text     = addr.city;
        _phoneCtrl.text    = addr.phone ?? '';
        _detailsCtrl.text  = addr.moreDetails ?? '';
        _adressType        = addr.adressType;
      }
    }
  }

  @override
  void dispose() {
    for (final c in [_streetCtrl, _cityCtrl, _phoneCtrl, _detailsCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    final data = {
      'street':       _streetCtrl.text.trim(),
      'city':         _cityCtrl.text.trim(),
      'phone':        _phoneCtrl.text.trim(),
      'more_details': _detailsCtrl.text.trim().isEmpty ? null : _detailsCtrl.text.trim(),
      'adress_type':  _adressType,
    };
    try {
      if (widget.addressId != null) {
        await ref.read(addressProvider.notifier).update(widget.addressId!, data);
        Fluttertoast.showToast(msg: 'Adresse modifiée');
      } else {
        await ref.read(addressProvider.notifier).create(data);
        Fluttertoast.showToast(msg: 'Adresse ajoutée');
      }
      if (mounted) context.pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.addressId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Modifier l\'adresse' : 'Nouvelle adresse')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          CustomTextField(label: 'Rue / Adresse', controller: _streetCtrl),
          const SizedBox(height: 12),
          CustomTextField(label: 'Ville', controller: _cityCtrl),
          const SizedBox(height: 12),
          CustomTextField(label: 'Téléphone', controller: _phoneCtrl, keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          CustomTextField(label: 'Détails supplémentaires (optionnel)', controller: _detailsCtrl, maxLines: 3),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _adressType,
            decoration: const InputDecoration(labelText: 'Type d\'adresse'),
            items: const [
              DropdownMenuItem(value: 'shipping', child: Text('Livraison')),
              DropdownMenuItem(value: 'billing',  child: Text('Facturation')),
            ],
            onChanged: (v) => setState(() => _adressType = v ?? 'shipping'),
          ),
          const SizedBox(height: 24),
          CustomButton(label: isEdit ? 'Modifier' : 'Ajouter', onPressed: _save, isLoading: _isLoading),
        ]),
      ),
    );
  }
}
