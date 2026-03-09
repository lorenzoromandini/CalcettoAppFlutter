# Requirements: CalcettoApp Flutter

**Defined:** 2026-03-09
**Core Value:** Football club members can easily manage their club activities, RSVP to matches, track live games, and view player statistics with FIFA-style cards on their mobile devices

---

## v1 Requirements

Requirements for initial release. Each maps to roadmap phases.

### Authentication

- [x] **AUTH-01**: User can log in with email and password ✅
- [x] **AUTH-02**: User can view and toggle password visibility ✅
- [x] **AUTH-03**: User session persists across app restarts ✅
- [x] **AUTH-04**: User can use biometric login (Face ID/Touch ID) after first login ✅
- [x] **AUTH-05**: User can log out from any screen ✅
- [ ] **AUTH-06**: User can request password reset via email (deferred)
- [x] **AUTH-07**: App shows loading state during authentication ✅
- [x] **AUTH-08**: App shows clear error messages for failed login ✅

### Club Management

- [ ] **CLUB-01**: User can view list of clubs they belong to
- [ ] **CLUB-02**: User can switch between clubs easily
- [ ] **CLUB-03**: User can view club details (name, logo, member count)
- [ ] **CLUB-04**: User can view club members with their roles
- [ ] **CLUB-05**: User can generate and share invite codes for their club
- [ ] **CLUB-06**: User can see their role in each club (OWNER/MANAGER/MEMBER)
- [ ] **CLUB-07**: User can view club statistics summary
- [ ] **CLUB-08**: Club list works offline (shows cached data)
- [ ] **CLUB-09**: App shows loading skeleton while fetching clubs

### Match Schedule

- [ ] **MATCH-01**: User can view upcoming matches for selected club
- [ ] **MATCH-02**: User can view past matches
- [ ] **MATCH-03**: User can see match status (Scheduled/Live/Completed)
- [ ] **MATCH-04**: User can view match details (date, time, location)
- [ ] **MATCH-05**: User can RSVP to matches (Yes/No/Maybe)
- [ ] **MATCH-06**: RSVP updates immediately (optimistic UI)
- [ ] **MATCH-07**: User can view who has RSVPed to a match
- [ ] **MATCH-08**: User can see match formation (once published)
- [ ] **MATCH-09**: Match list works offline
- [ ] **MATCH-10**: Pull-to-refresh updates match list

### Match Live Tracking

- [ ] **LIVE-01**: User can view live match score in real-time
- [ ] **LIVE-02**: User can see match timer (elapsed time)
- [ ] **LIVE-03**: User can view team formations during live match
- [ ] **LIVE-04**: User can see goal log with scorer and assister
- [ ] **LIVE-05**: User receives push notification when match goes live
- [ ] **LIVE-06**: User receives push notification for goals in subscribed matches
- [ ] **LIVE-07**: Live screen auto-refreshes every 30 seconds

### Player Statistics

- [ ] **STAT-01**: User can view player statistics (goals, assists, matches)
- [ ] **STAT-02**: User can view leaderboards by different metrics
- [ ] **STAT-03**: User can filter leaderboards by time period
- [ ] **STAT-04**: User can view their own statistics
- [ ] **STAT-05**: Stats display as charts (trend over time)
- [ ] **STAT-06**: User can view rating history (38-value system)

### FIFA Player Cards

- [ ] **CARD-01**: User can view FIFA-style player cards
- [ ] **CARD-02**: Cards show 9 rarity types (Bronze to Special)
- [ ] **CARD-03**: Cards display player statistics formatted by position
- [ ] **CARD-04**: Cards have entrance animation (scale + fade)
- [ ] **CARD-05**: Cards show rarity glow effect
- [ ] **CARD-06**: User can share card as image to social media
- [ ] **CARD-07**: Cards render at 60fps on mid-range devices
- [ ] **CARD-08**: Cards work offline (cached player data)

### Offline Support

- [ ] **OFF-01**: App detects network connectivity status
- [ ] **OFF-02**: User can view cached clubs when offline
- [ ] **OFF-03**: User can view cached matches when offline
- [ ] **OFF-04**: User can view cached player stats when offline
- [ ] **OFF-05**: RSVP actions queue when offline and sync when reconnected
- [ ] **OFF-06**: App shows offline indicator when disconnected
- [ ] **OFF-07**: App auto-syncs when connection restored
- [ ] **OFF-08**: Cache respects TTL (5 minutes for matches)

### Push Notifications

- [ ] **PUSH-01**: User receives notification 1 hour before scheduled match
- [ ] **PUSH-02**: User receives notification when invited to club
- [ ] **PUSH-03**: User receives notification for match goals (if subscribed)
- [ ] **PUSH-04**: User can manage notification preferences
- [ ] **PUSH-05**: Tapping notification opens relevant screen
- [ ] **PUSH-06**: App requests notification permission gracefully

### UI/UX

- [ ] **UI-01**: App follows Material 3 design system
- [ ] **UI-02**: App supports dark/light theme (system preference)
- [ ] **UI-03**: App uses bottom navigation for main sections
- [ ] **UI-04**: App shows loading states for async operations
- [ ] **UI-05**: App shows error states with retry options
- [ ] **UI-06**: App supports pull-to-refresh on list screens
- [ ] **UI-07**: App uses swipe actions for common operations
- [ ] **UI-08**: App is responsive across phone sizes

### Performance

- [ ] **PERF-01**: App launches in under 3 seconds
- [ ] **PERF-02**: Screen transitions run at 60fps
- [ ] **PERF-03**: FIFA card animations run at 60fps
- [ ] **PERF-04**: List scrolling is smooth (no jank)
- [ ] **PERF-05**: App uses less than 150MB RAM in normal use
- [ ] **PERF-06**: App size under 50MB (Android), under 80MB (iOS)

---

## v2 Requirements

Deferred to future release. Tracked but not in current roadmap.

### Advanced Club Management

- **CLUB-V2-01**: User can edit club details
- **CLUB-V2-02**: Managers can remove members from club
- **CLUB-V2-03**: Managers can change member roles
- **CLUB-V2-04**: Club activity log/history

### Match Management

- **MATCH-V2-01**: Managers can create matches from mobile
- **MATCH-V2-02**: Managers can edit match details
- **MATCH-V2-03**: Managers can cancel matches
- **MATCH-V2-04**: Managers can manage formations from mobile

### Social Features

- **SOCIAL-01**: User can share match results to social media
- **SOCIAL-02**: User can share leaderboard rankings
- **SOCIAL-03**: Match result cards (like FIFA cards for matches)

### Analytics

- **ANALYTICS-01**: App tracks screen views
- **ANALYTICS-02**: App tracks feature usage
- **ANALYTICS-03**: Club admins can view engagement metrics

---

## Out of Scope

Explicitly excluded. Documented to prevent scope creep.

| Feature | Reason |
|---------|--------|
| Real-time chat | Use WhatsApp/Telegram, not core value |
| Video recording/upload | Native device apps handle this, high complexity |
| Desktop apps (Windows/macOS/Linux) | Focus on mobile + web only |
| In-app purchases | Existing web monetization model sufficient |
| Augmented reality (AR) features | Visual cards sufficient, AR adds complexity |
| Custom keyboards | Use system keyboards |
| Wear OS / Apple Watch | Not enough users to justify |
| Home screen widgets | Phase 2 consideration |
| Complex match creation UI | Web is better for complex forms |
| Admin panel features | Keep in web app |

---

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| AUTH-01 | Phase 1 | ✅ Complete |
| AUTH-02 | Phase 1 | ✅ Complete |
| AUTH-03 | Phase 1 | ✅ Complete |
| AUTH-04 | Phase 1 | ✅ Complete |
| AUTH-05 | Phase 1 | ✅ Complete |
| AUTH-06 | Phase 1 | ⏸️ Deferred (needs backend email) |
| AUTH-07 | Phase 1 | ✅ Complete |
| AUTH-08 | Phase 1 | ✅ Complete |
| CLUB-01 | Phase 2 | Pending |
| CLUB-02 | Phase 2 | Pending |
| CLUB-03 | Phase 2 | Pending |
| CLUB-04 | Phase 2 | Pending |
| CLUB-05 | Phase 2 | Pending |
| CLUB-06 | Phase 2 | Pending |
| CLUB-07 | Phase 2 | Pending |
| CLUB-08 | Phase 2 | Pending |
| CLUB-09 | Phase 2 | Pending |
| MATCH-01 | Phase 3 | Pending |
| MATCH-02 | Phase 3 | Pending |
| MATCH-03 | Phase 3 | Pending |
| MATCH-04 | Phase 3 | Pending |
| MATCH-05 | Phase 3 | Pending |
| MATCH-06 | Phase 3 | Pending |
| MATCH-07 | Phase 3 | Pending |
| MATCH-08 | Phase 3 | Pending |
| MATCH-09 | Phase 3 | Pending |
| MATCH-10 | Phase 3 | Pending |
| STAT-01 | Phase 4 | Pending |
| STAT-02 | Phase 4 | Pending |
| STAT-03 | Phase 4 | Pending |
| STAT-04 | Phase 4 | Pending |
| STAT-05 | Phase 4 | Pending |
| STAT-06 | Phase 4 | Pending |
| CARD-01 | Phase 4 | Pending |
| CARD-02 | Phase 4 | Pending |
| CARD-03 | Phase 4 | Pending |
| CARD-04 | Phase 4 | Pending |
| CARD-05 | Phase 4 | Pending |
| CARD-06 | Phase 4 | Pending |
| CARD-07 | Phase 4 | Pending |
| CARD-08 | Phase 4 | Pending |
| LIVE-01 | Phase 5 | Pending |
| LIVE-02 | Phase 5 | Pending |
| LIVE-03 | Phase 5 | Pending |
| LIVE-04 | Phase 5 | Pending |
| LIVE-05 | Phase 5 | Pending |
| LIVE-06 | Phase 5 | Pending |
| LIVE-07 | Phase 5 | Pending |
| PUSH-01 | Phase 5 | Pending |
| PUSH-02 | Phase 5 | Pending |
| PUSH-03 | Phase 5 | Pending |
| PUSH-04 | Phase 5 | Pending |
| PUSH-05 | Phase 5 | Pending |
| PUSH-06 | Phase 5 | Pending |
| OFF-01 | Phase 2-5 | Pending |
| OFF-02 | Phase 2 | Pending |
| OFF-03 | Phase 3 | Pending |
| OFF-04 | Phase 4 | Pending |
| OFF-05 | Phase 3 | Pending |
| OFF-06 | Phase 2 | Pending |
| OFF-07 | Phase 3 | Pending |
| OFF-08 | Phase 2 | Pending |
| UI-01 | Phase 1 | ✅ Complete |
| UI-02 | Phase 1 | ✅ Complete |
| UI-03 | Phase 1 | ✅ Complete |
| UI-04 | Phase 1 | ✅ Complete |
| UI-05 | Phase 1 | ✅ Complete |
| UI-06 | Phase 2 | Pending |
| UI-07 | Phase 3 | Pending |
| UI-08 | Phase 1-5 | ✅ Complete |
| PERF-01 | Phase 1 | ⏳ Needs testing |
| PERF-02 | Phase 1-5 | ⏳ Needs testing |
| PERF-03 | Phase 4 | Pending |
| PERF-04 | Phase 2-5 | ⏳ Needs testing |
| PERF-05 | Phase 1-5 | ⏳ Needs testing |
| PERF-06 | Phase 5 | ⏳ Needs testing |

**Coverage:**
- v1 requirements: 67 total
- Phase 1 complete: 21/21 (100%) ✅
- Overall: 21/67 (31%)

**Phase Distribution:**
- Phase 1 (Foundation & Auth): 21/21 requirements ✅ COMPLETE
- Phase 2 (Clubs & Offline): 0/15 requirements ⏳ NEXT
- Phase 3 (Matches & RSVP): 0/14 requirements
- Phase 4 (Stats & FIFA Cards): 0/16 requirements
- Phase 5 (Live & Notifications): 0/13 requirements

---
*Requirements defined: 2026-03-09*
*Last updated: 2026-03-09 after Phase 1 completion*