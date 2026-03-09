# Research: Flutter Stack

**Domain:** Flutter + Next.js API integration for mobile football club management  
**Date:** 2025-03-09  
**Milestone:** Greenfield

---

## Executive Summary

**Recommended Stack:** Flutter 3.x with Riverpod for state management, Dio for HTTP client, Hive for local caching, and Firebase Cloud Messaging for push notifications. This combination provides offline support, clean architecture, and smooth animations required for FIFA-style player cards.

---

## Core Framework

### Flutter SDK
- **Version:** 3.24+ (latest stable)
- **Why:** Flutter 3.24 brings improved performance, better web support, and Material 3 updates
- **Confidence:** High ✓
- **Alternatives rejected:** 
  - React Native (slower animations, harder FIFA card implementation)
  - Native (iOS + Android separate codebases)

### Dart
- **Version:** 3.5+
- **Why:** Required by Flutter 3.24, brings pattern matching and records for cleaner code
- **Confidence:** High ✓

---

## State Management

### Riverpod 2.x (Generator syntax)
```yaml
dev_dependencies:
  riverpod_generator: ^2.4.0
  riverpod_lint: ^2.3.0

dependencies:
  flutter_riverpod: ^2.5.0
```

**Rationale:**
- Compile-safe (catches errors at build time, not runtime)
- Excellent caching and disposal handling
- Works well with Flutter 3.24 code generation
- Better than BLoC for this use case (less boilerplate, more Flutter-native)
- Better than Provider (successor, type-safe)
- Better than GetX (better architecture, not magical)

**Confidence:** High ✓

---

## HTTP Client

### Dio 5.x
```yaml
dependencies:
  dio: ^5.8.0
  dio_cache_interceptor: ^3.5.1
  dio_cache_interceptor_hive_store: ^4.0.0
```

**Rationale:**
- Interceptors for auth token management (NextAuth JWT)
- Built-in request/response logging
- Easy timeout and retry configuration
- Better cache control than vanilla `http` package
- Interceptor pattern perfect for adding auth headers to all requests

**Confidence:** High ✓

**NOT using:**
- `http` package (too basic, no interceptors)
- Chopper (overkill for this scale)
- GraphQL (REST API already exists, no benefit to add GraphQL layer)

---

## Local Storage & Caching

### Hive + Dio Cache Interceptor
```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^2.0.0
  dio_cache_interceptor: ^3.5.1
  dio_cache_interceptor_hive_store: ^4.0.0
```

**Rationale:**
- Hive: Fast NoSQL box for structured data (clubs, matches, user profile)
- Dio Cache: Automatic HTTP response caching with TTL
- Combined: Offline-first architecture
- Better than SharedPreferences (structured data, not just key-value)
- Better than SQLite (simpler API, sufficient for this use case)

**Cache Strategy:**
- Matches list: Cache 5 minutes (like web TanStack Query)
- User profile: Cache until explicitly refreshed
- Player cards: Cache aggressively (rarely change)
- Formations: Cache per-match

**Confidence:** High ✓

---

## Authentication

### NextAuth JWT Integration
```yaml
dependencies:
  flutter_secure_storage: ^9.2.0
```

**Rationale:**
- Store JWT token securely (Keychain on iOS, Keystore on Android)
- Intercept all Dio requests to add Authorization header
- Handle token refresh automatically
- Match existing NextAuth v5 flow on backend

**Flow:**
1. Login via API → receive JWT
2. Store in flutter_secure_storage
3. Dio interceptor adds header to all requests
4. On 401, redirect to login

**Confidence:** High ✓

---

## UI Components

### Material 3
- **Why:** Native Android look, works on iOS too, theming support
- **Alternative:** Cupertino (iOS-only, inconsistent on Android)
- **Confidence:** High ✓

### Additional Packages
```yaml
dependencies:
  shimmer: ^3.0.0          # Loading skeletons for cards
  flutter_staggered_grid_view: ^0.7.0  # Leaderboard grids
  fl_chart: ^0.70.0        # Statistics charts
  flutter_slidable: ^4.0.0 # Swipe actions in lists
```

---

## Animations

### FIFA Card Requirements
```yaml
dependencies:
  flutter_animate: ^4.5.0  # Easy animations
```

**Rationale:**
- Built-in Flutter animation system (CustomPainter, AnimatedContainer)
- flutter_animate for simple declarative animations
- 60fps target on mid-range devices
- Shimmer for loading states

**Animation Strategy:**
- Card entrance: Scale + fade (300ms)
- Card flip: RotationY (for card back reveal)
- Stats counter: Number animation
- Rarity glow: Continuous subtle pulse

**Confidence:** High ✓

---

## Push Notifications

### Firebase Cloud Messaging
```yaml
dependencies:
  firebase_core: ^3.8.0
  firebase_messaging: ^15.1.0
```

**Rationale:**
- Free tier sufficient for club notifications
- Works on iOS and Android
- Backend already can send FCM via Next.js
- Match reminders, goal updates, club invites

**Confidence:** High ✓

---

## Testing

### Test Stack
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.0        # Mocking (modern Mockito alternative)
  build_runner: ^2.4.0    # Code generation for Riverpod
```

**Strategy:**
- Unit tests: Repository layer, API clients
- Widget tests: Screen components
- Integration tests: Critical flows (login → view club → RSVP)

**Confidence:** Medium (testing always lower priority in practice)

---

## Development Tools

### Essential
```yaml
dev_dependencies:
  flutter_lints: ^5.0.0   # Linting
  build_runner: ^2.4.0     # Code generation
```

### Optional
- **melos:** Monorepo management (if splitting into packages)
- **patrol:** E2E testing (alternative to flutter_driver)
- **very_good_cli:** Project scaffolding (opinionated but good)

---

## Build Configuration

### Platforms
- **iOS:** Minimum iOS 14+ (covers 98% of devices)
- **Android:** Minimum SDK 21 (Android 5.0)
- **Web:** CanvasKit renderer for better performance

### Web Support
- Use `flutter build web --web-renderer canvaskit`
- CanvasKit provides near-native performance for FIFA cards
- HTML renderer too slow for complex animations

---

## Confidence Matrix

| Component | Confidence | Risk | Mitigation |
|-----------|-----------|------|------------|
| Flutter 3.24 | High ✓ | Low | Well-established framework |
| Riverpod 2.x | High ✓ | Low | De facto standard |
| Dio 5.x | High ✓ | Low | Battle-tested |
| Hive | Medium | Medium | Less active development |
| Firebase | High ✓ | Low | Google-backed |
| NextAuth JWT | High ✓ | Low | Standard JWT flow |

---

## Migration Path

If existing packages fail:
1. **Riverpod → BLoC:** More boilerplate but proven
2. **Hive → ObjectBox:** Similar API, better performance
3. **Dio → Chopper:** More code generation, similar features

---

*Research complete: 2025-03-09*