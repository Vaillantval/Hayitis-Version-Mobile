// lib/features/admin/screens/admin_product_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../products/models/category.dart';
import '../../products/models/product.dart';
import '../../products/providers/product_provider.dart';
import '../repositories/admin_repository.dart';

class AdminProductFormScreen extends ConsumerStatefulWidget {
  final int? productId;
  final Product? initialProduct;
  final List<int> initialCategoryIds;
  const AdminProductFormScreen({
    super.key,
    this.productId,
    this.initialProduct,
    this.initialCategoryIds = const [],
  });

  @override
  ConsumerState<AdminProductFormScreen> createState() => _AdminProductFormScreenState();
}

class _AdminProductFormScreenState extends ConsumerState<AdminProductFormScreen> {
  final _nameCtrl         = TextEditingController();
  final _descCtrl         = TextEditingController();
  final _moreDescCtrl     = TextEditingController();
  final _addInfoCtrl      = TextEditingController();
  final _brandCtrl        = TextEditingController();
  final _priceCtrl        = TextEditingController();
  final _soldePriceCtrl   = TextEditingController();
  final _stockCtrl        = TextEditingController();
  bool _isAvailable       = true;
  bool _isBestSeller      = false;
  bool _isNewArrival      = false;
  bool _isSpecialOffer    = false;
  bool _isFeatured        = false;
  bool _isLoading      = false;
  List<String> _imagePaths = [];
  List<int> _selectedCategoryIds = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialProduct != null) {
      _prefill(widget.initialProduct!, widget.initialCategoryIds);
    }
  }

  @override
  void dispose() {
    for (final c in [_nameCtrl, _descCtrl, _moreDescCtrl, _addInfoCtrl, _brandCtrl, _priceCtrl, _soldePriceCtrl, _stockCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  void _prefill(Product p, List<int> catIds) {
    _nameCtrl.text       = p.name;
    _descCtrl.text       = p.description;
    _moreDescCtrl.text   = p.moreDescription ?? '';
    _addInfoCtrl.text    = p.additionalInfo  ?? '';
    _brandCtrl.text      = p.brand           ?? '';
    _priceCtrl.text      = p.compareAtPrice.toStringAsFixed(0);
    _soldePriceCtrl.text = p.price.toStringAsFixed(0);
    _stockCtrl.text      = p.stockQuantity.toString();
    _isAvailable         = p.inStock;
    _isBestSeller        = p.isBestSeller;
    _isNewArrival        = p.isNewArrival;
    _isSpecialOffer      = p.isSpecialOffer;
    _isFeatured          = p.isFeatured;
    _selectedCategoryIds = catIds;
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    if (images.isNotEmpty) setState(() => _imagePaths = images.map((i) => i.path).toList());
  }

  double get _discount {
    final reg   = double.tryParse(_priceCtrl.text) ?? 0;
    final solde = double.tryParse(_soldePriceCtrl.text) ?? 0;
    if (reg <= 0 || solde >= reg) return 0;
    return ((reg - solde) / reg * 100).roundToDouble();
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Le nom est requis');
      return;
    }
    final regPrice   = double.tryParse(_priceCtrl.text);
    final soldePrice = double.tryParse(_soldePriceCtrl.text);
    if (regPrice == null || regPrice <= 0) {
      Fluttertoast.showToast(msg: 'Prix régulier invalide');
      return;
    }
    if (soldePrice == null || soldePrice <= 0) {
      Fluttertoast.showToast(msg: 'Prix soldé invalide');
      return;
    }
    final stock = int.tryParse(_stockCtrl.text);
    if (stock == null || stock < 0) {
      Fluttertoast.showToast(msg: 'Stock invalide');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final data = <String, dynamic>{
        'name':             _nameCtrl.text.trim(),
        'description':      _descCtrl.text.trim(),
        if (_moreDescCtrl.text.trim().isNotEmpty) 'more_description': _moreDescCtrl.text.trim(),
        if (_addInfoCtrl.text.trim().isNotEmpty)  'additional_info':  _addInfoCtrl.text.trim(),
        if (_brandCtrl.text.trim().isNotEmpty)    'brand':            _brandCtrl.text.trim(),
        'regular_price': regPrice,
        'solde_price':   soldePrice,
        'stock':         stock,
        'is_available':  _isAvailable,
        'is_best_seller':   _isBestSeller,
        'is_new_arrival':   _isNewArrival,
        'is_special_offer': _isSpecialOffer,
        'is_featured':      _isFeatured,
        if (_selectedCategoryIds.isNotEmpty) 'categories': _selectedCategoryIds,
      };
      final repo = AdminRepository();
      if (widget.productId != null) {
        await repo.updateProduct(widget.productId!, data);
        if (_imagePaths.isNotEmpty) await repo.uploadProductImages(widget.productId!, _imagePaths);
        Fluttertoast.showToast(msg: 'Produit modifié');
      } else {
        await repo.createProduct(data);
        Fluttertoast.showToast(msg: 'Produit créé');
      }
      if (mounted) context.pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    final categoriesAsync = ref.watch(categoriesProvider);
    final discount = _discount;

    return Scaffold(
      appBar: AppBar(title: Text(widget.productId != null ? 'Modifier produit' : 'Nouveau produit')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ── Informations de base ──────────────────────────
          _sectionTitle('Informations de base'),
          CustomTextField(label: 'Nom du produit *', controller: _nameCtrl),
          const SizedBox(height: 12),
          CustomTextField(label: 'Marque (optionnel)', controller: _brandCtrl),
          const SizedBox(height: 12),

          // Catégories
          categoriesAsync.when(
            loading: () => const SizedBox(height: 40, child: Center(child: LinearProgressIndicator())),
            error: (_, __) => const SizedBox.shrink(),
            data: (cats) => _CategorySelector(
              categories: cats,
              selected: _selectedCategoryIds,
              onChanged: (ids) => setState(() => _selectedCategoryIds = ids),
            ),
          ),
          const SizedBox(height: 20),

          // ── Prix ─────────────────────────────────────────
          _sectionTitle('Prix'),
          Row(children: [
            Expanded(child: CustomTextField(label: 'Prix régulier (G) *', controller: _priceCtrl, keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            )),
            const SizedBox(width: 12),
            Expanded(child: CustomTextField(label: 'Prix soldé (G) *', controller: _soldePriceCtrl, keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            )),
          ]),
          if (discount > 0) ...[
            const SizedBox(height: 6),
            Text('Réduction : ${discount.toStringAsFixed(0)} %',
                style: const TextStyle(fontFamily: 'Poppins', color: AppColors.success, fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: 20),

          // ── Stock ────────────────────────────────────────
          _sectionTitle('Stock'),
          CustomTextField(label: 'Quantité en stock *', controller: _stockCtrl, keyboardType: TextInputType.number),
          const SizedBox(height: 8),
          Card(child: SwitchListTile(
            value: _isAvailable,
            onChanged: (v) => setState(() => _isAvailable = v),
            title: const Text('Disponible à la vente', style: TextStyle(fontFamily: 'Poppins')),
            activeColor: AppColors.primary,
          )),
          const SizedBox(height: 20),

          // ── Description ──────────────────────────────────
          _sectionTitle('Description'),
          CustomTextField(label: 'Description principale *', controller: _descCtrl, maxLines: 4),
          const SizedBox(height: 12),
          CustomTextField(label: 'Description complémentaire (optionnel)', controller: _moreDescCtrl, maxLines: 3),
          const SizedBox(height: 12),
          CustomTextField(label: 'Informations supplémentaires (optionnel)', controller: _addInfoCtrl, maxLines: 3),
          const SizedBox(height: 20),

          // ── Badges ───────────────────────────────────────
          _sectionTitle('Badges'),
          Card(child: Column(children: [
            SwitchListTile(value: _isBestSeller,  onChanged: (v) => setState(() => _isBestSeller = v),  title: const Text('Meilleure vente',  style: TextStyle(fontFamily: 'Poppins')), activeColor: AppColors.primary),
            SwitchListTile(value: _isNewArrival,  onChanged: (v) => setState(() => _isNewArrival = v),  title: const Text('Nouveauté',        style: TextStyle(fontFamily: 'Poppins')), activeColor: AppColors.primary),
            SwitchListTile(value: _isSpecialOffer,onChanged: (v) => setState(() => _isSpecialOffer = v),title: const Text('Offre spéciale',   style: TextStyle(fontFamily: 'Poppins')), activeColor: AppColors.primary),
            SwitchListTile(value: _isFeatured,    onChanged: (v) => setState(() => _isFeatured = v),    title: const Text('Produit vedette',  style: TextStyle(fontFamily: 'Poppins')), activeColor: AppColors.primary),
          ])),
          const SizedBox(height: 20),

          // ── Images ───────────────────────────────────────
          _sectionTitle('Images'),
          OutlinedButton.icon(
            onPressed: _pickImages,
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: Text(
              _imagePaths.isEmpty ? 'Ajouter des images' : '${_imagePaths.length} image(s) sélectionnée(s) ✓',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
          ),
          const SizedBox(height: 32),

          CustomButton(
            label: widget.productId != null ? 'Modifier le produit' : 'Créer le produit',
            onPressed: _save,
            isLoading: _isLoading,
          ),
        ]),
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(t, style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600)),
  );
}

class _CategorySelector extends StatelessWidget {
  final List<Category> categories;
  final List<int> selected;
  final ValueChanged<List<int>> onChanged;
  const _CategorySelector({required this.categories, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Catégories *', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: AppColors.textMuted)),
      const SizedBox(height: 6),
      Wrap(
        spacing: 8,
        runSpacing: 4,
        children: categories.map((cat) {
          final isSelected = selected.contains(cat.id);
          return FilterChip(
            label: Text(cat.name, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12)),
            selected: isSelected,
            selectedColor: AppColors.primary.withValues(alpha: 0.2),
            checkmarkColor: AppColors.primary,
            onSelected: (_) {
              final updated = List<int>.from(selected);
              if (isSelected) {
                updated.remove(cat.id);
              } else {
                updated.add(cat.id);
              }
              onChanged(updated);
            },
          );
        }).toList(),
      ),
    ]);
  }
}
