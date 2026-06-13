// lib/core/cache/cache_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const int _ttlMs = 30 * 60 * 1000; // 30 minutes

  static Future<void> save(String key, String jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode({
      'data': jsonData,
      'ts': DateTime.now().millisecondsSinceEpoch,
    }));
  }

  /// Returns cached data. If [allowStale] is true (default), returns even if expired.
  static Future<String?> load(String key, {bool allowStale = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final ts = map['ts'] as int;
      final age = DateTime.now().millisecondsSinceEpoch - ts;
      if (!allowStale && age > _ttlMs) return null;
      return map['data'] as String;
    } catch (_) {
      return null;
    }
  }
}
