# Research: Flutter Architecture

**Domain:** Flutter app architecture for Next.js API integration  
**Date:** 2025-03-09  
**Milestone:** Greenfield

---

## Architecture Overview

Clean Architecture with Riverpod for dependency injection and state management. Three-layer separation: Presentation → Domain → Data.

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │
│  │   Screens   │  │  Widgets    │  │   State (Riverpod)  │   │
│  │   (UI)      │  │  (UI)       │  │   (Controllers)     │   │
│  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘   │
└─────────┼────────────────┼──────────────────┼────────────────┘
          │                │                  │
          ▼                ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│                        DOMAIN                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │
│  │   Entities  │  │  Use Cases  │  │   Repository        │   │
│  │   (Models)  │  │  (Logic)    │  │   Interfaces        │   │
│  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘   │
└─────────┼────────────────┼──────────────────┼────────────────┘
          │                │                  │
          ▼                ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│                         DATA                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │
│  │    API      │  │   Local     │  │     Cache           │   │
│  │   Client    │  │  Storage    │  │   (Hive/Dio)        │   │
│  │   (Dio)     │  │  (Hive)     │  │                     │   │
│  └─────────────┘  └─────────────┘  └─────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## Directory Structure

```
lib/
├── main.dart                    # Entry point
├── app.dart                     # MaterialApp configuration
├── core/                        # Shared utilities
│   ├── constants/               # App constants
│   ├── theme/                   # Theme data
│   ├── router/                  # Navigation (GoRouter)
│   ├── providers/               # Global providers
│   └── utils/                   # Utilities
├── data/                        # Data layer
│   ├── api/                     # API client
│   │   ├── dio_client.dart      # Dio configuration
│   │   ├── interceptors/        # Auth, logging, cache
│   │   └── endpoints/           # Endpoint definitions
│   ├── local/                   # Local storage
│   │   ├── hive_boxes.dart      # Box configuration
│   │   └── secure_storage.dart  # JWT storage
│   ├── models/                  # Data models
│   │   ├── user.dart            # User entity
│   │   ├── club.dart            # Club entity
│   │   ├── match.dart           # Match entity
│   │   └── ...
│   └── repositories/            # Repository implementations
│       ├── auth_repository.dart
│       ├── club_repository.dart
│       └── ...
├── domain/                      # Domain layer
│   ├── entities/                # Business entities
│   │   ├── user.dart            # (same as data models here)
│   │   └── ...
│   ├── repositories/            # Repository interfaces
│   │   ├── auth_repository.dart
│   │   └── ...
│   └── usecases/                # Business logic
│       ├── get_clubs.dart
│       ├── rsvp_match.dart
│       └── ...
├── presentation/                # Presentation layer
│   ├── screens/                 # Full screens
│   │   ├── login_screen.dart
│   │   ├── clubs_screen.dart
│   │   ├── match_detail_screen.dart
│   │   └── ...
│   ├── widgets/                 # Reusable widgets
│   │   ├── common/              # AppBar, Buttons, etc.
│   │   ├── clubs/               # Club-specific
│   │   ├── matches/             # Match-specific
│   │   └── cards/               # FIFA cards
│   └── providers/               # Riverpod providers
│       ├── auth_provider.dart
│       ├── clubs_provider.dart
│       └── ...
└── services/                    # External services
    ├── push_notifications.dart
    └── analytics.dart
```

---

## Data Flow

### 1. Read Flow (with cache)

```
UI (Widget)
    ↓ (watch provider)
Controller (Riverpod)
    ↓ (call use case)
Use Case
    ↓ (call repository)
Repository
    ↓ (check cache first)
Cache (Hive/Dio)
    ↓ (cache miss → fetch)
API (Next.js)
    ↓
Database (PostgreSQL)
```

**Example:**
```dart
// UI
Consumer(builder: (context, ref, child) {
  final clubs = ref.watch(clubsProvider);
  return clubs.when(
    loading: () => const CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
    data: (data) => ClubsList(clubs: data),
  );
});

// Provider
@riverpod
Future<List<Club>> clubs(ClubsRef ref) {
  return ref.read(getClubsUseCaseProvider).execute();
}
```

### 2. Write Flow (optimistic update)

```
UI (User action)
    ↓
Controller (optimistic update)
    ↓ (background)
Use Case
    ↓
Repository
    ↓ (queue if offline)
API
    ↓
Success → Update cache
Error → Revert optimistic update
```

**Example:**
```dart
// Controller with optimistic update
@riverpod
class RsvpController extends _$RsvpController {
  @override
  FutureOr<void> build() {}

  Future<void> rsvp(String matchId, RsvpStatus status) async {
    // Optimistic: Update UI immediately
    ref.read(matchProvider(matchId).notifier).updateRsvp(status);
    
    // Background: Sync with server
    try {
      await ref.read(rsvpUseCaseProvider).execute(matchId, status);
    } catch (e) {
      // Revert on error
      ref.read(matchProvider(matchId).notifier).revertRsvp();
      throw e;
    }
  }
}
```

---

## Component Boundaries

### Presentation Layer
**Responsibilities:**
- Build UI widgets
- Handle user input
- Observe state changes
- Navigate between screens

**Rules:**
- No direct API calls
- No direct database access
- Use Riverpod providers for data
- Keep widgets pure (data in → UI out)

### Domain Layer
**Responsibilities:**
- Define business entities
- Define repository interfaces
- Implement business logic
- Handle use cases

**Rules:**
- No Flutter dependencies
- No platform-specific code
- Pure Dart logic
- Repository interfaces, not implementations

### Data Layer
**Responsibilities:**
- Implement repositories
- Make API calls
- Manage local storage
- Handle caching

**Rules:**
- Implements domain interfaces
- Handles errors, retries
- Manages connection state
- Converts DTOs to entities

---

## Build Order (Dependencies)

### Phase 1: Foundation
1. **Core setup** - Constants, theme, router
2. **API client** - Dio configuration, interceptors
3. **Storage** - Hive boxes, secure storage
4. **Base models** - User, Club

### Phase 2: Auth
1. **Auth repository** - Login, logout, token management
2. **Auth provider** - Authentication state
3. **Login screen** - UI

### Phase 3: Clubs
1. **Club models** - Club, ClubMember
2. **Club repository** - CRUD operations
3. **Club providers** - List, detail
4. **Club screens** - List, detail

### Phase 4: Matches
1. **Match models** - Match, Formation, RSVP
2. **Match repository** - CRUD + RSVP
3. **Match providers** - Optimistic updates
4. **Match screens** - List, detail, RSVP

### Phase 5: Stats & Cards
1. **Stats models** - PlayerStats, Ratings
2. **Stats repository** - Aggregation queries
3. **FIFA card widgets** - CustomPainter
4. **Stats screens** - Leaderboard, cards

### Phase 6: Live & Notifications
1. **Real-time sync** - Firebase or WebSocket
2. **Push notifications** - FCM setup
3. **Live match screen** - Score tracking

---

## State Management Patterns

### AsyncValue Pattern
```dart
// Provider returns AsyncValue<T>
@riverpod
Future<Club> club(ClubRef ref, String id) async {
  return ref.read(clubRepositoryProvider).getById(id);
}

// UI handles all states
club.when(
  loading: () => const LoadingWidget(),
  error: (err, _) => ErrorWidget(err),
  data: (club) => ClubDetail(club: club),
);
```

### Optimistic Updates
```dart
@riverpod
class MatchRsvp extends _$MatchRsvp {
  @override
  Future<RsvpStatus> build(String matchId) async {
    return ref.read(getRsvpUseCaseProvider).execute(matchId);
  }

  Future<void> setRsvp(RsvpStatus status) async {
    // Save current state
    final previous = state.value;
    
    // Optimistic update
    state = AsyncData(status);
    
    // Sync with server
    try {
      await ref.read(updateRsvpUseCaseProvider).execute(matchId, status);
    } catch (e) {
      // Revert on failure
      state = AsyncData(previous!);
      rethrow;
    }
  }
}
```

---

## API Integration Strategy

### Endpoint Mapping

| Web Endpoint | Mobile Usage |
|--------------|--------------|
| `/api/auth/login` | Login → Store JWT |
| `/api/clubs` | Get club list |
| `/api/clubs/[id]` | Get club details |
| `/api/clubs/[id]/members` | Get members |
| `/api/clubs/[id]/matches` | Get matches |
| `/api/matches/[id]/rsvp` | RSVP to match |
| `/api/matches/[id]/goals` | Get/Post goals |
| `/api/user/dashboard` | Get user stats |

### Error Handling
```dart
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final bool isNetworkError;
  
  ApiException(this.statusCode, this.message, {this.isNetworkError = false});
}

// In Dio interceptor
dio.interceptors.add(
  InterceptorsWrapper(
    onError: (error, handler) {
      if (error.response?.statusCode == 401) {
        // Token expired, refresh or logout
        authRepository.refreshToken();
      }
      return handler.next(error);
    },
  ),
);
```

---

## Testing Architecture

### Test Pyramid

```
    ▲
   /  \       E2E Tests (Critical flows)
  /____\      ~5% of tests
 /      \
/   /
/ Integration \  Repository + API
/______________\ ~20% of tests

/              \
/    Unit Tests   \  Use cases, providers
/__________________\ ~75% of tests
```

### Test Structure
```
test/
├── unit/
│   ├── usecases/
│   └── providers/
├── integration/
│   └── repositories/
└── e2e/
    └── flows/
```

---

## Key Decisions

| Decision | Rationale |
|----------|-----------|
| Riverpod over BLoC | Less boilerplate, better DX |
| Dio over http | Interceptors, retry logic |
| Hive over SQLite | Simpler API, sufficient |
| Clean Architecture | Testability, separation |
| Feature-first folders | Scales better than layer-first |

---

*Research complete: 2025-03-09*