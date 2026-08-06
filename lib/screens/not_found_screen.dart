import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/text_styles.dart';
import '../widgets/gradient_button.dart';
import '../widgets/particle_background.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Stack(
        children: [
          const Positioned.fill(
            child: GridBackground(color: AppColors.border),
          ),
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBlob(
                color: AppColors.appleRed,
                size: 500,
                duration: const Duration(seconds: 10),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.appleBlue, AppColors.applePurple],
                  ).createShader(bounds),
                  child: Text(
                    AppStrings.notFoundTitle,
                    style: AppTextStyles.displayXl.copyWith(
                      color: Colors.white,
                      fontSize: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.notFoundSubtitle, style: AppTextStyles.displaySm),
                const SizedBox(height: 12),
                Text(
                  AppStrings.notFoundMessage,
                  style: AppTextStyles.bodyLg,
                ),
                const SizedBox(height: 40),
                GradientButton(
                  label: AppStrings.goHome,
                  prefixIcon: Icons.home_outlined,
                  onPressed: () => context.go('/'),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scaleXY(begin: 0.9, end: 1.0, duration: 600.ms),
          ),
        ],
      ),
    );
  }
}
