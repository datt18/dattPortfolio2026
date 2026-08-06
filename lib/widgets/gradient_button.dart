import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/text_styles.dart';

enum GradientButtonVariant { primary, secondary, outline, ghost }

class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final GradientButtonVariant variant;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? width;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = GradientButtonVariant.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.isLoading = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (_, __) => Transform.scale(
            scale: _scaleAnim.value,
            child: _buildButton(),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    switch (widget.variant) {
      case GradientButtonVariant.primary:
        return _PrimaryButton(
          label: widget.label,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          isHovered: _isHovered,
          width: widget.width,
          isLoading: widget.isLoading,
        );
      case GradientButtonVariant.secondary:
        return _SecondaryButton(
          label: widget.label,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          isHovered: _isHovered,
          width: widget.width,
        );
      case GradientButtonVariant.outline:
        return _OutlineButton(
          label: widget.label,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          isHovered: _isHovered,
          width: widget.width,
        );
      case GradientButtonVariant.ghost:
        return _GhostButton(
          label: widget.label,
          prefixIcon: widget.prefixIcon,
          isHovered: _isHovered,
        );
    }
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isHovered;
  final double? width;
  final bool isLoading;

  const _PrimaryButton({
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.isHovered,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHovered
              ? [const Color(0xFF1A8FFF), AppColors.appleBlue]
              : AppColors.buttonGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: AppColors.appleBlue.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ]
            : [],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisSize: width != null ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          else ...[
            if (prefixIcon != null) ...[
              Icon(prefixIcon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(label,
                style: AppTextStyles.buttonLabel.copyWith(color: Colors.white)),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              Icon(suffixIcon, size: 18, color: Colors.white),
            ],
          ],
        ],
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isHovered;
  final double? width;

  const _SecondaryButton({
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.isHovered,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        color: isHovered
            ? AppColors.applePurple.withOpacity(0.2)
            : AppColors.applePurple.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHovered
              ? AppColors.applePurple.withOpacity(0.6)
              : AppColors.applePurple.withOpacity(0.3),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisSize: width != null ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: 18, color: AppColors.applePurple),
            const SizedBox(width: 8),
          ],
          Text(label,
              style: AppTextStyles.buttonLabel
                  .copyWith(color: AppColors.applePurple)),
          if (suffixIcon != null) ...[
            const SizedBox(width: 8),
            Icon(suffixIcon, size: 18, color: AppColors.applePurple),
          ],
        ],
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isHovered;
  final double? width;

  const _OutlineButton({
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.isHovered,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        color: isHovered ? AppColors.glassCard : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHovered ? AppColors.borderLight : AppColors.border,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisSize: width != null ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: 18, color: AppColors.secondaryText),
            const SizedBox(width: 8),
          ],
          Text(label,
              style: AppTextStyles.buttonLabel
                  .copyWith(color: AppColors.secondaryText)),
          if (suffixIcon != null) ...[
            const SizedBox(width: 8),
            Icon(suffixIcon, size: 18, color: AppColors.secondaryText),
          ],
        ],
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isHovered;

  const _GhostButton({
    required this.label,
    this.prefixIcon,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon,
                size: 16,
                color: isHovered
                    ? AppColors.appleBlue
                    : AppColors.secondaryText),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTextStyles.buttonLabel.copyWith(
              color: isHovered ? AppColors.appleBlue : AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
