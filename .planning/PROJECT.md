# CalcettoApp Flutter

## What This Is

A hybrid Flutter mobile application that translates the existing CalcettoApp Next.js web platform into native iOS/Android apps with web fallback support. Football club members can manage their clubs, organize matches, track live games, view player statistics, and generate FIFA-style player cards — all optimized for mobile touch interactions with native performance.

## Core Value

Football club members can easily manage their club activities, RSVP to matches, track live games, and view player statistics with FIFA-style cards on their mobile devices, maintaining full feature parity with the web platform while delivering native mobile experience.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Full feature parity with existing web CalcettoApp (all clubs, matches, players, statistics features)
- [ ] FIFA-style player cards with animations and sharing capabilities
- [ ] Native iOS/Android builds with platform-specific optimizations
- [ ] Web support for development and browser fallback
- [ ] API integration with existing Next.js backend
- [ ] Offline support for key features (RSVP, viewing cached data)
- [ ] Push notifications for match reminders and club updates
- [ ] Dark/light theme following system preferences

### Out of Scope

- Desktop apps (Windows/macOS/Linux) — Focus on mobile + web
- Native game streaming/ recording — Use device native capabilities
- In-app purchases — Existing web model covers monetization
- Complex animations beyond FIFA cards — Keep performance smooth on lower-end devices
- Real-time multiplayer game features — Stick to match tracking/statistics

## Context

**Existing Web Platform:**
- Next.js 16 + React 19 + TypeScript web app
- NextAuth v5 for authentication
- PostgreSQL database via Prisma ORM
- TanStack Query for state management
- FIFA-style player cards with 9 rarity types
- Club management with OWNER/MANAGER/MEMBER roles
- Match lifecycle: scheduled → live → completed
- 38-value player rating system (4-10 scale with .5 increments)

**Translation to Mobile:**
- Reuse existing API endpoints where possible
- Adapt UI patterns for mobile touch interactions
- Optimize FIFA cards for mobile screen sizes
- Implement native sharing for player cards
- Add push notifications where web uses email

## Constraints

- **Tech Stack:** Flutter/Dart for cross-platform mobile + web — Chosen for single codebase targeting iOS, Android, and web
- **Backend:** Must integrate with existing Next.js backend — No backend rewrite, reuse existing APIs
- **API Compatibility:** Match existing Prisma data models — ClubMember, Match, Formation, Goal, PlayerRating structures
- **Performance:** 60fps animations on mid-range devices — FIFA cards must animate smoothly
- **Offline:** Core read operations work offline — RSVP and stats viewing must cache
- **Timeline:** Focus on feature parity before enhancements — Web features first, native-only features second

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Use existing Next.js backend | Faster development, single source of truth for data | — Pending |
| Full feature parity for v1 | Users expect all web features on mobile | — Pending |
| Full-featured FIFA cards | Key differentiator feature, visual wow factor | — Pending |
| Flutter for cross-platform | Single codebase for iOS, Android, and web | — Pending |

---
*Last updated: 2026-03-09 after initialization*
