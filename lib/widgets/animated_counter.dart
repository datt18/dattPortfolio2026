import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/text_styles.dart';

/// Animates from 0 to [targetValue] when mounted
class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String prefix;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.suffix = '',
    this.prefix = '',
    this.duration = const Duration(milliseconds: 1500),
    this.textStyle,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    // Delay then start
    Future.delayed(300.ms, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final value = (_animation.value * widget.targetValue).round();
        return Text(
          '${widget.prefix}$value${widget.suffix}',
          style: widget.textStyle ?? AppTextStyles.statValue,
        );
      },
    );
  }
}

/// Stat card used in About section
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final String suffix;
  final int numericValue;
  final Color? accentColor;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.suffix = '',
    required this.numericValue,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.glassCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedCounter(
                targetValue: numericValue,
                suffix: suffix,
                textStyle: AppTextStyles.statValue.copyWith(
                  color: accentColor ?? AppColors.appleBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.statLabel),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .scaleXY(begin: 0.9, end: 1.0, duration: 600.ms, curve: Curves.easeOut);
  }
}
