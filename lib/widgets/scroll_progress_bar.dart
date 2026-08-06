import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/scroll_provider.dart';

class ScrollProgressBar extends ConsumerWidget {
  const ScrollProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(scrollProgressProvider);

    return Container(
      height: 2,
      width: double.infinity,
      color: AppColors.border,
      alignment: Alignment.centerLeft,
      child: AnimatedFractionallySizedBox(
        duration: const Duration(milliseconds: 100),
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.appleBlue, AppColors.applePurple],
            ),
          ),
        ),
      ),
    );
  }
}
