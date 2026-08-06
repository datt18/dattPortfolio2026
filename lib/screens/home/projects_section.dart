import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/project_model.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/providers/portfolio_provider.dart';
import '../../widgets/section_header.dart';
import '../../widgets/project_card.dart';
import '../../widgets/particle_background.dart';

class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key});

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final category = ref.watch(selectedCategoryProvider);
    final projects = ref.watch(filteredProjectsProvider);

    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: AppColors.sectionBg,
        child: Stack(
          children: [
            // Animated blobs
            Positioned(
              top: -50,
              left: -100,
              child: AnimatedBlob(
                color: AppColors.appleBlue,
                size: 400,
                duration: const Duration(seconds: 12),
              ),
            ),
            Positioned(
              bottom: -50,
              right: -100,
              child: AnimatedBlob(
                color: AppColors.applePurple,
                size: 350,
                duration: const Duration(seconds: 10),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.horizontalPadding(context),
                vertical: ResponsiveUtils.sectionPaddingV(context),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: ResponsiveUtils.maxContentWidth),
                  child: Column(
                    children: [
                      SectionHeader(
                        overline: 'Portfolio',
                        title: AppStrings.projectsTitle,
                        subtitle: AppStrings.projectsSubtitle,
                        alignment: CrossAxisAlignment.center,
                        animate: _visible,
                      ),
                      const SizedBox(height: 48),

                      // Filter bar
                      if (_visible) _buildFilterBar(category),

                      const SizedBox(height: 48),

                      // Projects grid
                      if (_visible) _buildProjectsGrid(context, projects, isMobile, isTablet),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(ProjectCategory active) {
    final categories = ProjectCategory.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories.map((c) {
          final isActive = active == c;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterChip(
              label: c.label,
              isActive: isActive,
              onTap: () =>
                  ref.read(selectedCategoryProvider.notifier).state = c,
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 500.ms);
  }

  Widget _buildProjectsGrid(
    BuildContext context,
    List<ProjectModel> projects,
    bool isMobile,
    bool isTablet,
  ) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(Icons.folder_open, size: 64, color: AppColors.mutedText),
            const SizedBox(height: 16),
            Text('No projects in this category', style: AppTextStyles.bodyMd),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms);
    }

    final columns = isMobile ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (columns - 1) * 24) / columns;
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: List.generate(
            projects.length,
            (i) => SizedBox(
              width: itemWidth,
              child: ProjectCard(project: projects[i], index: i),
            ),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: widget.isActive
                ? const LinearGradient(colors: AppColors.buttonGradient)
                : null,
            color: widget.isActive
                ? null
                : _isHovered
                    ? AppColors.glassCard
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: widget.isActive
                  ? Colors.transparent
                  : _isHovered
                      ? AppColors.borderLight
                      : AppColors.border,
            ),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: AppColors.appleBlue.withOpacity(0.3),
                      blurRadius: 12,
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLg.copyWith(
              color: widget.isActive
                  ? Colors.white
                  : _isHovered
                      ? AppColors.primaryText
                      : AppColors.secondaryText,
              fontWeight:
                  widget.isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
