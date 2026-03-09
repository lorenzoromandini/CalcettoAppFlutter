# Research Summary: CalcettoApp Flutter

**Date:** 2025-03-09  
**Sources:** STACK.md, FEATURES.md, ARCHITECTURE.md, PITFALLS.md

---

## Key Findings

### Recommended Stack

**Flutter 3.24+** with **Riverpod 2.x** for state management, **Dio 5.x** for HTTP client, **Hive** for local storage, and **Firebase Cloud Messaging** for push notifications.

**Core Dependencies:**
```yaml
dependencies:
  flutter_riverpod: ^2.5.0
  dio: ^5.8.0
  hive: ^2.2.3
  firebase_messaging: ^15.1.0
  flutter_secure_storage: ^9.2.0
```

### Architecture Pattern

**Clean Architecture** with three layers:
1. **Presentation** - UI widgets + Riverpod providers
2. **Domain** - Entities + Repository interfaces + Use cases
3. **Data** - API client + Local storage + Repository implementations

### Critical Success Factors

1. **Offline Support:** Critical for mobile. Use Hive + Dio cache interceptor.
2. **Authentication:** Secure JWT storage with flutter_secure_storage.
3. **FIFA Cards:** Use RepaintBoundary to maintain 60fps animations.
4. **Next.js Integration:** Handle CORS, test mobile headers, use existing REST APIs.

---

## Table Stakes Features (Must Have)

| Feature | Complexity | Status |
|---------|-----------|--------|
| Email/password login | Low | Required |
| View clubs + switch | Low | Required |
| Match RSVP | Low | Required |
| View player stats | Medium | Required |
| Push notifications | Medium | Expected |

## Differentiating Features (Competitive Advantage)

| Feature | Complexity | Status |
|---------|-----------|--------|
| FIFA-style player cards | High | Key differentiator |
| Live match tracking | High | Differentiator |
| Offline support | Medium | Mobile expectation |
| Card sharing | Low | Engagement driver |

## Anti-Features (Out of Scope)

- Real-time chat (use WhatsApp)
- Video recording (native apps)
- Desktop apps (focus mobile)
- In-app purchases (web model)
- Complex AR (keep it visual)

---

## Architecture Highlights

### Data Flow
```
UI (Widget)
  ↓ watch provider
Controller (Riverpod)
  ↓ call use case
Use Case
  ↓ call repository
Repository
  ↓ check cache
Cache (Hive)
  ↓ miss → fetch
API (Next.js)
```

### Build Order
1. **Foundation** - Core, API, storage, base models
2. **Auth** - Login, token management
3. **Clubs** - CRUD operations
4. **Matches** - RSVP + optimistic updates
5. **Stats/Cards** - FIFA cards (CustomPainter)
6. **Live/Notifications** - Real-time + push

---

## Critical Pitfalls

### High Risk
1. **Token security** - Use flutter_secure_storage, not SharedPreferences
2. **Null safety** - Use json_serializable for all models
3. **UI blocking** - Always use AsyncValue patterns
4. **Memory leaks** - Use autoDispose providers
5. **Cache invalidation** - Implement TTL + manual refresh

### Medium Risk
6. **Card performance** - Use RepaintBoundary around FIFA cards
7. **CORS issues** - Configure Next.js for mobile headers
8. **Push permissions** - Request before first notification
9. **Web renderer** - Use CanvasKit for FIFA cards
10. **Date localization** - Convert UTC to local timezone

---

## Research Files

| File | Contents |
|------|----------|
| `STACK.md` | Complete stack recommendations with versions |
| `FEATURES.md` | Feature breakdown: table stakes, differentiators, anti-features |
| `ARCHITECTURE.md` | Clean architecture guide with code examples |
| `PITFALLS.md` | 15 common mistakes and prevention strategies |

---

## Confidence Levels

| Area | Confidence | Notes |
|------|-----------|-------|
| Stack choice | High ✓ | Riverpod/Dio are de facto standards |
| Architecture | High ✓ | Clean architecture proven pattern |
| Next.js integration | Medium | Need to test mobile-specific headers |
| FIFA cards | Medium | CustomPainter requires careful optimization |
| Offline support | Medium | Complex sync logic needed |

---

## Next Steps

1. **Phase 1:** Foundation + Auth
   - Setup Flutter project structure
   - Configure Dio + interceptors
   - Implement secure JWT storage
   - Build login screen

2. **Phase 2:** Clubs + Basic offline
   - Club list with cache
   - Club switching
   - Offline indicator

3. **Phase 3:** Matches + RSVP
   - Match list/detail
   - RSVP with optimistic updates
   - Formation viewing

4. **Phase 4:** Stats + FIFA cards
   - Leaderboards
   - FIFA card CustomPainter
   - Card sharing

5. **Phase 5:** Live + Notifications
   - Real-time match updates
   - Push notifications
   - Live score tracking

---

*Synthesized: 2025-03-09*