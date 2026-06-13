// lib/features/checkout/screens/offline_confirm_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../orders/providers/order_provider.dart';
import '../../payments/repositories/payment_proof_repository.dart';

class OfflineConfirmScreen extends ConsumerStatefulWidget {
  final int orderId;
  const OfflineConfirmScreen({super.key, required this.orderId});

  @override
  ConsumerState<OfflineConfirmScreen> createState() => _OfflineConfirmScreenState();
}

class _OfflineConfirmScreenState extends ConsumerState<OfflineConfirmScreen> {
  File? _proofFile;
  bool _uploading = false;
  bool _uploaded = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 85, maxWidth: 1200);
    if (picked != null) {
      setState(() {
        _proofFile = File(picked.path);
        _uploaded = false;
      });
    }
  }

  void _showPickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2))),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFFF0F4FF),
                    child: Icon(Icons.camera_alt_outlined, color: AppColors.primary)),
                title: const Text('Prendre une photo', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                onTap: () { Navigator.pop(context); _pickImage(ImageSource.camera); },
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFFF0F4FF),
                    child: Icon(Icons.photo_library_outlined, color: AppColors.primary)),
                title: const Text('Choisir depuis la galerie', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                onTap: () { Navigator.pop(context); _pickImage(ImageSource.gallery); },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadProof() async {
    if (_proofFile == null) return;
    setState(() => _uploading = true);
    try {
      await PaymentProofRepository().uploadProof(orderId: widget.orderId, file: _proofFile!);
      setState(() { _uploaded = true; });
      ref.invalidate(orderDetailProvider(widget.orderId));
      Fluttertoast.showToast(msg: 'Preuve de paiement envoyée !');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de l\'envoi. Réessayez.');
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderDetailProvider(widget.orderId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Confirmation de commande'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          tooltip: 'Accueil',
          onPressed: () => context.go('/home'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/orders/${widget.orderId}'),
            icon: const Icon(Icons.receipt_long_outlined, size: 16, color: Colors.white),
            label: const Text('Mes commandes', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
      body: orderAsync.when(
        loading: () => _buildBody(context, null),
        error: (_, __) => _buildBody(context, null),
        data: (order) => _buildBody(context, order),
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic order) {
    final total = order != null ? order.orderCostTtc + order.carrierPrice : null;
    final paymentStatus = order?.paymentStatus as String? ?? 'unpaid';
    final proofSent = _uploaded || paymentStatus == 'proof_submitted' || paymentStatus == 'verified' || paymentStatus == 'paid';
    final verified  = paymentStatus == 'verified' || paymentStatus == 'paid';
    final shipped   = order?.status == 'shipped' || order?.status == 'delivered';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header statut ──────────────────────────────────────
          _StatusCard(orderId: widget.orderId, total: total, currency: 'HTG', paymentStatus: paymentStatus),

          const SizedBox(height: 20),

          // ── Étapes ─────────────────────────────────────────────
          _SectionCard(
            title: 'Suivi de votre commande',
            icon: Icons.timeline_outlined,
            child: Column(children: [
              _Step(number: 1, label: 'Commande enregistrée', sublabel: 'Votre commande a bien été reçue', done: true),
              _Step(number: 2, label: 'Preuve de paiement', sublabel: 'Envoyez votre reçu de transfert', done: proofSent, active: !proofSent),
              _Step(number: 3, label: 'Vérification admin', sublabel: 'Notre équipe valide votre paiement', done: verified, active: proofSent && !verified),
              _Step(number: 4, label: 'Expédition', sublabel: 'Votre commande est en route', done: shipped, isLast: true),
            ]),
          ),

          const SizedBox(height: 20),

          // ── Instructions de paiement ───────────────────────────
          _SectionCard(
            title: 'Instructions de paiement',
            icon: Icons.info_outline,
            iconColor: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Effectuez votre paiement via MonCash ou NatCash au numéro suivant :',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: AppColors.textMuted),
                ),
                const SizedBox(height: 16),
                _InfoTile(icon: Icons.phone_android, label: 'Numéro MonCash / NatCash', value: '+509 XXXX-XXXX'),
                const SizedBox(height: 8),
                _InfoTile(icon: Icons.person_outline, label: 'Nom du bénéficiaire', value: "Hayiti's"),
                const SizedBox(height: 8),
                if (total != null)
                  _InfoTile(
                    icon: Icons.attach_money,
                    label: 'Montant exact à envoyer',
                    value: formatPrice(total, 'HTG'),
                    highlight: true,
                  ),
                const SizedBox(height: 8),
                _InfoTile(icon: Icons.tag, label: 'Référence', value: 'Commande #${widget.orderId}'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Mentionnez la référence "Commande #" dans le motif du transfert.',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.warning),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Upload preuve ──────────────────────────────────────
          if (!verified) _SectionCard(
            title: 'Preuve de paiement',
            icon: Icons.upload_file_outlined,
            iconColor: AppColors.success,
            child: Column(
              children: [
                if (!_uploaded) ...[
                  const Text(
                    'Envoyez une capture d\'écran ou photo de votre reçu de transfert.',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 16),
                  _proofFile == null
                      ? _UploadZone(onTap: _showPickerSheet)
                      : _ImagePreview(file: _proofFile!, onRemove: () => setState(() => _proofFile = null)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: _uploading
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.send_rounded, size: 18),
                      label: Text(_proofFile == null ? 'Sélectionner une preuve' : 'Envoyer la preuve',
                          style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                      onPressed: _uploading ? null : (_proofFile == null ? _showPickerSheet : _uploadProof),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _proofFile == null ? AppColors.dark : AppColors.success,
                        minimumSize: const Size(0, 52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                    ),
                    child: Row(children: [
                      const CircleAvatar(radius: 20, backgroundColor: AppColors.success,
                          child: Icon(Icons.check, color: Colors.white, size: 20)),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Preuve envoyée !', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: AppColors.success)),
                          Text('Notre équipe va valider votre paiement sous peu.', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.textMuted)),
                        ]),
                      ),
                    ]),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ── Actions ────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/orders/${widget.orderId}'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Voir ma commande', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/home'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 48),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Retour à l\'accueil', style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Composants ─────────────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final int orderId;
  final double? total;
  final String currency;
  final String paymentStatus;
  const _StatusCard({required this.orderId, this.total, required this.currency, required this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    final (icon, label, gradient) = switch (paymentStatus) {
      'proof_submitted' => (Icons.hourglass_bottom_rounded, 'Preuve envoyée — en vérification',
          [const Color(0xFF1565C0), const Color(0xFF1E88E5)]),
      'verified' => (Icons.verified_rounded, 'Paiement vérifié !',
          [const Color(0xFF1B5E20), const Color(0xFF43A047)]),
      'paid' => (Icons.check_circle_rounded, 'Paiement confirmé !',
          [const Color(0xFF1B5E20), const Color(0xFF43A047)]),
      _ => (Icons.hourglass_top_rounded, 'Commande enregistrée !',
          [const Color(0xFF1A1A2E), const Color(0xFF374151)]),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(30)),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 16),
        Text(label,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
            textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text('Commande #$orderId',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: Colors.white.withValues(alpha: 0.7))),
        if (total != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(30)),
            child: Text(formatPrice(total!, currency),
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
          ),
        ],
      ]),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Widget child;
  const _SectionCard({required this.title, required this.icon, this.iconColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(children: [
              Icon(icon, size: 18, color: iconColor ?? AppColors.textMuted),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600)),
            ]),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final int number;
  final String label;
  final String sublabel;
  final bool done;
  final bool active;
  final bool isLast;
  const _Step({required this.number, required this.label, required this.sublabel,
      this.done = false, this.active = false, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final color = done ? AppColors.success : active ? AppColors.primary : const Color(0xFFE2E8F0);
    final textColor = done || active ? AppColors.textPrimary : AppColors.textMuted;

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 32, height: 32,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: done
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text('$number', style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w700,
                    color: active ? Colors.white : AppColors.textMuted)),
          ),
        ),
        if (!isLast)
          Container(width: 2, height: 36, color: done ? AppColors.success.withValues(alpha: 0.3) : const Color(0xFFF0F0F0)),
      ]),
      const SizedBox(width: 14),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 6, bottom: isLast ? 0 : 36),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w600, color: textColor)),
            const SizedBox(height: 2),
            Text(sublabel, style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted)),
          ]),
        ),
      ),
    ]);
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlight;
  const _InfoTile({required this.icon, required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlight ? AppColors.primary.withValues(alpha: 0.06) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: highlight ? Border.all(color: AppColors.primary.withValues(alpha: 0.2)) : null,
      ),
      child: Row(children: [
        Icon(icon, size: 18, color: highlight ? AppColors.primary : AppColors.textMuted),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, color: AppColors.textMuted)),
            const SizedBox(height: 2),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(value, style: TextStyle(fontFamily: 'Poppins', fontSize: 14,
                  fontWeight: highlight ? FontWeight.w700 : FontWeight.w600,
                  color: highlight ? AppColors.primary : AppColors.textPrimary)),
              if (highlight)
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    Fluttertoast.showToast(msg: 'Copié !');
                  },
                  child: const Icon(Icons.copy_rounded, size: 16, color: AppColors.primary),
                ),
            ]),
          ]),
        ),
      ]),
    );
  }
}

class _UploadZone extends StatelessWidget {
  final VoidCallback onTap;
  const _UploadZone({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5,
              style: BorderStyle.solid),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(24)),
            child: const Icon(Icons.add_photo_alternate_outlined, color: AppColors.primary, size: 26),
          ),
          const SizedBox(height: 10),
          const Text('Appuyez pour ajouter une photo',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          const Text('JPG, PNG — max 5 Mo',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: AppColors.textMuted)),
        ]),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  const _ImagePreview({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(file, width: double.infinity, height: 200, fit: BoxFit.cover),
      ),
      Positioned(
        top: 8, right: 8,
        child: GestureDetector(
          onTap: onRemove,
          child: Container(
            width: 32, height: 32,
            decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
            child: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
        ),
      ),
    ]);
  }
}
