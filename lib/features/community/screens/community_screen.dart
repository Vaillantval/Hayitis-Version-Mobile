import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../models/community_message.dart';
import '../providers/community_provider.dart';

const _kAccent = AppColors.primary;
const _kCream  = AppColors.background;

// ── Main screen ───────────────────────────────────────────────────────────────

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    if (!auth.isLoggedIn) {
      return _LoginPrompt();
    }

    return const _CommunityShell();
  }
}

// ── Login prompt ──────────────────────────────────────────────────────────────

class _LoginPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCream,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text("Communauté",
          style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: _kAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.groups_rounded, size: 40, color: _kAccent),
            ),
            const SizedBox(height: 20),
            Text("Rejoignez la communauté",
              style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.dark),
              textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text("Connectez-vous pour participer aux discussions et poser vos questions.",
              style: GoogleFonts.nunito(fontSize: 14, color: AppColors.textMuted),
              textAlign: TextAlign.center),
            const SizedBox(height: 28),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: _kAccent, minimumSize: const Size(200, 48)),
              onPressed: () => context.push('/auth/login'),
              child: Text("Se connecter", style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ),
    );
  }
}

// ── Community shell ───────────────────────────────────────────────────────────

class _CommunityShell extends ConsumerStatefulWidget {
  const _CommunityShell();

  @override
  ConsumerState<_CommunityShell> createState() => _CommunityShellState();
}

class _CommunityShellState extends ConsumerState<_CommunityShell> {
  @override
  void initState() {
    super.initState();
    // Set first channel as active once loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final channels = ref.read(channelsProvider).valueOrNull;
      if (channels != null && channels.isNotEmpty) {
        final current = ref.read(activeChannelSlugProvider);
        if (current == null) {
          ref.read(activeChannelSlugProvider.notifier).state = channels.first.slug;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final channelsAsync = ref.watch(channelsProvider);
    final auth = ref.watch(authProvider);
    final isStaff = auth.profile?.isStaff ?? false;

    return Scaffold(
      backgroundColor: _kCream,
      appBar: _CommunityAppBar(isStaff: isStaff),
      body: channelsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: _kAccent)),
        error: (e, _) => Center(child: Text('Impossible de charger les salons',
          style: GoogleFonts.nunito(color: AppColors.textMuted))),
        data: (channels) {
          if (channels.isEmpty) {
            return Center(child: Text('Aucun salon disponible',
              style: GoogleFonts.nunito(color: AppColors.textMuted)));
          }
          // Auto-select first channel
          final activeSlug = ref.watch(activeChannelSlugProvider) ?? channels.first.slug;
          final activeChannel = channels.firstWhere(
            (c) => c.slug == activeSlug,
            orElse: () => channels.first,
          );

          return Column(children: [
            // Channel tabs
            _ChannelTabs(channels: channels, activeSlug: activeChannel.slug),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEDE0D8)),
            // Feed
            Expanded(child: _ChannelFeed(channel: activeChannel)),
          ]);
        },
      ),
    );
  }
}

// ── AppBar ────────────────────────────────────────────────────────────────────

class _CommunityAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isStaff;
  const _CommunityAppBar({required this.isStaff});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifAsync = ref.watch(notifProvider);
    final unread = notifAsync.valueOrNull?.unreadCount ?? 0;

    return AppBar(
      backgroundColor: AppColors.dark,
      automaticallyImplyLeading: false,
      title: Row(children: [
        Text("Communauté",
          style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: _kAccent, borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            Container(width: 6, height: 6,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Text("EN DIRECT",
              style: GoogleFonts.nunito(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
          ]),
        ),
      ]),
      actions: [
        // Notifications bell
        IconButton(
          onPressed: () => _showNotifications(context, ref),
          icon: Badge(
            isLabelVisible: unread > 0,
            label: Text('$unread'),
            child: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
        ),
        // Support
        IconButton(
          onPressed: () => context.push('/community/support'),
          icon: const Icon(Icons.support_agent_rounded, color: Colors.white),
          tooltip: 'Support',
        ),
      ],
    );
  }

  void _showNotifications(BuildContext context, WidgetRef ref) {
    final notifAsync = ref.read(notifProvider);
    final notifs = notifAsync.valueOrNull?.notifications ?? [];
    ref.read(notifProvider.notifier).markAllRead();

    showModalBottomSheet(
      context: context,
      backgroundColor: _kCream,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4,
            decoration: BoxDecoration(color: const Color(0xFFD1C4C4), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Notifications",
              style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.dark)),
          ),
          const SizedBox(height: 8),
          if (notifs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text("Aucune notification", style: GoogleFonts.nunito(color: AppColors.textMuted)),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: notifs.length,
                itemBuilder: (_, i) {
                  final n = notifs[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _kAccent.withValues(alpha: 0.1),
                      child: Text(_typeIcon(n.type), style: const TextStyle(fontSize: 18)),
                    ),
                    title: Text(n.message,
                      style: GoogleFonts.nunito(fontSize: 13, fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w700,
                        color: AppColors.dark)),
                    subtitle: Text(n.actorName,
                      style: GoogleFonts.nunito(fontSize: 11, color: AppColors.textMuted)),
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _typeIcon(String type) {
    switch (type) {
      case 'reply':   return '↩️';
      case 'mention': return '@️';
      default:        return '🔔';
    }
  }
}

// ── Channel tabs ──────────────────────────────────────────────────────────────

class _ChannelTabs extends ConsumerWidget {
  final List channels;
  final String activeSlug;
  const _ChannelTabs({required this.channels, required this.activeSlug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.dark,
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: channels.length,
        itemBuilder: (_, i) {
          final ch = channels[i];
          final active = ch.slug == activeSlug;
          return GestureDetector(
            onTap: () => ref.read(activeChannelSlugProvider.notifier).state = ch.slug,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: active ? _kAccent : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text("${ch.emoji}  ${ch.name}",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  )),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Channel feed ──────────────────────────────────────────────────────────────

class _ChannelFeed extends ConsumerStatefulWidget {
  final dynamic channel;
  const _ChannelFeed({required this.channel});

  @override
  ConsumerState<_ChannelFeed> createState() => _ChannelFeedState();
}

class _ChannelFeedState extends ConsumerState<_ChannelFeed> {
  final _scrollCtrl    = ScrollController();
  final _textCtrl      = TextEditingController();
  final _focusNode     = FocusNode();
  bool  _autoScroll    = true;
  int?  _replyToId;
  String? _replyAuthor;
  bool  _showEmoji     = false;
  final _picker        = ImagePicker();
  final List<XFile>    _pendingImages = [];

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final atBottom = _scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent - 80;
      if (_autoScroll != atBottom) setState(() => _autoScroll = atBottom);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _textCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_autoScroll && _scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _send() async {
    final text = _textCtrl.text.trim();
    if (text.isEmpty && _pendingImages.isEmpty) return;
    final replyId  = _replyToId;
    final images   = List<XFile>.from(_pendingImages);
    _textCtrl.clear();
    setState(() { _replyToId = null; _replyAuthor = null; _pendingImages.clear(); _showEmoji = false; });

    try {
      await ref.read(channelFeedProvider(widget.channel.slug).notifier)
          .sendMessage(text, replyToId: replyId, images: images);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e'), backgroundColor: AppColors.error));
      }
    }
  }

  Future<void> _pickImages() async {
    final files = await _picker.pickMultiImage(imageQuality: 80, limit: 5);
    if (files.isNotEmpty) {
      setState(() {
        _pendingImages.addAll(files);
        if (_pendingImages.length > 5) _pendingImages.removeRange(5, _pendingImages.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(channelFeedProvider(widget.channel.slug));

    return Column(children: [
      // Messages area
      Expanded(
        child: feedAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: _kAccent)),
          error: (e, _) => Center(child: Text('$e', style: GoogleFonts.nunito(color: AppColors.textMuted))),
          data: (feed) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
            return Stack(children: [
              ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                itemCount: feed.messages.length + (feed.hasOlder ? 1 : 0),
                itemBuilder: (_, i) {
                  if (feed.hasOlder && i == 0) {
                    return _LoadOlderBtn(
                      isLoading: feed.isLoadingOlder,
                      onTap: () => ref.read(channelFeedProvider(widget.channel.slug).notifier).loadOlder(),
                    );
                  }
                  final msg = feed.messages[feed.hasOlder ? i - 1 : i];
                  return _MessageBubble(
                    message: msg,
                    onReply: (m) => setState(() { _replyToId = m.id; _replyAuthor = m.authorName; }),
                    onReact: (m, emoji) =>
                        ref.read(channelFeedProvider(widget.channel.slug).notifier).react(m.id, emoji),
                    onDelete: (m) =>
                        ref.read(channelFeedProvider(widget.channel.slug).notifier).deleteMessage(m.id),
                    onPin: (m) =>
                        ref.read(channelFeedProvider(widget.channel.slug).notifier).pinMessage(m.id),
                  );
                },
              ),
              // Scroll-to-bottom FAB
              if (!_autoScroll)
                Positioned(
                  bottom: 8, right: 12,
                  child: FloatingActionButton.small(
                    backgroundColor: _kAccent,
                    onPressed: () { setState(() => _autoScroll = true); _scrollToBottom(); },
                    child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ),
                ),
            ]);
          },
        ),
      ),

      // Emoji grid
      if (_showEmoji) _EmojiPicker(
        onEmoji: (e) => setState(() => _textCtrl.text = _textCtrl.text + e),
      ),

      // Image previews
      if (_pendingImages.isNotEmpty) _ImagePreviews(
        images: _pendingImages,
        onRemove: (i) => setState(() => _pendingImages.removeAt(i)),
      ),

      // Reply bar
      if (_replyToId != null) _ReplyBar(
        author: _replyAuthor ?? '',
        onCancel: () => setState(() { _replyToId = null; _replyAuthor = null; }),
      ),

      // Composer
      _Composer(
        channel: widget.channel,
        textCtrl: _textCtrl,
        focusNode: _focusNode,
        onSend: _send,
        onPickImage: _pickImages,
        onToggleEmoji: () => setState(() { _showEmoji = !_showEmoji; if (_showEmoji) _focusNode.unfocus(); }),
        isSending: ref.watch(channelFeedProvider(widget.channel.slug)).valueOrNull?.isSending ?? false,
      ),
    ]);
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _LoadOlderBtn extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  const _LoadOlderBtn({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: isLoading
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: _kAccent))
          : TextButton(
              onPressed: onTap,
              child: Text("Charger les messages précédents",
                style: GoogleFonts.nunito(fontSize: 12, color: _kAccent))),
      ),
    );
  }
}

class _MessageBubble extends ConsumerWidget {
  final CommunityMessage message;
  final void Function(CommunityMessage) onReply;
  final void Function(CommunityMessage, String) onReact;
  final void Function(CommunityMessage) onDelete;
  final void Function(CommunityMessage) onPin;

  const _MessageBubble({
    required this.message,
    required this.onReply,
    required this.onReact,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwn = message.isOwn;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isOwn) ...[
            _Avatar(name: message.authorName, isStaff: message.isStaff),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Author + pin
                if (!isOwn || message.isPinned) Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 4, right: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (message.isStaff) Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: _kAccent, borderRadius: BorderRadius.circular(4)),
                        child: Text("Staff",
                          style: GoogleFonts.nunito(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                      Text(message.authorName,
                        style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.dark)),
                      if (message.isPinned) ...[
                        const SizedBox(width: 4),
                        const Text("📌", style: TextStyle(fontSize: 11)),
                      ],
                    ],
                  ),
                ),

                // Bubble
                GestureDetector(
                  onLongPress: () => _showActions(context),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isOwn ? _kAccent : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:     const Radius.circular(16),
                        topRight:    const Radius.circular(16),
                        bottomLeft:  Radius.circular(isOwn ? 16 : 4),
                        bottomRight: Radius.circular(isOwn ? 4  : 16),
                      ),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Reply context
                        if (message.replyTo != null) _ReplyContext(reply: message.replyTo!, isOwn: isOwn),

                        // Content
                        if (message.isDeleted)
                          Text("Message supprimé.",
                            style: GoogleFonts.nunito(fontSize: 13, color: isOwn ? Colors.white60 : AppColors.textMuted,
                              fontStyle: FontStyle.italic))
                        else
                          Text(message.content,
                            style: GoogleFonts.nunito(fontSize: 14, color: isOwn ? Colors.white : AppColors.dark, height: 1.4)),

                        // Attachments
                        if (message.attachments.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          _AttachmentGrid(urls: message.attachments),
                        ],
                      ],
                    ),
                  ),
                ),

                // Reactions — Map<String, int> from API
                if (message.reactions.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  child: Wrap(
                    spacing: 4,
                    children: message.reactions.entries.map((entry) {
                      final emoji  = entry.key;
                      final count  = entry.value;
                      final active = message.myReactions.contains(emoji);
                      return GestureDetector(
                        onTap: () => onReact(message, emoji),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: active ? _kAccent.withValues(alpha: 0.15) : Colors.white,
                            border: Border.all(color: active ? _kAccent : const Color(0xFFEDE0D8)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text("$emoji $count",
                            style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600,
                              color: active ? _kAccent : AppColors.dark)),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Timestamp
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 4, right: 4),
                  child: Text(_formatTime(message.createdAt),
                    style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                ),
              ],
            ),
          ),
          if (isOwn) ...[
            const SizedBox(width: 6),
            _Avatar(name: message.authorName, isStaff: message.isStaff),
          ],
        ],
      ),
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _MessageActions(
        message: message,
        onReply:  () { Navigator.pop(context); onReply(message); },
        onReact:  (e) { Navigator.pop(context); onReact(message, e); },
        onDelete: message.isOwn || message.canModerate
            ? () { Navigator.pop(context); onDelete(message); }
            : null,
        onPin:    message.canModerate
            ? () { Navigator.pop(context); onPin(message); }
            : null,
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now   = DateTime.now();
    final local = dt.toLocal();
    if (now.difference(local).inDays == 0) {
      return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    }
    return '${local.day}/${local.month} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final bool isStaff;
  const _Avatar({required this.name, required this.isStaff});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: 14,
      backgroundColor: isStaff ? _kAccent : AppColors.dark,
      child: Text(initial, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
    );
  }
}

class _ReplyContext extends StatelessWidget {
  final dynamic reply;
  final bool isOwn;
  const _ReplyContext({required this.reply, required this.isOwn});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: isOwn ? Colors.white54 : _kAccent, width: 3)),
        color: isOwn ? Colors.white.withValues(alpha: 0.1) : _kAccent.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(reply.authorName,
          style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700,
            color: isOwn ? Colors.white : _kAccent)),
        Text(reply.excerpt, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: GoogleFonts.nunito(fontSize: 11, color: isOwn ? Colors.white70 : AppColors.textMuted)),
      ]),
    );
  }
}

class _AttachmentGrid extends StatelessWidget {
  final List<String> urls;
  const _AttachmentGrid({required this.urls});

  @override
  Widget build(BuildContext context) {
    if (urls.length == 1) {
      return _AttachmentImg(url: urls[0]);
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4, childAspectRatio: 1),
      itemCount: urls.length.clamp(0, 4),
      itemBuilder: (_, i) => _AttachmentImg(url: urls[i]),
    );
  }
}

class _AttachmentImg extends StatelessWidget {
  final String url;
  const _AttachmentImg({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: url, fit: BoxFit.cover,
        errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
      ),
    );
  }
}

class _MessageActions extends StatelessWidget {
  final CommunityMessage message;
  final VoidCallback onReply;
  final void Function(String) onReact;
  final VoidCallback? onDelete;
  final VoidCallback? onPin;

  const _MessageActions({
    required this.message,
    required this.onReply,
    required this.onReact,
    this.onDelete,
    this.onPin,
  });

  static const _quickEmojis = ['❤️','😂','👍','🔥','😮','🙏','💯','🎉'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 40, height: 4,
          decoration: BoxDecoration(color: const Color(0xFFD1C4C4), borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 16),
        // Quick reactions
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _quickEmojis.map((e) => GestureDetector(
            onTap: () => onReact(e),
            child: Text(e, style: const TextStyle(fontSize: 26)),
          )).toList(),
        ),
        const Divider(height: 24),
        ListTile(
          leading: const Icon(Icons.reply_rounded, color: AppColors.dark),
          title: Text("Répondre", style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
          onTap: onReply,
        ),
        if (onPin != null) ListTile(
          leading: const Icon(Icons.push_pin_outlined, color: AppColors.dark),
          title: Text(message.isPinned ? "Désépingler" : "Épingler",
            style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
          onTap: onPin,
        ),
        if (onDelete != null) ListTile(
          leading: const Icon(Icons.delete_outline, color: AppColors.error),
          title: Text("Supprimer", style: GoogleFonts.nunito(fontWeight: FontWeight.w600, color: AppColors.error)),
          onTap: onDelete,
        ),
      ]),
    );
  }
}

class _EmojiPicker extends StatelessWidget {
  final void Function(String) onEmoji;

  static const _emojis = ['❤️','😂','😍','🔥','👍','👏','😭','🙏','🤩','💯',
    '😅','🎉','😮','🙌','💪','😊','🥰','😎','🤔','👀',
    '😤','🤣','💀','✨','😢','🥲','😃','🎊','💥','⭐',
    '🍀','🌸','🌙','🦋','🏆','💎','🌴','🍓','🎵','🚀'];

  const _EmojiPicker({required this.onEmoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, mainAxisSpacing: 4, crossAxisSpacing: 4),
        itemCount: _emojis.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => onEmoji(_emojis[i]),
          child: Center(child: Text(_emojis[i], style: const TextStyle(fontSize: 20))),
        ),
      ),
    );
  }
}

class _ImagePreviews extends StatelessWidget {
  final List<XFile> images;
  final void Function(int) onRemove;
  const _ImagePreviews({required this.images, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: images.length,
        itemBuilder: (_, i) => Stack(children: [
          Container(
            width: 64, height: 64,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(images[i].path), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 0, right: 4,
            child: GestureDetector(
              onTap: () => onRemove(i),
              child: Container(
                width: 18, height: 18,
                decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _ReplyBar extends StatelessWidget {
  final String author;
  final VoidCallback onCancel;
  const _ReplyBar({required this.author, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kAccent.withValues(alpha: 0.08),
      padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
      child: Row(children: [
        Container(width: 3, height: 32, decoration: BoxDecoration(color: _kAccent, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Expanded(
          child: Text("Répondre à $author",
            style: GoogleFonts.nunito(fontSize: 12, color: _kAccent, fontWeight: FontWeight.w600)),
        ),
        IconButton(icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted), onPressed: onCancel, padding: EdgeInsets.zero),
      ]),
    );
  }
}

class _Composer extends StatelessWidget {
  final dynamic channel;
  final TextEditingController textCtrl;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final VoidCallback onPickImage;
  final VoidCallback onToggleEmoji;
  final bool isSending;

  const _Composer({
    required this.channel,
    required this.textCtrl,
    required this.focusNode,
    required this.onSend,
    required this.onPickImage,
    required this.onToggleEmoji,
    required this.isSending,
  });

  @override
  Widget build(BuildContext context) {
    final canWrite = channel.canWrite as bool? ?? false;
    final writeAccess = channel.writeAccess as String? ?? 'open';

    if (writeAccess == 'admins') {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text("Ce salon est réservé à l'équipe. Lecture seule.",
          style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textMuted),
          textAlign: TextAlign.center),
      );
    }

    if (!canWrite && writeAccess == 'locked') {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text("Salon verrouillé. Vous ne pouvez pas poster.",
          style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textMuted),
          textAlign: TextAlign.center),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: Row(children: [
        IconButton(
          icon: const Icon(Icons.image_outlined, color: AppColors.textMuted),
          onPressed: onPickImage,
          tooltip: 'Ajouter une image',
        ),
        IconButton(
          icon: const Icon(Icons.emoji_emotions_outlined, color: AppColors.textMuted),
          onPressed: onToggleEmoji,
          tooltip: 'Emoji',
        ),
        Expanded(
          child: TextField(
            controller: textCtrl,
            focusNode: focusNode,
            maxLines: null,
            minLines: 1,
            maxLength: 2000,
            decoration: InputDecoration(
              hintText: 'Écrire un message...',
              hintStyle: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none),
              filled: true,
              fillColor: _kCream,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              counterText: '',
            ),
            style: GoogleFonts.nunito(fontSize: 14, color: AppColors.dark),
            textInputAction: TextInputAction.newline,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: isSending ? null : onSend,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: isSending ? AppColors.textMuted : _kAccent,
              shape: BoxShape.circle,
            ),
            child: isSending
              ? const Center(child: SizedBox(width: 18, height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)))
              : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
          ),
        ),
      ]),
    );
  }
}
