import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../widgets/typing_text.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/particle_background.dart';
import '../../widgets/social_icon_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const HeroSection({
    super.key,
    this.onViewProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Grid background
          Positioned.fill(child: GridBackground(color: AppColors.border)),

          // Blue glow — top right
          Positioned(
            top: -100,
            right: isMobile ? -100 : 0,
            child: const AnimatedBlob(
              color: AppColors.appleBlue,
              size: 500,
              duration: Duration(seconds: 10),
            ),
          ),

          // Purple glow — bottom left
          Positioned(
            bottom: 0,
            left: isMobile ? -150 : -50,
            child: const AnimatedBlob(
              color: AppColors.applePurple,
              size: 450,
              duration: Duration(seconds: 12),
            ),
          ),

          // Particles
          const Positioned.fill(
            child: ParticleBackground(
              color: AppColors.appleBlue,
              particleCount: 25,
            ),
          ),

          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.horizontalPadding(context),
                vertical: 100,
              ),
              child: isMobile
                  ? _MobileHeroContent(
                      onViewProjects: onViewProjects,
                      onContact: onContact,
                    )
                  : _DesktopHeroContent(
                      onViewProjects: onViewProjects,
                      onContact: onContact,
                    ),
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: const _ScrollIndicator(),
          ),
        ],
      ),
    );
  }
}

class _DesktopHeroContent extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const _DesktopHeroContent({this.onViewProjects, this.onContact});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left — text content
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(AppStrings.heroGreeting, style: AppTextStyles.heroGreeting)
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideX(begin: -0.2, end: 0),

              const SizedBox(height: 16),

              // Name
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.primaryText, Color(0xFFB8C1CC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  AppStrings.heroIntro,
                  style: AppTextStyles.heroName,
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 800.ms)
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

              const SizedBox(height: 16),

              // Typing role
              Row(
                children: [
                  Text('> ', style: AppTextStyles.heroRole.copyWith(color: AppColors.mutedText)),
                  TypingText(
                    texts: AppStrings.typingRoles,
                    style: AppTextStyles.heroRole,
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms),

              const SizedBox(height: 8),

              // Experience badge
              Container(
                margin: const EdgeInsets.only(top: 4, bottom: 28),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.appleGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.appleGreen.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.appleGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${AppStrings.yearsExp} Years Experience • Available for Work',
                      style: AppTextStyles.labelMd.copyWith(color: AppColors.appleGreen),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 600.ms),

              // Summary
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Text(AppStrings.summary, style: AppTextStyles.bodyLg),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 600.ms),

              const SizedBox(height: 40),

              // CTA Buttons
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  GradientButton(
                    label: AppStrings.viewProjects,
                    prefixIcon: Icons.folder_outlined,
                    onPressed: onViewProjects,
                  ),
                  GradientButton(
                    label: AppStrings.hireMe,
                    variant: GradientButtonVariant.outline,
                    prefixIcon: Icons.handshake_outlined,
                    onPressed: onContact,
                  ),
                  GradientButton(
                    label: AppStrings.downloadResume,
                    variant: GradientButtonVariant.ghost,
                    prefixIcon: Icons.download_outlined,
                    onPressed: () async {
                      if (AppStrings.resumeUrl.isNotEmpty) {
                        final uri = Uri.parse(AppStrings.resumeUrl);
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      }
                    },
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 40),

              // Social Icons
              Row(
                children: [
                  SocialIconButton(
                    icon: Icons.code,
                    url: AppStrings.github,
                    tooltip: 'GitHub',
                    color: AppColors.secondaryText,
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
              )
                  .animate()
                  .fadeIn(delay: 1100.ms, duration: 600.ms),
            ],
          ),
        ),

        const SizedBox(width: 64),

        // Right — profile visual
        Expanded(
          flex: 4,
          child: _ProfileVisual()
              .animate()
              .fadeIn(delay: 600.ms, duration: 800.ms)
              .scaleXY(begin: 0.85, end: 1.0, duration: 800.ms, curve: Curves.easeOut),
        ),
      ],
    );
  }
}

class _MobileHeroContent extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const _MobileHeroContent({this.onViewProjects, this.onContact});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile visual — mobile top
        _ProfileVisual(size: 140)
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .scaleXY(begin: 0.85, end: 1.0),

        const SizedBox(height: 32),

        Text(AppStrings.heroGreeting, style: AppTextStyles.heroGreeting)
            .animate().fadeIn(delay: 400.ms, duration: 500.ms),

        const SizedBox(height: 12),

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryText, Color(0xFFB8C1CC)],
          ).createShader(bounds),
          child: Text(
            AppStrings.heroIntro,
            style: AppTextStyles.heroNameMobile,
            textAlign: TextAlign.center,
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

        const SizedBox(height: 12),

        TypingText(
          texts: AppStrings.typingRoles,
          style: AppTextStyles.heroRoleMobile,
        ).animate().fadeIn(delay: 600.ms, duration: 500.ms),

        const SizedBox(height: 20),

        Text(
          AppStrings.summary,
          style: AppTextStyles.bodyMd,
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 700.ms, duration: 500.ms),

        const SizedBox(height: 32),

        GradientButton(
          label: AppStrings.viewProjects,
          prefixIcon: Icons.folder_outlined,
          width: double.infinity,
          onPressed: onViewProjects,
        ).animate().fadeIn(delay: 800.ms),

        const SizedBox(height: 12),

        GradientButton(
          label: AppStrings.hireMe,
          variant: GradientButtonVariant.outline,
          prefixIcon: Icons.handshake_outlined,
          width: double.infinity,
          onPressed: onContact,
        ).animate().fadeIn(delay: 900.ms),

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
        ).animate().fadeIn(delay: 1000.ms),
      ],
    );
  }
}

class _ProfileVisual extends StatelessWidget {
  final double size;

  const _ProfileVisual({this.size = 300});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.appleBlue.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Rotating dashes ring
          _RotatingRing(size: size * 0.9),
          // Profile image container
          Container(
            width: size * 0.72,
            height: size * 0.72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.appleBlue.withOpacity(0.4),
                  AppColors.applePurple.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: AppColors.appleBlue.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: _buildProfileImage(),
            ),
          ),
          // Tech stack floating icons
          ..._buildFloatingIcons(size),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Image.asset(
      'assets/images/profile_img.png',
      fit: BoxFit.cover,
    );
  }

  List<Widget> _buildFloatingIcons(double size) {
    final icons = [
      _FloatingIcon(
        icon: Icons.apple,
        color: AppColors.primaryText,
        offset: Offset(size * 0.05, size * 0.1),
        delay: const Duration(milliseconds: 0),
      ),
      _FloatingIcon(
        icon: Icons.flutter_dash,
        color: const Color(0xFF54C5F8),
        offset: Offset(size * 0.75, size * 0.05),
        delay: const Duration(milliseconds: 500),
      ),
      _FloatingIcon(
        icon: Icons.local_fire_department,
        color: AppColors.appleOrange,
        offset: Offset(size * 0.85, size * 0.6),
        delay: const Duration(milliseconds: 300),
      ),
      _FloatingIcon(
        icon: Icons.merge_type,
        color: AppColors.secondaryText,
        offset: Offset(size * 0.0, size * 0.6),
        delay: const Duration(milliseconds: 700),
      ),
    ];
    return icons;
  }
}

class _FloatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Offset offset;
  final Duration delay;

  const _FloatingIcon({
    required this.icon,
    required this.color,
    required this.offset,
    required this.delay,
  });

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(widget.delay, () {
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
    return Positioned(
      left: widget.offset.dx,
      top: widget.offset.dy,
      child: AnimatedBuilder(
        animation: _floatAnim,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.color.withOpacity(0.25)),
            ),
            child: Icon(widget.icon, color: widget.color, size: 20),
          ),
        ),
      ),
    );
  }
}

class _RotatingRing extends StatefulWidget {
  final double size;
  const _RotatingRing({required this.size});

  @override
  State<_RotatingRing> createState() => _RotatingRingState();
}

class _RotatingRingState extends State<_RotatingRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
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
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 2 * 3.14159,
        child: CustomPaint(
          painter: _DashedCirclePainter(
            color: AppColors.appleBlue.withOpacity(0.2),
            size: widget.size,
          ),
          size: Size(widget.size, widget.size),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double size;
  _DashedCirclePainter({required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    const dashCount = 24;
    const dashLength = 0.15;
    const gapLength = 0.11;
    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);
    final radius = size / 2;
    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashLength + gapLength));
      final sweepAngle = dashLength;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter old) => false;
}

class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator();

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Scroll to explore', style: AppTextStyles.labelSm),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => Opacity(
            opacity: 0.4 + 0.6 * _controller.value,
            child: Transform.translate(
              offset: Offset(0, 4 * _controller.value),
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.secondaryText,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1500.ms, duration: 800.ms);
  }
}
