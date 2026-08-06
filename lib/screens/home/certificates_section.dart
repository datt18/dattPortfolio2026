import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/certificate_model.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/providers/portfolio_provider.dart';
import '../../widgets/section_header.dart';

class CertificatesSection extends ConsumerStatefulWidget {
  const CertificatesSection({super.key});

  @override
  ConsumerState<CertificatesSection> createState() =>
      _CertificatesSectionState();
}

class _CertificatesSectionState extends ConsumerState<CertificatesSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final certificates = ref.watch(certificatesProvider);

    return VisibilityDetector(
      key: const Key('certificates-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: AppColors.sectionBg,
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
                    overline: 'Credentials',
                    title: AppStrings.certificatesTitle,
                    subtitle: AppStrings.certificatesSubtitle,
                    alignment: CrossAxisAlignment.center,
                    animate: _visible,
                  ),
                  const SizedBox(height: 64),
                  if (_visible) _buildTimeline(certificates, isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(List<CertificateModel> certs, bool isMobile) {
    if (isMobile) {
      return Column(
        children: certs
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _CertCard(cert: e.value, index: e.key),
              ),
            )
            .toList(),
      );
    }

    // Desktop: alternating timeline
    return Column(
      children: certs
          .asMap()
          .entries
          .map((e) => _TimelineCertItem(
                cert: e.value,
                index: e.key,
                isLast: e.key == certs.length - 1,
              ))
          .toList(),
    );
  }
}

class _TimelineCertItem extends StatelessWidget {
  final CertificateModel cert;
  final int index;
  final bool isLast;

  const _TimelineCertItem({
    required this.cert,
    required this.index,
    required this.isLast,
  });

  bool get isLeft => index % 2 == 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        children: [
          // Left content
          Expanded(
            child: isLeft
                ? _CertCard(cert: cert, index: index, alignRight: true)
                : const SizedBox.shrink(),
          ),

          // Center line + dot
          Column(
            children: [
              if (index == 0)
                Container(height: 40, width: 1, color: AppColors.border),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: cert.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: cert.color.withOpacity(0.3),
                    width: 4,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                    child: Container(width: 1, color: AppColors.border)),
            ],
          ),

          // Right content
          Expanded(
            child: !isLeft
                ? _CertCard(cert: cert, index: index, alignRight: false)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  final CertificateModel cert;
  final int index;
  final bool alignRight;

  const _CertCard({
    required this.cert,
    required this.index,
    this.alignRight = false,
  });

  String get _statusLabel {
    switch (cert.status) {
      case CertificateStatus.achieved:
        return 'Achieved';
      case CertificateStatus.inProgress:
        return 'In Progress';
      case CertificateStatus.planned:
        return 'Planned';
    }
  }

  Color get _statusColor {
    switch (cert.status) {
      case CertificateStatus.achieved:
        return AppColors.appleGreen;
      case CertificateStatus.inProgress:
        return AppColors.appleOrange;
      case CertificateStatus.planned:
        return AppColors.mutedText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: alignRight ? 0 : 16,
        right: alignRight ? 16 : 0,
        top: 12,
        bottom: 12,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.glassCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cert.color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cert.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(cert.icon, color: cert.color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cert.title,
                      style: AppTextStyles.labelLg,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(cert.issuer, style: AppTextStyles.labelSm),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          _statusLabel,
                          style: AppTextStyles.labelSm
                              .copyWith(color: _statusColor),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(cert.date, style: AppTextStyles.labelSm),
                    ],
                  ),
                ],
              ),
            ),
            if (cert.credentialUrl != null)
              IconButton(
                icon: const Icon(Icons.open_in_new,
                    size: 16, color: AppColors.appleBlue),
                onPressed: () async {
                  final uri = Uri.parse(cert.credentialUrl!);
                  if (await canLaunchUrl(uri)) await launchUrl(uri);
                },
              ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 150 * index),
          duration: 600.ms,
        )
        .slideX(
          begin: alignRight ? -0.1 : 0.1,
          end: 0,
          delay: Duration(milliseconds: 150 * index),
          duration: 600.ms,
        );
  }
}
