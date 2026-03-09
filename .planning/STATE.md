# CalcettoApp Flutter - Project State

**Project:** CalcettoApp Flutter  
**Core Value:** Football club members can easily manage their club activities, RSVP to matches, track live games, and view player statistics with FIFA-style cards on their mobile devices

---

## Current Position

| Field | Value |
|-------|-------|
| **Phase** | 1 - Foundation & Authentication |
| **Plan** | ✓ Complete (3/3) |
| **Status** | ⚠️ Verification - Gaps Found |
| **Started** | 2026-03-09 |
| **Target Completion** | TBD |

### Phase Progress

```
Phase 1: Foundation & Auth     [█████████░] 80% (4/5 criteria, 1 gap)
Phase 2: Clubs & Offline         [░░░░░░░░░░] 0%
Phase 3: Matches & RSVP          [░░░░░░░░░░] 0%
Phase 4: Stats & FIFA Cards      [░░░░░░░░░░] 0%
Phase 5: Live & Notifications    [░░░░░░░░░░] 0%
```

**Overall:** 0/67 requirements complete (0%) | Phase 1: 15/17 requirements implemented

---

## Phase 1 Verification Status

**Score:** 4/5 must-haves verified

| Criterion | Status | Notes |
|-----------|--------|-------|
| Login + session persistence | ✓ Passed | Implemented with flutter_secure_storage |
| Biometric auth | ✗ Gap | AUTH-04 not implemented |
| Loading/error states | ✓ Passed | Implemented in login flow |
| Material 3 + theme | ✓ Passed | Full theme system with dark/light mode |
| Performance (<3s launch, 60fps) | ⏳ Human needed | Requires device testing |

### Gap Summary

**1 gap blocking full verification:**
- **AUTH-04:** Biometric authentication (Face ID/Touch ID) not implemented
- **Missing files:** `lib/core/services/biometric_service.dart`, biometric toggle in settings

---

## Performance Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Launch time | <3s | — | ⏳ Needs device test |
| Screen transitions | 60fps | — | ⏳ Needs device test |
| FIFA card animations | 60fps | — | ⏳ Future phase |
| RAM usage | <150MB | — | ⏳ Needs device test |
| App size (Android) | <50MB | — | ⏳ Post-build |
| App size (iOS) | <80MB | — | ⏳ Post-build |

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
| 2026-03-09 | Password reset deferred | Requires backend email integration (AUTH-06) |
| 2026-03-09 | Biometric auth gap | AUTH-04 needs gap-closure plan |

### Open Questions

- [ ] What are the exact Next.js API endpoint specifications?
- [ ] Are there existing design assets for FIFA cards?
- [ ] What Firebase project should be used for push notifications?
- [ ] Should we support web as primary or secondary platform?

### Known Blockers

- AUTH-04 (Biometric auth) — Gap closure plan needed

### Technical Debt

- [ ] Unused import removal cleanup (minor warnings in type_definitions.dart, main.dart, auth_provider.dart)
- [ ] Test file needs proper provider mocking for widget tests

---

## Session Continuity

### Last Action

Phase 1 execution complete, verification identified 1 gap (AUTH-04 biometric auth) and 5 human verification items.

### Next Actions

1. Run `/gsd-plan-phase 1 --gaps` to create gap closure plan for AUTH-04
2. Execute gap closure plan
3. Re-verify Phase 1
4. Begin Phase 2 planning

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
