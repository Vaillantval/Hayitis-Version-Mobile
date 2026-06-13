import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/channel.dart';
import '../models/community_message.dart';
import '../models/community_notification.dart';
import '../models/direct_message.dart';

// Safely extracts a List from any API response shape:
// { "results": [...] }, { "data": [...] }, { "data": {"results": [...]} }, or raw [...]
List<dynamic> _extractList(dynamic data) {
  if (data is List) return data;
  if (data is Map<String, dynamic>) {
    final r = data['results'];
    if (r is List) return r;
    final d = data['data'];
    if (d is List) return d;
    if (d is Map<String, dynamic>) {
      final dr = d['results'];
      if (dr is List) return dr;
    }
  }
  return [];
}

class CommunityRepository {
  final Dio _dio = ApiClient.instance;

  Future<List<Channel>> getChannels() async {
    try {
      final r = await _dio.get(Endpoints.communityChannels);
      return _extractList(r.data)
          .map((e) => Channel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<List<CommunityMessage>> getMessages(String slug, {int? after, int? before}) async {
    try {
      final params = <String, dynamic>{};
      if (after  != null) params['after']  = after;
      if (before != null) params['before'] = before;
      final r = await _dio.get(
        Endpoints.communityMessages(slug),
        queryParameters: params.isEmpty ? null : params,
      );
      return _extractList(r.data)
          .map((e) => CommunityMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<CommunityMessage> postMessage(
    String slug, {
    required String content,
    int? replyToId,
    List<MultipartFile>? images,
  }) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (replyToId != null) 'reply_to': replyToId,
        if (images != null && images.isNotEmpty) 'images': images,
      });
      final r = await _dio.post(Endpoints.communityMessages(slug), data: formData);
      final root = r.data;
      final msgData = (root is Map<String, dynamic>)
          ? (root['data'] ?? root)
          : root;
      return CommunityMessage.fromJson(msgData as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> react(int pk, String emoji) async {
    try {
      final r = await _dio.post(Endpoints.communityReact(pk), data: {'emoji': emoji});
      return r.data as Map<String, dynamic>? ?? {};
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<void> deleteMessage(int pk) async {
    try {
      await _dio.delete(Endpoints.communityMessageAction(pk));
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<void> pinMessage(int pk) async {
    try {
      await _dio.post(Endpoints.communityMessageAction(pk));
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<bool> toggleSubscribe(String slug) async {
    try {
      final r = await _dio.post(Endpoints.communitySubscribe(slug));
      final root = r.data as Map<String, dynamic>? ?? {};
      return root['following'] as bool? ?? false;
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<({List<CommunityNotification> notifications, int unreadCount})> getNotifications() async {
    try {
      final r = await _dio.get(Endpoints.communityNotifications);
      final root = r.data as Map<String, dynamic>? ?? {};
      final list = _extractList(r.data);
      return (
        notifications: list.map((e) => CommunityNotification.fromJson(e as Map<String, dynamic>)).toList(),
        unreadCount: root['unread_count'] as int? ?? 0,
      );
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<void> markNotificationsRead({List<int>? ids}) async {
    try {
      await _dio.post(Endpoints.communityNotifications,
          data: ids != null ? {'ids': ids} : {'all': true});
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  // ── Support DM ──────────────────────────────────────────────────────────────

  Future<List<DirectMessage>> getSupportMessages({int? after, int? before}) async {
    try {
      final params = <String, dynamic>{};
      if (after  != null) params['after']  = after;
      if (before != null) params['before'] = before;
      final r = await _dio.get(
        Endpoints.communitySupport,
        queryParameters: params.isEmpty ? null : params,
      );
      return _extractList(r.data)
          .map((e) => DirectMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<DirectMessage> postSupportMessage(String content, {List<MultipartFile>? images}) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (images != null && images.isNotEmpty) 'images': images,
      });
      final r = await _dio.post(Endpoints.communitySupport, data: formData);
      final root = r.data as Map<String, dynamic>? ?? {};
      return DirectMessage.fromJson((root['data'] as Map<String, dynamic>?) ?? root);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<List<SupportConversation>> getSupportInbox() async {
    try {
      final r = await _dio.get(Endpoints.communitySupportInbox);
      return _extractList(r.data)
          .map((e) => SupportConversation.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<List<DirectMessage>> getConversationMessages(int convId, {int? after}) async {
    try {
      final params = after != null ? {'after': after} : null;
      final r = await _dio.get(
        Endpoints.communitySupportConversation(convId),
        queryParameters: params,
      );
      return _extractList(r.data)
          .map((e) => DirectMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }

  Future<DirectMessage> postConversationMessage(int convId, String content, {List<MultipartFile>? images}) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (images != null && images.isNotEmpty) 'images': images,
      });
      final r = await _dio.post(Endpoints.communitySupportConversation(convId), data: formData);
      final root = r.data as Map<String, dynamic>? ?? {};
      return DirectMessage.fromJson((root['data'] as Map<String, dynamic>?) ?? root);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {}, statusCode: e.response?.statusCode);
    }
  }
}

final communityRepositoryProvider = Provider<CommunityRepository>(
  (ref) => CommunityRepository(),
);
