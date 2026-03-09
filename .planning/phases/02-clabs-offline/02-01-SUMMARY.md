---
phase: 02-clabs-offline
plan: 01
subsystem: offline, data, repositories
tags: connectivity_plus, hive, dio, freezed, riverpod

# Dependency graph
requires:
  - phase: 01-foundation-auth
    provides: ApiClient, Dio setup, AuthRepository pattern, cache box
provides:
  - Network connectivity detection service
  - Clubs data models with Hive persistence
  - Network-aware ClubsRepository with cache-first strategy
  - Remote and local datasources with 5-minute TTL
affects:
  - clubs-screen-ui
  - matches-offline
  - home-clabs-integration

# Tech tracking
tech-stack:
  added: [connectivity_plus ^7.0.0, shimmer ^3.0.0, share_plus ^12.0.1]
  patterns: [cache-first with TTL, network-aware repository, Result type error handling]

key-files:
  created:
    - lib/core/services/connectivity_service.dart
    - lib/core/services/clabs_local_datasource.dart
    - lib/core/services/clabs_remote_datasource.dart
    - lib/features/clabs/data/models/club_model.dart
    - lib/features/clabs/data/models/member_model.dart
    - lib/features/clabs/data/repositories/clabs_repository_impl.dart
    - lib/core/providers/connectivity_provider.dart
  modified:
    - pubspec.yaml

key-decisions:
  - Use connectivity_plus for cross-platform network detection
  - Implement 5-minute TTL cache for clubs data
  - Cache-first strategy: check cache before network, always have fallback
  - Result<T> type for functional error handling throughout repository

patterns-established:
  - ConnectivityService: isOnline getter + onConnectivityChanged stream
  - TTL cache: store timestamp with data, invalidate after 5 minutes
  - Network-aware repository: check connectivity before remote calls, graceful fallback

# Metrics
duration: 33 min
completed: 2026-03-09
---

# Phase 2 Plan 01: Clubs Offline Infrastructure Summary

**Network-aware clubs repository with connectivity detection, 5-minute TTL cache, and seamless offline fallback**

## Performance

- **Duration:** 33 min
- **Started:** 2026-03-09T22:19:56Z
- **Completed:** 2026-03-09T22:53:10Z
- **Tasks:** 4
- **Files modified:** 13 (7 created, 6 modified/generated)

## Accomplishments

- Connectivity service detecting network state in real-time on mobile and web
- Clubs data models (Club, Member, MemberStats) with Hive persistence
- TTL cache implementation: 5-minute expiry for data freshness
- Network-aware repository: online→fetch+cache, offline→fallback to cache
- Riverpod providers for connectivity and repository injection

## Task Commits

Each task was committed atomically:

1. **Task 1: Add Dependencies and Connectivity Service** - e32e03b (feat)
   - Added connectivity_plus, shimmer, share_plus to pubspec.yaml
   - Created ConnectivityService with isOnline and onConnectivityChanged
   - Created Riverpod providers for injection

2. **Task 2: Create Club and Member Domain Entities** - cdf7f6b (feat)
   - Club entity: id, name, logoUrl, memberCount, userRole, ClubRole enum
   - Member entity: id, name, avatarUrl, role, joinedAt, MemberStats
   - ClubsRepository interface with Result return types
   - Generated freezed code

3. **Task 3: Create Data Models and TTL Cache Implementation** - 0833a5a (feat)
   - ClubModel and MemberModel with Hive adapters
   - Generated json_serializable and hive code
   - HiveClabsLocalDataSource with 5-min TTL
   - DioClabsRemoteDataSource for API calls

4. **Task 4: Implement Network-Aware Clubs Repository** - 0833a5a (feat)
   - ClubsRepositoryImpl with cache-first strategy
   - Checks connectivity before remote calls
   - Graceful fallback to cache when offline
   - Error mapping: DioException → NetworkFailure/ServerFailure

## Files Created/Modified

- lib/core/services/connectivity_service.dart - Network state detection
- lib/core/providers/connectivity_provider.dart - Riverpod providers
- lib/core/services/clabs_local_datasource.dart - TTL cache with Hive
- lib/core/services/clabs_remote_datasource.dart - API calls with Dio
- lib/features/clabs/data/models/club_model.dart - Club data model
- lib/features/clabs/data/models/member_model.dart - Member data model
- lib/features/clabs/data/repositories/clabs_repository_impl.dart - Repository
- pubspec.yaml - Added Phase 2 dependencies

## Decisions Made

- Use connectivity_plus for network detection (cross-platform support)
- 5-minute TTL for clubs data (balances freshness vs. offline availability)
- Cache-first pattern: always check cache before network, never return empty when cached
- Result type throughout: Success(data) / FailureResult(error) for functional composition

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- Build_runner generated code required proper part directives (resolved)
- LSP errors during development (resolved before commit)

## Next Phase Readiness

- Infrastructure complete for Plan 02: Clubs UI integration
- Repository ready for use in ViewModel providers
- connectivityServiceProvider available for all repository injection
- Need to wire clubsRepositoryProvider in injection.dart (next plan)

---
*Phase: 02-clabs-offline*
*Completed: 2026-03-09*
