---
status: testing
phase: 02-clubs-offline
source:
  - 02-01-SUMMARY.md
  - 02-02-SUMMARY.md
  - 02-03-SUMMARY.md
  - 02-04-SUMMARY.md
started: 2026-03-10T00:00:00Z
updated: 2026-03-10T00:00:00Z
---

## Current Test
<!-- OVERWRITE each test - shows where we are -->

number: 1
name: View Clubs List with Loading State
expected: |
  Navigate to Clubs tab. App shows shimmer loading skeleton (6 placeholders with circle avatars and text lines). After loading, displays list of clubs with club logo, name, member count, and role badge (OWNER/MANAGER/MEMBER).
awaiting: user response

## Tests

### 1. View Clubs List with Loading State
expected: Navigate to Clubs tab, shimmer skeleton appears during load, then club list with logo/name/member count/role badge
result: issue
reported: "I don't see any change at port 8081"
severity: major

### 2. Pull-to-Refresh Clubs List
expected: Pull down on clubs list triggers refresh indicator, data reloads, shimmer only on first load thereafter
result: [pending]

### 3. Active Club Star Indicator
expected: Currently active club shows gold star icon (Icons.star) on the right side of the list item
result: [pending]

### 4. Switch Active Club via Long-Press
expected: Long-press on a club shows confirmation dialog "Switch to [Club Name]?", tap confirm switches active club, star indicator moves, navigates to Home tab
result: [pending]

### 5. View Club Detail with Tabs
expected: Tap on a club opens detail screen with 3 tabs (Info, Members, Matches). Info tab shows club logo (large), name, member count, description, stats summary cards
result: [pending]

### 6. View Members in FIFA-Style Cards
expected: Members tab shows grid of FIFA-style player cards with gradient backgrounds (OWNER=gold, MANAGER=blue, MEMBER=silver), avatar, name, role icon, stats preview row
result: [pending]

### 7. Generate Invite Code (Admin Only)
expected: As club OWNER/MANAGER, tap Generate Invite Code button shows 8-character alphanumeric code (XXXX-XXXX format) with Share and Copy buttons. As MEMBER, shows "Contact admin" message
result: [pending]

### 8. Share Invite Code
expected: Tap Share button opens native share sheet with pre-filled message "Join my football club! Use invite code: XXXX-XXXX"
result: [pending]

### 9. Offline Indicator Appears
expected: Disable network (airplane mode), MaterialBanner appears at top of screens with cloud_off icon and "You're offline. Showing cached data." message, shows cache age
result: [pending]

### 10. View Cached Clubs When Offline
expected: While offline, navigate to clubs list - shows cached club data (not empty/error state), offline indicator visible, pull-to-refresh works but shows cached data
result: [pending]

### 11. Read-Only Mode When Offline
expected: While offline, create club button is greyed out/disabled, generate invite code button disabled, tooltip shows "Requires internet connection" on tap
result: [pending]

### 12. Home Screen Shows Active Club Context
expected: Home screen displays ActiveClubHeader with club logo (40px), club name, role icon, chevron. Tap opens club switcher. Shows "Upcoming Matches" and "Recent Activity" placeholder sections
result: [pending]

### 2. Pull-to-Refresh Clubs List
expected: Pull down on clubs list triggers refresh indicator, data reloads, shimmer only on first load thereafter
result: [pending]

### 3. Active Club Star Indicator
expected: Currently active club shows gold star icon (Icons.star) on the right side of the list item
result: [pending]

### 4. Switch Active Club via Long-Press
expected: Long-press on a club shows confirmation dialog "Switch to [Club Name]?", tap confirm switches active club, star indicator moves, navigates to Home tab
result: [pending]

### 5. View Club Detail with Tabs
expected: Tap on a club opens detail screen with 3 tabs (Info, Members, Matches). Info tab shows club logo (large), name, member count, description, stats summary cards
result: [pending]

### 6. View Members in FIFA-Style Cards
expected: Members tab shows grid of FIFA-style player cards with gradient backgrounds (OWNER=gold, MANAGER=blue, MEMBER=silver), avatar, name, role icon, stats preview row
result: [pending]

### 7. Generate Invite Code (Admin Only)
expected: As club OWNER/MANAGER, tap Generate Invite Code button shows 8-character alphanumeric code (XXXX-XXXX format) with Share and Copy buttons. As MEMBER, shows "Contact admin" message
result: [pending]

### 8. Share Invite Code
expected: Tap Share button opens native share sheet with pre-filled message "Join my football club! Use invite code: XXXX-XXXX"
result: [pending]

### 9. Offline Indicator Appears
expected: Disable network (airplane mode), MaterialBanner appears at top of screens with cloud_off icon and "You're offline. Showing cached data." message, shows cache age
result: [pending]

### 10. View Cached Clubs When Offline
expected: While offline, navigate to clubs list - shows cached club data (not empty/error state), offline indicator visible, pull-to-refresh works but shows cached data
result: [pending]

### 11. Read-Only Mode When Offline
expected: While offline, create club button is greyed out/disabled, generate invite code button disabled, tooltip shows "Requires internet connection" on tap
result: [pending]

### 12. Home Screen Shows Active Club Context
expected: Home screen displays ActiveClubHeader with club logo (40px), club name, role icon, chevron. Tap opens club switcher. Shows "Upcoming Matches" and "Recent Activity" placeholder sections
result: [pending]

## Summary

total: 12
passed: 0
issues: 0
pending: 12
skipped: 0

## Gaps

[none yet]
