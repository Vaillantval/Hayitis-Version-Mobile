// lib/features/orders/screens/order_tracking_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/order_tracking.dart';
import '../repositories/order_repository.dart';

class OrderTrackingScreen extends ConsumerStatefulWidget {
  final String? initialId;
  final String? initialEmail;

  const OrderTrackingScreen({super.key, this.initialId, this.initialEmail});

  @override
  ConsumerState<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends ConsumerState<OrderTrackingScreen> {
  final _idCtrl    = TextEditingController();
  final _emailCtrl = TextEditingController();
  OrderTracking? _tracking;
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialId != null) _idCtrl.text = widget.initialId!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Pre-fill email from logged-in user or initialEmail param
      final userEmail = ref.read(authProvider).profile?.email;
      final email = widget.initialEmail ?? userEmail ?? '';
      if (email.isNotEmpty) _emailCtrl.text = email;
      if (widget.initialId != null && email.isNotEmpty) _track();
    });
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _track() async {
    final id    = int.tryParse(_idCtrl.text.trim());
    final email = _emailCtrl.text.trim();
    if (id == null || email.isEmpty) {
      Fluttertoast.showToast(msg: 'Veuillez entrer un numéro de commande');
      return;
    }
    setState(() { _isLoading = true; _hasSearched = true; });
    try {
      final tracking = await OrderRepository().trackOrder(id, email);
      setState(() => _tracking = tracking);
    } catch (e) {
      setState(() => _tracking = null);
      Fluttertoast.showToast(msg: 'Commande introuvable. Vérifiez le numéro.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(authProvider).isLoggedIn;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Suivre ma commande')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Formulaire ─────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Entrez les informations de votre commande',
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 16),

                // Numéro de commande — éditable
                TextFormField(
                  controller: _idCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Numéro de commande',
                    hintText: 'Ex : 42',
                    helperText: 'Tapez votre numéro de commande ici',
                    helperStyle: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.receipt_long_outlined),
                    suffixIcon: const Tooltip(
                      message: 'Modifiable',
                      child: Icon(Icons.edit_outlined, size: 16, color: AppColors.textMuted),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                  ),
                ),
                const SizedBox(height: 14),

                // Email — pré-rempli, non éditable si connecté
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: isLoggedIn,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    suffixIcon: isLoggedIn
                        ? const Tooltip(
                            message: 'Email associé à votre compte',
                            child: Icon(Icons.lock_outline, size: 16, color: AppColors.textMuted),
                          )
                        : null,
                    filled: true,
                    fillColor: isLoggedIn ? const Color(0xFFF0F4F8) : const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isLoggedIn ? const Color(0xFFE2E8F0) : AppColors.primary, width: isLoggedIn ? 1 : 2)),
                  ),
                ),
                const SizedBox(height: 20),

                // Bouton animé
                _AnimatedSearchButton(onPressed: _track, isLoading: _isLoading),
              ]),
            ),

            // ── Résultat ───────────────────────────────────────────
            if (_hasSearched && !_isLoading && _tracking != null) ...[
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Commande #${_tracking!.id}',
                        style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 16)),
                    OrderStatusBadge(status: _tracking!.status),
                  ]),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  _TrackRow(Icons.local_shipping_outlined, 'Transporteur', _tracking!.carrierName),
                  _TrackRow(Icons.location_on_outlined, 'Adresse', _tracking!.shippingAddress),
                  _TrackRow(Icons.shopping_bag_outlined, 'Articles', '${_tracking!.itemsCount}'),
                  _TrackRow(Icons.attach_money, 'Total', formatPrice(_tracking!.orderCostTtc, 'HTG')),
                  _TrackRow(_tracking!.isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
                      'Paiement', _tracking!.isPaid ? 'Confirmé' : 'En attente'),
                  const SizedBox(height: 16),
                  const Text('Progression', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 12),
                  ..._buildTimeline(_tracking!.status),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeline(String status) {
    final steps  = ['pending', 'processing', 'shipped', 'delivered'];
    final labels = ['Reçue', 'En traitement', 'Expédiée', 'Livrée'];
    final icons  = [Icons.inbox_outlined, Icons.settings_outlined, Icons.local_shipping_outlined, Icons.home_outlined];
    final currentIndex = steps.indexOf(status);

    return List.generate(steps.length, (i) {
      final isDone   = i <= currentIndex;
      final isActive = i == currentIndex;
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: isDone ? AppColors.primary : const Color(0xFFF0F4F8),
              shape: BoxShape.circle,
              border: isActive ? Border.all(color: AppColors.primary, width: 2) : null,
            ),
            child: Icon(isDone ? Icons.check : icons[i], size: 16,
                color: isDone ? Colors.white : AppColors.textMuted),
          ),
          if (i < steps.length - 1)
            Container(width: 2, height: 32,
                color: i < currentIndex ? AppColors.primary.withValues(alpha: 0.3) : const Color(0xFFF0F4F8)),
        ]),
        const SizedBox(width: 14),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: i < steps.length - 1 ? 32 : 0),
          child: Text(labels[i], style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: isActive ? FontWeight.w700 : (isDone ? FontWeight.w600 : FontWeight.w400),
            color: isDone ? AppColors.dark : AppColors.textMuted,
            fontSize: isActive ? 14 : 13,
          )),
        ),
      ]);
    });
  }
}

// ── Animated search button ────────────────────────────────────────────────────

class _AnimatedSearchButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const _AnimatedSearchButton({required this.onPressed, required this.isLoading});

  @override
  State<_AnimatedSearchButton> createState() => _AnimatedSearchButtonState();
}

class _AnimatedSearchButtonState extends State<_AnimatedSearchButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.03)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _glow = Tween<double>(begin: 4.0, end: 14.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.scale(
        scale: widget.isLoading ? 1.0 : _scale.value,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: widget.isLoading ? [] : [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: _glow.value,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: widget.isLoading ? null : widget.onPressed,
              icon: widget.isLoading
                  ? const SizedBox(width: 18, height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.search_rounded, size: 20),
              label: Text(
                widget.isLoading ? 'Recherche...' : 'Rechercher ma commande',
                style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Row helpers ───────────────────────────────────────────────────────────────

class _TrackRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _TrackRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(children: [
      Icon(icon, size: 16, color: AppColors.textMuted),
      const SizedBox(width: 8),
      Text('$label : ', style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 13)),
      Expanded(
        child: Text(value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 13)),
      ),
    ]),
  );
}
