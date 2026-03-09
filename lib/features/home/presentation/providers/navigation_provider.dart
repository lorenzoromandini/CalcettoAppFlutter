import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation state class holding current index.
class NavigationState {
  final int currentIndex;

  const NavigationState({this.currentIndex = 0});

  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

/// Provider for bottom navigation state.
final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

/// Notifier for managing bottom navigation state.
///
/// Manages the current tab index for the bottom navigation bar.
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState(currentIndex: 0));

  /// Set the current navigation index.
  void setIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  /// Reset navigation to home (index 0).
  void resetToHome() {
    state = const NavigationState(currentIndex: 0);
  }
}

/// Number of tabs in bottom navigation.
const int navigationTabCount = 4;
