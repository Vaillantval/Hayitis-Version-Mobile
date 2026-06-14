import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> urls;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.urls,
    this.initialIndex = 0,
  });

  static void show(BuildContext context, List<String> urls, {int initialIndex = 0}) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, __, ___) => FullScreenImageViewer(urls: urls, initialIndex: initialIndex),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late final PageController _pageCtrl;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageCtrl = PageController(initialPage: widget.initialIndex);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: widget.urls.length > 1
            ? Text(
                '${_currentIndex + 1} / ${widget.urls.length}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              )
            : null,
      ),
      body: PageView.builder(
        controller: _pageCtrl,
        itemCount: widget.urls.length,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (_, i) => InteractiveViewer(
          minScale: 0.8,
          maxScale: 5.0,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.urls[i],
              fit: BoxFit.contain,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator(color: Colors.white54)),
              errorWidget: (_, __, ___) =>
                  const Icon(Icons.broken_image_outlined, color: Colors.white38, size: 72),
            ),
          ),
        ),
      ),
      // Dot indicators for multiple images
      bottomNavigationBar: widget.urls.length > 1
          ? Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.urls.length, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: i == _currentIndex ? 16 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: i == _currentIndex ? Colors.white : Colors.white38,
                    borderRadius: BorderRadius.circular(3),
                  ),
                )),
              ),
            )
          : null,
    );
  }
}
