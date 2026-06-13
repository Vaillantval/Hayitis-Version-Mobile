// lib/features/checkout/screens/checkout_screen.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/utils/price_formatter.dart';
import '../../addresses/models/address.dart' as app_address;
import '../../addresses/providers/address_provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../orders/repositories/order_repository.dart';
import '../../payments/repositories/payment_repository.dart';
import '../providers/checkout_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _pageCtrl = PageController();
  final _streetCtrl   = TextEditingController();
  final _cityCtrl     = TextEditingController();
  final _departCtrl   = TextEditingController();
  final _notesCtrl    = TextEditingController();
  String?             _selectedMethod;
  app_address.Address? _selectedAddress;

  @override
  void dispose() {
    _pageCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _departCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    final cart = ref.read(cartProvider).valueOrNull;
    if (cart == null) return;

    ref.read(checkoutProvider.notifier).setLoading(true);
    try {
      final items = cart.items.map((i) => {'product_id': i.product.id, 'quantity': i.quantity}).toList();
      final order = await OrderRepository().createOrder(
        items: items,
        paymentMethod: _selectedMethod!,
        deliveryAddress: {
          'street':     _selectedAddress?.street     ?? _streetCtrl.text.trim(),
          'city':       _selectedAddress?.city       ?? _cityCtrl.text.trim(),
          'department': _selectedAddress?.codePostal ?? _departCtrl.text.trim(),
        },
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      );

      ref.read(checkoutProvider.notifier).setOrderId(order.id);

      switch (_selectedMethod) {
        case 'stripe':
          final payInit = await PaymentRepository().initiate(orderId: order.id, method: 'stripe');
          if (payInit.clientSecret != null) {
            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: payInit.clientSecret!,
                merchantDisplayName: "Hayiti's",
              ),
            );
            await Stripe.instance.presentPaymentSheet();
            await PaymentRepository().verify(orderId: order.id);
            Fluttertoast.showToast(msg: 'Paiement réussi !');
            if (mounted) context.go('/orders/${order.id}');
          }
          break;

        case 'moncash':
          final payInit = await PaymentRepository().initiate(orderId: order.id, method: 'moncash');
          if (payInit.redirectUrl != null && mounted) {
            context.push('/checkout/moncash?url=${Uri.encodeComponent(payInit.redirectUrl!)}&orderId=${order.id}');
          }
          break;

        case 'offline':
          if (mounted) context.push('/checkout/offline-confirm?orderId=${order.id}');
          break;

        default:
          Fluttertoast.showToast(msg: 'Commande passée. Nous vous contacterons pour le paiement.');
          if (mounted) context.go('/orders/${order.id}');
      }
    } catch (e, st) {
      debugPrint('_placeOrder error: $e\n$st');
      Fluttertoast.showToast(
        msg: e.toString().replaceAll('Exception: ', ''),
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      ref.read(checkoutProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkout = ref.watch(checkoutProvider);
    final cart = ref.watch(cartProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Commander')),
      body: Column(
        children: [
          // Stepper indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) => Row(children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: checkout.step >= i ? AppColors.primary : const Color(0xFFE2E8F0),
                  child: Text('${i + 1}', style: TextStyle(color: checkout.step >= i ? Colors.white : AppColors.textMuted, fontSize: 12)),
                ),
                if (i < 3) Container(width: 40, height: 2, color: checkout.step > i ? AppColors.primary : const Color(0xFFE2E8F0)),
              ])),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Étape 1 — Méthode de paiement
                _buildPaymentStep(),
                // Étape 2 — Adresse
                _buildAddressStep(),
                // Étape 3 — Livraison
                _buildDeliveryStep(),
                // Étape 4 — Confirmation
                _buildConfirmStep(cart),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    final methods = [
      // ('stripe',  'Stripe',       Icons.credit_card,  Colors.blue),
      ('moncash', 'MonCash',      Icons.phone_android, AppColors.moncash),
      // ('natcash', 'NatCash',      Icons.phone_android, Colors.green),
      ('offline', 'Paiement Hors Ligne', Icons.receipt_long, const Color(0xFF374151)),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Méthode de paiement', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...methods.map((m) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: RadioListTile<String>(
              value: m.$1,
              groupValue: _selectedMethod,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _selectedMethod = v),
              title: Row(children: [
                Icon(m.$3, color: m.$4),
                const SizedBox(width: 8),
                Text(m.$2, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
              ]),
            ),
          )),
          const SizedBox(height: 24),
          CustomButton(
            label: 'Continuer',
            onPressed: _selectedMethod == null ? null : () {
              ref.read(checkoutProvider.notifier).setPaymentMethod(_selectedMethod!);
              _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressStep() {
    final addressAsync = ref.watch(addressProvider);
    void goBack() {
      ref.read(checkoutProvider.notifier).previousStep();
      _pageCtrl.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

    return addressAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Adresse de livraison', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          TextFormField(controller: _streetCtrl, decoration: _inputDeco('Rue / Adresse')),
          const SizedBox(height: 12),
          TextFormField(controller: _cityCtrl, decoration: _inputDeco('Ville')),
          const SizedBox(height: 12),
          TextFormField(controller: _departCtrl, decoration: _inputDeco('Département (ex: Ouest)')),
          const SizedBox(height: 24),
          CustomButton(label: 'Continuer', onPressed: () {
            if (_streetCtrl.text.isEmpty || _cityCtrl.text.isEmpty || _departCtrl.text.isEmpty) {
              Fluttertoast.showToast(msg: 'Veuillez remplir tous les champs');
              return;
            }
            ref.read(checkoutProvider.notifier).setDeliveryAddress({
              'street': _streetCtrl.text, 'city': _cityCtrl.text, 'department': _departCtrl.text,
            });
            _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }),
          const SizedBox(height: 12),
          _BackButton(onPressed: goBack),
        ]),
      ),
      data: (addresses) {
        // Pré-sélectionner l'adresse par défaut au premier rendu
        if (_selectedAddress == null && addresses.isNotEmpty) {
          _selectedAddress = addresses.firstWhere(
            (a) => a.isDefault,
            orElse: () => addresses.first,
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Adresse de livraison', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),

              if (addresses.isEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)]),
                  child: Column(children: [
                    const Icon(Icons.location_off_outlined, size: 48, color: AppColors.textMuted),
                    const SizedBox(height: 12),
                    const Text('Aucune adresse enregistrée',
                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 6),
                    const Text('Ajoutez une adresse de livraison pour continuer.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted, fontSize: 13)),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_location_alt_outlined),
                        label: const Text('Ajouter une adresse', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                        onPressed: () => context.push('/profile/addresses/new'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(0, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ] else ...[
                ...addresses.map((addr) => GestureDetector(
                  onTap: () => setState(() => _selectedAddress = addr),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedAddress?.id == addr.id ? AppColors.primary : const Color(0xFFE2E8F0),
                        width: _selectedAddress?.id == addr.id ? 2 : 1,
                      ),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
                    ),
                    child: RadioListTile<int>(
                      value: addr.id,
                      groupValue: _selectedAddress?.id,
                      activeColor: AppColors.primary,
                      onChanged: (_) => setState(() => _selectedAddress = addr),
                      title: Row(children: [
                        Expanded(
                          child: Text(addr.name,
                              style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 14)),
                        ),
                        if (addr.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('Par défaut',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 10,
                                    color: AppColors.primary, fontWeight: FontWeight.w600)),
                          ),
                      ]),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(height: 2),
                        Text(addr.street, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.textMuted)),
                        Text('${addr.city}${addr.codePostal.isNotEmpty ? ' • ${addr.codePostal}' : ''}',
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.textMuted)),
                      ]),
                    ),
                  ),
                )),
                TextButton.icon(
                  icon: const Icon(Icons.add_location_alt_outlined, size: 18),
                  label: const Text('Ajouter une nouvelle adresse',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 13)),
                  onPressed: () => context.push('/profile/addresses/new'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],

              const SizedBox(height: 16),
              CustomButton(
                label: 'Continuer',
                onPressed: _selectedAddress == null ? null : () {
                  ref.read(checkoutProvider.notifier).setDeliveryAddress({
                    'street':     _selectedAddress!.street,
                    'city':       _selectedAddress!.city,
                    'department': _selectedAddress!.codePostal,
                  });
                  _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
              ),
              const SizedBox(height: 12),
              _BackButton(onPressed: goBack),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeliveryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mode de livraison', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text('Les options de livraison seront disponibles prochainement. Veuillez indiquer vos préférences dans les notes.',
              style: TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
          const SizedBox(height: 16),
          TextFormField(controller: _notesCtrl, maxLines: 4, decoration: _inputDeco('Notes de livraison (optionnel)')),
          const SizedBox(height: 24),
          CustomButton(
            label: 'Continuer',
            onPressed: () {
              ref.read(checkoutProvider.notifier).setDeliveryNotes(_notesCtrl.text);
              _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
          const SizedBox(height: 12),
          _BackButton(onPressed: () {
            ref.read(checkoutProvider.notifier).previousStep();
            _pageCtrl.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }),
        ],
      ),
    );
  }

  Widget _buildConfirmStep(cart) {
    final checkout = ref.watch(checkoutProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Récapitulatif', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Card(child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _InfoRow('Paiement', checkout.paymentMethod?.toUpperCase() ?? '-'),
              _InfoRow('Adresse', '${checkout.deliveryAddress?['street']}, ${checkout.deliveryAddress?['city']}'),
              if (cart != null) ...[
                const Divider(),
                _InfoRow('Articles', '${cart.totalItems}'),
                _InfoRow('Sous-total HT', formatPrice(cart.subtotalHt, cart.currency)),
                _InfoRow('Taxes', formatPrice(cart.taxAmount, cart.currency)),
                _InfoRow('Total TTC', formatPrice(cart.subtotalTtc, cart.currency), isBold: true),
              ],
            ]),
          )),
          const SizedBox(height: 24),
          CustomButton(
            label: 'Confirmer et payer',
            onPressed: checkout.isLoading ? null : _placeOrder,
            isLoading: checkout.isLoading,
          ),
          const SizedBox(height: 12),
          _BackButton(onPressed: checkout.isLoading ? null : () {
            ref.read(checkoutProvider.notifier).previousStep();
            _pageCtrl.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
  );
}

class _BackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _BackButton({this.onPressed});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 48,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
      label: const Text('Précédent', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textMuted,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _InfoRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Poppins', color: AppColors.textMuted)),
          Text(value, style: TextStyle(fontFamily: 'Poppins', fontWeight: isBold ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
