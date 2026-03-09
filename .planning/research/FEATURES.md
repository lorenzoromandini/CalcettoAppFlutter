# Research: Flutter Features

**Domain:** Football club management mobile app features  
**Date:** 2025-03-09  
**Milestone:** Greenfield

---

## Table Stakes Features

These are non-negotiable. Users expect these or they'll delete the app.

### Authentication
- **Email/password login** - Match existing NextAuth flow
- **Session persistence** - Stay logged in across app restarts
- **Password reset** - Via email link
- **Biometric login** - Face ID / Touch ID for convenience
- **Logout** - Clear secure storage

**Complexity:** Low  
**Dependencies:** flutter_secure_storage, JWT handling  
**Confidence:** Must have

### Club Management
- **View my clubs** - List with badges/unread indicators
- **Switch clubs** - Easy navigation between clubs
- **Club details** - Name, logo, member count
- **Invite members** - Generate/share invite codes
- **Member roles** - OWNER/MANAGER/MEMBER visibility

**Complexity:** Medium (role-based UI variations)  
**Dependencies:** None  
**Confidence:** Must have

### Match Schedule
- **View upcoming matches** - List with RSVP status
- **Match details** - Date, time, location, participants
- **RSVP (Yes/No/Maybe)** - With status indicator
- **Match status** - Scheduled → Live → Completed

**Complexity:** Low  
**Dependencies:** Real-time updates for status changes  
**Confidence:** Must have

### Player Statistics
- **View player stats** - Goals, assists, matches played
- **Leaderboards** - Rankings by various metrics
- **Rating history** - 38-value rating trend

**Complexity:** Medium (charts, sorting)  
**Dependencies:** fl_chart  
**Confidence:** Must have

---

## Differentiating Features

These set the app apart from generic sports apps.

### FIFA-Style Player Cards ⭐
- **Card display** - 9 rarity types (Bronze to Special)
- **Animations** - Entrance, flip, glow effects
- **Statistics display** - Formatted per position
- **Share to social** - Export as image
- **Rarity indicators** - Visual differentiation

**Complexity:** High (CustomPainter, animations)  
**Dependencies:** flutter_animate, screenshot  
**Confidence:** Key differentiator

### Live Match Tracking
- **Real-time score** - Updates during match
- **Goal logging** - Who scored, who assisted
- **Formation display** - Visual pitch with positions
- **Match timer** - Elapsed time display

**Complexity:** High (WebSocket/Firebase real-time)  
**Dependencies:** firebase_database or WebSocket  
**Confidence:** Differentiator

### Offline Support
- **View cached clubs** - When offline
- **View cached matches** - Last known state
- **Queue RSVP changes** - Sync when reconnected
- **Offline indicators** - Clear visual feedback

**Complexity:** Medium (Hive cache + sync queue)  
**Dependencies:** Hive, connectivity_plus  
**Confidence:** Differentiator for mobile

### Push Notifications
- **Match reminders** - 1 hour before match
- **Goal alerts** - During live matches
- **Invite notifications** - When added to club
- **RSVP confirmations** - When someone joins

**Complexity:** Medium  
**Dependencies:** firebase_messaging  
**Confidence:** Mobile expectation

---

## Mobile-Specific Adaptations

### From Web to Mobile

| Web Feature | Mobile Adaptation | Reasoning |
|-------------|-------------------|-----------|
| Hover tooltips | Long-press or info buttons | No hover on touch |
| Right-click menus | Swipe actions | Native mobile pattern |
| Desktop sidebar | Bottom navigation | Thumb reachability |
| Multi-column layouts | Single column with tabs | Screen width |
| Drag formations | Touch drag with snap-to-grid | Touch vs mouse |
| Infinite scroll | Pull-to-refresh + pagination | Native expectation |
| Modal dialogs | Bottom sheets | Better on mobile |
| Date pickers | Native iOS/Android pickers | Platform expectation |
| File uploads | Camera/gallery access | Mobile-first |

---

## Anti-Features

Explicitly NOT building these. Documented to prevent scope creep.

### Out of Scope

| Feature | Reason |
|---------|--------|
| Real-time chat | Use WhatsApp/Telegram, too complex |
| Video recording | Native device apps handle this |
| Live streaming | Bandwidth/complexity, not core value |
| In-app purchases | Existing web monetization model |
| Desktop apps | Focus on mobile + web only |
| Complex AR features | FIFA cards are visual, not AR |
| Custom keyboard | Use system keyboards |
| Widgets (Android/iOS) | Phase 2 consideration |
| Wear OS / Watch | Not enough users |
| Tablet-optimized UI | Responsive, but not tablet-first |

---

## Feature Complexity Matrix

| Feature | Complexity | Risk | Phase |
|---------|------------|------|-------|
| Auth flow | Low | Low | 1 |
| Club list/view | Low | Low | 1 |
| Match RSVP | Low | Low | 2 |
| Player stats | Medium | Low | 3 |
| FIFA cards | High | Medium | 4 |
| Live tracking | High | High | 5 |
| Push notifications | Medium | Low | 5 |
| Offline support | Medium | Medium | 2-5 |

---

## Feature Dependencies

```
Authentication
    ↓
Club Management
    ↓
Match Schedule
    ↓
Player Statistics
    ↓
FIFA Cards (needs stats)
    ↓
Live Match (needs matches)
```

**Critical path:** Auth → Club → Match → Stats → Cards

---

## Research Notes

### User Expectations
- **Speed:** App must feel native (60fps, <2s load)
- **Offline:** Partial functionality without internet
- **Notifications:** Timely, not spammy
- **Sharing:** Easy to share cards/results

### Competitive Analysis
- **TeamSnap:** Good scheduling, poor stats
- **Spond:** Simple, lacks depth
- **Custom apps:** This app's FIFA cards are unique

### Success Metrics
- FIFA card shares = engagement
- RSVP rate > 80% = utility
- Session duration = stickiness

---

*Research complete: 2025-03-09*