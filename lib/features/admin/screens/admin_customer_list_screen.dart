// lib/features/admin/screens/admin_customer_list_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../auth/models/user_profile.dart';
import '../repositories/admin_repository.dart';
import 'admin_shell_screen.dart';

class AdminCustomerListScreen extends StatefulWidget {
  const AdminCustomerListScreen({super.key});

  @override
  State<AdminCustomerListScreen> createState() => _AdminCustomerListScreenState();
}

class _AdminCustomerListScreenState extends State<AdminCustomerListScreen> {
  List<UserProfile> _customers = [];
  bool _isLoading = true;
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
      final customers = await AdminRepository().getCustomers();
      setState(() => _customers = customers);
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

  List<UserProfile> get _filtered {
    if (_search.isEmpty) return _customers;
    final q = _search.toLowerCase();
    return _customers.where((c) =>
      c.username.toLowerCase().contains(q) ||
      c.email.toLowerCase().contains(q) ||
      '${c.firstName} ${c.lastName}'.toLowerCase().contains(q)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => AdminShellScreen.scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('Clients'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Rechercher (nom ou email)...',
              prefixIcon: const Icon(Icons.search),
              filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : filtered.isEmpty
                  ? const Center(child: Text('Aucun client', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)))
                  : RefreshIndicator(
                      onRefresh: _load,
                      color: AppColors.primary,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final c = filtered[i];
                          final initials = c.firstName.isNotEmpty
                              ? '${c.firstName[0]}${c.lastName.isNotEmpty ? c.lastName[0] : ''}'.toUpperCase()
                              : c.username.isNotEmpty ? c.username[0].toUpperCase() : '?';
                          final displayName = '${c.firstName} ${c.lastName}'.trim().isEmpty ? c.username : '${c.firstName} ${c.lastName}';
                          return Card(child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              child: Text(initials, style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                            ),
                            title: Text(displayName, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            subtitle: Text(c.email, style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 12)),
                            trailing: Text(formatDate(c.dateJoined), style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted)),
                            onTap: () => context.push('/admin/customers/${c.id}'),
                          ));
                        },
                      ),
                    ),
        ),
      ]),
    );
  }
}
