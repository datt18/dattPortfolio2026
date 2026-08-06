import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/text_styles.dart';
import '../core/models/project_model.dart';
import 'skill_chip.dart';
import 'gradient_button.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Color get _accent => widget.project.accentColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -8.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.sectionBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? _accent.withOpacity(0.3) : AppColors.glassBorder,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: _accent.withOpacity(0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  )
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient banner
              _buildHeader(),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategories(),
                    const SizedBox(height: 12),
                    Text(widget.project.title, style: AppTextStyles.h2),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.shortDescription,
                      style: AppTextStyles.bodyMd,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    // Features
                    _buildFeatures(),
                    const SizedBox(height: 16),
                    // Tech stack
                    _buildTechStack(),
                    const SizedBox(height: 20),
                    // Role badge
                    Row(
                      children: [
                        Icon(Icons.person_outline,
                            size: 14, color: AppColors.mutedText),
                        const SizedBox(width: 6),
                        Text(
                          widget.project.role,
                          style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Action buttons
                    _buildActions(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * widget.index),
          duration: 600.ms,
        )
        .slideY(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: 100 * widget.index),
          duration: 600.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _accent.withOpacity(0.3),
            _accent.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background grid pattern
          CustomPaint(
            painter: _GridPainter(color: _accent.withOpacity(0.06)),
            size: Size.infinite,
          ),
          // Icon
          Positioned(
            right: 24,
            bottom: 24,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _accent.withOpacity(0.3)),
              ),
              child: Icon(widget.project.icon, color: _accent, size: 32),
            ),
          ),
          // Featured badge
          if (widget.project.isFeatured)
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: _accent.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 10, color: _accent),
                    const SizedBox(width: 4),
                    Text('Featured',
                        style: AppTextStyles.labelSm
                            .copyWith(color: _accent, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Wrap(
      spacing: 6,
      children: widget.project.categories
          .map((c) => SkillChip(label: c.label, color: _accent))
          .toList(),
    );
  }

  Widget _buildFeatures() {
    final displayed = widget.project.features.take(4).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Key Features', style: AppTextStyles.labelSm),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...displayed.map(
              (f) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.glassCard,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Text(f, style: AppTextStyles.labelSm),
              ),
            ),
            if (widget.project.features.length > 4)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '+${widget.project.features.length - 4} more',
                  style: AppTextStyles.labelSm
                      .copyWith(color: _accent),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTechStack() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: widget.project.technologies
          .map((t) => SkillChip(label: t))
          .toList(),
    );
  }

  Widget _buildActions() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        if (widget.project.githubUrl != null)
          GradientButton(
            label: 'GitHub',
            variant: GradientButtonVariant.outline,
            prefixIcon: Icons.code,
            onPressed: () => _launch(widget.project.githubUrl!),
          ),
        if (widget.project.appStoreUrl != null)
          GradientButton(
            label: 'App Store',
            variant: GradientButtonVariant.primary,
            prefixIcon: Icons.apple,
            onPressed: () => _launch(widget.project.appStoreUrl!),
          ),
        if (widget.project.liveDemoUrl != null)
          GradientButton(
            label: 'Live Demo',
            variant: GradientButtonVariant.secondary,
            prefixIcon: Icons.open_in_new,
            onPressed: () => _launch(widget.project.liveDemoUrl!),
          ),
      ],
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.color != color;
}
