import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/text_styles.dart';
import '../core/providers/theme_provider.dart';
import '../core/providers/scroll_provider.dart';

class PortfolioNavBar extends ConsumerStatefulWidget {
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const PortfolioNavBar({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
  });

  @override
  ConsumerState<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends ConsumerState<PortfolioNavBar> {
  int _hoveredIndex = -1;

  void _scrollToSection(int index) {
    if (index >= widget.sectionKeys.length) return;
    final key = widget.sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final activeSection = ref.watch(activeNavSectionProvider);
    final isMobile = MediaQuery.of(context).size.width < 768;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: isMobile ? 60 : 72,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.primaryBg.withOpacity(0.8)
                : Colors.white.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48),
            child: Row(
              children: [
                // Brand
                Text(
                  'DP',
                  style: AppTextStyles.navBrand.copyWith(
                    color: AppColors.appleBlue,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppStrings.name,
                  style: AppTextStyles.navBrand,
                ),

                const Spacer(),

                // Nav items — desktop only
                if (!isMobile) ...[
                  ...List.generate(AppStrings.navItems.length, (i) {
                    final isActive = activeSection == i;
                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoveredIndex = i),
                      onExit: (_) => setState(() => _hoveredIndex = -1),
                      child: GestureDetector(
                        onTap: () => _scrollToSection(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.appleBlue.withOpacity(0.12)
                                : _hoveredIndex == i
                                    ? AppColors.glassCard
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            AppStrings.navItems[i],
                            style: isActive
                                ? AppTextStyles.navItemActive.copyWith(
                                    color: AppColors.appleBlue)
                                : AppTextStyles.navItem,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 16),
                ],

                // Theme toggle
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      key: ValueKey(isDark),
                      color: AppColors.secondaryText,
                      size: 20,
                    ),
                  ),
                  onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
                  tooltip: isDark ? 'Light mode' : 'Dark mode',
                ),

                // Mobile menu
                if (isMobile)
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.secondaryText),
                    onPressed: () => _showMobileMenu(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -1, end: 0, duration: 600.ms);
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              ...List.generate(
                AppStrings.navItems.length,
                (i) => ListTile(
                  title: Text(AppStrings.navItems[i], style: AppTextStyles.h3),
                  onTap: () {
                    Navigator.pop(context);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _scrollToSection(i);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
