// lib/features/checkout/screens/moncash_webview_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../payments/repositories/payment_repository.dart';

class MonCashWebViewScreen extends StatefulWidget {
  final String redirectUrl;
  final int orderId;

  const MonCashWebViewScreen({super.key, required this.redirectUrl, required this.orderId});

  @override
  State<MonCashWebViewScreen> createState() => _MonCashWebViewScreenState();
}

class _MonCashWebViewScreenState extends State<MonCashWebViewScreen> {
  late final WebViewController _ctrl;
  bool _isLoading = true;
  bool _paymentHandled = false;

  @override
  void initState() {
    super.initState();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => _isLoading = true),
        onPageFinished: (_) => setState(() => _isLoading = false),
        onNavigationRequest: (req) {
          final url = req.url.toLowerCase();
          if (!_paymentHandled) {
            if (url.contains('success') || url.contains('thank')) {
              _paymentHandled = true;
              // Extract transactionId from URL query params (MonCash returns it here)
              final uri = Uri.tryParse(req.url);
              final transactionId = uri?.queryParameters['transactionId'] ??
                  uri?.queryParameters['transaction_id'];
              _verifyPayment(transactionId: transactionId);
              return NavigationDecision.prevent;
            }
            if (url.contains('cancel') || url.contains('error')) {
              _paymentHandled = true;
              Fluttertoast.showToast(msg: 'Le paiement a été annulé.');
              if (mounted) context.pop();
              return NavigationDecision.prevent;
            }
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  Future<void> _verifyPayment({String? transactionId}) async {
    try {
      final ok = await PaymentRepository().verify(orderId: widget.orderId, transactionId: transactionId);
      if (ok) {
        Fluttertoast.showToast(msg: 'Paiement confirmé !');
        if (mounted) context.go('/orders/${widget.orderId}');
      } else {
        Fluttertoast.showToast(msg: 'Paiement en attente de confirmation.');
        if (mounted) context.go('/orders/${widget.orderId}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur de vérification du paiement.');
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paiement MonCash'),
          leading: const SizedBox(),
          actions: [
            TextButton(
              onPressed: () {
                Fluttertoast.showToast(msg: 'Paiement annulé');
                context.pop();
              },
              child: const Text('Annuler', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _ctrl),
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
