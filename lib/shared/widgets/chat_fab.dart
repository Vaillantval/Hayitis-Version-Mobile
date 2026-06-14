import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ChatFab extends StatelessWidget {
  const ChatFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      tooltip: 'Contacter le support',
      onPressed: () => context.push('/community/support'),
      child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}
