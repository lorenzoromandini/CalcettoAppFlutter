---
phase: 02-clubs-offline
plan: 03
subsystem: ui, clubs, presentation
tags: flutter, riverpod, material3, share_plus, shimmer

# Dependency graph
requires:
  - phase: 02-clubs-offline
    provides: ClubsRepository, Club/Member entities, connectivity detection
provides:
  - Club detail screen with 3 tabs (Info, Members, Matches)
  - FIFA-style member cards with role-based gradients
  - Role icon system (star/shield/person)
  - Invite code generation with admin permissions
  - Share and clipboard functionality
affects:
  - clubs-ui-integration
  - matches-offline (Phase 3 - Matches tab placeholder)
  - home-clubs-integration

# Tech tracking
tech-stack:
  added: [share_plus, shimmer, flutter/services (Clipboard)]
  patterns: [FIFA-style card presentation, role-based visual hierarchy, admin-only feature gating]

key-files:
  created:
    - lib/features/clubs/presentation/screens/club_detail_screen.dart
    - lib/features/clubs/presentation/widgets/club_info_tab.dart
    - lib/features/clubs/presentation/screens/club_members_screen.dart
    - lib/features/clubs/presentation/providers/club_members_provider.dart
    - lib/features/clubs/presentation/widgets/member_card.dart
    - lib/features/clubs/presentation/widgets/role_icon.dart
    - lib/features/clubs/presentation/widgets/members_grid_skeleton.dart
    - lib/features/clubs/presentation/widgets/invite_code_generator.dart
    - lib/features/clubs/presentation/providers/invite_code_provider.dart

key-decisions:
  - Use gradient backgrounds for role hierarchy (gold/blue/silver)
  - FIFA-style cards foreshadow Phase 4 player cards
  - Role icons instead of text badges for visual clarity
  - 8-char alphanumeric codes with XXXX-XXXX display format
  - Native share sheet via share_plus for cross-platform sharing

patterns-established:
  - RoleIcon: Reusable widget for consistent role display across app
  - MemberCard: Aspect ratio 0.7, gradient + stats preview pattern
  - Grid skeleton loading: Shimmer effect matching actual grid layout

# Metrics
duration: 45 min
completed: 2026-03-10
---

# Phase 2 Plan 03: Clubs UI & Invite Codes Summary

**Club detail screen with FIFA-style member cards, role icons, and admin-only invite code generation with sharing**

## Performance

- **Duration:** 45 min
- **Started:** 2026-03-09T23:21:13Z
- **Completed:** 2026-03-10T00:15:00Z
- **Tasks:** 4
- **Files modified:** 9 (all created)

## Accomplishments

- ClubDetailScreen with Material 3 TabBar (Info, Members, Matches)
- ClubInfoTab with club logo, statistics, role section with permissions
- FIFA-style MemberCard with role-based gradients (OWNER=amber, MANAGER=blue, MEMBER=grey)
- RoleIcon widget with tooltips (star/shield/person icons)
- ClubMembersTab with 2-column GridView, sorting by role hierarchy
- MembersGridSkeleton shimmer loading state
- InviteCodeGenerator with admin-only gating (OWNER/MANAGER)
- 8-char alphanumeric codes formatted as XXXX-XXXX
- Native share sheet integration via share_plus
- Clipboard copy with snackbar feedback
- One-time use security warnings in UI

## Task Commits

Each task was committed atomically:

1. **Task 1: Create Club Detail Screen with Tabs** - `832e22a` (feat)
   - club_detail_screen.dart with TabBar and offline indicator
   - club_info_tab.dart with statistics and role section
   - club_members_screen.dart with GridView layout
   - club_members_provider.dart with role-based sorting

2. **Tasks 2-4: FIFA-style Cards & Invite Codes** - `6e557cd` (feat)
   - member_card.dart with gradient backgrounds
   - role_icon.dart with role-appropriate icons
   - members_grid_skeleton.dart shimmer loading
   - invite_code_generator.dart with admin permissions
   - invite_code_provider.dart for state management

## Files Created

- `lib/features/clubs/presentation/screens/club_detail_screen.dart` - Main detail screen with tabs
- `lib/features/clubs/presentation/widgets/club_info_tab.dart` - Info tab with club details
- `lib/features/clubs/presentation/screens/club_members_screen.dart` - Members grid tab
- `lib/features/clubs/presentation/providers/club_members_provider.dart` - Members fetch + sort
- `lib/features/clubs/presentation/widgets/member_card.dart` - FIFA-style player card
- `lib/features/clubs/presentation/widgets/role_icon.dart` - Role indicator icon
- `lib/features/clubs/presentation/widgets/members_grid_skeleton.dart` - Loading skeleton
- `lib/features/clubs/presentation/widgets/invite_code_generator.dart` - Code gen UI
- `lib/features/clubs/presentation/providers/invite_code_provider.dart` - Code state

## Decisions Made

- **Gradient hierarchy:** Amber (OWNER) > Blue (MANAGER) > Grey (MEMBER) for visual distinction
- **FIFA card style:** Aspect ratio 0.7, stats preview at bottom, foreshadows Phase 4
- **Icons over text:** RoleIcon uses Icons.stars/shield/person instead of badges
- **Code format:** 8-char alphanumeric, displayed as XXXX-XXXX for readability
- **Share approach:** Native share_plus dialog vs custom UI (better UX, platform-native)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- **LSP errors from previous phase:** `lib/features/clabs/` directory has typos (clabs vs clubs) - pre-existing issue not addressed in this plan
- **clipboard package:** Used Flutter's built-in `Clipboard` from `flutter/services.dart` instead of external package
- **Provider dependency fix:** invite_code_provider needed clubsRepositoryProvider import from di/injection.dart

## Next Phase Readiness

- Club detail UI complete for integration with navigation
- Members grid ready for real data from ClubsRepository
- Invite code generation depends on backend implementation (generateInviteCode method)
- Matches tab placeholder ready for Phase 3 implementation
- Role icon system reusable across app (club list, members list, etc.)

---
*Phase: 02-clubs-offline*
*Completed: 2026-03-10*
