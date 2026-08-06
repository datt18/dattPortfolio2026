import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String overline;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final bool animate;

  const SectionHeader({
    super.key,
    required this.overline,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: alignment,
      children: [
        // Overline pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.appleBlue.withOpacity(0.12),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.appleBlue.withOpacity(0.25),
            ),
          ),
          child: Text(
            overline.toUpperCase(),
            style: AppTextStyles.overline,
          ),
        ),
        const SizedBox(height: 16),

        // Title with gradient highlight
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryText, AppColors.secondaryText],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            title,
            style: AppTextStyles.displaySm.copyWith(color: Colors.white),
            textAlign: alignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.start,
          ),
        ),

        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: AppTextStyles.bodyLg,
            textAlign: alignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.start,
          ),
        ],

        const SizedBox(height: 8),

        // Decorative line
        if (alignment != CrossAxisAlignment.center)
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.appleBlue, AppColors.applePurple],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          )
        else
          Center(
            child: Container(
              width: 60,
              height: 3,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.appleBlue, AppColors.applePurple],
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
      ],
    );

    if (!animate) return content;
    return content
        .animate()
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}
