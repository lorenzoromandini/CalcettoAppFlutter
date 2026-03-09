import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/connectivity_service.dart';

/// Provider for ConnectivityService instance.
final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(),
);

/// Stream provider for offline status.
///
/// Emits true when offline, false when online.
final offlineStatusProvider = StreamProvider<bool>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.onConnectivityChanged.map((isOnline) => !isOnline);
});

/// Synchronous provider for current offline state.
final isOfflineProvider =
    StateNotifierProvider<OfflineStateNotifier, bool>((ref) {
  return OfflineStateNotifier(
    ref.watch(connectivityServiceProvider),
    ref.watch(offlineBannerProvider.notifier),
  );
});

/// StateNotifier that tracks offline state synchronously.
class OfflineStateNotifier extends StateNotifier<bool> {
  StreamSubscription<bool>? _subscription;
  final StateController<bool>? _bannerController;

  OfflineStateNotifier(
    ConnectivityService connectivityService,
    this._bannerController,
  ) : super(false) {
    _subscription =
        connectivityService.onConnectivityChanged.listen((isOnline) {
      final wasOnline = !state;
      state = !isOnline; // Invert: true = offline

      // Auto-show banner when transitioning to offline
      if (state && !wasOnline) {
        _bannerController?.state = true;
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// Controls visibility of offline banner.
final offlineBannerProvider = StateProvider<bool>((ref) {
  return false;
});

/// Tracks when we last had an internet connection.
final lastOnlineAtProvider = StateProvider<DateTime?>((ref) {
  return null;
});

/// Computes how stale the cache is.
final cacheAgeProvider = Provider<Duration?>((ref) {
  final lastOnlineAt = ref.watch(lastOnlineAtProvider);
  if (lastOnlineAt == null) {
    return null;
  }
  return DateTime.now().difference(lastOnlineAt);
});
