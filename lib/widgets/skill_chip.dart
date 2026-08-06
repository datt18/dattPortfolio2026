import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/text_styles.dart';

class SkillChip extends StatefulWidget {
  final String label;
  final Color? color;
  final IconData? icon;

  const SkillChip({
    super.key,
    required this.label,
    this.color,
    this.icon,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final chipColor = widget.color ?? AppColors.appleBlue;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _isHovered
              ? chipColor.withOpacity(0.2)
              : chipColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _isHovered
                ? chipColor.withOpacity(0.5)
                : chipColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 12, color: chipColor),
              const SizedBox(width: 5),
            ],
            Text(
              widget.label,
              style: AppTextStyles.labelMd.copyWith(
                color: _isHovered ? chipColor : chipColor.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated skill progress bar card
class SkillProgressCard extends StatefulWidget {
  final String name;
  final double proficiency;
  final Color color;
  final IconData icon;
  final String description;

  const SkillProgressCard({
    super.key,
    required this.name,
    required this.proficiency,
    required this.color,
    required this.icon,
    required this.description,
  });

  @override
  State<SkillProgressCard> createState() => _SkillProgressCardState();
}

class _SkillProgressCardState extends State<SkillProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _progressAnim = Tween<double>(begin: 0.0, end: widget.proficiency).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withOpacity(0.08)
              : AppColors.glassCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.color.withOpacity(0.3)
                : AppColors.glassBorder,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name, style: AppTextStyles.labelLg),
                      Text(widget.description,
                          style: AppTextStyles.labelSm,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _progressAnim,
                  builder: (_, __) => Text(
                    '${(_progressAnim.value * 100).round()}%',
                    style: AppTextStyles.labelMd
                        .copyWith(color: widget.color, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Progress bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(100),
              ),
              child: AnimatedBuilder(
                animation: _progressAnim,
                builder: (_, __) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnim.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [widget.color, widget.color.withOpacity(0.6)],
                      ),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
