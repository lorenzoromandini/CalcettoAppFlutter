<p align="center">
  <img src="web/logo.png" alt="Calcetto App Flutter Logo" width="128" height="128">
</p>

<h1 align="center">Calcetto App Flutter</h1>

<p align="center">
  A <strong>native mobile app</strong> (iOS/Android) for organizing football matches with friends. 
  Built with Flutter and Riverpod, with standalone Serverpod backend.
</p>

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/Flutter-3.19-02569B?logo=flutter" alt="Flutter Version"></a>
  <a href="#"><img src="https://img.shields.io/badge/Dart-3.3-00B4AB?logo=dart" alt="Dart Version"></a>
  <a href="#"><img src="https://img.shields.io/badge/Riverpod-2.5-4CAF50?logo=flutter" alt="Riverpod"></a>
</p>

---

## 🎯 Overview

**Calcetto App Flutter** is the official mobile companion to the Calcetto Manager web platform. 
It provides the same powerful club management features in a native mobile experience with offline support.

| Project | Platform | Purpose |
|---------|----------|---------|
| **calcetto_backend/** (./calcetto_backend) | Serverpod (Dart) | Standalone REST API with PostgreSQL |
| **calcetto_app_flutter/** (this repo) | Flutter (iOS/Android) | Native mobile app with offline-first design |
| **CalcettoApp** (../CalcettoApp) | React/Next.js Web | Original web platform (optional) |

---

## ✨ Features (v1.0 - In Development)

### ✅ Phase 1 COMPLETE - Foundation & Authentication
- **Email/Password Login** - Secure JWT authentication
- **User Registration** - Signup with validation
- **Session Persistence** - Auto-login on app launch
- **Biometric Auth** - Face ID / Touch ID support (ready)
- **Dark/Light Theme** - System detection + manual toggle
- **Hive Caching** - Offline-first architecture ready

### ⏳ Phase 2 - Clubs & Offline (Next)
- Club list and management
- Offline data synchronization
- Home screen with club activity

### 🔮 Future Phases
- **Phase 3:** Matches & RSVP (match scheduling, player availability)
- **Phase 4:** Statistics & FIFA Cards (player ratings, performance cards)
- **Phase 5:** Live Matches & Push Notifications (real-time updates)

---

## 🚀 Tech Stack

### Core Framework
- **Flutter 3.19+** - Cross-platform framework (iOS, Android, Web)
- **Dart 3.3+** - Type-safe language with null safety
- **Riverpod 2.5** - Compile-safe state management
  - `StateNotifierProvider` for form state
  - Async providers for API calls
  - Family modifiers for parameterized queries

### Data & Networking
- **Dio** - HTTP client with interceptors for JWT
- **Hive** - NoSQL local database for offline caching
- **flutter_secure_storage** - Encrypted JWT token storage
- **local_auth** - Biometric authentication (Face ID/Touch ID)

### Architecture
- **Clean Architecture** - Separation into layers:
  - **Domain** - Entities, repositories, use cases
  - **Data** - Models, repositories impl, datasources
  - **Presentation** - Widgets, screens, providers
- **Repository Pattern** - Abstract data access logic
- **Result<T>** - Functional error handling (no exceptions)

---

## 📊 Architecture

### Clean Architecture Flow

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Presentation   │────▶│   Domain Layer    │────▶│   Data Layer    │
│  (Riverpod)     │     │  (Use Cases)      │     │  (Repository)   │
│  LoginScreen    │     │  LoginUseCase     │     │  AuthRepository │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │  ApiClient      │
                                               │  (Dio + JWT)    │
                                               └─────────────────┘
                                                        │
                                                        ▼
                                                ┌─────────────────┐
                                                │ Serverpod API   │
                                                │  (port 8080)    │
                                                └─────────────────┘
```

### Backend Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Flutter App    │────▶│ Serverpod API    │────▶│  PostgreSQL     │
│  (port 8080)    │ JWT │  (Dart/Serverpod)│ SQL │  Database       │
└─────────────────┘     └──────────────────┘     └─────────────────┘
```

### State Management Example

```dart
// Provider definition
final loginFormProvider = StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier(ref.watch(loginAsyncUseCaseProvider));
});

// Usage in widget
@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(loginFormProvider);
  
  ref.listen<LoginFormState>(loginFormProvider, (prev, next) {
    if (next.isSuccess) {
      Navigator.pushReplacement(context, MainLayout());
    }
  });
  
  return TextFormField(
    onChanged: (v) => ref.read(loginFormProvider.notifier).setEmail(v),
  );
}
```

---

## 📁 Project Structure

```
lib/
  main.dart                          # App entry point with Hive init
  core/
    app/
      app.dart                       # Root widget with theme
    constants/
      app_constants.dart             # API URLs, Hive box names
    di/
      injection.dart                 # Riverpod providers (DI)
    errors/
      failures.dart                  # Failure types (AuthFailure, etc.)
      exceptions.dart                # ApiException
    network/
      api_client.dart                # Dio HTTP client with JWT
    theme/
      app_theme.dart                 # Material 3 theme config
      theme_provider.dart            # Theme mode provider
    utils/
      result.dart                    # Result<T> sealed class
    widgets/
      app_drawer.dart                # Side drawer with theme toggle
  features/
    auth/
      domain/
        entities/
          user.dart                  # User entity (domain layer)
        repositories/
          auth_repository.dart       # Repository interface
        usecases/
          login.dart                 # Login validation + execution
          signup.dart                # Signup validation + execution
      data/
        models/
          user_model.dart            # User model with JSON parsing
        datasources/
          auth_local_datasource.dart # Hive cache operations
        repositories/
          auth_repository_impl.dart  # Repository implementation
      presentation/
        providers/
          auth_providers.dart        # Form + session providers
        screens/
          login_screen.dart          # Login UI with validation
          signup_screen.dart         # Signup UI with 6 fields
        widgets/
          password_field.dart        # Reusable password input
    home/
      presentation/
        screens/
          home_screen.dart           # Home dashboard
          main_layout.dart           # Bottom nav layout
    clubs/
      # Phase 2 implementation
    matches/
      # Phase 3 implementation
    profile/
      # Phase 3 implementation

.planning/
  PROJECT.md                         # Project context and value
  REQUIREMENTS.md                    # 67 v1 requirements
  ROADMAP.md                         # 5-phase delivery plan
  STATE.md                           # Current status (read first!)
  config.json                        # Workflow preferences
  research/
    SUMMARY.md                       # Research findings
    STACK.md                         # Tech stack details
    ARCHITECTURE.md                  # Architecture guide
    PITFALLS.md                      # Common mistakes
  phases/
    01-foundation-auth/              # Phase 1 plans and verification
      01-PLAN.md
      01-SUMMARY.md
      VERIFICATION.md

test/
  features/
    auth/
      login_screen_test.dart         # Widget tests with mocking
```

---

## 🏗️ Database Schema (Backend)

The Flutter app connects to the Serverpod backend with this schema:

**Auth Models:**
- `User` - Authentication and profile (id, email, firstName, lastName, nickname, image)

**Club Models:**
- `Club` - Football club info
- `ClubMember` - Membership with roles (OWNER/MANAGER/MEMBER)
- `Match` - Scheduled matches
- `Goal` - Match goals with scorer/assister
- `PlayerRating` - 38-value rating system (4-10 with 0.5 increments)

---

## 🎯 Backend Options

You can run this Flutter app with **two backend choices**:

### Option 1: Serverpod Backend (Recommended ✅)
Independent Dart backend created for this project:
- **Location:** `./calcetto_backend/`
- **Port:** 8080
- **Language:** Dart (same as Flutter)
- **Setup:** Simple, minimal dependencies
- **Use:** For new development and testing

### Option 2: Next.js Backend
Original CalcettoApp web platform:
- **Location:** `../CalcettoApp/`
- **Port:** 3000
- **Language:** TypeScript/JavaScript
- **Setup:** Requires Node.js, Prisma, full web stack
- **Use:** For full web platform features

---

## 🚀 Getting Started

### Prerequisites

1. **Flutter 3.19+** - [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **Dart 3.6+** - For Serverpod backend (included with Flutter)
3. **PostgreSQL** - Backend database (Docker container)
4. **Android Studio / VS Code** - Recommended IDEs

### Setup

#### 1. Clone the repository
```bash
git clone git@github.com:lorenzoromandini/CalcettoAppFlutter.git
cd calcetto-app-flutter
```

#### 2. Install Flutter dependencies
```bash
flutter pub get
```

#### 3. Start the PostgreSQL database
```bash
# Uses existing Postgres container
docker start calcetto-postgres

# Or create new if needed:
docker run -d \
  --name calcetto-postgres \
  -e POSTGRES_USER=calcetto \
  -e POSTGRES_PASSWORD=calcetto \
  -e POSTGRES_DB=calcetto \
  -p 5432:5432 \
  postgres:16-alpine
```

#### 4. Start the Serverpod backend
```bash
cd calcetto_backend/calcetto_backend_server
dart bin/main.dart
```

> **Backend must be running on** `http://localhost:8080`

#### 5. Configure API base URL (if needed)
Edit `lib/core/constants/app_constants.dart`:
```dart
static const String apiBaseUrl = 'http://localhost:8080';
```

#### 5. Run the Flutter app
```bash
# Choose a target device
flutter devices

# Run on Chrome (fastest for testing)
flutter run -d chrome

# Run on Android emulator
flutter run -d android

# Run on iOS simulator (macOS only)
flutter run -d ios
```

---

## 🔄 Quick Start Script

Start everything at once:
```bash
# Terminal 1: Start backend
cd calcetto_backend/calcetto_backend_server && \
  dart bin/main.dart

# Terminal 2: Start Flutter app  
flutter run -d chrome
```

---

## 🧪 Testing the Backend

Create a test user:
```bash
curl -X POST http://localhost:8080/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123","firstName":"Test"}'
```

Login:
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

---

## 🧪 Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run specific device
flutter run -d chrome  # or android, ios, edge, windows

# Run tests
flutter test

# Code analysis
flutter analyze

# Format code
dart format .

# Clean build
flutter clean && flutter pub get

# Build for web
flutter build web --release

# Build Android APK
flutter build apk --release

# Build iOS (requires macOS + signing)
flutter build ios --release
```

---

## 🔐 Authentication Flow

### Login Flow
```
┌──────────────────┐
│  LoginScreen     │ User enters email/password
│  - Form validation│
│  - Show errors   │
└────────┬─────────┘
         │ User submits
         ▼
┌──────────────────┐
│ LoginFormNotifier│ Update form state
│ .login()         │ Show loading spinner
└────────┬─────────┘
         │ Call use case
         ▼
┌──────────────────┐
│ LoginAsyncUseCase│ Validate email/password format
│                  │ Check min 6 char password
└────────┬─────────┘
         │ Call repository
         ▼
┌──────────────────┐
│ AuthRepositoryImpl
│ .login()         │ POST /api/auth/login
│                  │ Store JWT token
│                  │ Cache user data
└────────┬─────────┘
         │ Success
         ▼
┌──────────────────┐
│ Navigator        │ Push to MainLayout
│ Navigation       │ Clear form state
└──────────────────┘
```

### Session Persistence
On app launch (`lib/core/app/app.dart`):
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final authState = ref.watch(authSessionProvider);

  if (authState.isLoading) {
    // Show loading spinner
    return CircularProgressIndicator();
  }

  return MaterialApp(
    home: authState.isAuthenticated
        ? MainLayout()        // Auto-login if valid JWT
        : LoginScreen(),      // Show login if not authenticated
  );
}
```

---

## 📱 Testing Authentication

### Manual Testing Checklist

1. **Login Screen**
   - [ ] Enter invalid email → Error appears
   - [ ] Enter invalid password → Error appears
   - [ ] Click "Sign In" without filling → Validation errors
   - [ ] Valid credentials → Navigate to home
   - [ ] Theme toggle works (dark/light)
   - [ ] Drawer menu opens/closes

2. **Signup Screen**
   - [ ] All fields required (except nickname)
   - [ ] Password min 6 characters
   - [ ] Password confirmation must match
   - [ ] Email format validation
   - [ ] Success message on completion

3. **Session Persistence**
   - [ ] Login → Close app → Reopen → Still logged in
   - [ ] Logout → Session cleared → Login screen shown

### Testing Without Backend
If backend is not running:
- Login/signup will show "Network error" or "Server unavailable"
- UI/UX testing still works (validation, loading states, navigation)

---

## 🔧 Troubleshooting

### Common Issues

#### 1. "Failed to connect to localhost:8080"
**Cause:** Serverpod backend is not running.

**Solution:**
```bash
cd calcetto_backend/calcetto_backend_server
dart bin/main.dart
```

#### 2. Flutter web shows old version after rebuild
**Cause:** Browser aggressively caches Flutter web builds.

**Solution:**
- Hard refresh: `Ctrl+Shift+R` (Windows/Linux) or `Cmd+Shift+R` (Mac)
- Or open in incognito: `Ctrl+Shift+N`
- Or disable cache in DevTools Network tab

#### 3. Hive initialization fails on web
**Expected:** Hive may not be fully available on web.

**Solution:** Wrapped in try/catch - app continues without caching.

#### 4. Biometric auth not working on emulator
**Cause:** Emulators don't have biometric sensors.

**Solution:** Test on physical device or enable mock biometrics in Android settings.

---

## 🔄 Current Phase Status

### Phase 1: Foundation & Authentication ✅ COMPLETE (21/21 requirements)

| Feature | Status | Notes |
|---------|--------|-------|
| Login screen with validation | ✅ | 2 fields, inline errors, loading state |
| Signup screen | ✅ | 6 fields, password confirmation |
| JWT token storage | ✅ | flutter_secure_storage |
| Session persistence | ✅ | Auto-check on app launch |
| Biometric auth | ✅ | local_auth + Hive preference |
| Theme toggle | ✅ | Light/Dark/System |
| Drawer menu | ✅ | Right-side sliding |
| Real API integration | ✅ | Next.js /api/auth/* endpoints |
| Error translation | ✅ | Italian → English mapping |
| Web build | ✅ | Deployed at localhost:8080 (Flutter web) |

### Phase 2: Clubs & Offline ⏳ NEXT (0/17 requirements)

---

## ⚠️ License & Usage

This software is proprietary and confidential. All rights reserved.

**Unauthorized copying, distribution, or replication of this software is strictly prohibited.**

This codebase is part of the Calcetto Manager platform and is intended for use only by authorized developers and team members.

---

## 📞 Links

- **Backend (Serverpod):** `./calcetto_backend` - Dart REST API
- **Web Platform (React/Next.js):** [../CalcettoApp](../CalcettoApp) - Optional original web app
- **Backend API:** http://localhost:8080
- **Flutter App:** http://localhost:8080 (web) or mobile device
- **GitHub Repository:** [lorenzoromandini/CalcettoAppFlutter](https://github.com/lorenzoromandini/CalcettoAppFlutter)

---

<p align="center">
  <strong>Phase 1 Status:</strong> ✅ COMPLETE | Next: Phase 2 - Clubs & Offline
</p>

<p align="center">
  Built with ❤️ and ⚽ using <strong>Flutter</strong>, <strong>Riverpod</strong>, and <strong>Dio</strong>
</p>
