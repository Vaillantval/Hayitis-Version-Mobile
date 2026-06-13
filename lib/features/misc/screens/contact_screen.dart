// lib/features/misc/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/theme/app_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
      ..loadRequest(Uri.parse('https://hayitis.com/contact/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Stack(children: [
        WebViewWidget(controller: _ctrl),
        if (_isLoading) const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ]),
    );
  }
}
