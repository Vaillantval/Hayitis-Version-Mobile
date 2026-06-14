import 'package:cached_network_image/cached_network_image.dart';
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
                  onPressed: () => context.push('/login?redirect=/community/support'),
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
    final images = List<XFile>.from(_pendingImages);
    _textCtrl.clear();
    setState(() => _pendingImages.clear());
    try {
      await ref.read(supportFeedProvider.notifier).send(text, images: images);
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
                itemBuilder: (_, i) => _DMBubble(msg: feed.messages[i]),
              );
            },
          ),
        ),

        // Image previews
        if (_pendingImages.isNotEmpty)
          Container(
            color: Colors.white, height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: _pendingImages.length,
              itemBuilder: (_, i) => Stack(children: [
                Container(
                  width: 64, height: 64, margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage(_pendingImages[i].path), fit: BoxFit.cover),
                  ),
                ),
                Positioned(top: 0, right: 4,
                  child: GestureDetector(
                    onTap: () => setState(() => _pendingImages.removeAt(i)),
                    child: Container(
                      width: 18, height: 18,
                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 12, color: Colors.white),
                    ),
                  )),
              ]),
            ),
          ),

        // Composer
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

class _AdminConversationView extends ConsumerStatefulWidget {
  final SupportConversation conv;
  const _AdminConversationView({required this.conv});

  @override
  ConsumerState<_AdminConversationView> createState() => _AdminConversationViewState();
}

class _AdminConversationViewState extends ConsumerState<_AdminConversationView> {
  final _textCtrl   = TextEditingController();
  final _scrollCtrl = ScrollController();
  List<DirectMessage> _messages = [];
  bool _loading = true;
  bool _sending = false;

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

  Future<void> _send() async {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    _textCtrl.clear();
    setState(() => _sending = true);
    try {
      final msg = await ref.read(communityRepositoryProvider)
          .postConversationMessage(widget.conv.id, text);
      setState(() { _messages.add(msg); _sending = false; });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (_) {
      setState(() => _sending = false);
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
                itemBuilder: (_, i) => _DMBubble(msg: _messages[i], adminView: true),
              ),
        ),
        _SupportComposer(textCtrl: _textCtrl, onSend: _send, isSending: _sending),
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

class _DMBubble extends StatelessWidget {
  final DirectMessage msg;
  final bool adminView;
  const _DMBubble({required this.msg, this.adminView = false});

  bool get _isRight => msg.isOwn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: _isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!_isRight) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: _isRight ? _kAccent : AppColors.dark,
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
                if (msg.content.isNotEmpty)
                  Text(msg.content,
                    style: GoogleFonts.nunito(fontSize: 14, color: _isRight ? Colors.white : AppColors.dark, height: 1.4)),
                if (msg.attachments.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  ...msg.attachments.map((url) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(imageUrl: url, width: 180, fit: BoxFit.cover),
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
  }

  String _fmtTime(DateTime dt) {
    final l = dt.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
  }
}

class _SupportComposer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: Row(children: [
        if (onPickImage != null)
          IconButton(
            icon: const Icon(Icons.image_outlined, color: AppColors.textMuted),
            onPressed: onPickImage,
          ),
        Expanded(
          child: TextField(
            controller: textCtrl,
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
