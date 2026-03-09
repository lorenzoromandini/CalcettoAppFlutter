import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/biometric_service.dart';

/// Provider for BiometricService.
final biometricServiceProvider = Provider<BiometricService>(
  (ref) => BiometricService(),
);

/// Simplified biometric state.
enum BiometricStatus {
  initial,
  checking,
  enabled,
  disabled,
  error,
}

/// Riverpod notifier for biometric state management.
class BiometricNotifier extends StateNotifier<BiometricStatus> {
  final BiometricService _biometricService;
  String? _errorMessage;

  BiometricNotifier(this._biometricService) : super(BiometricStatus.initial) {
    loadBiometricStatus();
  }

  /// Current error message if in error state.
  String? get errorMessage => _errorMessage;

  /// Checks if device supports biometrics and if biometrics are available.
  ///
  /// Updates state to enabled/disabled based on biometric support and enrollment.
  Future<void> checkBiometricSupport() async {
    state = BiometricStatus.checking;
    _errorMessage = null;

    try {
      final bool canCheckBiometrics =
          await _biometricService.canCheckBiometrics();
      final bool isBiometricAvailable =
          await _biometricService.isBiometricAvailable();

      if (!canCheckBiometrics || !isBiometricAvailable) {
        state = BiometricStatus.disabled;
        return;
      }

      // Device supports biometrics, check if user has enabled it
      final bool isEnabled = await _biometricService.isBiometricEnabled();
      state = isEnabled ? BiometricStatus.enabled : BiometricStatus.disabled;
    } catch (e) {
      _errorMessage = 'Failed to check biometric support: $e';
      state = BiometricStatus.error;
    }
  }

  /// Toggles biometric login on or off.
  ///
  /// [enabled] determines whether to enable or disable biometric login.
  Future<void> toggleBiometric(bool enabled) async {
    _errorMessage = null;

    try {
      if (enabled) {
        await _biometricService.enableBiometric();
        state = BiometricStatus.enabled;
      } else {
        await _biometricService.disableBiometric();
        state = BiometricStatus.disabled;
      }
    } catch (e) {
      _errorMessage = 'Failed to toggle biometric: $e';
      state = BiometricStatus.error;
    }
  }

  /// Loads the current biometric status from Hive.
  ///
  /// Called on initialization to restore persisted state.
  Future<void> loadBiometricStatus() async {
    state = BiometricStatus.checking;
    _errorMessage = null;

    try {
      // First check if device supports biometrics
      final bool canCheckBiometrics =
          await _biometricService.canCheckBiometrics();
      final bool isBiometricAvailable =
          await _biometricService.isBiometricAvailable();

      if (!canCheckBiometrics || !isBiometricAvailable) {
        state = BiometricStatus.disabled;
        return;
      }

      // Check if user has enabled biometric login
      final bool isEnabled = await _biometricService.isBiometricEnabled();
      state = isEnabled ? BiometricStatus.enabled : BiometricStatus.disabled;
    } catch (e) {
      _errorMessage = 'Failed to load biometric status: $e';
      state = BiometricStatus.error;
    }
  }
}

/// Provider for BiometricNotifier.
final biometricEnabledProvider =
    StateNotifierProvider<BiometricNotifier, BiometricStatus>(
  (ref) => BiometricNotifier(ref.watch(biometricServiceProvider)),
);
