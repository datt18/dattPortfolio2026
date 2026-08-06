import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/scroll_provider.dart';
import '../widgets/nav_bar.dart';
import '../widgets/floating_nav.dart';
import '../widgets/scroll_progress_bar.dart';
import '../widgets/loading_screen.dart';
import 'home/hero_section.dart';
import 'home/about_section.dart';
import 'home/skills_section.dart';
import 'home/projects_section.dart';
import 'home/services_section.dart';
import 'home/certificates_section.dart';
import 'home/contact_section.dart';
import 'home/footer_section.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for navigation
  final List<GlobalKey> _sectionKeys = List.generate(8, (_) => GlobalKey());

  // 0=Home, 1=About, 2=Skills, 3=Projects, 4=Services, 5=Certs, 6=Contact
  late final List<GlobalKey> _navKeys;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _navKeys = _sectionKeys.sublist(0, 7);
    _scrollController.addListener(_onScroll);
    // Loading screen
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ref.read(isLoadingProvider.notifier).state = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Update scroll progress
    if (maxScroll > 0) {
      ref.read(scrollProgressProvider.notifier).state =
          currentScroll / maxScroll;
    }

    // Show/hide floating nav
    final showNav = currentScroll > 400;
    if (ref.read(showFloatingNavProvider) != showNav) {
      ref.read(showFloatingNavProvider.notifier).state = showNav;
    }

    // Update active section
    _updateActiveSection();
  }

  void _updateActiveSection() {
    const threshold = 100.0;

    for (var i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final ctx = key.currentContext;
      if (ctx != null) {
        final renderBox = ctx.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final pos = renderBox.localToGlobal(Offset.zero);
          if (pos.dy - threshold <= 0) {
            ref.read(activeNavSectionProvider.notifier).state = i;
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    if (index >= _sectionKeys.length) return;
    final key = _sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen(
        onComplete: () => setState(() => _isLoading = false),
      );
    }

    // Compute nav height here so the delegate's min/max extent matches
    // exactly what PortfolioNavBar renders — prevents the
    // "layoutExtent exceeds paintExtent" SliverGeometry assertion.
    final navHeight = MediaQuery.of(context).size.width < 768 ? 60.0 : 72.0;

    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Sticky nav bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavBarDelegate(
                  sectionKeys: _navKeys,
                  scrollController: _scrollController,
                  height: navHeight,
                ),
              ),

              // Scroll progress bar
              SliverToBoxAdapter(
                child: const ScrollProgressBar(),
              ),

              // Hero
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onViewProjects: () => _scrollToSection(3),
                    onContact: () => _scrollToSection(6),
                  ),
                ),
              ),

              // About
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),
              ),

              // Skills
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),
              ),

              // Projects
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),
              ),

              // Services
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const ServicesSection(),
                ),
              ),

              // Certificates
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[5],
                  child: const CertificatesSection(),
                ),
              ),

              // Contact
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[6],
                  child: const ContactSection(),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[7],
                  child: FooterSection(onBackToTop: _scrollToTop),
                ),
              ),
            ],
          ),

          // Floating nav pill — centered bottom
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingNav(sectionKeys: _navKeys),
            ),
          ),
        ],
      ),
    );
  }
}

/// SliverPersistentHeaderDelegate for the nav bar.
///
/// [height] must equal the actual rendered height of [PortfolioNavBar] for the
/// current screen width — otherwise Flutter throws a SliverGeometry assertion
/// because layoutExtent would exceed paintExtent.
class _NavBarDelegate extends SliverPersistentHeaderDelegate {
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;
  final double height;

  _NavBarDelegate({
    required this.sectionKeys,
    required this.scrollController,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PortfolioNavBar(
      sectionKeys: sectionKeys,
      scrollController: scrollController,
    );
  }

  @override
  bool shouldRebuild(covariant _NavBarDelegate oldDelegate) =>
      oldDelegate.height != height;
}
