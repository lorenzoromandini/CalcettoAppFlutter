# Calcetto App Flutter – Agent Operating Guide

Flutter + Riverpod mobile application for managing casual calcetto (5v5 football) matches among friends/club members.  
Uses Serverpod backend with PostgreSQL database.

---

## Quick Commands

```bash
# Flutter app
flutter pub get
flutter run -d chrome              # Web (fastest for testing)
flutter run -d android             # Android device/emulator
flutter run -d ios                 # iOS simulator (macOS only)

# Code quality
flutter analyze
dart format .
flutter test

# Serverpod backend
cd calcetto_backend/calcetto_backend_server
dart bin/main.dart
~/.pub-cache/bin/serverpod generate          # after model changes
# ~/.pub-cache/bin/serverpod create-migration  # ONLY when owner explicitly instructs
```

Never run migrations when fixing logic, validation or UI issues.

---

## Core Rules

- All API calls must go through Serverpod endpoints (no direct database access from Flutter).
- Keep business logic in **Domain Layer** (use cases) and **Backend Endpoints**.
- Use Riverpod for state management (never `setState` for API data).
- Always handle loading/error states in UI.
- Validate all user inputs in Flutter before sending to API.
- Use `Result<T>` pattern for error handling (no exceptions in business logic).

---

## Architecture Layers

```
lib/
├── features/
│   └── auth/
│       ├── domain/           # Entities, repositories (abstract), use cases
│       ├── data/             # Models, API calls, repository implementations
│       └── presentation/     # Screens, widgets, Riverpod providers
```

**Flow:** Screen → Provider → Use Case → Repository → API → Serverpod Backend → PostgreSQL

---

## Important Invariants to Respect

These are enforced at both database and application level:

- Exactly one formation per side per match (`Formation` unique on `matchId + isHome`).
- One rating per player per match (`PlayerRating` unique on `matchId + clubMemberId`).
- Goal order must be unique per match.
- Jersey number unique per club (`ClubMember` unique on `clubId + jerseyNumber`).
- Club membership unique (`ClubMember` unique on `clubId + userId`).
- Player ratings use `Decimal(3,2)` precision.
- Password minimum 6 characters (validated in Flutter + backend).

---

## Serverpod & Schema Guidance

- The authoritative Serverpod models live in `calcetto_backend/calcetto_backend_server/lib/src/*.spy.yaml`.
- Read those files to understand models, fields, relations, constraints, enums, defaults, indexes.
- Never propose or generate changes to the schema unless owner explicitly instructs.
- After model changes: run `serverpod generate` then `serverpod create-migration`.

### Backend Structure

```
calcetto_backend/
└── calcetto_backend_server/
    ├── lib/src/
    │   ├── auth_endpoint.dart       # Login/signup logic
    │   ├── user.spy.yaml            # User database model
    │   └── generated/               # Auto-generated (NEVER EDIT)
    ├── migrations/                  # Database migrations
    └── config/                      # Database configuration
```

---

## Code Style & Patterns

### Dart Conventions

- **camelCase** for variables, parameters, methods: `matchData`, `homeScore`, `isFinalized`
- **PascalCase** for classes, enums, widgets: `LoginScreen`, `ClubMember`, `MatchStatus`
- **snake_case** for database fields (in yaml): `created_at`, `user_id`
- **kPrefix** for constants: `kMaxAvatarSize`, `kDefaultTimeout`

### Riverpod Patterns

```dart
// Provider definition
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(dio: ref.read(dioProvider));
});

final loginFormProvider = StateNotifierProvider<LoginFormNotifier, LoginFormState>(
  (ref) => LoginFormNotifier(ref.watch(loginUseCaseProvider)),
);

// Usage in widget
@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(loginFormProvider);
  
  ref.listen<LoginFormState>(loginFormProvider, (prev, next) {
    if (next.isSuccess) {
      Navigator.pushReplacement(context, MainLayout());
    }
    if (next.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(next.error!)),
      );
    }
  });
  
  return TextFormField(
    onChanged: (v) => ref.read(loginFormProvider.notifier).setEmail(v),
  );
}
```

### API Call Pattern

```dart
// Data source
Future<UserModel> login(String email, String password) async {
  final response = await _dio.post(
    '${AppConstants.apiBaseUrl}/auth/login',
    data: {'email': email, 'password': password},
  );
  
  if (response.data['success'] == true) {
    return UserModel.fromJson(response.data['user']);
  } else {
    throw AuthException(response.data['error'] ?? 'Login failed');
  }
}

// Repository with Result pattern
Future<Result<User, AuthFailure>> login(String email, String password) async {
  try {
    final user = await _remoteDataSource.login(email, password);
    await _localDataSource.cacheUser(user);
    return Result.success(user);
  } on DioException {
    return Result.failure(AuthFailure.networkError());
  } on AuthException catch (e) {
    return Result.failure(AuthFailure.invalidCredentials(e.message));
  }
}
```

### State Management Example

```dart
@riverpod
class AuthSession extends _$AuthSession {
  @override
  Future<AuthState> build() async {
    final token = await _storage.read(AppConstants.jwtTokenKey);
    if (token == null) return AuthState.unauthenticated();
    
    try {
      final user = await _authRepository.getCurrentUser(token);
      return AuthState.authenticated(user);
    } catch (_) {
      return AuthState.unauthenticated();
    }
  }
}
```

---

## Workflow Reminders

- For multi-step tasks: identify affected screens → determine state changes → update providers → update UI.
- Prefer minimal, focused edits over large refactors.
- When in doubt about backend models: read `*.spy.yaml` files first.
- Always test both success and error states.
- Keep UI logic in widgets, business logic in use cases/providers.

---

## Club Privileges System

### Privilege Hierarchy

Three privilege levels exist, managed via `ClubPrivilege` enum:

- **OWNER** (Proprietario)
- **MANAGER**
- **MEMBER**

There is one and only one OWNER per club.

### Permission Matrix

| Operation | OWNER | MANAGER | MEMBER |
|-----------|-------|---------|--------|
| **Club Management** ||||
| Modify club name/description/image | ✅ | ❌ | ❌ |
| Delete club | ✅ | ❌ | ❌ |
| View club details | ✅ | ✅ | ✅ |
| **Roster Management** ||||
| Invite new members | ✅ | ✅ | ❌ |
| Kick/Eject members | ✅ | ❌ | ❌ |
| Promote to MANAGER | ✅ | ❌ | ❌ |
| Demote from MANAGER | ✅ | ❌ | ❌ |
| View roster | ✅ | ✅ | ✅ |
| **Match Operations** ||||
| Create matches | ✅ | ✅ | ❌ |
| Edit match details | ✅ | ✅ | ❌ |
| Match formations management | ✅ | ✅ | ❌ |
| Delete matches | ✅ | ✅ | ❌ |
| Join match as player | ✅ | ✅ | ✅ |
| **Match Lifecycle** ||||
| Start match | ✅ | ✅ | ❌ |
| End match | ✅ | ✅ | ❌ |
| Finalize results/scores | ✅ | ✅ | ❌ |
| Add/remove goals | ✅ | ✅ | ❌ |
| Assign player ratings | ✅ | ✅ | ❌ |
| **Other** ||||
| Generate invite links | ✅ | ✅ | ❌ |
| View statistics | ✅ | ✅ | ✅ |
| View match history | ✅ | ✅ | ✅ |

### Implementation in Flutter

```dart
// Check permissions in UI
final member = ref.watch(currentClubMemberProvider);
final canEditClub = member?.privileges == ClubPrivilege.owner;
final canManageMatches = [
  ClubPrivilege.owner,
  ClubPrivilege.manager,
].contains(member?.privileges);

// Show/hide actions based on privileges
if (canManageMatches) {
  yield MatchAction.createMatch;
  yield MatchAction.finalizeScore;
}

if (member?.privileges == ClubPrivilege.owner) {
  yield ClubAction.deleteClub;
  yield ClubAction.ejectMember;
}
```

### Backend Validation

All privilege checks must also be validated on the backend (Serverpod endpoints):

```dart
// In endpoint
Future<MatchResponse> createMatch(Session session, String clubId, ...) async {
  final member = await ClubMember.db.findFirstRow(
    session,
    where: (t) => t.clubId.equals(clubId) & t.userId.equals(session.authenticatedUserId),
  );
  
  if (member == null || member.privileges == ClubPrivilege.member) {
    throw ApiException('Permessi insufficienti');
  }
  
  // Proceed with match creation
}
```

---

## Internationalization (i18n) & Text Translations

### Language Configuration

**IMPORTANT**: The application supports **multiple languages** with a language switcher.

**Configuration Details:**
- **Default Locale**: `it` (Italian)
- **Supported Locales**: `['it', 'en']` - Italian (primary) and English
- **Language Switcher**: Available in settings/profile screen
- **Persistence**: User's language choice is saved locally (Hive/flutter_secure_storage)

### Flutter Localization Setup

#### 1. Configuration Files

**`l10n.yaml`** (in project root):
```yaml
arb-dir: lib/l10n
template-arb-file: app_it.arb
output-localization-file: app_localizations.dart
nullable-getter: false
```

**`lib/l10n/app_it.arb`** (Italian translations):
```json
{
  "@@locale": "it",
  "loginTitle": "Accedi",
  "@loginTitle": {
    "description": "Title text for login screen"
  },
  "emailHint": "Email",
  "passwordHint": "Password",
  "signupButton": "Registrati",
  "loginButton": "Accedi",
  "invalidEmail": "Email non valida",
  "invalidPassword": "Password non valida",
  "passwordTooShort": "Password minima 6 caratteri",
  "networkError": "Errore di connessione",
  "authError": "Email o password non validi",
  "userExists": "Utente già registrato",
  "insufficientPermissions": "Permessi insufficienti"
}
```

#### 2. Implementation in Code

**In `main.dart`:**
```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  runApp(
    MaterialApp(
      locale: const Locale('it'),
      localizationsDelegates: const [
        AppLocalizations.delegate,  // Generated delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('it'), Locale('en')],
      home: LoginScreen(),
    ),
  );
}
```

**In Widgets:**
```dart
// Access translations
final l10n = AppLocalizations.of(context)!;

Text(l10n.loginTitle),           // "Accedi"
Text(l10n.emailHint),            // "Email"
Text(l10n.passwordHint),         // "Password"
ElevatedButton(
  child: Text(l10n.loginButton),
  onPressed: () => ...,
)

// In error handling
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(l10n.authError)),
);
```

**In Providers/Use Cases (without context):**
```dart
// For validation messages, use constants or pass locale
class AuthValidation {
  static String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email obbligatoria';  // Hardcoded Italian
    }
    if (!RegexPatterns.email.hasMatch(email)) {
      return 'Email non valida';
    }
    return '';
  }
  
  static String validatePassword(String password) {
    if (password.length < 6) {
      return 'Password minima 6 caratteri';
    }
    return '';
  }
}
```

#### 3. Generating Localizations

After adding new translations to `app_it.arb`:
```bash
# Flutter automatically generates on build, or force regeneration:
flutter pub get
flutter pub run intl_generator:extract_to_arb
flutter pub run intl_generator:generate_from_arb
```

Generated files:
- `lib/l10n/app_localizations.dart` - Main localization class
- `lib/l10n/app_localizations_it.dart` - Italian translations

### Text String Guidelines

#### ✅ DO:
- Use `AppLocalizations` for all UI text in widgets
- Keep ARB file organized by feature/screen
- Add descriptions for translators (even if self-translating)
- Use Italian for hardcoded validation messages (no context available)
- Use `intl` package for dates, numbers, plurals:
  ```dart
  import 'package:intl/intl.dart';
  
  final dateFormat = DateFormat('dd/MM/yyyy', 'it_IT');
  final formatted = dateFormat.format(DateTime.now());  // "10/03/2026"
  
  final numberFormat = NumberFormat('#,##0.##', 'it_IT');
  final formatted = numberFormat.format(1234.5);  // "1.234,5"
  ```

#### ❌ DON'T:
- Hardcode language without using localization system
- Use English text by default (Italian is the default locale)
- Mix Italian and English in same screen
- Forget to add translations to both `app_it.arb` and `app_en.arb`
- Assume users will keep default language (always provide switcher)

### Language Switcher Implementation

```dart
// In settings/profile screen
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    
    return DropdownButton<Locale>(
      value: currentLocale,
      items: [
        DropdownMenuItem(
          value: Locale('it'),
          child: Text('Italiano'),
        ),
        DropdownMenuItem(
          value: Locale('en'),
          child: Text('English'),
        ),
      ],
      onChanged: (locale) {
        if (locale != null) {
          ref.read(localeProvider.notifier).locale = locale;
          // Persist to storage
          ref.read(settingsRepositoryProvider).setLocale(locale);
        }
      },
    );
  }
}
```

### Translation Examples (Italian → English)

```dart
// Authentication
'Accedi'              →  'Sign In'
'Registrati'          →  'Sign Up'
'Email'               →  'Email'
'Password'            →  'Password'
'Conferma password'   →  'Confirm password'
'Password dimenticata?' → 'Forgot password?'
'Non hai un account? Registrati' → 'No account? Sign up'
'Hai già un account? Accedi' → 'Already have account? Sign in'

// Validation Messages
'Email obbligatoria'     → 'Email required'
'Email non valida'       → 'Invalid email'
'Password minima 6 caratteri' → 'Password must be at least 6 characters'
'Le password non corrispondono' → 'Passwords do not match'
'Campo obbligatorio'     → 'Required field'

// Error Messages
'Errore di connessione'     → 'Connection error'
'Email o password non validi' → 'Invalid email or password'
'Utente già registrato'     → 'User already exists'
'Permessi insufficienti'    → 'Insufficient permissions'
'Operazione non autorizzata' → 'Operation not authorized'
'Risorsa non trovata'       → 'Resource not found'
'Errore del server'         → 'Server error'
'Riprova più tardi'         → 'Try again later'

// Common UI Elements
'Salva'         → 'Save'
'Annulla'       → 'Cancel'
'Modifica'      → 'Edit'
'Elimina'       → 'Delete'
'Indietro'      → 'Back'
'Avanti'        → 'Next'
'Chiudi'        → 'Close'
'Caricamento...' → 'Loading...'
'Nessun dato'   → 'No data'
```

### Backend Error Messages

Backend errors are returned in **Italian**. Map them in the Flutter app:

```dart
// In data layer or error handling
String translateError(String backendError) {
  final errorMap = {
    'Permessi insufficienti': 'Insufficient permissions',
    'Email o password non validi': 'Invalid email or password',
    'Errore di connessione': 'Connection error',
    'Utente già registrato': 'User already exists',
  };
  
  return errorMap[backendError] ?? backendError;
}
```

Or keep backend errors in Italian and display as-is (recommended for consistency).

### Adding New Languages

To add a new language (e.g., Spanish):

1. Create `app_es.arb` in `lib/l10n/`
2. Copy structure from `app_it.arb`
3. Translate all values to Spanish
4. Update `main.dart`: `supportedLocales: const [Locale('it'), Locale('en'), Locale('es')]`
5. Add language switcher option
6. Run code generation

---

**Important:** Italian is the **default language**, but users can switch to English (or other added languages) via the settings screen. The app **MUST** support multiple languages with a language switcher component.

#### Validation Messages
```dart
'Email obbligatoria'           // Email required
'Email non valida'             // Invalid email
'Password minima 6 caratteri'  // Password min 6 chars
'Le password non corrispondono' // Passwords don't match
'Campo obbligatorio'           // Required field
'Numero non valido'            // Invalid number
```

#### Error Messages
```dart
'Errore di connessione'              // Network error
'Email o password non validi'        // Invalid credentials
'Utente già registrato'              // User already exists
'Permessi insufficienti'             // Insufficient permissions
'Operazione non autorizzata'         // Operation not authorized
'Risorsa non trovata'                // Resource not found
'Errore del server'                  // Server error
'Riprova più tardi'                  // Try again later
```

#### Common UI Elements
```dart
'Salva'         // Save
'Annulla'       // Cancel
'Modifica'      // Edit
'Elimina'       // Delete
'Indietro'      // Back
'Avanti'        // Next
'Chiudi'        // Close
'OK'            // OK (standard)
'Caricamento...' // Loading...
'Nessun dato'   // No data
```

---

**Note:** Since the app only supports Italian, all new UI text MUST be written in Italian from the start. Do not write in English and then translate.

---

## Testing Guidelines

### Widget Tests

```dart
testWidgets('Login shows error with invalid email', (tester) async {
  await tester.pumpWidget(
    ProviderScope(child: MaterialApp(home: LoginScreen())),
  );
  
  await tester.enterText(find.byKey(Keys.emailField), 'invalid-email');
  await tester.tap(find.byKey(Keys.loginButton));
  await tester.pump();
  
  expect(find.text('Email non valida'), findsOneWidget);
});
```

### Provider Tests

```dart
test('login use case validates email format', () async {
  final useCase = LoginUseCase(repository: MockAuthRepository());
  
  final result = await useCase.execute('invalid-email', 'password123');
  
  expect(result.isFailure, true);
  expect(result.failure, isA<AuthFailure>().having(
    (f) => f.type, 'type', AuthFailureType.invalidEmail,
  ));
});
```

---

## Common Scenarios

### Adding a New Screen

1. Create screen in `features/x/presentation/screens/x_screen.dart`
2. Create providers in `features/x/presentation/providers/x_providers.dart`
3. Add routes in navigation service
4. Write widget tests
5. Test with backend endpoint

### Adding a New API Endpoint

1. Add model in `calcetto_backend/.../lib/src/model.spy.yaml`
2. Create endpoint in `calcetto_backend/.../lib/src/model_endpoint.dart`
3. Run `serverpod generate`
4. Run `serverpod create-migration`
5. Restart server
6. Add Flutter data source method
7. Add repository method
8. Add use case
9. Add providers
10. Update UI

### Handling Authentication State

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final authState = ref.watch(authSessionProvider);
  
  return authState.when(
    data: (state) {
      if (state.isAuthenticated) {
        return MainLayout();
      } else {
        return LoginScreen();
      }
    },
    loading: () => CircularProgressIndicator(),
    error: (error, stack) => ErrorScreen(error: error),
  );
}
```

---

## Security Checklist

- ✅ JWT stored in `flutter_secure_storage` (encrypted)
- ✅ Passwords never logged or stored locally
- ✅ HTTPS required in production
- ✅ Input validation on both client and server
- ✅ Auth token validated on protected routes
- ✅ Logout clears all local data
- ✅ Biometric auth (if enabled) uses `local_auth` package

---

## Troubleshooting

### "Connection refused" to backend
```bash
# Check if Serverpod is running
curl http://localhost:8080/health

# If not running:
cd calcetto_backend/calcetto_backend_server
dart bin/main.dart
```

### State not updating
- Check if using `ref.watch` or `ref.read`
- Ensure provider is disposed properly
- Check if state is immutable (use `copyWith`)

### Generated code outdated
```bash
cd calcetto_backend/calcetto_backend_server
~/.pub-cache/bin/serverpod generate --force
```

---

**Last Updated:** March 10, 2026  
**Framework:** Flutter 3.19 + Riverpod 2.5 + Serverpod 2.9.2  
**Database:** PostgreSQL 16  
**Language:** Dart 3.6+
