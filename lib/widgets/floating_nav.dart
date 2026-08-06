import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/providers/scroll_provider.dart';

/// Floating pill navigation that appears after scrolling past the hero
class FloatingNav extends ConsumerWidget {
  final List<GlobalKey> sectionKeys;

  const FloatingNav({super.key, required this.sectionKeys});

  void _scrollToSection(int index) {
    if (index >= sectionKeys.length) return;
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(showFloatingNavProvider);
    final activeSection = ref.watch(activeNavSectionProvider);

    final icons = [
      Icons.home_outlined,
      Icons.person_outline,
      Icons.code_outlined,
      Icons.folder_outlined,
      Icons.design_services_outlined,
      Icons.mail_outline,
    ];

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: visible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 400),
        offset: visible ? Offset.zero : const Offset(0, 0.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.sectionBg.withOpacity(0.9),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.glassBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              AppStrings.navItems.length,
              (i) => Tooltip(
                message: AppStrings.navItems[i],
                child: GestureDetector(
                  onTap: () => _scrollToSection(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: activeSection == i
                          ? AppColors.appleBlue.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icons[i],
                      size: 20,
                      color: activeSection == i
                          ? AppColors.appleBlue
                          : AppColors.mutedText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
