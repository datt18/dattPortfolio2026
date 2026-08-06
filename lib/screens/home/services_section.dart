import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../widgets/section_header.dart';
import '../../widgets/glass_card.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return VisibilityDetector(
      key: const Key('services-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBg, AppColors.sectionBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
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
                    overline: 'What I Offer',
                    title: AppStrings.servicesTitle,
                    subtitle: AppStrings.servicesSubtitle,
                    alignment: CrossAxisAlignment.center,
                    animate: _visible,
                  ),
                  const SizedBox(height: 64),
                  if (_visible) _buildServicesGrid(context, isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context, bool isMobile) {
    final columns = isMobile ? 1 : 3;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (columns - 1) * 24) / columns;
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: _services
              .asMap()
              .entries
              .map(
                (e) => SizedBox(
                  width: itemWidth,
                  child: _ServiceCard(
                    service: e.value,
                    index: e.key,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

final _services = [
  _ServiceData(
    icon: Icons.phone_iphone,
    title: 'iOS Development',
    description:
        'Native iPhone & iPad apps using Swift, SwiftUI, and UIKit. '
        'From architecture to App Store submission.',
    color: AppColors.appleBlue,
    features: [
      'Swift & SwiftUI',
      'UIKit & Storyboards',
      'App Store Deployment',
      'Performance Optimization',
    ],
  ),
  _ServiceData(
    icon: Icons.flutter_dash,
    title: 'Flutter Development',
    description:
        'Cross-platform apps for iOS, Android, and Web using Flutter & Dart. '
        'Single codebase, premium feel.',
    color: const Color(0xFF54C5F8),
    features: [
      'iOS & Android',
      'Flutter Web',
      'Riverpod State Mgmt',
      'Clean Architecture',
    ],
  ),
  _ServiceData(
    icon: Icons.business_center,
    title: 'Enterprise Applications',
    description:
        'Large-scale mobile solutions for conferences, events, education, '
        'and inventory management.',
    color: AppColors.applePurple,
    features: [
      'Offline-first Architecture',
      'REST API Integration',
      'Real-time Features',
      'SQLite & Firebase',
    ],
  ),
  _ServiceData(
    icon: Icons.store,
    title: 'App Store Deployment',
    description:
        'Complete App Store submission lifecycle from certificates and '
        'provisioning to release and monitoring.',
    color: AppColors.appleBlue,
    features: [
      'Certificates & Signing',
      'TestFlight Beta',
      'App Store Review',
      'ASO & Analytics',
    ],
  ),
  _ServiceData(
    icon: Icons.api,
    title: 'API Integration',
    description:
        'Seamless integration of REST APIs, Firebase, OpenAI, Mapbox, '
        'and real-time services via Socket.IO.',
    color: AppColors.appleGreen,
    features: [
      'REST & GraphQL',
      'Firebase Suite',
      'AI/LLM APIs',
      'WebSocket / Socket.IO',
    ],
  ),
  _ServiceData(
    icon: Icons.speed,
    title: 'Performance & Consulting',
    description:
        'Code reviews, architecture consultation, performance profiling, '
        'bug fixing, and app modernization.',
    color: AppColors.appleOrange,
    features: [
      'Performance Profiling',
      'Architecture Review',
      'Bug Fixing',
      'Legacy Migration',
    ],
  ),
];

class _ServiceCard extends StatelessWidget {
  final _ServiceData service;
  final int index;

  const _ServiceCard({required this.service, required this.index});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  service.color.withOpacity(0.2),
                  service.color.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: service.color.withOpacity(0.2)),
            ),
            child: Icon(service.icon, color: service.color, size: 28),
          ),
          const SizedBox(height: 20),

          Text(service.title, style: AppTextStyles.h2),
          const SizedBox(height: 10),
          Text(service.description, style: AppTextStyles.bodySm),
          const SizedBox(height: 20),

          // Feature list
          ...service.features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 14, color: service.color),
                  const SizedBox(width: 8),
                  Text(f, style: AppTextStyles.bodySm),
                ],
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: 600.ms,
        )
        .slideY(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          duration: 600.ms,
          curve: Curves.easeOut,
        );
  }
}

class _ServiceData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<String> features;

  const _ServiceData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.features,
  });
}
