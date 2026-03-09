---
phase: 02-clubs-offline
plan: 04
subsystem: ui, offline, home
tags: offline, riverpod, material3, connectivity

# Dependency graph
requires:
  - phase: 02-clubs-offline
    provides: ClubsRepository, connectivity detection, active club provider
provides:
  - Offline indicator widget with Material 3 MaterialBanner
  - Offline-aware providers (isOfflineProvider, offlineBannerProvider, cacheAgeProvider)
  - Home screen with active club context and quick stats
  - Read-only mode enforcement across club screens
  - ActiveClubHeader widget for club display

affects:
  - clubs-ui-integration
  - matches-offline (Phase 3)
  - home-screen-polish

# Tech tracking
tech-stack:
  added: [offline_status_provider, OfflineIndicator widget, ActiveClubHeader]
  patterns: [OfflineAware helper pattern, cache age tracking, dismissible banner]

key-files:
  created:
    - lib/core/providers/offline_status_provider.dart
    - lib/core/widgets/offline_indicator.dart
    - lib/features/home/presentation/widgets/active_club_header.dart
    - lib/features/home/presentation/screens/home_screen.dart (complete rewrite)
  modified:
    - lib/features/clubs/presentation/screens/clubs_list_screen.dart
    - lib/features/clubs/presentation/screens/club_detail_screen.dart
    - lib/features/clubs/presentation/widgets/invite_code_generator.dart
    - lib/core/widgets/app_drawer.dart

key-decisions:
  - Use MaterialBanner for offline indicator (consistent with Material 3)
  - Show cache age in offline indicator when >1 minute
  - Disable action buttons with opacity + IgnorePointer pattern
  - Home screen: ActiveClubHeader with role icon and stats
  - Quick stats with color-coded cards (Members, Matches, Role)

patterns-established:
  - OfflineAwareButton helper: tooltip + IgnorePointer + opacity animation
  - Cache age display: "Last updated Xm ago" for user context
  - Home screen sliver layout for proper scrolling behavior

# Metrics
duration: 7 min
completed: 2026-03-09
---

# Phase 2 Plan 04: Offline Indicator & Home Screen Summary

**Offline indicator with Material 3 banner, read-only mode enforcement, and home screen with active club context**

## Performance

- **Duration:** 7 min
- **Started:** 2026-03-09T23:29:07Z
- **Completed:** 2026-03-09T23:36:17Z
- **Tasks:** 4
- **Files modified:** 9 (5 created, 4 modified)

## Accomplishments

- OfflineIndicator widget with MaterialBanner, cache age display, dismissible
- Offline state providers: isOfflineProvider, offlineBannerProvider, cacheAgeProvider
- Home screen rewrite with ActiveClubHeader, Quick Stats, phase 3 placeholders
- Read-only mode enforcement: disabled create club, share, invite generation when offline
- ActiveClubHeader widget with club logo, role icon, tap to switch
- Offline indicator integrated in clubs list, club detail, home screens

## Task Commits

Each task was committed atomically:

1. **Task 1: Create Offline Indicator Widget and Provider** - `29d9cf5` (feat)
   - offline_status_provider.dart: StreamProvider, StateNotifier providers
   - offline_indicator.dart: MaterialBanner, OfflineAwareButton, LastUpdatedText
   - Auto-shows banner when network disconnects

2. **Task 2: Integrate Offline Indicator Across Screens** - `ecef644` (feat)
   - clubs_list_screen.dart: Disabled create button when offline
   - club_detail_screen.dart: Disabled share button when offline
   - invite_code_generator.dart: Shows offline message, disables generation
   - app_drawer.dart: Offline status in drawer header

3. **Task 3: Complete Home Screen with Active Club Context** - `da658c4` (feat)
   - home_screen.dart: Complete rewrite with CustomScrollView
   - ActiveClubHeader widget: Club info, role, logo
   - Quick Stats cards: Members, Matches, Role
   - Upcoming matches and Recent Activity placeholders (Phase 3)
   - Skeleton loading, error handling, pull-to-refresh

4. **Task 4: Final Integration and Testing Preparation** - `73f47c7` (fix)
   - Flutter analyze passes with no errors
   - Fixed memberCount null check warning
   - All imports resolve correctly

## Files Created/Modified

- `lib/core/providers/offline_status_provider.dart` - Offline state management with stream/notifier
- `lib/core/widgets/offline_indicator.dart` - MaterialBanner + helper widgets
- `lib/features/home/presentation/widgets/active_club_header.dart` - Club header with role icon
- `lib/features/home/presentation/screens/home_screen.dart` - Complete home screen
- `lib/features/clubs/presentation/screens/clubs_list_screen.dart` - Integrated offline indicator
- `lib/features/clubs/presentation/screens/club_detail_screen.dart` - Integrated offline indicator
- `lib/features/clubs/presentation/widgets/invite_code_generator.dart` - Offline handling
- `lib/core/widgets/app_drawer.dart` - Offline status in header

## Decisions Made

- **Material 3 MaterialBanner:** Used for offline indicator (consistent with app theme)
- **Cache age display:** Shows "Last updated Xm ago" for user context when >1 minute
- **Disable pattern:** Opacity + IgnorePointer + Tooltip for offline-aware buttons
- **Home screen layout:** CustomScrollView with slivers for proper scrolling and refresh
- **Quick stats cards:** Color-coded (primary/secondary/tertiary) for visual hierarchy

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- **Pre-existing typo directory:** The 02-clabs-offline directory has typos (clabs vs clubs) - not addressed in this plan
- **Deprecated API:** flutter analyze shows withOpacity deprecation warnings (will be addressed in cleanup phase)
- **Share API deprecated:** share_plus Share.share is deprecated, should use SharePlus.instance.share()

## Next Phase Readiness

- ✅ Offline indicator fully integrated across all club screens
- ✅ Read-only mode enforced (all write actions disabled when offline)
- ✅ Home screen shows active club context with stats
- ✅ Cache age tracking implemented for user feedback
- ⏭️ Phase 3: Matches & RSVP can now build on this foundation
- ⏭️ Home screen placeholders ready for real data (matches, activity feed)
- ⏭️ Club functionality complete for Phase 2

---
*Phase: 02-clubs-offline*
*Completed: 2026-03-09*
