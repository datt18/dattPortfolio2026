import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/text_styles.dart';

class LoadingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const LoadingScreen({super.key, required this.onComplete});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _progressController.forward().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 300), widget.onComplete);
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            AnimatedBuilder(
              animation: _pulseController,
              builder: (_, __) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.appleBlue, AppColors.applePurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appleBlue.withOpacity(
                          0.3 + 0.2 * _pulseController.value),
                      blurRadius: 20 + 10 * _pulseController.value,
                    ),
                  ],
                ),
                child: const Icon(Icons.apple, color: Colors.white, size: 44),
              ),
            ),
            const SizedBox(height: 32),

            Text('DP', style: AppTextStyles.navBrand.copyWith(fontSize: 28)),
            const SizedBox(height: 4),
            Text(AppStrings.tagline, style: AppTextStyles.bodySm),

            const SizedBox(height: 40),

            // Progress bar
            SizedBox(
              width: 200,
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (_, __) => Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        value: _progressController.value,
                        backgroundColor: AppColors.border,
                        valueColor: const AlwaysStoppedAnimation(AppColors.appleBlue),
                        minHeight: 3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(_progressController.value * 100).round()}%',
                      style: AppTextStyles.labelSm,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms);
  }
}
