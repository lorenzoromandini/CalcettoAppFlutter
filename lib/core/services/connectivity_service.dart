import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for detecting network connectivity status.
///
/// Uses connectivity_plus to monitor network state and provide
/// real-time updates when connectivity changes.
class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  /// Checks if the device is currently online.
  ///
  /// Returns true if any network connection is available
  /// (WiFi, mobile, ethernet, etc.), false if no connection.
  ///
  /// Handles edge cases:
  /// - VPN: Returns true if underlying network is available
  /// - Captive portal: Returns true (connectivity exists, even if limited)
  /// - No internet but connected: Returns true (L2 connectivity)
  Future<bool> get isOnline async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.isEmpty) {
        return false;
      }

      // Check all connectivity types
      for (final result in results) {
        switch (result) {
          case ConnectivityResult.none:
            // Continue checking other interfaces
            break;
          case ConnectivityResult.wifi:
          case ConnectivityResult.mobile:
          case ConnectivityResult.ethernet:
          case ConnectivityResult.bluetooth:
          case ConnectivityResult.other:
          case ConnectivityResult.vpn:
            // Any non-none connectivity means online
            return true;
        }
      }

      // If all results were none, we're offline
      return false;
    } on SocketException {
      // Network stack error, assume offline
      return false;
    } catch (e) {
      // Log error in production, fail gracefully
      return false;
    }
  }

  /// Stream of connectivity changes.
  ///
  /// Emits true when device goes online, false when offline.
  /// Listen to this stream to react to connectivity changes in real-time.
  ///
  /// Important: Always call [isOnline] getter first for initial state,
  /// then listen to this stream for changes.
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      if (results.isEmpty) {
        return false;
      }

      for (final result in results) {
        if (result != ConnectivityResult.none) {
          return true;
        }
      }

      return false;
    }).handleError((error) {
      // Stream error - emit false as safe default
      return false;
    });
  }

  /// Disposes resources. Call when service is no longer needed.
  void dispose() {
    // connectivity_plus manages its own resources
    // No explicit cleanup needed
  }
}
