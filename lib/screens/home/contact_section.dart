import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../widgets/section_header.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/particle_background.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);

    final subject = Uri.encodeComponent(
        'Portfolio Inquiry from ${_nameController.text}');
    final body = Uri.encodeComponent(
        'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\nMessage:\n${_messageController.text}');
    final mailtoUri = Uri.parse(
        'mailto:${AppStrings.email}?subject=$subject&body=$body');

    await Future.delayed(const Duration(milliseconds: 800));
    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    }
    if (mounted) {
      setState(() {
        _sending = false;
        _sent = true;
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _sent = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBg, Color(0xFF061227), AppColors.primaryBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Blue lighting effect
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.appleBlue,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Animated dots
            Positioned.fill(
              child: ParticleBackground(
                color: AppColors.appleBlue,
                particleCount: 40,
              ),
            ),

            // Blue glow center
            Positioned(
              top: -100,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBlob(
                  color: AppColors.appleBlue,
                  size: 600,
                  duration: const Duration(seconds: 15),
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
                      SectionHeader(
                        overline: 'Get in Touch',
                        title: AppStrings.contactTitle,
                        subtitle: AppStrings.contactSubtitle,
                        alignment: CrossAxisAlignment.center,
                        animate: _visible,
                      ),
                      const SizedBox(height: 64),

                      if (_visible)
                        isMobile
                            ? _buildMobileContact()
                            : _buildDesktopContact(),
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

  Widget _buildDesktopContact() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left — contact info
        Expanded(
          flex: 4,
          child: _buildContactInfo()
              .animate()
              .fadeIn(duration: 600.ms)
              .slideX(begin: -0.1, end: 0),
        ),
        const SizedBox(width: 48),
        // Right — form
        Expanded(
          flex: 6,
          child: _buildForm()
              .animate()
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideX(begin: 0.1, end: 0),
        ),
      ],
    );
  }

  Widget _buildMobileContact() {
    return Column(
      children: [
        _buildContactInfo().animate().fadeIn(duration: 600.ms),
        const SizedBox(height: 40),
        _buildForm().animate().fadeIn(delay: 200.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Information', style: AppTextStyles.h2),
        const SizedBox(height: 8),
        Text(
          'Feel free to reach out for collaborations, freelance projects, or just a friendly chat.',
          style: AppTextStyles.bodyMd,
        ),
        const SizedBox(height: 40),
        ..._contactItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GlassCard(
              padding: const EdgeInsets.all(16),
              onTap: item.onTap,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: item.color, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.label, style: AppTextStyles.labelSm),
                      Text(item.value,
                          style: AppTextStyles.labelLg
                              .copyWith(color: AppColors.primaryText)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    if (_sent) {
      return GlassCard(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Icon(Icons.check_circle,
                color: AppColors.appleGreen, size: 64),
            const SizedBox(height: 20),
            Text('Message Sent! 🎉', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text("Your email client has opened with the message. I'll get back to you soon!",
                style: AppTextStyles.bodyMd, textAlign: TextAlign.center),
          ],
        ),
      ).animate().scaleXY(begin: 0.9, end: 1.0, duration: 400.ms).fadeIn();
    }

    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send a Message', style: AppTextStyles.h2),
            const SizedBox(height: 24),

            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.primaryText),
              decoration: const InputDecoration(
                labelText: 'Your Name',
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: AppColors.primaryText),
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.mail_outline, size: 20),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter your email';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _messageController,
              style: const TextStyle(color: AppColors.primaryText),
              decoration: const InputDecoration(
                labelText: 'Message',
                prefixIcon: Icon(Icons.message_outlined, size: 20),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter a message' : null,
            ),
            const SizedBox(height: 24),

            GradientButton(
              label: _sending ? 'Sending...' : 'Send Message',
              suffixIcon: Icons.send_outlined,
              width: double.infinity,
              isLoading: _sending,
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  List<_ContactItem> get _contactItems => [
        _ContactItem(
          icon: Icons.mail_outline,
          label: 'Email',
          value: AppStrings.email,
          color: AppColors.appleRed,
          onTap: () async {
            final uri = Uri.parse('mailto:${AppStrings.email}');
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        _ContactItem(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: AppStrings.phone,
          color: AppColors.appleGreen,
          onTap: () async {
            final uri = Uri.parse('tel:${AppStrings.phone}');
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        _ContactItem(
          icon: Icons.code,
          label: 'GitHub',
          value: 'github.com/dattpatel',
          color: AppColors.secondaryText,
          onTap: () async {
            final uri = Uri.parse(AppStrings.github);
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        _ContactItem(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: AppStrings.location,
          color: AppColors.appleBlue,
          onTap: null,
        ),
      ];
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onTap,
  });
}
