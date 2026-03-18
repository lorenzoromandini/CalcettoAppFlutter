<p align="center">
  <img src="assets/logo.png" alt="Calcetto App Flutter Logo" width="128" height="128">
</p>

<h1 align="center">Calcetto App Flutter</h1>

<p align="center">
  A mobile application for organizing football matches with friends.
</p>

---

## 🎯 Overview

Calcetto App Flutter is a mobile application for managing casual football (calcetto) matches among friends and club members.

---

## ✨ Features

- **Authentication** - Email/password login with JWT
- **Club Management** - Create and manage football clubs
- **Club Roles** - Owner, Manager, Member privileges
- **Profile Editing** - Edit profile and change password
- **Match Scheduling** - Schedule and manage matches
- **Player Statistics** - Track player performance
- **Offline Support** - Local caching with Hive
- **Club Recovery** - Soft delete with 30-day recovery period
- **Invitation System** - Generate shareable invite links (7-day expiration, reusable)
- **WhatsApp Integration** - Direct sharing to WhatsApp
- **Member Profiles** - View detailed member information with stats

---

## 🚀 Tech Stack

- **Flutter 3.19+** - Cross-platform framework
- **Dart 3.6+** - Programming language
- **Riverpod 2.5** - State management
- **Serverpod 2.9** - Dart backend framework
- **PostgreSQL 16** - Database

---

## 📁 Project Structure

```
lib/
  features/
    auth/          # Authentication (login, signup)
    home/          # Home screen and navigation
    clubs/         # Club management
    profile/       # Profile editing
    matches/       # Match scheduling

calcetto_backend/
  calcetto_backend_server/  # Serverpod backend
```

---

## 🧪 Testing Checklist

### ✅ Authentication (Implemented & Tested)

**Login Screen**
- ✅ Enter invalid email format → Shows validation error
- ✅ Enter wrong password → Shows "Invalid credentials" error
- ✅ Submit empty form → Shows validation errors
- ✅ Valid credentials → Navigates to Home
- ✅ Toggle password visibility → Eye icon works
- ✅ Theme toggle in drawer → Dark/light mode switches
- ✅ Drawer menu → Opens/closes correctly

**Signup Screen**
- ✅ All required fields marked with *
- ✅ Email format validation → Invalid email rejected
- ✅ Password min 6 characters → Error if shorter
- ✅ Password confirmation → Error if doesn't match
- ✅ Nickname field → Optional (can be empty)
- ✅ Valid signup → Shows success, navigates to login

**Session Management**
- ✅ Login → Close browser → Reopen → Still logged in
- ✅ Logout → Clears session → Shows login screen
- ⏳ Token expiration → Auto-redirects to login (Phase 3)

### ✅ Profile Management (Implemented & Tested)

**Profile Screen**
- ✅ View profile → Shows email, name, avatar
- ✅ Click "Edit Profile" → Opens edit screen

**Edit Profile**
- ✅ Email field → Read-only (not editable)
- ✅ Edit first name → Saves correctly
- ✅ Edit last name → Saves correctly
- ✅ Add nickname → Saves and displays
- ✅ Change nickname → Updates immediately
- ✅ Change password → Min 6 chars required
- ✅ Password confirmation → Must match
- ✅ Save with mismatched passwords → Shows error
- ✅ Save with valid data → Shows success message
- ✅ Reopen profile → Changes persist
- ✅ Pull-to-refresh → Updates data from server

### ✅ Club Management (Implemented & Tested)

**Clubs List**
- ✅ Navigate to Clubs tab → Shows clubs list
- ✅ No clubs → Shows "No clubs" message
- ✅ Tap club → Opens Club Detail screen

**Club Detail (Active Club)**
- ✅ Club tab opens → Shows active club details
- ✅ View club info → Name, description, logo
- ✅ View members → Shows member list with roles
- ✅ Pull-to-refresh → Updates club data

**Club Switching**
- ✅ Home screen → Tap active club header
- ✅ Dropdown opens → Shows available clubs
- ✅ Select different club → Updates active club
- ✅ Club tab updates → Shows new active club
- ✅ Home screen updates → Shows new club context

**Club Roles**
- ✅ Owner privileges → Can delete club, manage members
- ✅ Owner only → Can edit club info
- ⏳ Manager privileges → Can create matches, manage formations (Phase 3)
- ⏳ Member privileges → Can join matches, view only (Phase 3)

**Club Deletion & Recovery**
- ✅ Delete club (Owner) → Soft delete, hidden from all members
- ✅ Delete affects all members → Everyone loses access
- ✅ Recover club → Restores for all members with data intact
- ✅ Recovery period → 30 days to recover
- ✅ Recovery UI → Access from Profile → "Club Eliminati"

**Invitation System**
- ✅ Generate invite link → Creates reusable link
- ✅ Link expiration → 7 days from generation
- ✅ Share via WhatsApp → Opens WhatsApp with pre-filled message
- ✅ Copy link → Clipboard integration
- ✅ Join via link → New members can join club

**Member Management**
- ✅ View members → FIFA-style cards in grid
- ✅ Tap member card → Opens detailed member profile
- ✅ Member profile → Shows stats, join date, privilege

**Club Header**
- ✅ Share button (left) → Generate invite codes
- ✅ Edit button (right, Owner only) → Edit club details
- ✅ No delete button in header → Moved to edit screen

### ✅ General UI (Implemented & Tested)

**Navigation**
- ✅ Bottom navigation → Switches between tabs
- ✅ Home → Shows club context
- ✅ Clubs → Shows active club detail
- ⏳ Matches → Placeholder (Phase 3)
- ✅ Profile → Shows user info

**Pull-to-Refresh**
- ✅ Home screen → Swipe down → Refreshes data
- ✅ Club Detail → Swipe down → Refreshes data
- ✅ Profile → Swipe down → Refreshes user data

**Offline Support**
- ✅ Offline mode → Shows offline indicator
- ✅ Cached data → Displays when offline
- ✅ Network returns → Auto-hides indicator

### 🧪 Testing Without Backend

If backend is not running:
- ✅ Login/signup → Shows "Network error"
- ✅ UI validation → Still works (email format, password length)
- ✅ Navigation → Works between screens
- ✅ Forms → Show validation errors correctly

---

## 📱 Current Status

- ✅ Phase 1: Authentication - Complete
- ✅ Phase 2: Clubs & Profile - Complete
- ⏳ Phase 3: Matches & Statistics - In Progress
