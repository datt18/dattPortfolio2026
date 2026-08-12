import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/providers/portfolio_provider.dart';
import '../../widgets/section_header.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/glass_card.dart';

class AboutSection extends ConsumerStatefulWidget {
  const AboutSection({super.key});

  @override
  ConsumerState<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends ConsumerState<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final experiences = ref.watch(experiencesProvider);

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1117),
              Color(0xFF161B22),
              Color(0xFF0D1117),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Blue glow — top left
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.appleBlue.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Purple glow — bottom right
            Positioned(
              bottom: -100,
              right: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.applePurple.withOpacity(0.07),
                      Colors.transparent,
                    ],
                  ),
                ),
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
                      // Header
                      SectionHeader(
                        overline: 'About Me',
                        title: AppStrings.aboutTitle,
                        subtitle: AppStrings.aboutSubtitle,
                        alignment: CrossAxisAlignment.center,
                        animate: _visible,
                      ),
                      const SizedBox(height: 64),

                      // Stats
                      if (_visible) _buildStats(context),

                      const SizedBox(height: 64),

                      // Story + Timeline
                      if (isMobile)
                        _MobileAboutContent(
                          experiences: experiences,
                          visible: _visible,
                        )
                      else
                        _DesktopAboutContent(
                          experiences: experiences,
                          visible: _visible,
                        ),
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

  Widget _buildStats(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final stats = AppStrings.stats;
    final colors = [
      AppColors.appleBlue,
      AppColors.appleGreen,
      AppColors.applePurple,
      AppColors.appleOrange,
    ];

    if (isMobile) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: stats.length,
        itemBuilder: (_, i) => StatCard(
          value: stats[i]['value']!,
          label: stats[i]['label']!,
          suffix: stats[i]['suffix']!,
          numericValue: int.tryParse(stats[i]['value']!.replaceAll('+', '')) ?? 0,
          accentColor: colors[i % colors.length],
        ),
      );
    }

    return Row(
      children: List.generate(stats.length, (i) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < stats.length - 1 ? 16 : 0),
            child: StatCard(
              value: stats[i]['value']!,
              label: stats[i]['label']!,
              suffix: stats[i]['suffix']!,
              numericValue: int.tryParse(
                    stats[i]['value']!.replaceAll('+', '').replaceAll('K', ''),
                  ) ??
                  0,
              accentColor: colors[i % colors.length],
            ),
          ),
        );
      }),
    );
  }
}

class _DesktopAboutContent extends StatelessWidget {
  final List experiences;
  final bool visible;

  const _DesktopAboutContent({
    required this.experiences,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Story
        Expanded(
          flex: 5,
          child: _StoryCard(visible: visible),
        ),
        const SizedBox(width: 48),
        // Experience Timeline
        Expanded(
          flex: 5,
          child: _ExperienceTimeline(
            experiences: experiences,
            visible: visible,
          ),
        ),
      ],
    );
  }
}

class _MobileAboutContent extends StatelessWidget {
  final List experiences;
  final bool visible;

  const _MobileAboutContent({
    required this.experiences,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StoryCard(visible: visible),
        const SizedBox(height: 32),
        _ExperienceTimeline(experiences: experiences, visible: visible),
      ],
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool visible;

  const _StoryCard({required this.visible});

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.appleBlue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_outline,
                    color: AppColors.appleBlue, size: 24),
              ),
              const SizedBox(width: 16),
              Text('My Story', style: AppTextStyles.h2),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.aboutDescription,
            style: AppTextStyles.bodyMd,
          ),
          const SizedBox(height: 24),
          _buildHighlights(),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms)
        .slideX(begin: -0.1, end: 0, duration: 700.ms);
  }

  Widget _buildHighlights() {
    final items = [
      (Icons.apple, 'iOS & SwiftUI Expert', AppColors.primaryText),
      (Icons.flutter_dash, 'Flutter Cross-Platform', const Color(0xFF54C5F8)),
      (Icons.store, 'App Store Deployments', AppColors.appleBlue),
      (Icons.groups_outlined, 'Enterprise Client Focus', AppColors.applePurple),
    ];
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(item.$1, size: 16, color: item.$3),
                  const SizedBox(width: 10),
                  Text(item.$2, style: AppTextStyles.bodyMd),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ExperienceTimeline extends StatelessWidget {
  final List experiences;
  final bool visible;

  const _ExperienceTimeline({
    required this.experiences,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Experience', style: AppTextStyles.h2),
        const SizedBox(height: 24),
        ...List.generate(experiences.length, (i) {
          final exp = experiences[i];
          return _TimelineItem(
            experience: exp,
            isLast: i == experiences.length - 1,
            index: i,
          );
        }),
      ],
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 700.ms)
        .slideX(begin: 0.1, end: 0, duration: 700.ms);
  }
}

class _TimelineItem extends StatelessWidget {
  final dynamic experience;
  final bool isLast;
  final int index;

  const _TimelineItem({
    required this.experience,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: experience.isCurrent
                        ? AppColors.appleGreen
                        : AppColors.appleBlue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: experience.isCurrent
                          ? AppColors.appleGreen.withOpacity(0.4)
                          : AppColors.appleBlue.withOpacity(0.4),
                      width: 3,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(experience.role, style: AppTextStyles.h3),
                      ),
                      if (experience.isCurrent)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.appleGreen.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColors.appleGreen.withOpacity(0.3)),
                          ),
                          child: Text(
                            'Current',
                            style: AppTextStyles.labelSm
                                .copyWith(color: AppColors.appleGreen),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(experience.company,
                      style: AppTextStyles.bodyMd
                          .copyWith(color: AppColors.appleBlue)),
                  const SizedBox(height: 2),
                  Text(
                    '${experience.startDate} – ${experience.endDate} • ${experience.location}',
                    style: AppTextStyles.labelSm,
                  ),
                  const SizedBox(height: 10),
                  ...experience.responsibilities.take(3).map(
                        (r) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ',
                                  style: AppTextStyles.bodySm.copyWith(
                                      color: AppColors.appleBlue)),
                              Expanded(
                                child: Text(r, style: AppTextStyles.bodySm),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
