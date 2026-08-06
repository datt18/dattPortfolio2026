import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/skill_model.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/providers/portfolio_provider.dart';
import '../../widgets/section_header.dart';
import '../../widgets/skill_chip.dart';
import '../../widgets/particle_background.dart';

class SkillsSection extends ConsumerStatefulWidget {
  const SkillsSection({super.key});

  @override
  ConsumerState<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends ConsumerState<SkillsSection>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  SkillCategory? _selectedCategory;
  late TabController _tabController;

  final List<SkillCategory> _categories = SkillCategory.values;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedCategory = _categories[_tabController.index]);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final allSkills = ref.watch(skillsProvider);

    final filteredSkills = _selectedCategory == null
        ? allSkills
        : allSkills.where((s) => s.category == _selectedCategory).toList();

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBg, Color(0xFF0D1B3E), AppColors.primaryBg],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Floating tech icons background
            Positioned.fill(
              child: ParticleBackground(
                color: AppColors.applePurple,
                particleCount: 20,
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
                        overline: 'Technical Skills',
                        title: AppStrings.skillsTitle,
                        subtitle: AppStrings.skillsSubtitle,
                        alignment: CrossAxisAlignment.center,
                        animate: _visible,
                      ),
                      const SizedBox(height: 48),

                      // Category filter tabs
                      if (_visible)
                        _buildCategoryTabs(isMobile),

                      const SizedBox(height: 40),

                      // Skills grid
                      if (_visible)
                        _buildSkillsGrid(context, filteredSkills, isMobile),

                      const SizedBox(height: 48),

                      // All skills as chips
                      if (_visible)
                        _buildAllSkillsCloud(allSkills),
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

  Widget _buildCategoryTabs(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // "All" button
          _CategoryTab(
            label: 'All',
            isActive: _selectedCategory == null,
            onTap: () => setState(() {
              _selectedCategory = null;
              _tabController.index = 0;
            }),
          ),
          const SizedBox(width: 8),
          ..._categories.map(
            (c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _CategoryTab(
                label: c.label,
                isActive: _selectedCategory == c,
                onTap: () => setState(() => _selectedCategory = c),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 500.ms);
  }

  Widget _buildSkillsGrid(
      BuildContext context, List<SkillModel> skills, bool isMobile) {
    final columns = isMobile ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - (columns - 1) * 16) / columns;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(
            skills.length,
            (i) => SizedBox(
              width: itemWidth,
              child: SkillProgressCard(
                name: skills[i].name,
                proficiency: skills[i].proficiency,
                color: skills[i].color,
                icon: skills[i].icon,
                description: skills[i].description,
              )
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 50 * i), duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, duration: 400.ms),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAllSkillsCloud(List<SkillModel> skills) {
    final allTech = [
      'Swift', 'Objective-C', 'Dart', 'SwiftUI', 'UIKit', 'Flutter',
      'Firebase', 'SQLite', 'REST APIs', 'Mapbox', 'CoreData',
      'Push Notifications', 'Socket.IO', 'Git', 'GitHub', 'Xcode',
      'Android Studio', 'SPM', 'CocoaPods', 'App Store Connect',
      'OpenAI API', 'Claude API',
    ];

    return Column(
      children: [
        Container(
          width: 40,
          height: 1,
          color: AppColors.border,
        ),
        const SizedBox(height: 32),
        Text('All Technologies', style: AppTextStyles.overline),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: allTech
              .asMap()
              .entries
              .map(
                (e) => SkillChip(label: e.value)
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 30 * e.key),
                      duration: 300.ms,
                    ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CategoryTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<_CategoryTab> {
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
            color: widget.isActive
                ? AppColors.appleBlue
                : _isHovered
                    ? AppColors.glassCard
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: widget.isActive
                  ? AppColors.appleBlue
                  : _isHovered
                      ? AppColors.borderLight
                      : AppColors.border,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLg.copyWith(
              color: widget.isActive
                  ? Colors.white
                  : _isHovered
                      ? AppColors.primaryText
                      : AppColors.secondaryText,
            ),
          ),
        ),
      ),
    );
  }
}
