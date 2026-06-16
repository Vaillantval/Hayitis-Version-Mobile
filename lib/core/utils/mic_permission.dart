// lib/core/utils/mic_permission.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme/app_colors.dart';

/// Requests microphone permission once if it has never been decided yet.
/// Safe to call repeatedly (e.g. on every shell mount) — only shows the
/// system dialog when the status is still the default "denied" (undecided).
Future<void> requestMicPermissionOnEntry() async {
  final status = await Permission.microphone.status;
  if (status.isDenied) {
    await Permission.microphone.request();
  }
}

/// Ensures microphone permission is granted before recording.
/// Re-requests on every call if previously denied (Android reshows the
/// system dialog automatically unless permanently denied). Shows feedback
/// via [context] and returns whether recording can proceed.
Future<bool> ensureMicPermission(BuildContext context) async {
  var status = await Permission.microphone.status;

  if (!status.isGranted && !status.isPermanentlyDenied) {
    status = await Permission.microphone.request();
  }

  if (status.isGranted) return true;
  if (!context.mounted) return false;

  if (status.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Permission microphone refusée définitivement. Activez-la dans les paramètres de l'application."),
        backgroundColor: AppColors.error,
        action: SnackBarAction(label: 'Paramètres', textColor: Colors.white, onPressed: openAppSettings),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permission microphone refusée."), backgroundColor: AppColors.error),
    );
  }
  return false;
}
