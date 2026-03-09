# CalcettoApp Flutter - Project State

**Project:** CalcettoApp Flutter  
**Core Value:** Football club members can easily manage their club activities, RSVP to matches, track live games, and view player statistics with FIFA-style cards on their mobile devices

---

## Current Position

| Field | Value |
|-------|-------|
| **Phase** | 1 - Foundation & Authentication |
| **Plan** | 3 of 3 complete |
| **Status** | ✅ Complete |
| **Started** | 2026-03-09 |
| **Target Completion** | 2026-03-09 |

### Phase Progress

```
Phase 1: Foundation & Auth     [██████████] 100%
Phase 2: Clubs & Offline         [░░░░░░░░░░] 0%
Phase 3: Matches & RSVP          [░░░░░░░░░░] 0%
Phase 4: Stats & FIFA Cards      [░░░░░░░░░░] 0%
Phase 5: Live & Notifications    [░░░░░░░░░░] 0%
```

**Overall:** 2/67 requirements complete (3%)

---

## Performance Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Launch time | <3s | — | ⏳ |
| Screen transitions | 60fps | — | ⏳ |
| FIFA card animations | 60fps | — | ⏳ |
| RAM usage | <150MB | — | ⏳ |
| App size (Android) | <50MB | — | ⏳ |
| App size (iOS) | <80MB | — | ⏳ |

---

## Accumulated Context

### Decisions Made

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-03-09 | Use Flutter for cross-platform | Single codebase for iOS, Android, and web |
| 2026-03-09 | Use existing Next.js backend | Faster development, single source of truth |
| 2026-03-09 | Full feature parity for v1 | Users expect all web features on mobile |
| 2026-03-09 | Riverpod + Dio + Hive stack | Research-validated, industry standard |
| 2026-03-09 | Clean Architecture pattern | Proven separation of concerns |
| 2026-03-09 | Result<T> over dartz Either | Simpler API, better Flutter integration |
| 2026-03-09 | MinSdkVersion 23 | Required for flutter_secure_storage Android support |
| 2026-03-09 | Football field green as theme seed color | Reinforces football/soccer app identity |
| 2026-03-09 | Material 3 NavigationBar over BottomNavigationBar | Modern design, Material 3 compliance |
| 2026-03-09 | IndexedStack for tab switching | Preserves screen state (scroll, form data) |
| 2026-03-09 | Cache-based first launch detection | Non-sensitive UI preference, not security-critical |

### Open Questions

- [ ] What are the exact Next.js API endpoint specifications?
- [ ] Are there existing design assets for FIFA cards?
- [ ] What Firebase project should be used for push notifications?
- [ ] Should we support web as primary or secondary platform?

### Known Blockers

*None currently*

### Technical Debt

- [ ] Unused import removal cleanup (minor warnings in type_definitions.dart, main.dart, auth_provider.dart)
- [ ] Test file needs proper provider mocking for widget tests

---

## Session Continuity

### Last Action

Completed Plan 01-03: Navigation and theming implementation with bottom navigation bar, Material 3 theme system, welcome screen, and complete user flow. Phase 1 NOW COMPLETE.

### Next Actions

1. Plan Phase 2: Clubs & Offline functionality
2. Implement user session persistence verification
3. Review Next.js API specifications for auth endpoints

### Working Notes

**Phase 1 Priority:** Focus on authentication with secure JWT storage using flutter_secure_storage. Test API connectivity with Next.js backend early.

**Phase 2 Priority:** Implement Hive for offline caching. Start with read-only offline support.

**Phase 3 Priority:** RSVP optimistic updates are critical UX feature. Test offline queue sync thoroughly.

**Phase 4 Priority:** FIFA cards are key differentiator. Profile animations on mid-range devices.

**Phase 5 Priority:** Push notifications require Firebase setup. Test on physical devices early.

---

## Quick Reference

### Project Files

| File | Purpose |
|------|---------|
| `PROJECT.md` | Core value, constraints, decisions |
| `REQUIREMENTS.md` | 67 v1 requirements with traceability |
| `ROADMAP.md` | 5-phase delivery plan |
| `STATE.md` | This file — current status |
| `research/SUMMARY.md` | Research findings and recommendations |
| `research/STACK.md` | Complete stack with versions |
| `research/ARCHITECTURE.md` | Clean architecture guide |
| `research/PITFALLS.md` | Common mistakes to avoid |

### Key URLs

- **Web Platform:** (existing Next.js app)
- **API Base:** (to be configured)
- **Firebase Console:** (to be configured)

### Build Commands

```bash
# Development
flutter run

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Build web
flutter build web --release
```

---

*State file: Tracks current position and accumulated context*  
*Updated: 2026-03-09 after Phase 1 completion (Plans 01-01, 01-02, 01-03)*
