---
phase: 02-clubs-offline
plan: 02
subsystem: ui, clubs, presentation
tags: riverpod, shimmer, clubs, offline

# Dependency graph
requires:
  - phase: 02-clubs-offline
    provides: Network-aware ClubsRepository, Club/Member entities, TTL cache, connectivity service
provides:
  - Clubs list UI with pull-to-refresh and shimmer loading
  - Active club state management with Hive persistence
  - Club switching mechanism (long-press + bottom sheet)
  - Role badge widget with role-specific colors
  - Offline indicator banner
  - Material 3 list items with star active indicator
affects:
  - clubs-detail-screen
  - matches-rsvp
  - club-members-view

# Tech tracking
tech-stack:
  added: [shimmer]
  patterns: [ConsumerWidget with ref.watch, AsyncValue state handling, pull-to-refresh with RefreshIndicator]

key-files:
  created:
    - lib/features/clubs/presentation/providers/clubs_list_provider.dart
    - lib/features/clubs/presentation/providers/active_club_provider.dart
    - lib/features/clubs/presentation/screens/clubs_list_screen.dart
    - lib/features/clubs/presentation/widgets/club_list_item.dart
    - lib/features/clubs/presentation/widgets/clubs_list_skeleton.dart
    - lib/features/clubs/presentation/widgets/role_badge.dart
    - lib/features/clubs/presentation/widgets/club_switcher.dart
    - lib/features/clubs/clubs_feature.dart
  modified:
    - lib/core/di/injection.dart
    - lib/features/home/presentation/screens/clubs_screen.dart

key-decisions:
  - Use shimmer package for loading skeleton (not CircularProgressIndicator)
  - Long-press gesture for club switching (in addition to bottom sheet)
  - Active club persisted to Hive for session continuity
  - RefreshIndicator wrapped around ListView for standard pull-to-refresh

patterns-established:
  - AsyncValue loading → shimmer skeleton, error → retry UI pattern
  - ClubListItem: ListTile with leading avatar, subtitle member count, trailing role badge
  - Club switching: confirmation dialog, then setActiveClub with navigation reset

# Metrics
duration: 11 min
completed: 2026-03-09
---

# Phase 2 Plan 02: Clubs List UI Summary

**Clubs list UI with shimmer loading, pull-to-refresh, active club star indicator, and club switching via long-press/bottom sheet**

## Performance

- **Duration:** 11 min
- **Started:** 2026-03-09T23:06:09Z
- **Completed:** 2026-03-09T23:17:26Z
- **Tasks:** 4
- **Files modified:** 10 (8 created, 2 modified)

## Accomplishments

- Clubs list screen with pull-to-refresh using RefreshIndicator
- Shimmer loading skeleton showing 6 placeholders matching club list layout
- Club list items with club logo, name, member count, role badge, star active indicator
- Active club provider with Hive persistence and navigation reset on switch
- Long-press gesture to switch club with confirmation dialog
- Club switcher widget and bottom sheet for alternative switching UX
- Offline banner showing when connectivity is unavailable

## Task Commits

Each task was committed atomically:

1. **Task 1: Create Clubs List Provider and Active Club State** - `f9ec52f` (feat)
   - ClubsList provider with fetch/refresh methods
   - ActiveClub provider with Hive persistence
   - clubs_feature.dart exports
   - clubs providers registered in injection.dart

2. **Task 2: Create Loading Skeleton and Club List Item Widgets** - `3717056` (feat)
   - RoleBadge widget with role-specific colors (OWNER: amber, MANAGER: blue, MEMBER: grey)
   - ClubsListSkeleton with shimmer loading effect
   - ClubListItem ListTile with club info and active star indicator

3. **Task 3: Create Clubs List Screen with Pull-to-Refresh** - `7b8a0c5` (feat)
   - ClubsListScreen with Scaffold, AppBar, RefreshIndicator
   - Loading → skeleton, error → retry UI, data → ListView pattern
   - Offline banner using MaterialBanner
   - Empty state with "No clubs yet" message

4. **Task 4: Implement Club Switching Mechanism** - `f78cd45` (feat)
   - ClubSwitcher widget (compact mode for AppBar, expanded for drawer)
   - ClubSwitcherSheet bottom sheet with radio selection
   - Long-press on ClubListItem triggers switch confirmation dialog

## Files Created/Modified

- `lib/features/clubs/presentation/providers/clubs_list_provider.dart` - Clubs list state management with fetch/refresh
- `lib/features/clubs/presentation/providers/active_club_provider.dart` - Active club selection with Hive persistence
- `lib/features/clubs/presentation/screens/clubs_list_screen.dart` - Main clubs list screen UI
- `lib/features/clubs/clubs_feature.dart` - Public API exports for clubs feature
- `lib/features/clubs/presentation/widgets/club_list_item.dart` - Individual club list item
- `lib/features/clubs/presentation/widgets/clubs_list_skeleton.dart` - Shimmer loading placeholders
- `lib/features/clubs/presentation/widgets/role_badge.dart` - Role badge with color coding
- `lib/features/clubs/presentation/widgets/club_switcher.dart` - Club switching widget + bottom sheet
- `lib/core/di/injection.dart` - Added clubs providers (Dio, datasources, repository)
- `lib/features/home/presentation/screens/clubs_screen.dart` - Updated to wrap ClubsListScreen

## Decisions Made

- Use shimmer package (not CircularProgressIndicator) for better loading UX matching web app
- Long-press gesture for club switching - faster than always opening bottom sheet
- Active club persisted to Hive - maintains selection across app restarts
- RefreshIndicator wrapped around ListView - standard Material pattern users expect

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Added missing Dio provider for club datasources**
- **Found during:** Task 1 (provider registration in injection.dart)
- **Issue:** ApiClient has private _dio field, couldn't share with club datasources
- **Fix:** Created separate dioProvider in injection.dart with same BaseOptions config
- **Files modified:** lib/core/di/injection.dart
- **Verification:** clubsRepositoryProvider builds successfully, datasources receive Dio instance
- **Committed in:** f9ec52f (Task 1 commit)

**2. [Rule 3 - Blocking] Fixed import path in clubs_screen.dart**
- **Found during:** Task 3 (analysis errors)
- **Issue:** Relative import path incorrect ('clubs_list_screen.dart' not found)
- **Fix:** Updated import to '../../../clubs/preservation/preservations/preservations_list_screen.dart'
- **Files modified:** lib/features/home/screens/screens.dart
- **Verification:** flutter analyze shows no errors
- **Committed in:** 7b8a0c5 (Task 3 commit)

---

**Total deviations:** 2 auto-fixed (2 blocking)
**Impact on plan:** Both deviations essential for code to compile. No scope creep - same features delivered.

## Issues Encountered

- None - plan executed smoothly

## Next Phase Readiness

- ✅ Clubs list screen complete with all must-haves
- ✅ Active club provider with persistence ready for club-dependent features
- ✅ Club switching mechanism ready for matches/members contexts
- 📋 Plan 03: Club Detail screen needs ClubDetailScreen implementation
- 📋 Plan 04: Club members view needs member list + FIFA cards future work

---

*Phase: 02-clabs-offline*
*Completed: 2026-03-09*
