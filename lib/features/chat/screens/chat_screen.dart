// lib/features/chat/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/config/app_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../../orders/providers/order_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final int? orderId; // null = mode général, non-null = mode commande

  const ChatScreen({super.key, this.orderId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final WebViewController _ctrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted : (_) => setState(() => _isLoading = true),
        onPageFinished: (url) async {
          setState(() => _isLoading = false);
          await _injectVisitor();
        },
      ))
      ..loadRequest(Uri.parse(AppConfig.tawkDirectChatLink));
  }

  /// Pré-remplit le nom et l'email du visiteur via l'API Tawk.to JS
  Future<void> _injectVisitor() async {
    final profile = ref.read(userProfileProvider);
    if (profile == null) return;

    String name = '${profile.firstName} ${profile.lastName}'.trim();

    // Mode commande : préfixe le n° de commande dans le nom
    if (widget.orderId != null) {
      final orderAsync = ref.read(orderDetailProvider(widget.orderId!));
      orderAsync.whenData((order) {
        name = '#${order.id} — $name';
      });
    }

    final email = profile.email;
    final js = '''
      if (typeof Tawk_API !== "undefined" && Tawk_API.setAttributes) {
        Tawk_API.setAttributes({
          name  : ${_jsString(name)},
          email : ${_jsString(email)}
        }, function(error) {});
      }
    ''';
    await _ctrl.runJavaScript(js);
  }

  /// Échappe une valeur pour insertion sûre dans un littéral JS
  String _jsString(String value) {
    final escaped = value
        .replaceAll(r'\', r'\\')
        .replaceAll("'", r"\'")
        .replaceAll('\n', r'\n');
    return "'$escaped'";
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = widget.orderId != null
        ? ref.watch(orderDetailProvider(widget.orderId!))
        : null;

    // Erreur chargement commande
    if (orderAsync != null && orderAsync.hasError) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 12),
              const Text(
                'Impossible de charger la commande',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(orderDetailProvider(widget.orderId!)),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.pop();
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            WebViewWidget(controller: _ctrl),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.support_agent, size: 20),
          SizedBox(width: 8),
          Text("Assistance Hayiti's"),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => context.pop(),
      ),
    );
  }
}
