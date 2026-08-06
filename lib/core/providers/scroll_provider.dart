import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks scroll progress (0.0 – 1.0) for the scroll progress bar
final scrollProgressProvider = StateProvider<double>((ref) => 0.0);

/// Tracks the active nav section
final activeNavSectionProvider = StateProvider<int>((ref) => 0);

/// Controls whether to show the floating nav (appears after scrolling past hero)
final showFloatingNavProvider = StateProvider<bool>((ref) => false);

/// Controls the loading screen visibility
final isLoadingProvider = StateProvider<bool>((ref) => true);
