import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_colors.dart';

class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  final Color? color;
  final double size;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.url,
    required this.tooltip,
    this.color,
    this.size = 20,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.color ?? AppColors.secondaryText;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: _launch,
          child: AnimatedBuilder(
            animation: _scaleAnim,
            builder: (_, __) => Transform.scale(
              scale: _scaleAnim.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? iconColor.withOpacity(0.12)
                      : AppColors.glassCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered ? iconColor.withOpacity(0.4) : AppColors.glassBorder,
                  ),
                ),
                child: Icon(widget.icon, color: iconColor, size: widget.size),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
