// lib/features/misc/screens/faq_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/theme/app_colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late final WebViewController _ctrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) => setState(() => _isLoading = false),
      ))
      ..loadRequest(Uri.parse('https://hayitis.com/faq/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: Stack(children: [
        WebViewWidget(controller: _ctrl),
        if (_isLoading) const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ]),
    );
  }
}
