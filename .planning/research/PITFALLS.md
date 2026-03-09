# Research: Flutter Pitfalls

**Domain:** Flutter + Next.js API integration pitfalls  
**Date:** 2025-03-09  
**Milestone:** Greenfield

---

## Critical Pitfalls

### 1. Authentication Token Management

**The Mistake:** Storing JWT in SharedPreferences (not encrypted) or not handling token refresh.

**Warning Signs:**
- Security audit flags
- Users randomly logged out
- 401 errors appearing in logs

**Prevention:**
- Use `flutter_secure_storage` for tokens
- Implement interceptor to auto-refresh tokens
- Handle 401 gracefully with re-login flow

**Phase to Address:** Phase 1 (Auth)

**Example:**
```dart
// WRONG:
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('token', jwt);  // Not encrypted!

// RIGHT:
FlutterSecureStorage storage = const FlutterSecureStorage();
await storage.write(key: 'jwt', value: token);  // Encrypted
```

---

### 2. API Response Parsing Without Null Safety

**The Mistake:** Assuming all API fields exist, causing runtime crashes.

**Warning Signs:**
- `NoSuchMethodError` in production
- Crashes on certain user data
- "Works on my machine" issues

**Prevention:**
- Use code generation (json_serializable, freezed)
- Make all fields nullable with defaults
- Validate API responses before use

**Phase to Address:** Phase 1 (Models)

**Example:**
```dart
// WRONG:
class User {
  final String name;  // Crashes if null
  User.fromJson(Map json) : name = json['name'];
}

// RIGHT:
@JsonSerializable()
class User {
  @JsonKey(defaultValue: '')
  final String name;
  
  factory User.fromJson(Map<String, dynamic> json) => 
    _$UserFromJson(json);
}
```

---

### 3. UI Blocking on Network Calls

**The Mistake:** Making API calls in build methods or button handlers without async.

**Warning Signs:**
- UI freezing during loads
- "Application Not Responding" (ANR)
- Janky animations

**Prevention:**
- Always use Riverpod AsyncValue
- Show loading states
- Use FutureBuilder/StreamBuilder properly

**Phase to Address:** All phases

**Example:**
```dart
// WRONG:
ElevatedButton(
  onPressed: () {
    final result = api.fetchData();  // Blocks UI!
    setState(() => data = result);
  },
);

// RIGHT:
ElevatedButton(
  onPressed: () async {
    setState(() => isLoading = true);
    try {
      final result = await api.fetchData();
      setState(() => data = result);
    } finally {
      setState(() => isLoading = false);
    }
  },
);
```

---

### 4. Memory Leaks from Streams

**The Mistake:** Not disposing stream subscriptions or providers.

**Warning Signs:**
- App slows down over time
- Memory warnings in logs
- Crashes after extended use

**Prevention:**
- Use Riverpod's autoDispose modifier
- Cancel subscriptions in dispose()
- Use `keepAlive: false` for providers

**Phase to Address:** Phase 2+ (All providers)

**Example:**
```dart
// WRONG:
@riverpod
Stream<List<Club>> clubs(ClubsRef ref) {
  return clubRepository.watchAll();  // Never disposed!
}

// RIGHT:
@riverpod
Stream<List<Club>> clubs(ClubsRef ref) {
  final stream = clubRepository.watchAll();
  ref.onDispose(stream.cancel);  // Cleanup
  return stream;
}
```

---

### 5. Offline-First Done Wrong

**The Mistake:** Caching without cache invalidation or showing stale data.

**Warning Signs:**
- Users see old data
- "I updated it but it's not showing"
- Conflicting data between devices

**Prevention:**
- Implement TTL on cached data
- Show last-updated timestamps
- Manual refresh button
- Cache invalidation on mutations

**Phase to Address:** Phase 2+ (Cache layer)

---

### 6. FIFA Card Performance Issues

**The Mistake:** Using too many complex animations or rebuilding cards unnecessarily.

**Warning Signs:**
- Laggy card scrolling
- Frame drops below 60fps
- Slow card generation

**Prevention:**
- Use `RepaintBoundary` around cards
- Cache card images with `RepaintBoundary`
- Limit concurrent animations
- Use `const` constructors where possible

**Phase to Address:** Phase 4 (FIFA cards)

**Example:**
```dart
// WRONG:
ListView.builder(
  itemBuilder: (context, index) => FifaCard(
    player: players[index],  // Rebuilds on every scroll
  ),
);

// RIGHT:
ListView.builder(
  itemBuilder: (context, index) => RepaintBoundary(
    child: FifaCard(
      player: players[index],
    ),
  ),
  addRepaintBoundaries: true,
);
```

---

### 7. Platform-Specific Code Not Abstracted

**The Mistake:** Sprinkling `Platform.isIOS` checks throughout UI code.

**Warning Signs:**
- Hard to test on single platform
- UI inconsistencies
- Code duplication

**Prevention:**
- Create platform abstraction layer
- Use platform widgets (Cupertino vs Material)
- Test on both platforms

**Phase to Address:** Phase 1 (Core setup)

---

### 8. Next.js API Compatibility Assumptions

**The Mistake:** Assuming web API works identically for mobile without testing.

**Warning Signs:**
- CORS errors in web build
- Authentication not working on mobile
- Different response formats

**Prevention:**
- Test API with mobile headers
- Handle CORS properly in Next.js
- Mobile-specific endpoints if needed

**Phase to Address:** Phase 1 (API client)

**Example Next.js CORS fix:**
```typescript
// next.config.js
headers: async () => [
  {
    source: '/api/:path*',
    headers: [
      { key: 'Access-Control-Allow-Origin', value: '*' },
      { key: 'Access-Control-Allow-Headers', value: 'Authorization, Content-Type' },
    ],
  },
];
```

---

### 9. Push Notification Permissions Not Handled

**The Mistake:** Assuming notifications work without requesting permissions.

**Warning Signs:**
- Notifications never arrive
- iOS app rejected for missing permission flow
- Users confused why notifications don't work

**Prevention:**
- Request permissions on first relevant action
- Handle "Don't Allow" gracefully
- Clear settings to re-request

**Phase to Address:** Phase 5 (Notifications)

---

### 10. Web Build Rendering Issues

**The Mistake:** Using CanvasKit-dependent features without fallback for HTML renderer.

**Warning Signs:**
- FIFA cards don't render on HTML renderer
- Platform-specific crashes
- Shader compilation errors

**Prevention:**
- Use `--web-renderer canvaskit` for builds
- Test on both renderers
- Document web limitations

**Phase to Address:** Phase 1 (Build config)

---

## Medium Risk Pitfalls

### 11. Image Caching
- **Mistake:** Loading club/player images from URL without caching
- **Fix:** Use `cached_network_image` package
- **Phase:** All phases with images

### 12. Form Validation Timing
- **Mistake:** Validating on every keystroke (laggy)
- **Fix:** Debounce validation, validate on blur
- **Phase:** Phase 1 (Forms)

### 13. Deep Linking Not Configured
- **Mistake:** No way to open specific screens from notifications
- **Fix:** Configure deep links (uni_links package)
- **Phase:** Phase 1 (Routing)

### 14. Date/Time Localization
- **Mistake:** Showing UTC dates without conversion
- **Fix:** Use `intl` package, convert to local timezone
- **Phase:** Phase 2 (Match dates)

### 15. Accessibility Not Considered
- **Mistake:** Missing semantic labels, poor contrast
- **Fix:** Add semantic wrappers, test with screen reader
- **Phase:** All phases

---

## Early Warning System

Watch for these signs in each phase:

| Phase | Red Flags |
|-------|-----------|
| 1 | Auth not persisting, API calls failing |
| 2 | Clubs not loading, infinite spinners |
| 3 | RSVP not reflecting, match list stale |
| 4 | Card animations lag, leaderboards slow |
| 5 | Notifications not arriving, live updates delayed |

---

## Recovery Strategies

If you hit a pitfall:

1. **Don't workaround** — Fix the root cause
2. **Add tests** — Prevent regression
3. **Document** — Add to this file
4. **Review** — Check other code for same issue

---

*Research complete: 2025-03-09*