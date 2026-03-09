import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/injection.dart';
import '../../core/services/cache_service.dart';

/// Provider for theme mode (system/light/dark).
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.watch(cacheServiceProvider));
});

/// Notifier for managing theme mode state.
///
/// Persists user preference to cache and defaults to system preference.
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final CacheService _cacheService;

  ThemeModeNotifier(this._cacheService) : super(ThemeMode.system) {
    _loadThemePreference();
  }

  /// Load saved theme preference from cache.
  Future<void> _loadThemePreference() async {
    try {
      final savedTheme = await _cacheService.get<String>('theme_mode');
      if (savedTheme != null) {
        state = switch (savedTheme) {
          'light' => ThemeMode.light,
          'dark' => ThemeMode.dark,
          _ => ThemeMode.system,
        };
      }
    } catch (e) {
      // Default to system if cache read fails
      state = ThemeMode.system;
    }
  }

  /// Set theme to follow system preference.
  Future<void> setSystem() async {
    state = ThemeMode.system;
    await _saveThemePreference('system');
  }

  /// Set theme to light mode.
  Future<void> setLight() async {
    state = ThemeMode.light;
    await _saveThemePreference('light');
  }

  /// Set theme to dark mode.
  Future<void> setDark() async {
    state = ThemeMode.dark;
    await _saveThemePreference('dark');
  }

  /// Save theme preference to cache.
  Future<void> _saveThemePreference(String theme) async {
    try {
      await _cacheService.put('theme_mode', theme);
    } catch (e) {
      // Ignore cache errors - theme still works in memory
    }
  }
}
