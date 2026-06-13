// lib/shared/widgets/chat_fab.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ChatFab extends StatelessWidget {
  final int? orderId;
  const ChatFab({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      tooltip: 'Chat avec nous',
      onPressed: () {
        final route = orderId != null ? '/chat?orderId=$orderId' : '/chat';
        context.push(route);
      },
      child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}
