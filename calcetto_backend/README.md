# Calcetto Backend - Serverpod

Independent PostgreSQL backend for the Calcetto Flutter app, built with **Serverpod** (Dart framework).

## What's This?

This is a **standalone backend** you can use instead of the Next.js backend in `CalcettoApp`. It provides:

✅ **PostgreSQL database** (same as CalcettoApp)  
✅ **JWT authentication** (login/signup endpoints)  
✅ **Dart language** (same as your Flutter app)  
✅ **Type-safe API** (auto-generated client code)  
✅ **Production-ready** (Serverpod framework by Google)

## Quick Start

### 1. Start PostgreSQL
```bash
# Uses existing Postgres container from CalcettoApp
docker ps | grep calcetto-postgres
# If not running:
docker start calcetto-postgres
```

### 2. Start Serverpod Server
```bash
cd /home/lromandini/projects/calcetto_backend/calcetto_backend_server
dart bin/main.dart
```

**Server runs on:** http://localhost:8080

### 3. Test Authentication
```bash
# Create test user
curl -X POST http://localhost:8080/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123","firstName":"Test","lastName":"User"}'

# Login
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

### 4. Connect Flutter App
Your Flutter app is already configured to use this backend:
- **API URL:** `http://localhost:8080`
- **Location:** `lib/core/constants/app_constants.dart`

Run your Flutter app:
```bash
cd /home/lromandini/projects/calcetto-app-flutter
flutter run -d chrome
```

## Architecture

### Database Schema
```sql
CREATE TABLE "user_info" (
  "id" bigserial PRIMARY KEY,
  "email" text NOT NULL,
  "firstName" text NOT NULL,
  "lastName" text NOT NULL,
  "nickname" text,
  "imageUrl" text,
  "passwordHash" text NOT NULL,
  "passwordSalt" text NOT NULL,
  "createdAt" timestamp NOT NULL,
  "updatedAt" timestamp NOT NULL,
  "lastLogin" timestamp,
  "deletedAt" timestamp
);
```

### API Endpoints
- `POST /auth/login` - Authenticate user (email + password)
- `POST /auth/signup` - Register new user

### Response Format
```json
{
  "success": true,
  "token": "jwt_token_here",
  "user": {
    "id": 1,
    "email": "test@example.com",
    "firstName": "Test",
    "lastName": "User",
    "createdAt": "2026-03-10T16:36:09Z"
  }
}
```

## Project Structure
```
calcetto_backend/
├── calcetto_backend_server/    # Server code
│   ├── lib/src/
│   │   ├── auth_endpoint.dart  # Login/signup logic
│   │   ├── user.spy.yaml       # User database model
│   │   └── generated/          # Auto-generated code
│   ├── migrations/             # Database migrations
│   └── config/                 # Database config
├── calcetto_backend_client/    # Dart client (for Flutter)
└── calcetto_backend_flutter/   # Sample Flutter app
```

## Comparison with CalcettoApp

| Feature | Serverpod Backend | Next.js Backend |
|---------|------------------|-----------------|
| Language | Dart | TypeScript/JavaScript |
| Framework | Serverpod | Next.js + Express |
| ORM | Serverpod ORM | Prisma |
| Auth | Custom JWT | NextAuth |
| Setup | `dart bin/main.dart` | `npm run dev` |
| Port | 8080 | 3000 |
| Same DB | ✅ Yes (PostgreSQL) | ✅ Yes |

## Development Commands

```bash
# Generate code from models
~/.pub-cache/bin/serverpod generate

# Create database migration
~/.pub-cache/bin/serverpod create-migration

# Start server with migrations
dart bin/main.dart --apply-migrations

# View logs
tail -f /tmp/serverpod.log
```

## Next Steps

To add more features (clubs, matches, etc.):

1. **Add models** in `lib/src/*.spy.yaml`
2. **Create endpoints** in `lib/src/*_endpoint.dart`
3. **Generate code:** `serverpod generate`
4. **Create migration:** `serverpod create-migration`
5. **Restart server:** `dart bin/main.dart`

## Production Deployment

Serverpod supports deployment to:
- Google Cloud Run
- AWS ECS
- DigitalOcean
- Any Docker host

See: https://docs.serverpod.dev/

---

**Created:** March 10, 2026  
**Framework:** Serverpod 2.9.2  
**Database:** PostgreSQL 16
