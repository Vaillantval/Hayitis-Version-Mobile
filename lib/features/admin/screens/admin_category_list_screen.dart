// lib/features/admin/screens/admin_category_list_screen.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../products/models/category.dart';
import '../repositories/admin_repository.dart';
import 'admin_shell_screen.dart';

class AdminCategoryListScreen extends StatefulWidget {
  const AdminCategoryListScreen({super.key});

  @override
  State<AdminCategoryListScreen> createState() => _AdminCategoryListScreenState();
}

class _AdminCategoryListScreenState extends State<AdminCategoryListScreen> {
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final cats = await AdminRepository().getAdminCategories();
      setState(() => _categories = cats);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmDelete(Category cat) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supprimer la catégorie', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
        content: Text('Supprimer « ${cat.name} » ? Cette action est irréversible.', style: const TextStyle(fontFamily: 'Poppins')),
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
      await AdminRepository().deleteAdminCategory(cat.id);
      setState(() => _categories.removeWhere((c) => c.id == cat.id));
      Fluttertoast.showToast(msg: 'Catégorie supprimée');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void _showForm({Category? existing}) {
    showDialog(
      context: context,
      builder: (_) => _CategoryFormDialog(
        existing: existing,
        onSaved: _load,
      ),
    );
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
        title: const Text('Catégories'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _categories.isEmpty
              ? const Center(
                  child: Text('Aucune catégorie', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  color: AppColors.primary,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final cat = _categories[i];
                      final imgUrl = cat.image == null
                          ? null
                          : cat.image!.startsWith('http')
                              ? cat.image
                              : 'https://hayitis.com${cat.image}';
                      return Dismissible(
                        key: ValueKey(cat.id),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          await _confirmDelete(cat);
                          return false; // We handle the removal ourselves
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delete_outline, color: Colors.white),
                        ),
                        child: Card(
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: imgUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: imgUrl,
                                      width: 48, height: 48,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) => Container(
                                        width: 48, height: 48,
                                        color: const Color(0xFFE2E8F0),
                                        child: const Icon(Icons.category, size: 24),
                                      ),
                                    )
                                  : Container(
                                      width: 48, height: 48,
                                      color: const Color(0xFFE2E8F0),
                                      child: const Icon(Icons.category, size: 24),
                                    ),
                            ),
                            title: Text(cat.name, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            subtitle: Text(cat.slug, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.textMuted)),
                            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                                onPressed: () => _showForm(existing: cat),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: () => _confirmDelete(cat),
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

class _CategoryFormDialog extends StatefulWidget {
  final Category? existing;
  final VoidCallback onSaved;
  const _CategoryFormDialog({this.existing, required this.onSaved});

  @override
  State<_CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<_CategoryFormDialog> {
  final _nameCtrl = TextEditingController();
  String? _imagePath;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      _nameCtrl.text = widget.existing!.name;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _imagePath = img.path);
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Le nom est requis');
      return;
    }
    setState(() => _isSaving = true);
    try {
      final repo = AdminRepository();
      if (widget.existing != null) {
        await repo.updateAdminCategory(
          widget.existing!.id,
          {'name': name},
          imagePath: _imagePath,
        );
        Fluttertoast.showToast(msg: 'Catégorie modifiée');
      } else {
        await repo.createAdminCategory({'name': name}, imagePath: _imagePath);
        Fluttertoast.showToast(msg: 'Catégorie créée');
      }
      if (mounted) Navigator.pop(context);
      widget.onSaved();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.existing != null ? 'Modifier la catégorie' : 'Nouvelle catégorie',
        style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: _nameCtrl,
          decoration: InputDecoration(
            labelText: 'Nom',
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image_outlined),
          label: Text(
            _imagePath != null ? 'Image sélectionnée ✓' : 'Choisir une image (optionnel)',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 44)),
        ),
      ]),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _save,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: _isSaving
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text(widget.existing != null ? 'Modifier' : 'Créer', style: const TextStyle(fontFamily: 'Poppins')),
        ),
      ],
    );
  }
}
