# Phase 2: Club Management & Offline Foundation - Research

**Researched:** 2026-03-09
**Domain:** Flutter Offline-First, Club Management, Hive Caching, Network Detection
**Confidence:** HIGH

## Summary

This phase implements read-only offline support for club management using the existing Flutter stack. The architecture leverages Riverpod for state management, Dio for network operations, and Hive for local caching. Key technical decisions center around network state detection, cache invalidation strategies, and handling the "active club" concept across the app.

**Primary recommendation:** Use connectivity_plus for network detection, implement TTL-based cache invalidation in Hive, and use Riverpod's AsyncNotifier for offline-aware state management. Avoid custom pull-to-refresh packages in favor of Flutter's built-in RefreshIndicator for Material 3 compliance.

## User Constraints (from CONTEXT.md)

### Locked Decisions

**Club List Layout**
- Display style: List items (not cards or grid)
- Per club information: Club image (optional), name, member count, role badge
- Active indicator: Star icon on currently selected club
- Navigation: Tap club → opens club detail screen with tabs
- Create button: In app bar (NOT floating action button)

**Club Switching**
- Behavior on switch: Reset to Home tab with new club's data
- Switching mechanism: Claude's discretion
- Quick gestures: Claude's discretion
- Active club display: Claude's discretion

**Offline Behavior**
- Interaction mode: Read-only when offline (no actions allowed)
- Offline indicator: Claude's discretion
- Stale data threshold: Claude's discretion
- Reconnection behavior: Claude's discretion

**Loading States**
- Initial loading: Claude's discretion
- Cached vs fresh timing: Claude's discretion
- Pull-to-refresh: Claude's discretion
- Empty state: Claude's discretion

**Invite Code Sharing**
- Generation permission: Admin only (Owners and Managers)
- Security requirement: One-time use only - second user with same code cannot join
- Expiration: Never expire
- Sharing mechanism: Claude's discretion
- Code format: Claude's discretion

**Member Display**
- Presentation style: FIFA-style player cards (foreshadows Phase 4)
- Information shown: All info on the card (name, stats, etc.)
- Role indicators: Icons (not color badges or text)
- Interactivity: Tappable to view full member profile and statistics

### Claude's Discretion
- Club switching mechanism and UI placement
- Offline indicator style and position
- Loading skeleton/shimmer design
- Pull-to-refresh implementation details
- Invite code format and sharing UX
- Member list sorting and grouping
- Empty state design for new users

### Deferred Ideas (OUT OF SCOPE)
None — discussion stayed within Phase 2 scope

---

## Standard Stack

### Core (Already Installed)
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| flutter_riverpod | ^2.4.0 | State management | Official Flutter Favorite, handles async/loading/error states natively |
| dio | ^5.4.0 | HTTP client | Industry standard, interceptor support for auth/cache |
| hive | ^2.2.3 | Local key-value cache | Fast, type-safe, supports custom objects with adapters |
| hive_flutter | ^1.1.0 | Flutter Hive integration | Required for Hive initialization in Flutter apps |
| freezed | ^2.4.6 | Immutable data classes | Required for Riverpod code generation |
| json_serializable | ^6.7.1 | JSON serialization | Works with freezed for API models |

### Required Additions for Phase 2
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| connectivity_plus | ^7.0.0 | Network state detection | Required for offline/online detection; Flutter Favorite |
| shimmer | ^3.0.0 | Loading skeletons | For skeleton screens during data fetch |
| share_plus | ^12.0.1 | Native share dialog | For sharing invite codes; Flutter Favorite |

### Installation
```yaml
dependencies:
  connectivity_plus: ^7.0.0
  shimmer: ^3.0.0
  share_plus: ^12.0.1
```

**Note:** `pull_to_refresh` package (v2.0.0) is **NOT recommended** - last updated 4 years ago, and Flutter's built-in `RefreshIndicator` is sufficient for Material 3 apps.

---

## Architecture Patterns

### Recommended Project Structure
```
lib/
├── features/
│   └── clubs/
│       ├── clubs_feature.dart              # Public exports
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── clubs_remote_datasource.dart
│       │   │   └── clubs_local_datasource.dart
│       │   ├── models/
│       │   │   ├── club_model.dart
│       │   │   ├── club_model.g.dart
│       │   │   ├── member_model.dart
│       │   │   └── member_model.g.dart
│       │   └── repositories/
│       │       └── clubs_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── club.dart
│       │   │   └── member.dart
│       │   ├── repositories/
│       │   │   └── clubs_repository.dart
│       │   └── usecases/
│       │       ├── get_clubs.dart
│       │       ├── get_club_by_id.dart
│       │       ├── get_club_members.dart
│       │       └── generate_invite_code.dart
│       └── presentation/
│           ├── providers/
│           │   ├── clubs_list_provider.dart
│           │   ├── active_club_provider.dart
│           │   ├── club_members_provider.dart
│           │   └── offline_status_provider.dart
│           ├── screens/
│           │   ├── clubs_list_screen.dart
│           │   └── club_detail_screen.dart
│           └── widgets/
│               ├── club_list_item.dart
│               ├── member_card.dart
│               ├── club_switcher.dart
│               └── offline_indicator.dart
├── core/
│   └── services/
│       └── connectivity_service.dart
```

### Pattern 1: Network-Aware Repository

**What:** Repository checks connectivity before fetching and implements cache-first strategy
**When to use:** All data that needs offline support
**Example:**
```dart
// Source: Verified with connectivity_plus docs
class ClubsRepositoryImpl implements ClubsRepository {
  final ClubsRemoteDataSource remote;
  final ClubsLocalDataSource local;
  final ConnectivityService connectivity;

  @override
  Future<Result<List<Club>>> getClubs() async {
    final isOnline = await connectivity.isOnline;
    
    if (isOnline) {
      try {
        final clubs = await remote.getClubs();
        await local.cacheClubs(clubs);
        return Success(clubs);
      } catch (e) {
        // Fall back to cache on network error
        final cached = await local.getCachedClubs();
        if (cached != null) {
          return Success(cached);
        }
        return FailureResult(NetworkFailure());
      }
    } else {
      final cached = await local.getCachedClubs();
      if (cached != null) {
        return Success(cached);
      }
      return FailureResult(CacheFailure());
    }
  }
}
```

### Pattern 2: TTL Cache Strategy

**What:** Hive-based cache with timestamp tracking for automatic invalidation
**When to use:** When cache freshness matters (5-minute TTL for matches per requirements)
**Example:**
```dart
// Cache strategy for clubs data
class ClubsLocalDataSourceImpl implements ClubsLocalDataSource {
  static const String _clubsKey = 'clubs_cache';
  static const String _clubsTimestampKey = 'clubs_cache_timestamp';
  static const Duration _ttl = Duration(minutes: 5); // Matches requirement OFF-08

  final Box _cacheBox;

  ClubsLocalDataSourceImpl(this._cacheBox);

  @override
  Future<void> cacheClubs(List<ClubModel> clubs) async {
    await _cacheBox.put(_clubsKey, clubs.map((c) => c.toJson()).toList());
    await _cacheBox.put(_clubsTimestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<List<ClubModel>?> getCachedClubs() async {
    final timestamp = _cacheBox.get(_clubsTimestampKey) as int?;
    if (timestamp == null) return null;
    
    final cacheAge = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
    
    if (cacheAge > _ttl) {
      await _cacheBox.delete(_clubsKey);
      await _cacheBox.delete(_clubsTimestampKey);
      return null;
    }
    
    final data = _cacheBox.get(_clubsKey) as List<dynamic>?;
    if (data == null) return null;
    
    return data.map((json) => ClubModel.fromJson(json)).toList();
  }

  @override
  Future<bool> isCacheValid() async {
    final timestamp = _cacheBox.get(_clubsTimestampKey) as int?;
    if (timestamp == null) return false;
    
    final cacheAge = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
    return cacheAge <= _ttl;
  }
}
```

### Pattern 3: Offline-First Riverpod Provider

**What:** Provider that handles loading states, caching, and offline detection
**When to use:** Main list providers (clubs, members)
**Example:**
```dart
// Source: flutter_riverpod docs pattern for async operations
@riverpod
class ClubsList extends _$ClubsList {
  @override
  Future<List<Club>> build() async {
    final repo = ref.read(clubsRepositoryProvider);
    final result = await repo.getClubs();
    
    return result.fold(
      (failure) => throw failure,
      (clubs) => clubs,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(clubsRepositoryProvider);
      final result = await repo.getClubs(forceRefresh: true);
      return result.fold(
        (failure) => throw failure,
        (clubs) => clubs,
      );
    });
  }
}

// UI usage with pull-to-refresh
Consumer(
  builder: (context, ref, child) {
    final clubsAsync = ref.watch(clubsListProvider);
    final isOffline = ref.watch(offlineStatusProvider);
    
    return RefreshIndicator(
      onRefresh: () => ref.read(clubsListProvider.notifier).refresh(),
      child: clubsAsync.when(
        data: (clubs) => _buildList(clubs, isOffline),
        loading: () => _buildSkeleton(),
        error: (error, _) => _buildError(error),
      ),
    );
  },
)
```

### Pattern 4: Connectivity Service

**What:** Centralized network state detection using connectivity_plus
**When to use:** App-wide offline indicator, repository network checks
**Example:**
```dart
// Source: connectivity_plus official docs
class ConnectivityService {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  /// Check if currently online
  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  /// Stream of connectivity changes
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      return !results.contains(ConnectivityResult.none);
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}

// Riverpod provider for connectivity
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

final offlineStatusProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onConnectivityChanged;
});
```

### Pattern 5: FIFA-Style Member Card

**What:** Custom card widget showing member info with stats, foreshadowing Phase 4
**When to use:** Member list display
**Key considerations:**
- Use ClipRRect for rounded corners
- Gradient backgrounds for card styling
- Custom paint for "rarity" borders (bronze/silver/gold tiers)
- Stack layout for overlapping elements

```dart
class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(member.role),
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: CustomPaint(painter: CardPatternPainter()),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar and role icon
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: member.avatarUrl != null
                            ? NetworkImage(member.avatarUrl!)
                            : null,
                        child: member.avatarUrl == null
                            ? Text(member.initials)
                            : null,
                      ),
                      const Spacer(),
                      _RoleIcon(role: member.role),
                    ],
                  ),
                  const Spacer(),
                  // Name and stats
                  Text(member.name, style: Theme.of(context).textTheme.titleMedium),
                  if (member.stats != null) ...[
                    const SizedBox(height: 4),
                    _StatsRow(stats: member.stats!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradientColors(ClubRole role) {
    return switch (role) {
      ClubRole.owner => [Colors.amber.shade300, Colors.amber.shade600],
      ClubRole.manager => [Colors.blue.shade300, Colors.blue.shade600],
      ClubRole.member => [Colors.grey.shade300, Colors.grey.shade600],
    };
  }
}
```

### Pattern 6: Active Club State Management

**What:** Global state for the currently selected club with persistence
**When to use:** When user switches clubs, affects home screen data
**Example:**
```dart
@riverpod
class ActiveClub extends _$ActiveClub {
  static const String _activeClubIdKey = 'active_club_id';

  @override
  Future<Club?> build() async {
    // Load from cache on init
    final box = ref.read(cacheBoxProvider);
    final cachedId = box.get(_activeClubIdKey) as String?;
    
    if (cachedId != null) {
      final repo = ref.read(clubsRepositoryProvider);
      final result = await repo.getClubById(cachedId);
      return result.fold(
        (_) => null,
        (club) => club,
      );
    }
    
    return null;
  }

  Future<void> setActiveClub(String clubId) async {
    final box = ref.read(cacheBoxProvider);
    await box.put(_activeClubIdKey, clubId);
    
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(clubsRepositoryProvider);
      final result = await repo.getClubById(clubId);
      return result.fold(
        (failure) => throw failure,
        (club) => club,
      );
    });
    
    // Reset navigation to home tab
    ref.read(navigationProvider.notifier).setTab(0);
  }
}
```

### Anti-Patterns to Avoid
- **Don't** use Provider family for club-specific data without considering cache invalidation
- **Don't** store large binary data (images) in Hive - use URLs only
- **Don't** check connectivity before EVERY network call (check once, then handle errors gracefully)
- **Don't** use setState for loading states when using Riverpod
- **Don't** implement custom network retry logic - Dio has built-in interceptors

---

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Network connectivity detection | Custom socket checks | connectivity_plus | Handles all platforms, handles airplane mode, VPN detection |
| Pull-to-refresh | Custom gesture detector | Flutter's RefreshIndicator | Native Material 3 behavior, proper haptics |
| Share functionality | Custom share dialogs | share_plus | Native platform share sheets, handles all content types |
| Loading skeletons | Custom AnimatedContainer | shimmer | Optimized shimmer animation, configurable colors/duration |
| JSON serialization | Manual fromJson/toJson | json_serializable | Handles null safety, nested objects, generates code |
| Immutable data classes | Manual @immutable | freezed | Generates copyWith, equality, hashCode automatically |
| Cache timestamp tracking | Manual DateTime fields | TTL pattern with Hive | Standard pattern, easy to implement TTL checks |

**Key insight:** The Flutter ecosystem has mature solutions for all offline-first patterns. Hand-rolling leads to subtle bugs in edge cases (VPN detection, network switching, share sheet positioning on iPad).

---

## Common Pitfalls

### Pitfall 1: Connectivity Check Not Reflecting Reality
**What goes wrong:** connectivity_plus returns "wifi" but the network has no actual internet access (captive portals, airplane wifi)
**Why it happens:** connectivity_plus checks network interface state, not actual internet reachability
**How to avoid:** Always implement request timeouts and error handling; don't assume connectivity == working internet
**Warning signs:** Users report "stuck on loading" despite showing online indicator

### Pitfall 2: Cache Not Invalidated on Club Switch
**What goes wrong:** Old club's data persists when switching to new club
**Why it happens:** Providers not properly invalidated when active club changes
**How to avoid:** Use ref.invalidate() or ref.watch(activeClubProvider) in dependent providers
**Warning signs:** Members from club A appear in club B's member list

### Pitfall 3: Hive Box Not Opened Before Use
**What goes wrong:** Null errors when accessing Hive box
**Why it happens:** Box accessed before Hive.initFlutter() completes
**How to avoid:** Always use provider-based box access after initialization in main.dart
**Warning signs:** "Box not found" exceptions in tests or on app startup

### Pitfall 4: Shimmer Animation Performance
**What goes wrong:** Janky animations on older devices
**Why it happens:** Shimmer rebuilds too frequently or on complex widget trees
**How to avoid:** Keep skeleton layouts simple, use RepaintBoundary if needed
**Warning signs:** Frame drops during loading (check with performance overlay)

### Pitfall 5: Share Sheet Positioning on iPad
**What goes wrong:** Share sheet crashes or appears off-screen on iPad
**Why it happens:** iPad requires explicit sharePositionOrigin parameter
**How to avoid:** Always provide RenderBox position when calling Share.share() on iOS/iPad
**Warning signs:** Crash reports specifically on iPad

### Pitfall 6: Active Club ID Stored but Club Deleted
**What goes wrong:** App tries to load deleted club on startup, crashes or shows errors
**Why it happens:** Club deleted on server but ID still in local cache
**How to avoid:** Validate cached club ID on startup; fallback to first club or null
**Warning signs:** Persistent error on app launch after being removed from a club

---

## Code Examples

### Verified Pattern: Invite Code Sharing
```dart
// Source: share_plus official docs
Future<void> shareInviteCode(BuildContext context, String code) async {
  final box = context.findRenderObject() as RenderBox?;
  
  await SharePlus.instance.share(
    ShareParams(
      text: 'Join my football club! Use invite code: $code',
      subject: 'Club Invitation',
      sharePositionOrigin: box != null 
          ? box.localToGlobal(Offset.zero) & box.size
          : null,
    ),
  );
}
```

### Verified Pattern: Offline Indicator
```dart
// Recommended: Position as banner below app bar or as snackbar
class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOfflineAsync = ref.watch(offlineStatusProvider);
    
    return isOfflineAsync.when(
      data: (isOffline) {
        if (!isOffline) return const SizedBox.shrink();
        
        return MaterialBanner(
          content: const Row(
            children: [
              Icon(Icons.cloud_off, color: Colors.orange),
              SizedBox(width: 8),
              Text('You are offline. Showing cached data.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('DISMISS'),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
```

### Verified Pattern: Skeleton Loading List
```dart
// Source: shimmer package docs
class ClubsListSkeleton extends StatelessWidget {
  const ClubsListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual offline detection | connectivity_plus (plus_plugins) | 2021 | Unified API across all Flutter platforms |
| SQL/SharedPreferences | Hive | 2019-2020 | 10x+ faster writes, native Dart |
| StatefulWidget + setState | Riverpod + AsyncNotifier | 2023 | Built-in loading/error states, better testability |
| CachedNetworkImage manual | Flutter's Image.network + Dio | Ongoing | Use existing Dio interceptors for caching |
| Custom share dialogs | share_plus | 2021 | Native platform behavior, Flutter Favorite |

**Deprecated/outdated:**
- `data_connection_checker`: Replaced by connectivity_plus
- `flutter_offline`: Complex, use connectivity_plus directly
- `cached_network_image`: Still valid but adds dependency; Dio can cache images

---

## Open Questions

1. **Club API Endpoints**
   - What we know: Need GET /clubs, GET /clubs/:id, GET /clubs/:id/members
   - What's unclear: Exact field names, invite code generation endpoint
   - Recommendation: Document in API spec before implementation

2. **Invite Code Format**
   - What we know: One-time use only, admin-only generation
   - What's unclear: Alphanumeric length, format (XXXX-XXXX vs XXXXXXXX)
   - Recommendation: Use 8-char alphanumeric (readable, 36^8 combinations)

3. **Member Statistics**
   - What we know: FIFA-style cards foreshadow Phase 4
   - What's unclear: Which stats are available in Phase 2 vs Phase 4
   - Recommendation: Show basic stats in Phase 2 (matches played, goals), expand in Phase 4

4. **Club Switching UI**
   - What we know: Active club has star icon, switch resets to home
   - What's unclear: Long-press vs tap, drawer vs dropdown
   - Recommendation: Tap to view details, long-press/dropdown to switch

---

## Sources

### Primary (HIGH confidence)
- [pub.dev - connectivity_plus 7.0.0](https://pub.dev/packages/connectivity_plus) - Network detection API
- [pub.dev - hive 2.2.3](https://pub.dev/packages/hive) - Key-value cache patterns
- [pub.dev - flutter_riverpod 3.3.1](https://pub.dev/packages/flutter_riverpod) - Async state management
- [pub.dev - dio 5.9.2](https://pub.dev/packages/dio) - HTTP client with interceptors
- [pub.dev - share_plus 12.0.1](https://pub.dev/packages/share_plus) - Native sharing
- [pub.dev - shimmer 3.0.0](https://pub.dev/packages/shimmer) - Loading skeletons

### Secondary (MEDIUM confidence)
- Riverpod documentation patterns for offline-first apps
- Hive best practices from isar.dev documentation

### Tertiary (LOW confidence)
- None - all core libraries verified with official docs

---

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - All packages verified with pub.dev, Flutter Favorites where applicable
- Architecture: HIGH - Patterns verified against Riverpod/Hive official docs
- Pitfalls: MEDIUM - Some derived from common Flutter patterns, not all verified with specific library docs

**Research date:** 2026-03-09
**Valid until:** 2026-06-09 (90 days - stable packages)
