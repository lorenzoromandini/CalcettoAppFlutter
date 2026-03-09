import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/connectivity_service.dart';

/// Provider for ConnectivityService instance.
///
/// Use this to inject connectivity detection into repositories.
final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(),
);

/// Stream provider for real-time connectivity state.
///
/// Emits true when online, false when offline.
/// Use in UI to show/hide offline banners or disable network features.
///
/// Auto-disposes when no longer listened to.
final isOnlineProvider = StreamProvider<bool>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);

  // Get initial state first
  // Note: Stream only provides changes, not initial state
  // UI should check connectivityService.isOnline() for current state

  return connectivityService.onConnectivityChanged;
});
