# Phase 1: Foundation & Authentication - Context

**Gathered:** 2026-03-09
**Status:** Ready for planning

<domain>
## Phase Boundary

Users can securely access the app with persistent sessions and experience a polished, responsive UI foundation. This phase delivers: Flutter project setup with Material 3 theming, secure authentication with JWT storage, biometric login, bottom navigation structure, and polished loading/error states.

</domain>

<decisions>
## Implementation Decisions

### Authentication Flow
- Single-screen login with email and password fields visible together
- Eye icon toggle button for password visibility
- Biometric setup timing: Prompt after first successful login (Claude can adjust timing based on UX best practices)
- Session persistence: Indefinite (stay logged in until explicit logout)
- Password reset: Email link flow

### Theme & Appearance
- Default to system dark/light mode preference
- User can override theme in settings
- Material 3 design system throughout
- Dynamic accent colors (Material 3 color scheme, not fixed brand color)
- App bar styling: Claude decides based on Material 3 best practices

### Navigation Structure
- Bottom navigation bar with 4 items: Home, Clubs, Matches, Profile
- Standard Material screen transitions (fade/slide)
- Responsive layouts for various phone sizes
- Navigation state persists across app restarts

### Loading & Error States
- Loading indicators: Claude decides (circular spinner vs shimmer skeletons)
- Error display: Claude decides (snackbar vs inline vs full-screen)
- Retry behavior: Claude decides (auto-retry, manual, or pull-to-refresh)
- Clear error messages for authentication failures

### First Launch Experience
- Welcome screen displayed on first app launch
- Then proceed to login
- Onboarding/tutorial can be added in future phase

### Claude's Discretion
- Loading indicator style (circular spinner, shimmer skeletons, or linear)
- Error display approach (snackbar, inline, or full-screen)
- Retry behavior strategy
- App bar styling and color scheme details
- Splash screen implementation (if any)
- Exact biometric prompt timing and messaging
- Loading skeleton patterns for async operations

</decisions>

<specifics>
## Specific Ideas

- Follow Material 3 guidelines closely — user wants native Material feel
- Bottom navigation should be thumb-friendly on mobile devices
- Theme should feel "football/soccer" appropriate but not cheesy
- Authentication needs to feel secure and trustworthy
- App should launch fast (<3 seconds) — prioritize perceived performance

</specifics>

<deferred>
## Deferred Ideas

- Onboarding/tutorial screens (Phase 6+)
- Advanced theme customization (custom colors)
- Login animations beyond Material standard
- Alternative navigation patterns (drawer, tabs)

</deferred>

---

*Phase: 01-foundation-auth*
*Context gathered: 2026-03-09*
