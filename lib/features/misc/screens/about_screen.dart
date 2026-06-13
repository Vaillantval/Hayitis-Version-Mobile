// lib/features/misc/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/theme/app_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
      ..loadRequest(Uri.parse('https://hayitis.com/about/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: Stack(children: [
        WebViewWidget(controller: _ctrl),
        if (_isLoading) const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ]),
    );
  }
}
