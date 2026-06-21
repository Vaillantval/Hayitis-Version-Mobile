import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class AudioMessageBubble extends StatefulWidget {
  final String? url;
  final String? localPath;
  final int duration;
  final bool isOwn;

  const AudioMessageBubble({
    super.key,
    this.url,
    this.localPath,
    required this.duration,
    required this.isOwn,
  });

  @override
  State<AudioMessageBubble> createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble> {
  final _player = AudioPlayer();
  bool _playing = false;
  bool _error = false;
  Duration _position = Duration.zero;
  Duration _total = Duration.zero;

  @override
  void initState() {
    super.initState();
    _total = Duration(seconds: widget.duration.clamp(1, 7200));
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _total = d > Duration.zero ? d : _total);
    });
    _player.onPlayerStateChanged.listen((s) {
      if (mounted) setState(() => _playing = s == PlayerState.playing);
    });
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() { _playing = false; _position = Duration.zero; });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_playing) {
      await _player.pause();
      return;
    }
    // Resume if paused mid-way
    if (_position > Duration.zero && _position < _total && !_error) {
      await _player.resume();
      return;
    }
    // Fresh play
    if (mounted) setState(() { _position = Duration.zero; _error = false; });
    try {
      if (widget.url != null) {
        await _player.play(UrlSource(widget.url!));
      } else if (widget.localPath != null) {
        await _player.play(DeviceFileSource(widget.localPath!));
      } else {
        if (mounted) setState(() => _error = true);
        Fluttertoast.showToast(msg: 'Fichier audio introuvable.');
      }
    } catch (e) {
      if (mounted) setState(() { _error = true; _playing = false; });
      Fluttertoast.showToast(msg: 'Impossible de lire ce message vocal.');
    }
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _total.inMilliseconds > 0
        ? (_position.inMilliseconds / _total.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;
    final iconColor  = widget.isOwn ? Colors.white : AppColors.primary;
    final barColor   = widget.isOwn ? Colors.white70 : AppColors.primary;
    final timeColor  = widget.isOwn ? Colors.white70 : AppColors.textMuted;
    final trackColor = widget.isOwn ? Colors.white24 : const Color(0xFFEDE0D8);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: _error
                  ? AppColors.error.withValues(alpha: 0.15)
                  : widget.isOwn
                      ? Colors.white24
                      : AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _error
                  ? Icons.error_outline_rounded
                  : _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: _error ? AppColors.error : iconColor,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.toDouble(),
                  minHeight: 3,
                  backgroundColor: trackColor,
                  valueColor: AlwaysStoppedAnimation(barColor),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                _fmt(_playing || _position > Duration.zero ? _position : _total),
                style: GoogleFonts.nunito(fontSize: 10, color: timeColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
