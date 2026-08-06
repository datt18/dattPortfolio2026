import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/text_styles.dart';

/// Cycles through [texts] with a typing and erasing animation
class TypingText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typeSpeed;
  final Duration eraseSpeed;
  final Duration pauseDuration;

  const TypingText({
    super.key,
    required this.texts,
    this.style,
    this.typeSpeed = const Duration(milliseconds: 80),
    this.eraseSpeed = const Duration(milliseconds: 50),
    this.pauseDuration = const Duration(milliseconds: 1800),
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  int _textIndex = 0;
  String _displayText = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    final target = widget.texts[_textIndex];
    _timer = Timer.periodic(widget.typeSpeed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_displayText.length < target.length) {
        setState(() => _displayText = target.substring(0, _displayText.length + 1));
      } else {
        timer.cancel();
        Future.delayed(widget.pauseDuration, _startErasing);
      }
    });
  }

  void _startErasing() {
    _timer = Timer.periodic(widget.eraseSpeed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_displayText.isNotEmpty) {
        setState(() => _displayText = _displayText.substring(0, _displayText.length - 1));
      } else {
        timer.cancel();
        _textIndex = (_textIndex + 1) % widget.texts.length;
        _startTyping();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _displayText,
          style: widget.style ?? AppTextStyles.heroRole,
        ),
        _BlinkingCursor(
          color: AppColors.appleBlue,
          textStyle: widget.style ?? AppTextStyles.heroRole,
        ),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  final Color color;
  final TextStyle textStyle;

  const _BlinkingCursor({required this.color, required this.textStyle});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Opacity(
        opacity: _controller.value > 0.5 ? 1.0 : 0.0,
        child: Text('|', style: widget.textStyle.copyWith(color: widget.color)),
      ),
    );
  }
}
