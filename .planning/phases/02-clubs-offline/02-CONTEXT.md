# Phase 2: Club Management & Offline Foundation - Context

**Gathered:** 2026-03-09
**Status:** Ready for planning

<domain>
## Phase Boundary

Users can view their club memberships and manage them with offline read support. Core capabilities: view clubs list, switch between clubs, view club details and members, generate invite codes. Phase 2 is read-only offline; write operations (RSVP, create club) require connection and come in Phase 3.

</domain>

<decisions>
## Implementation Decisions

### Club List Layout
- **Display style:** List items (not cards or grid)
- **Per club information:** Club image (optional), name, member count, role badge
- **Active indicator:** Star icon on currently selected club
- **Navigation:** Tap club → opens club detail screen with tabs
- **Create button:** In app bar (NOT floating action button)

### Club Switching
- **Behavior on switch:** Reset to Home tab with new club's data
- **Switching mechanism:** Claude's discretion
- **Quick gestures:** Claude's discretion
- **Active club display:** Claude's discretion

### Offline Behavior
- **Interaction mode:** Read-only when offline (no actions allowed)
- **Offline indicator:** Claude's discretion
- **Stale data threshold:** Claude's discretion
- **Reconnection behavior:** Claude's discretion

### Loading States
- **Initial loading:** Claude's discretion
- **Cached vs fresh timing:** Claude's discretion
- **Pull-to-refresh:** Claude's discretion
- **Empty state:** Claude's discretion

### Invite Code Sharing
- **Generation permission:** Admin only (Owners and Managers)
- **Security requirement:** One-time use only - second user with same code cannot join
- **Expiration:** Never expire
- **Sharing mechanism:** Claude's discretion
- **Code format:** Claude's discretion

### Member Display
- **Presentation style:** FIFA-style player cards (foreshadows Phase 4)
- **Information shown:** All info on the card (name, stats, etc.)
- **Role indicators:** Icons (not color badges or text)
- **Interactivity:** Tappable to view full member profile and statistics

### Claude's Discretion
- Club switching mechanism and UI placement
- Offline indicator style and position
- Loading skeleton/shimmer design
- Pull-to-refresh implementation details
- Invite code format and sharing UX
- Member list sorting and grouping
- Empty state design for new users

</decisions>

<specifics>
## Specific Ideas

- "Active club should have a star or something similar to indicate it's the one showing statistics"
- "FIFA-style player cards for members" (connection to Phase 4 FIFA cards feature)
- "One-time use invite codes - even if someone knows the code, they can't join without being invited"
- Club detail screen should have tabs (info, members, matches)

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within Phase 2 scope

</deferred>

---

*Phase: 02-clubs-offline*
*Context gathered: 2026-03-09*
