# CalcettoApp Flutter - Project State

**Project:** CalcettoApp Flutter  
**Core Value:** Football club members can easily manage their club activities, RSVP to matches, track live games, and view player statistics with FIFA-style cards on their mobile devices

---

## Current Position

| Field | Value |
|-------|-------|
| **Phase** | 1 - Foundation & Auth (Backend Migration) |
| **Current Plan** | Complete |
| **Total Plans** | 5 |
| **Status** | ✅ Backend Migration Complete |
| **Started** | 2026-03-09 |
| **Updated** | 2026-03-10 |
| **Target Completion** | 2026-03-10 |

### Phase Progress

```
Phase 1: Foundation & Auth     [██████████] 100% (Auth + Serverpod Backend) ✅
Phase 2: Clubs & Offline         [░░░░░░░░░░] 0%
Phase 3: Matches & RSVP          [░░░░░░░░░░] 0%
Phase 4: Stats & FIFA Cards      [░░░░░░░░░░] 0%
Phase 5: Live & Notifications    [░░░░░░░░░░] 0%
```

**Overall:** Foundation + Authentication complete with standalone Serverpod backend ✅

---

## Current Status: Serverpod Backend Migration ✅

**Achievements:**
- ✅ Independent Serverpod backend created in `./calcetto_backend/`
- ✅ PostgreSQL database with user_info table
- ✅ Auth endpoints: `/auth/login` and `/auth/signup` working
- ✅ Flutter app connected to new backend (port 8080)
- ✅ Multi-language support (it + en) with language switcher
- ✅ AGENTS.md updated with comprehensive guidelines
- ✅ start.sh script for easy development workflow

### Backend Architecture

**New Stack:**
- ✅ Flutter app connects to Serverpod backend at `http://localhost:8080`
- ✅ Independent PostgreSQL database (same schema pattern as original)
- ✅ Dart backend (same language as Flutter - no context switching)
- ✅ Auto-generated type-safe API clients
- ✅ Serverpod migrations for schema management
- ✅ Multi-language support (Italian + English) with language switcher

**Old Stack (Optional):**
- Next.js backend at port 3000 (can still be used but not recommended)

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

### Decisions Made (Including Backend Migration)

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-03-09 | Use Flutter for cross-platform | Single codebase for iOS, Android, and web |
| 2026-03-09 | Riverpod + Dio + Hive stack | Research-validated, industry standard |
| 2026-03-09 | Clean Architecture pattern | Proven separation of concerns |
| 2026-03-09 | Result<T> over dartz Either | Simpler API, better Flutter integration |
| 2026-03-09 | MinSdkVersion 23 | Required for flutter_secure_storage Android support |
| 2026-03-09 | Football field green as theme seed color | Reinforces football/soccer app identity |
| 2026-03-09 | Material 3 NavigationBar over BottomNavigationBar | Modern design, Material 3 compliance |
| 2026-03-09 | IndexedStack for tab switching | Preserves screen state (scroll, form data) |
| 2026-03-09 | Cache-based first launch detection | Non-sensitive UI preference, not security-critical |
| 2026-03-10 | Use Serverpod for backend | Dart language (same as Flutter), type-safe, PostgreSQL native |
| 2026-03-10 | Independent backend architecture | Decoupled from Next.js, dedicated API for mobile app |
| 2026-03-10 | Multi-language support (it + en) | Language switcher with Hive persistence |
| 2026-03-10 | start.sh automation script | Single command to start all services (DB + Backend + Flutter) |

### Open Questions

- [ ] What are the exact Next.js API endpoint specifications?
- [ ] Are there existing design assets for FIFA cards?
- [ ] What Firebase project should be used for push notifications?
- [ ] Should we support web as primary or secondary platform?

### Known Blockers

None - Serverpod backend migration complete. Ready to continue with Phase 2 implementation.

### Decisions Made (Phase 2 Plan 04)

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-03-09 | Material 3 MaterialBanner for offline indicator | Consistent with app theme, proper Material 3 component |
| 2026-03-09 | Show cache age in offline indicator | User context for data freshness |
| 2026-03-09 | Opacity + IgnorePointer for offline disable | Visual feedback + prevent interaction |
| 2026-03-09 | ActiveClubHeader with role icon | Quick visual identification of club and user role |

### Technical Debt

- [ ] Unused import removal cleanup (~14 warnings - minor analysis issues)
- [ ] Test file needs proper provider mocking for widget tests
- [ ] Flutter web build cache clearing (aggressive caching requires hard refresh)
- [ ] Italian error translations expansion (current map covers main auth errors only)

---

## Session Continuity

### Last Action

Phase 2 Plan 04 COMPLETE: Offline indicator with Material 3 banner, read-only mode enforcement, and home screen with active club context.

### Next Actions

1. ✅ Phase 2 Plan 01 - Clubs offline infrastructure (repositories, TTL cache)
2. ✅ Phase 2 Plan 02 - Club list screen with switching
3. ✅ Phase 2 Plan 03 - Club detail UI with FIFA-style cards
4. ✅ Phase 2 Plan 04 - Offline indicator and final integration
5. ⏭️ Phase 3: Matches & RSVP - Ready to start

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
*Updated: 2026-03-09 after Phase 1 Plan 05 completion (line 67 biometric bug fix)*
