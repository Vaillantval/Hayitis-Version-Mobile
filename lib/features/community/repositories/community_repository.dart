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
// { "results": [...] }, { "data": [...] }, { "data": {"results": [...]} },
// { "messages": [...] }, or raw [...]
List<dynamic> _extractList(dynamic data) {
  if (data is List) return data;
  if (data is Map<String, dynamic>) {
    final r = data['results'];
    if (r is List) return r;
    final m = data['messages'];
    if (m is List) return m;
    final d = data['data'];
    if (d is List) return d;
    if (d is Map<String, dynamic>) {
      final dr = d['results'];
      if (dr is List) return dr;
    }
  }
  return [];
}

ApiException _toApiException(DioException e) {
  final d = e.response?.data;
  return ApiException.fromJson(d is Map<String, dynamic> ? d : {}, statusCode: e.response?.statusCode);
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
      throw _toApiException(e);
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
      throw _toApiException(e);
    }
  }

  Future<CommunityMessage> postMessage(
    String slug, {
    required String content,
    int? replyToId,
    List<MultipartFile>? images,
    MultipartFile? audio,
    int? audioDuration,
  }) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (replyToId != null) 'reply_to': replyToId,
        if (images != null && images.isNotEmpty) 'images': images,
        if (audio != null) 'audio': audio,
        if (audio != null) 'audio_duration': audioDuration ?? 0,
      });
      final r = await _dio.post(Endpoints.communityMessages(slug), data: formData);
      final root = r.data;
      final msgData = (root is Map<String, dynamic>)
          ? (root['data'] ?? root)
          : root;
      return CommunityMessage.fromJson(msgData as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<Map<String, dynamic>> react(int pk, String emoji) async {
    try {
      final r = await _dio.post(Endpoints.communityReact(pk), data: {'emoji': emoji});
      return r.data as Map<String, dynamic>? ?? {};
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> deleteMessage(int pk) async {
    try {
      await _dio.delete(Endpoints.communityMessageAction(pk));
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> pinMessage(int pk) async {
    try {
      await _dio.post(Endpoints.communityMessageAction(pk));
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<bool> toggleSubscribe(String slug) async {
    try {
      final r = await _dio.post(Endpoints.communitySubscribe(slug));
      final root = r.data as Map<String, dynamic>? ?? {};
      return root['following'] as bool? ?? false;
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<({List<CommunityNotification> notifications, int unreadCount})> getNotifications() async {
    try {
      final r = await _dio.get(Endpoints.communityNotifications);
      final root = r.data as Map<String, dynamic>? ?? {};
      final list = _extractList(r.data);
      return (
        notifications: list.map((e) => CommunityNotification.fromJson(e as Map<String, dynamic>)).toList(),
        unreadCount: root['unread'] as int? ?? 0,
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> markNotificationsRead({List<int>? ids}) async {
    try {
      await _dio.post(Endpoints.communityNotifications,
          data: ids != null ? {'ids': ids} : {'all': true});
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  // ── Support DM ──────────────────────────────────────────────────────────────

  // Poll community messages — also returns current typing names
  Future<({List<CommunityMessage> messages, List<String> typing})> pollMessages(
      String slug, {required int after}) async {
    try {
      final r = await _dio.get(
        Endpoints.communityMessages(slug),
        queryParameters: {'after': after},
      );
      final root = r.data is Map<String, dynamic> ? r.data as Map<String, dynamic> : <String, dynamic>{};
      return (
        messages: _extractList(r.data)
            .map((e) => CommunityMessage.fromJson(e as Map<String, dynamic>))
            .toList(),
        typing: (root['typing'] as List?)?.map((e) => e.toString()).toList() ?? [],
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  // Poll support messages — also returns read_ids and typing
  Future<({List<DirectMessage> messages, List<int> readIds, List<String> typing})>
      pollSupportMessages({int? after}) async {
    try {
      final r = await _dio.get(
        Endpoints.communitySupport,
        queryParameters: after != null ? {'after': after} : null,
      );
      final root = r.data is Map<String, dynamic> ? r.data as Map<String, dynamic> : <String, dynamic>{};
      return (
        messages: _extractList(r.data)
            .map((e) => DirectMessage.fromJson(e as Map<String, dynamic>))
            .toList(),
        readIds: (root['read_ids'] as List?)?.map((e) => e as int).toList() ?? [],
        typing: (root['typing'] as List?)?.map((e) => e.toString()).toList() ?? [],
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> sendTyping(String slug) async {
    try { await _dio.post(Endpoints.communityTyping(slug)); } catch (_) {}
  }

  Future<void> sendSupportTyping({int? convId}) async {
    try {
      await _dio.post(convId != null
          ? Endpoints.communitySupportConvTyping(convId)
          : Endpoints.communitySupportTyping);
    } catch (_) {}
  }

  Future<Map<String, dynamic>> getReaders(int pk) async {
    try {
      final r = await _dio.get(Endpoints.communityReaders(pk));
      return r.data as Map<String, dynamic>? ?? {};
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<bool> getReadReceipts() async {
    try {
      final r = await _dio.get(Endpoints.communityReadReceipts);
      return (r.data as Map<String, dynamic>?)?['enabled'] as bool? ?? true;
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<bool> setReadReceipts(bool on) async {
    try {
      final r = await _dio.post(Endpoints.communityReadReceipts, data: {'enabled': on});
      return (r.data as Map<String, dynamic>?)?['enabled'] as bool? ?? on;
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

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
      throw _toApiException(e);
    }
  }

  Future<DirectMessage> postSupportMessage(String content, {int? replyToId, List<MultipartFile>? images, MultipartFile? audio, int? audioDuration}) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (replyToId != null) 'reply_to': replyToId,
        if (images != null && images.isNotEmpty) 'images': images,
        if (audio != null) 'audio': audio,
        if (audio != null) 'audio_duration': audioDuration ?? 0,
      });
      final r = await _dio.post(Endpoints.communitySupport, data: formData);
      final root = r.data as Map<String, dynamic>? ?? {};
      return DirectMessage.fromJson(
          (root['message'] as Map<String, dynamic>?) ??
          (root['data']    as Map<String, dynamic>?) ?? root);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<List<SupportConversation>> getSupportInbox() async {
    try {
      final r = await _dio.get(Endpoints.communitySupportInbox);
      return _extractList(r.data)
          .map((e) => SupportConversation.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<List<DirectMessage>> getConversationMessages(int convId, {int? after}) async {
    try {
      final params = after != null ? {'after': after} : null;
      final r = await _dio.get(
        Endpoints.communitySupportConversationFeed(convId),
        queryParameters: params,
      );
      return _extractList(r.data)
          .map((e) => DirectMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  // Admin per-conversation polling — also returns read_ids and typing
  Future<({List<DirectMessage> messages, List<int> readIds, List<String> typing})>
      pollConversationMessages(int convId, {int? after}) async {
    try {
      final r = await _dio.get(
        Endpoints.communitySupportConversationFeed(convId),
        queryParameters: after != null ? {'after': after} : null,
      );
      final root = r.data is Map<String, dynamic> ? r.data as Map<String, dynamic> : <String, dynamic>{};
      return (
        messages: _extractList(r.data)
            .map((e) => DirectMessage.fromJson(e as Map<String, dynamic>))
            .toList(),
        readIds: (root['read_ids'] as List?)?.map((e) => e as int).toList() ?? [],
        typing: (root['typing'] as List?)?.map((e) => e.toString()).toList() ?? [],
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<DirectMessage> postConversationMessage(int convId, String content, {int? replyToId, List<MultipartFile>? images, MultipartFile? audio, int? audioDuration}) async {
    try {
      final formData = FormData.fromMap({
        'content': content,
        if (replyToId != null) 'reply_to': replyToId,
        if (images != null && images.isNotEmpty) 'images': images,
        if (audio != null) 'audio': audio,
        if (audio != null) 'audio_duration': audioDuration ?? 0,
      });
      final r = await _dio.post(Endpoints.communitySupportConversationPost(convId), data: formData);
      final root = r.data as Map<String, dynamic>? ?? {};
      return DirectMessage.fromJson(
          (root['message'] as Map<String, dynamic>?) ??
          (root['data']    as Map<String, dynamic>?) ?? root);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final communityRepositoryProvider = Provider<CommunityRepository>(
  (ref) => CommunityRepository(),
);
