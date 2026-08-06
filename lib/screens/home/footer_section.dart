import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../widgets/social_icon_button.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback? onBackToTop;

  const FooterSection({super.key, this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Gradient top line
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.appleBlue,
                  AppColors.applePurple,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context),
              vertical: 48,
            ),
            child: isMobile
                ? _MobileFooter(onBackToTop: onBackToTop)
                : _DesktopFooter(onBackToTop: onBackToTop),
          ),
        ],
      ),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  final VoidCallback? onBackToTop;
  const _DesktopFooter({this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left — branding
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.apple, color: AppColors.appleBlue, size: 28),
                  const SizedBox(width: 8),
                  Text(AppStrings.name, style: AppTextStyles.navBrand),
                ],
              ),
              const SizedBox(height: 8),
              Text(AppStrings.tagline, style: AppTextStyles.bodySm),
              const SizedBox(height: 16),
              Text(AppStrings.footerCopyright, style: AppTextStyles.labelSm),
            ],
          ),
        ),

        // Center — social icons
        Row(
          children: [
            SocialIconButton(
              icon: Icons.code,
              url: AppStrings.github,
              tooltip: 'GitHub',
            ),
            const SizedBox(width: 12),
            SocialIconButton(
              icon: Icons.work_outline,
              url: AppStrings.linkedin,
              tooltip: 'LinkedIn',
              color: const Color(0xFF0A66C2),
            ),
            const SizedBox(width: 12),
            SocialIconButton(
              icon: Icons.mail_outline,
              url: 'mailto:${AppStrings.email}',
              tooltip: 'Email',
              color: AppColors.appleRed,
            ),
          ],
        ),

        const Spacer(),

        // Right — tagline + back to top
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppStrings.footerTagline, style: AppTextStyles.bodySm),
            const SizedBox(height: 16),
            _BackToTopButton(onTap: onBackToTop),
          ],
        ),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  final VoidCallback? onBackToTop;
  const _MobileFooter({this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.apple, color: AppColors.appleBlue, size: 24),
            const SizedBox(width: 8),
            Text(AppStrings.name, style: AppTextStyles.navBrand),
          ],
        ),
        const SizedBox(height: 8),
        Text(AppStrings.tagline,
            style: AppTextStyles.bodySm, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIconButton(
              icon: Icons.code,
              url: AppStrings.github,
              tooltip: 'GitHub',
            ),
            const SizedBox(width: 12),
            SocialIconButton(
              icon: Icons.work_outline,
              url: AppStrings.linkedin,
              tooltip: 'LinkedIn',
              color: const Color(0xFF0A66C2),
            ),
            const SizedBox(width: 12),
            SocialIconButton(
              icon: Icons.mail_outline,
              url: 'mailto:${AppStrings.email}',
              tooltip: 'Email',
              color: AppColors.appleRed,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(AppStrings.footerTagline, style: AppTextStyles.bodySm),
        const SizedBox(height: 16),
        _BackToTopButton(onTap: onBackToTop),
        const SizedBox(height: 16),
        Text(AppStrings.footerCopyright,
            style: AppTextStyles.labelSm, textAlign: TextAlign.center),
      ],
    );
  }
}

class _BackToTopButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _BackToTopButton({this.onTap});

  @override
  State<_BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<_BackToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.appleBlue.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered ? AppColors.appleBlue : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.backToTop, style: AppTextStyles.labelMd),
              const SizedBox(width: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: _isHovered
                    ? (Matrix4.identity()..translate(0.0, -3.0))
                    : Matrix4.identity(),
                child: const Icon(
                  Icons.arrow_upward,
                  size: 14,
                  color: AppColors.appleBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
