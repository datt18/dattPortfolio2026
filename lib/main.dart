import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'screens/portfolio_screen.dart';
import 'screens/not_found_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DattProApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      path: '/404',
      name: 'notFound',
      builder: (context, state) => const NotFoundScreen(),
    ),
  ],
);

class DattProApp extends ConsumerWidget {
  const DattProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Datt Patel — iOS & Flutter Developer',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
