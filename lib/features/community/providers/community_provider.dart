import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../models/channel.dart';
import '../models/community_message.dart';
import '../models/community_notification.dart';
import '../models/direct_message.dart';
import '../repositories/community_repository.dart';

// ── Channels ─────────────────────────────────────────────────────────────────

final channelsProvider = FutureProvider<List<Channel>>((ref) async {
  return ref.read(communityRepositoryProvider).getChannels();
});

// Active channel slug (which tab is selected)
final activeChannelSlugProvider = StateProvider<String?>((ref) => null);

// ── Channel messages state ────────────────────────────────────────────────────

class ChannelFeedState {
  final List<CommunityMessage> messages;
  final bool isLoadingOlder;
  final bool hasOlder;
  final bool isSending;
  final List<String> typing;

  const ChannelFeedState({
    this.messages = const [],
    this.isLoadingOlder = false,
    this.hasOlder = false,
    this.isSending = false,
    this.typing = const [],
  });

  ChannelFeedState copyWith({
    List<CommunityMessage>? messages,
    bool? isLoadingOlder,
    bool? hasOlder,
    bool? isSending,
    List<String>? typing,
  }) => ChannelFeedState(
    messages:        messages        ?? this.messages,
    isLoadingOlder:  isLoadingOlder  ?? this.isLoadingOlder,
    hasOlder:        hasOlder        ?? this.hasOlder,
    isSending:       isSending       ?? this.isSending,
    typing:          typing          ?? this.typing,
  );
}

class ChannelFeedNotifier extends AutoDisposeFamilyAsyncNotifier<ChannelFeedState, String> {
  late final String _slug;
  late final CommunityRepository _repo;
  Timer? _timer;
  int? _lastId;
  int? _oldestId;
  static const _pollInterval = Duration(seconds: 4);
  static const _feedLimit = 30;

  @override
  Future<ChannelFeedState> build(String slug) async {
    _slug = slug;
    _repo = ref.read(communityRepositoryProvider);
    ref.onDispose(() => _timer?.cancel());
    return _initialFetch();
  }

  Future<ChannelFeedState> _initialFetch() async {
    final msgs = await _repo.getMessages(_slug);
    if (msgs.isNotEmpty) {
      _lastId   = msgs.last.id;
      _oldestId = msgs.first.id;
    }
    _startPolling();
    return ChannelFeedState(messages: msgs, hasOlder: msgs.length >= _feedLimit);
  }

  void _startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(_pollInterval, (_) => _poll());
  }

  Future<void> _poll() async {
    final lastId = _lastId;
    if (lastId == null) return;
    try {
      final result = await _repo.pollMessages(_slug, after: lastId);
      final current = state.valueOrNull;
      if (current == null) return;
      if (result.messages.isNotEmpty) {
        _lastId = result.messages.last.id;
        final existing = current.messages.map((m) => m.id).toSet();
        final fresh = result.messages.where((m) => !existing.contains(m.id)).toList();
        state = AsyncData(current.copyWith(
          messages: fresh.isNotEmpty ? [...current.messages, ...fresh] : null,
          typing: result.typing,
        ));
      } else {
        if (result.typing != current.typing) {
          state = AsyncData(current.copyWith(typing: result.typing));
        }
      }
    } catch (_) {}
  }

  Future<void> loadOlder() async {
    final current = state.valueOrNull;
    if (current == null || _oldestId == null || current.isLoadingOlder) return;
    state = AsyncData(current.copyWith(isLoadingOlder: true));
    try {
      final older = await _repo.getMessages(_slug, before: _oldestId);
      if (older.isNotEmpty) _oldestId = older.first.id;
      state = AsyncData(current.copyWith(
        messages: [...older, ...current.messages],
        isLoadingOlder: false,
        hasOlder: older.length >= _feedLimit,
      ));
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingOlder: false));
    }
  }

  Future<void> sendMessage(String content, {int? replyToId, List<XFile>? images, String? audioPath, int? audioDuration}) async {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(isSending: true));
    try {
      final multiparts = await _filesToMultiparts(images);
      MultipartFile? audioFile;
      if (audioPath != null) audioFile = await MultipartFile.fromFile(audioPath);
      final msg = await _repo.postMessage(_slug, content: content, replyToId: replyToId, images: multiparts, audio: audioFile, audioDuration: audioDuration);
      _lastId = msg.id;
      state = AsyncData(current.copyWith(
        messages: [...current.messages, msg],
        isSending: false,
      ));
    } catch (e) {
      state = AsyncData(current.copyWith(isSending: false));
      rethrow;
    }
  }

  Future<void> react(int messageId, String emoji) async {
    final current = state.valueOrNull;
    if (current == null) return;
    // Optimistic toggle — reactions is Map<String, int>
    final updated = current.messages.map((m) {
      if (m.id != messageId) return m;
      final alreadyReacted = m.myReactions.contains(emoji);
      final newMyReactions = alreadyReacted
          ? m.myReactions.where((e) => e != emoji).toList()
          : [...m.myReactions, emoji];
      final newReactions = Map<String, int>.from(m.reactions);
      if (alreadyReacted) {
        final prev = newReactions[emoji] ?? 0;
        if (prev <= 1) newReactions.remove(emoji);
        else newReactions[emoji] = prev - 1;
      } else {
        newReactions[emoji] = (newReactions[emoji] ?? 0) + 1;
      }
      return m.copyWith(myReactions: newMyReactions, reactions: newReactions);
    }).toList();
    state = AsyncData(current.copyWith(messages: updated));
    try {
      await _repo.react(messageId, emoji);
    } catch (_) {
      state = AsyncData(current);
    }
  }

  Future<void> deleteMessage(int messageId) async {
    await _repo.deleteMessage(messageId);
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(
      messages: current.messages.map((m) => m.id == messageId
          ? m.copyWith(isDeleted: true, content: 'Message supprimé.')
          : m).toList(),
    ));
  }

  Future<void> pinMessage(int messageId) async {
    await _repo.pinMessage(messageId);
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(
      messages: current.messages.map((m) => m.id == messageId
          ? m.copyWith(isPinned: !m.isPinned)
          : m).toList(),
    ));
  }

  Future<List<MultipartFile>> _filesToMultiparts(List<XFile>? files) async {
    if (files == null || files.isEmpty) return [];
    return Future.wait(files.map((f) async =>
      MultipartFile.fromFileSync(f.path, filename: f.name)));
  }
}

final channelFeedProvider = AsyncNotifierProvider.autoDispose
    .family<ChannelFeedNotifier, ChannelFeedState, String>(
  () => ChannelFeedNotifier(),
);

// ── Notifications ─────────────────────────────────────────────────────────────

class NotifState {
  final List<CommunityNotification> notifications;
  final int unreadCount;
  const NotifState({this.notifications = const [], this.unreadCount = 0});
}

class NotifNotifier extends AutoDisposeAsyncNotifier<NotifState> {
  late final CommunityRepository _repo;
  Timer? _timer;

  @override
  Future<NotifState> build() async {
    _repo = ref.read(communityRepositoryProvider);
    ref.onDispose(() => _timer?.cancel());
    final result = await _repo.getNotifications();
    _timer = Timer.periodic(const Duration(seconds: 25), (_) => _poll());
    return NotifState(notifications: result.notifications, unreadCount: result.unreadCount);
  }

  Future<void> _poll() async {
    try {
      final result = await _repo.getNotifications();
      state = AsyncData(NotifState(notifications: result.notifications, unreadCount: result.unreadCount));
    } catch (_) {}
  }

  Future<void> markAllRead() async {
    await _repo.markNotificationsRead();
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(NotifState(
      notifications: current.notifications.map((n) => n.copyWith(isRead: true)).toList(),
      unreadCount: 0,
    ));
  }
}

final notifProvider = AsyncNotifierProvider.autoDispose<NotifNotifier, NotifState>(
  () => NotifNotifier(),
);

// ── Support DM ────────────────────────────────────────────────────────────────

class SupportFeedState {
  final List<DirectMessage> messages;
  final bool isSending;
  final List<String> typing;

  const SupportFeedState({
    this.messages = const [],
    this.isSending = false,
    this.typing = const [],
  });

  SupportFeedState copyWith({
    List<DirectMessage>? messages,
    bool? isSending,
    List<String>? typing,
  }) => SupportFeedState(
    messages: messages ?? this.messages,
    isSending: isSending ?? this.isSending,
    typing: typing ?? this.typing,
  );
}

class SupportFeedNotifier extends AutoDisposeAsyncNotifier<SupportFeedState> {
  late final CommunityRepository _repo;
  Timer? _timer;
  int? _lastId;

  @override
  Future<SupportFeedState> build() async {
    _repo = ref.read(communityRepositoryProvider);
    ref.onDispose(() => _timer?.cancel());
    final msgs = await _repo.getSupportMessages();
    if (msgs.isNotEmpty) _lastId = msgs.last.id;
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _poll());
    return SupportFeedState(messages: msgs);
  }

  Future<void> _poll() async {
    try {
      final result = await _repo.pollSupportMessages(after: _lastId);
      final current = state.valueOrNull;
      if (current == null) return;
      if (result.messages.isNotEmpty) _lastId = result.messages.last.id;
      final existing = current.messages.map((m) => m.id).toSet();
      final fresh = result.messages.where((m) => !existing.contains(m.id)).toList();
      final readSet = result.readIds.toSet();
      // Apply readIds: mark matched admin messages as read (✓✓)
      final allMsgs = [
        ...current.messages.map((m) =>
            readSet.contains(m.id) && m.read != true ? m.copyWith(read: true) : m),
        ...fresh,
      ];
      state = AsyncData(current.copyWith(
        messages: allMsgs,
        typing: result.typing,
      ));
    } catch (_) {}
  }

  Future<void> send(String content, {int? replyToId, List<XFile>? images, String? audioPath, int? audioDuration}) async {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(isSending: true));
    try {
      final multiparts = await _filesToMultiparts(images);
      MultipartFile? audioFile;
      if (audioPath != null) audioFile = await MultipartFile.fromFile(audioPath);
      final msg = await _repo.postSupportMessage(content, replyToId: replyToId, images: multiparts, audio: audioFile, audioDuration: audioDuration);
      _lastId = msg.id;
      state = AsyncData(current.copyWith(messages: [...current.messages, msg], isSending: false));
    } catch (e) {
      state = AsyncData(current.copyWith(isSending: false));
      rethrow;
    }
  }

  Future<List<MultipartFile>> _filesToMultiparts(List<XFile>? files) async {
    if (files == null || files.isEmpty) return [];
    return Future.wait(files.map((f) async =>
      MultipartFile.fromFileSync(f.path, filename: f.name)));
  }
}

final supportFeedProvider = AsyncNotifierProvider.autoDispose<SupportFeedNotifier, SupportFeedState>(
  () => SupportFeedNotifier(),
);

// Admin inbox
final supportInboxProvider = FutureProvider.autoDispose<List<SupportConversation>>((ref) async {
  return ref.read(communityRepositoryProvider).getSupportInbox();
});
