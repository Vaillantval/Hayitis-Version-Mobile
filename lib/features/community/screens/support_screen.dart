import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import '../../../shared/widgets/full_screen_image_viewer.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as ep;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../models/direct_message.dart';
import '../providers/community_provider.dart';
import '../repositories/community_repository.dart';

const _kAccent = AppColors.primary;

// ── Router: /community/support ────────────────────────────────────────────────

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    if (!auth.isLoggedIn) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Support Hayiti\'s'),
          backgroundColor: AppColors.dark,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.support_agent_rounded, color: AppColors.primary, size: 40),
              ),
              const SizedBox(height: 20),
              Text('Contactez-nous', style: GoogleFonts.playfairDisplay(
                fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.dark)),
              const SizedBox(height: 10),
              Text('Connectez-vous pour envoyer un message directement à notre équipe support.',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(fontSize: 13, color: AppColors.textMuted, height: 1.5)),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/auth/login?redirect=/community/support'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Se connecter', style: GoogleFonts.nunito(
                    fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ]),
          ),
        ),
      );
    }

    final isStaff = auth.profile?.isStaff ?? false;
    return isStaff ? const _AdminInboxView() : const _ClientSupportView();
  }
}

// ── Client support view ───────────────────────────────────────────────────────

class _ClientSupportView extends ConsumerStatefulWidget {
  const _ClientSupportView();

  @override
  ConsumerState<_ClientSupportView> createState() => _ClientSupportViewState();
}

class _ClientSupportViewState extends ConsumerState<_ClientSupportView> {
  final _textCtrl   = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _picker     = ImagePicker();
  final List<XFile> _pendingImages = [];
  bool _autoScroll  = true;
  int?    _replyToId;
  String? _replyAuthor;
  String? _replySnippet;

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
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
    final replyId = _replyToId;
    final images  = List<XFile>.from(_pendingImages);
    _textCtrl.clear();
    setState(() { _pendingImages.clear(); _replyToId = null; _replyAuthor = null; _replySnippet = null; });
    try {
      await ref.read(supportFeedProvider.notifier).send(text, replyToId: replyId, images: images);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e'), backgroundColor: AppColors.error));
    }
  }

  Future<void> _pickImage() async {
    final files = await _picker.pickMultiImage(imageQuality: 80, limit: 3);
    if (files.isNotEmpty) setState(() => _pendingImages.addAll(files));
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(supportFeedProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: _kAccent, borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Support Hayiti's",
              style: GoogleFonts.nunito(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
            Text("Généralement répond en quelques heures",
              style: GoogleFonts.nunito(color: Colors.white60, fontSize: 10)),
          ]),
        ]),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(children: [
        Expanded(
          child: feedAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: _kAccent)),
            error:   (e, _) => Center(child: Text('$e')),
            data: (feed) {
              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
              if (feed.messages.isEmpty) {
                return Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.chat_bubble_outline, size: 56, color: AppColors.textMuted),
                    const SizedBox(height: 12),
                    Text("Démarrez la conversation",
                      style: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Notre équipe vous répondra rapidement.",
                      style: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 12)),
                  ]),
                );
              }
              return ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                itemCount: feed.messages.length,
                itemBuilder: (_, i) => _DMBubble(
                  msg: feed.messages[i],
                  onReply: (m) => setState(() {
                    _replyToId     = m.id;
                    _replyAuthor   = m.isAdmin ? "Support Hayiti's" : 'Moi';
                    _replySnippet  = m.content.isNotEmpty ? m.content : '📷 image';
                  }),
                ),
              );
            },
          ),
        ),

        if (_replyToId != null)
          _SupportReplyBar(
            author: _replyAuthor ?? '',
            snippet: _replySnippet ?? '',
            onCancel: () => setState(() { _replyToId = null; _replyAuthor = null; _replySnippet = null; }),
          ),

        _ImagePreviewStrip(
          images: _pendingImages,
          onRemove: (i) => setState(() => _pendingImages.removeAt(i)),
        ),

        _SupportComposer(
          textCtrl: _textCtrl,
          onSend: _send,
          onPickImage: _pickImage,
          isSending: feedAsync.valueOrNull?.isSending ?? false,
        ),
      ]),
    );
  }
}

// ── Admin inbox view ──────────────────────────────────────────────────────────

class _AdminInboxView extends ConsumerWidget {
  const _AdminInboxView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inboxAsync = ref.watch(supportInboxProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text("Boîte de support",
          style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => ref.invalidate(supportInboxProvider),
          ),
        ],
      ),
      body: inboxAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: _kAccent)),
        error: (e, _) => Center(child: Text('$e')),
        data: (conversations) => conversations.isEmpty
            ? Center(child: Text("Aucune conversation",
                style: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 14)))
            : ListView.separated(
                itemCount: conversations.length,
                separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                itemBuilder: (_, i) {
                  final conv = conversations[i];
                  return _ConversationTile(conv: conv);
                },
              ),
      ),
    );
  }
}

class _ConversationTile extends ConsumerWidget {
  final SupportConversation conv;
  const _ConversationTile({required this.conv});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: _kAccent,
        child: Text(conv.clientName.isNotEmpty ? conv.clientName[0].toUpperCase() : '?',
          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      title: Text(conv.clientName,
        style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: AppColors.dark, fontSize: 14)),
      subtitle: Text(conv.lastMessage ?? "Aucun message",
        maxLines: 1, overflow: TextOverflow.ellipsis,
        style: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 12)),
      trailing: conv.unreadCount > 0
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: _kAccent, borderRadius: BorderRadius.circular(12)),
            child: Text('${conv.unreadCount}',
              style: GoogleFonts.nunito(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
          )
        : Text(conv.lastAt != null ? _fmtDate(conv.lastAt!) : '',
            style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => _AdminConversationView(conv: conv),
      )),
    );
  }

  String _fmtDate(DateTime dt) {
    final l = dt.toLocal();
    return '${l.day}/${l.month}';
  }
}

// ── Admin conversation view ───────────────────────────────────────────────────

class _AdminConversationView extends ConsumerStatefulWidget {
  final SupportConversation conv;
  const _AdminConversationView({required this.conv});

  @override
  ConsumerState<_AdminConversationView> createState() => _AdminConversationViewState();
}

class _AdminConversationViewState extends ConsumerState<_AdminConversationView> {
  final _textCtrl   = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _picker     = ImagePicker();
  final List<XFile> _pendingImages = [];
  List<DirectMessage> _messages = [];
  bool _loading = true;
  bool _sending = false;
  int?    _replyToId;
  String? _replyAuthor;
  String? _replySnippet;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final msgs = await ref.read(communityRepositoryProvider).getConversationMessages(widget.conv.id);
      if (mounted) setState(() { _messages = msgs; _loading = false; });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _scrollToBottom() {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Future<void> _pickImage() async {
    final files = await _picker.pickMultiImage(imageQuality: 80, limit: 3);
    if (files.isNotEmpty) setState(() => _pendingImages.addAll(files));
  }

  Future<void> _send() async {
    final text = _textCtrl.text.trim();
    if (text.isEmpty && _pendingImages.isEmpty) return;
    final replyId = _replyToId;
    final images  = List<XFile>.from(_pendingImages);
    _textCtrl.clear();
    setState(() { _pendingImages.clear(); _sending = true; _replyToId = null; _replyAuthor = null; _replySnippet = null; });
    try {
      final multiparts = await Future.wait(
        images.map((f) => MultipartFile.fromFile(f.path, filename: f.name)),
      );
      final msg = await ref.read(communityRepositoryProvider)
          .postConversationMessage(widget.conv.id, text, replyToId: replyId, images: multiparts);
      if (mounted) setState(() { _messages.add(msg); _sending = false; });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (_) {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text(widget.conv.clientName,
          style: GoogleFonts.nunito(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(children: [
        Expanded(
          child: _loading
            ? const Center(child: CircularProgressIndicator(color: _kAccent))
            : ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _DMBubble(
                  msg: _messages[i],
                  adminView: true,
                  onReply: (m) => setState(() {
                    _replyToId     = m.id;
                    _replyAuthor   = m.isAdmin ? 'Moi' : widget.conv.clientName;
                    _replySnippet  = m.content.isNotEmpty ? m.content : '📷 image';
                  }),
                ),
              ),
        ),
        if (_replyToId != null)
          _SupportReplyBar(
            author: _replyAuthor ?? '',
            snippet: _replySnippet ?? '',
            onCancel: () => setState(() { _replyToId = null; _replyAuthor = null; _replySnippet = null; }),
          ),
        _ImagePreviewStrip(
          images: _pendingImages,
          onRemove: (i) => setState(() => _pendingImages.removeAt(i)),
        ),
        _SupportComposer(
          textCtrl: _textCtrl,
          onSend: _send,
          onPickImage: _pickImage,
          isSending: _sending,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────────

class _ImagePreviewStrip extends StatelessWidget {
  final List<XFile> images;
  final ValueChanged<int> onRemove;
  const _ImagePreviewStrip({required this.images, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();
    return Container(
      color: Colors.white, height: 84,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: images.length,
        itemBuilder: (_, i) => Stack(children: [
          Container(
            width: 64, height: 64, margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(File(images[i].path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(top: 0, right: 4,
            child: GestureDetector(
              onTap: () => onRemove(i),
              child: Container(
                width: 18, height: 18,
                decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            )),
        ]),
      ),
    );
  }
}

class _SupportComposer extends StatefulWidget {
  final TextEditingController textCtrl;
  final VoidCallback onSend;
  final VoidCallback? onPickImage;
  final bool isSending;

  const _SupportComposer({
    required this.textCtrl,
    required this.onSend,
    this.onPickImage,
    required this.isSending,
  });

  @override
  State<_SupportComposer> createState() => _SupportComposerState();
}

class _SupportComposerState extends State<_SupportComposer> {
  bool _showEmoji = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _showEmoji) {
        setState(() => _showEmoji = false);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEmoji() {
    if (_showEmoji) {
      _focusNode.requestFocus();
      setState(() => _showEmoji = false);
    } else {
      _focusNode.unfocus();
      setState(() => _showEmoji = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.cardBorder)),
        ),
        padding: const EdgeInsets.fromLTRB(4, 6, 8, 8),
        child: Row(children: [
          // Emoji button
          IconButton(
            icon: Icon(
              _showEmoji ? Icons.keyboard_rounded : Icons.emoji_emotions_outlined,
              color: _showEmoji ? _kAccent : AppColors.textMuted,
            ),
            onPressed: _toggleEmoji,
            tooltip: 'Emoji',
          ),
          // Image button
          if (widget.onPickImage != null)
            IconButton(
              icon: const Icon(Icons.image_outlined, color: AppColors.textMuted),
              onPressed: widget.onPickImage,
              tooltip: 'Image',
            ),
          // Text field
          Expanded(
            child: TextField(
              controller: widget.textCtrl,
              focusNode: _focusNode,
              maxLines: null, minLines: 1, maxLength: 2000,
              decoration: InputDecoration(
                hintText: 'Votre message...',
                hintStyle: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none),
                filled: true, fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                counterText: '',
              ),
              style: GoogleFonts.nunito(fontSize: 14, color: AppColors.dark),
            ),
          ),
          const SizedBox(width: 6),
          // Send button
          GestureDetector(
            onTap: widget.isSending ? null : widget.onSend,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: widget.isSending ? AppColors.textMuted : _kAccent,
                shape: BoxShape.circle,
              ),
              child: widget.isSending
                ? const Center(child: SizedBox(width: 18, height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)))
                : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ]),
      ),
      // Emoji panel
      if (_showEmoji)
        SizedBox(
          height: 256,
          child: ep.EmojiPicker(
            textEditingController: widget.textCtrl,
            config: ep.Config(
              height: 256,
              emojiViewConfig: ep.EmojiViewConfig(
                columns: 8,
                emojiSizeMax: 28,
                backgroundColor: Colors.white,
                noRecents: Text('Aucun récent',
                  style: GoogleFonts.nunito(color: AppColors.textMuted, fontSize: 12)),
              ),
              categoryViewConfig: ep.CategoryViewConfig(
                indicatorColor: _kAccent,
                iconColor: AppColors.textMuted,
                iconColorSelected: _kAccent,
                backgroundColor: Colors.white,
              ),
              bottomActionBarConfig: const ep.BottomActionBarConfig(enabled: false),
            ),
          ),
        ),
    ]);
  }
}

class _DMBubble extends StatelessWidget {
  final DirectMessage msg;
  final bool adminView;
  final void Function(DirectMessage)? onReply;
  const _DMBubble({required this.msg, this.adminView = false, this.onReply});

  bool get _isRight => msg.isOwn;

  @override
  Widget build(BuildContext context) {
    final bubble = Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: _isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!_isRight) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.dark,
              child: const Icon(Icons.support_agent_rounded, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isRight ? _kAccent : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft:     const Radius.circular(16),
                  topRight:    const Radius.circular(16),
                  bottomLeft:  Radius.circular(_isRight ? 16 : 4),
                  bottomRight: Radius.circular(_isRight ? 4  : 16),
                ),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (msg.replyTo != null) _DmReplyContext(reply: msg.replyTo!, isOwn: _isRight),
                if (msg.content.isNotEmpty)
                  Text(msg.content,
                    style: GoogleFonts.nunito(fontSize: 14, color: _isRight ? Colors.white : AppColors.dark, height: 1.4)),
                if (msg.attachments.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  ...msg.attachments.asMap().entries.map((e) => GestureDetector(
                    onTap: () => FullScreenImageViewer.show(context, msg.attachments, initialIndex: e.key),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(imageUrl: e.value, width: 180, fit: BoxFit.cover),
                      ),
                    ),
                  )),
                ],
                const SizedBox(height: 2),
                Text(_fmtTime(msg.createdAt),
                  style: GoogleFonts.nunito(fontSize: 9, color: _isRight ? Colors.white60 : AppColors.textMuted)),
              ]),
            ),
          ),
          if (_isRight) const SizedBox(width: 8),
        ],
      ),
    );

    if (onReply == null) return bubble;

    return Dismissible(
      key: ValueKey('dm_reply_${msg.id}'),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (_) async {
        onReply!(msg);
        return false;
      },
      background: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: _kAccent.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: const Icon(Icons.reply_rounded, color: _kAccent, size: 20),
          ),
        ),
      ),
      child: bubble,
    );
  }

  String _fmtTime(DateTime dt) {
    final l = dt.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
  }
}

class _DmReplyContext extends StatelessWidget {
  final DmReplyTo reply;
  final bool isOwn;
  const _DmReplyContext({required this.reply, required this.isOwn});

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
        Text(reply.senderName,
          style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700,
            color: isOwn ? Colors.white : _kAccent)),
        Text(reply.excerpt, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: GoogleFonts.nunito(fontSize: 11, color: isOwn ? Colors.white70 : AppColors.textMuted)),
      ]),
    );
  }
}

class _SupportReplyBar extends StatelessWidget {
  final String author;
  final String snippet;
  final VoidCallback onCancel;
  const _SupportReplyBar({required this.author, required this.snippet, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kAccent.withValues(alpha: 0.08),
      padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
      child: Row(children: [
        Container(width: 3, height: 36,
          decoration: BoxDecoration(color: _kAccent, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text('Répondre à $author',
              style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: _kAccent)),
            Text(snippet, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(fontSize: 11, color: AppColors.textMuted)),
          ]),
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
          onPressed: onCancel,
          padding: EdgeInsets.zero,
        ),
      ]),
    );
  }
}
