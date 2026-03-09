import 'package:local_auth/local_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

/// Service for biometric authentication (Face ID/Touch ID).
///
/// Wraps local_auth package functionality and provides methods for:
/// - Checking biometric support on device
/// - Authenticating with biometrics
/// - Managing biometric login preference in Hive
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Checks if the device supports biometric authentication.
  ///
  /// Returns true if the device has biometric hardware and it's available.
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  /// Checks if biometrics are enrolled on the device.
  ///
  /// Returns true if at least one biometric (fingerprint, face, iris) is enrolled.
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canCheckBiometrics = await this.canCheckBiometrics();
      if (!canCheckBiometrics) return false;

      final List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) return false;

      return await _localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  /// Prompts the user for biometric authentication.
  ///
  /// [reason] is the message displayed in the biometric prompt.
  /// Returns true if authentication succeeds, false otherwise.
  Future<bool> authenticate({String reason = 'Authenticate to login'}) async {
    try {
      // Check if biometrics are available first
      final bool hasBiometricSupport = await canCheckBiometrics();
      final bool hasBiometricEnrolled = await isBiometricAvailable();

      if (!hasBiometricSupport || !hasBiometricEnrolled) {
        return false;
      }

      // Authenticate with biometrics
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true, // Keep prompting until success or cancel
        ),
      );

      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  /// Enables biometric login by saving preference to Hive.
  ///
  /// Stores the preference in the 'auth' Hive box with key 'biometric_enabled'.
  Future<void> enableBiometric() async {
    try {
      final box = await Hive.openBox(AppConstants.authBoxName);
      await box.put(AppConstants.biometricEnabledKey, true);
    } catch (e) {
      throw Exception('Failed to enable biometric: $e');
    }
  }

  /// Disables biometric login by removing preference from Hive.
  ///
  /// Removes the 'biometric_enabled' key from the 'auth' Hive box.
  Future<void> disableBiometric() async {
    try {
      final box = await Hive.openBox(AppConstants.authBoxName);
      await box.delete(AppConstants.biometricEnabledKey);
    } catch (e) {
      throw Exception('Failed to disable biometric: $e');
    }
  }

  /// Checks if biometric login is enabled.
  ///
  /// Returns true if the user has previously enabled biometric login.
  Future<bool> isBiometricEnabled() async {
    try {
      final box = await Hive.openBox(AppConstants.authBoxName);
      return box.get(AppConstants.biometricEnabledKey, defaultValue: false);
    } catch (e) {
      return false;
    }
  }
}
