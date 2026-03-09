import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/offline_status_provider.dart';

/// Offline indicator banner widget.
///
/// Displays a MaterialBanner when the app is offline,
/// informing users they're viewing cached data.
///
/// Position: Use in Scaffold's body above content or
/// as the banner property of the Scaffold.
///
/// Example:
/// ```dart
/// Scaffold(
///   body: Column(
///     children: [
///       const OfflineIndicator(),
///       Expanded(child: YourContent()),
///     ],
///   ),
/// )
/// ```
class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    final showBanner = ref.watch(offlineBannerProvider);

    // Only show if offline and banner not dismissed
    if (!isOffline || !showBanner) {
      return const SizedBox.shrink();
    }

    final cacheAge = ref.watch(cacheAgeProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: MaterialBanner(
        key: const ValueKey('offline-banner'),
        content: Row(
          children: [
            const Icon(
              Icons.cloud_off,
              color: Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "You're offline. Showing cached data.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (cacheAge != null && cacheAge.inMinutes > 0)
                    Text(
                      'Last updated ${_formatCacheAge(cacheAge)} ago',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.9),
        elevation: 0,
        leading: const Icon(
          Icons.info_outline,
          color: Colors.orange,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Dismiss banner (user can still see cached data)
              ref.read(offlineBannerProvider.notifier).state = false;
            },
            child: const Text('DISMISS'),
          ),
        ],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  String _formatCacheAge(Duration age) {
    if (age.inHours > 0) {
      return '${age.inHours}h ${age.inMinutes % 60}m';
    } else if (age.inMinutes > 0) {
      return '${age.inMinutes}m';
    } else {
      return '${age.inSeconds}s';
    }
  }
}

/// Helper widget that disables its child when offline.
///
/// Wraps any interactive widget (button, etc.) and greys it out
/// when the app is in offline mode.
///
/// Example:
/// ```dart
/// OfflineAwareButton(
///   onTap: () => _generateInviteCode(),
///   child: Text('Generate Invite Code'),
/// )
/// ```
class OfflineAwareButton extends ConsumerWidget {
  final VoidCallback? onTap;
  final Widget child;
  final String? offlineTooltip;

  const OfflineAwareButton({
    super.key,
    this.onTap,
    required this.child,
    this.offlineTooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);

    return Tooltip(
      message:
          isOffline ? (offlineTooltip ?? 'Requires internet connection') : '',
      child: IgnorePointer(
        ignoring: isOffline,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isOffline ? 0.5 : 1.0,
          child: onTap != null && !isOffline
              ? InkWell(onTap: onTap, child: child)
              : child,
        ),
      ),
    );
  }
}

/// Widget that displays when the cache was last updated.
///
/// Shows human-readable time since last online state.
class LastUpdatedText extends ConsumerWidget {
  const LastUpdatedText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheAge = ref.watch(cacheAgeProvider);

    if (cacheAge == null) {
      return const SizedBox.shrink();
    }

    return Text(
      'Last updated ${_formatLastUpdated(cacheAge)}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }

  String _formatLastUpdated(Duration age) {
    if (age.inMinutes < 1) {
      return 'just now';
    } else if (age.inMinutes < 60) {
      return '${age.inMinutes}m ago';
    } else if (age.inHours < 24) {
      return '${age.inHours}h ${age.inMinutes % 60}m ago';
    } else {
      return '${age.inDays}d ago';
    }
  }
}
