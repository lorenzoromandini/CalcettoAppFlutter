#!/bin/bash

# =============================================================================
# Calcetto App Flutter - Complete Startup Script
# =============================================================================
# This script starts ALL required services for the Calcetto App:
#   1. PostgreSQL Database (Docker container)
#   2. pgAdmin (Database management UI)
#   3. Serverpod Backend (Dart API server)
#   4. Flutter Web App (Chrome browser)
#
# Usage: ./start.sh
# Requirements: Docker, Flutter, Dart
# =============================================================================

set -e

echo "🚀 Starting Calcetto App Flutter - Complete Environment"
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project directories
PROJECT_DIR="/home/lromandini/projects/calcetto-app-flutter"
BACKEND_DIR="$PROJECT_DIR/calcetto_backend/calcetto_backend_server"

cd "$PROJECT_DIR"

# =============================================================================
# Helper Functions
# =============================================================================

# Check if a port is listening
check_port() {
    local port=$1
    local name=$2
    if ss -tlnp 2>/dev/null | grep -q ":$port "; then
        return 0
    else
        return 1
    fi
}

# Wait for a service to be ready
wait_for_service() {
    local port=$1
    local name=$2
    local max_attempts=60
    local attempt=1
    
    echo -n "⏳ Waiting for $name on port $port..."
    while [ $attempt -le $max_attempts ]; do
        if check_port $port "$name" >/dev/null 2>&1; then
            echo -e "\n${GREEN}✓${NC} $name is ready!"
            return 0
        fi
        echo -n "."
        sleep 1
        attempt=$((attempt + 1))
    done
    echo -e "\n${RED}✗${NC} $name failed to start after ${max_attempts}s"
    return 1
}

# Check if Docker container is running
check_container() {
    local container_name=$1
    docker ps --format "{{.Names}}" | grep -q "^${container_name}$"
}

# =============================================================================
# Step 1: PostgreSQL Database
# =============================================================================

echo -e "${BLUE}📦 Step 1/4: PostgreSQL Database${NC}"
if check_container "calcetto-postgres"; then
    echo -e "${GREEN}✓${NC} PostgreSQL container already running"
else
    echo "   Starting PostgreSQL container..."
    if docker ps -a | grep -q "calcetto-postgres"; then
        docker start calcetto-postgres
    else
        docker run -d \
            --name calcetto-postgres \
            -e POSTGRES_USER=calcetto \
            -e POSTGRES_PASSWORD=calcetto \
            -e POSTGRES_DB=calcetto \
            -p 5432:5432 \
            postgres:16-alpine
    fi
    wait_for_service 5432 "PostgreSQL"
fi
echo ""

# =============================================================================
# Step 2: pgAdmin (Database Management UI)
# =============================================================================

echo -e "${BLUE}🗄️  Step 2/4: pgAdmin Database UI${NC}"
if check_container "calcetto-pgadmin"; then
    echo -e "${GREEN}✓${NC} pgAdmin container already running"
else
    echo "   Starting pgAdmin container..."
    if docker ps -a | grep -q "calcetto-pgadmin"; then
        docker start calcetto-pgadmin
    else
        docker run -d \
            --name calcetto-pgadmin \
            --network calcettoapp_default \
            -e PGADMIN_DEFAULT_EMAIL=admin@admin.com \
            -e PGADMIN_DEFAULT_PASSWORD=admin \
            -p 5050:80 \
            dpage/pgadmin4:latest
    fi
    wait_for_service 5050 "pgAdmin"
fi

# Ensure PostgreSQL is on the same network as pgAdmin
if ! docker network inspect calcettoapp_default 2>/dev/null | grep -q "calcetto-postgres"; then
    echo "   Connecting PostgreSQL to pgAdmin network..."
    docker network connect calcettoapp_default calcetto-postgres 2>/dev/null || true
fi
echo ""

# =============================================================================
# Step 3: Serverpod Backend
# =============================================================================

echo -e "${BLUE}⚙️  Step 3/4: Serverpod Backend${NC}"
if check_port 8080 "Serverpod"; then
    echo -e "${GREEN}✓${NC} Serverpod already running on port 8080"
else
    echo "   Starting Serverpod backend..."
    # Kill any existing Serverpod processes
    pkill -f "dart bin/main.dart" 2>/dev/null || true
    sleep 2
    
    cd "$BACKEND_DIR"
    nohup dart bin/main.dart > /tmp/serverpod.log 2>&1 &
    wait_for_service 8080 "Serverpod"
fi
echo ""

# =============================================================================
# Step 4: Flutter Web App
# =============================================================================

echo -e "${BLUE}🎨 Step 4/4: Flutter Web App${NC}"

# Check if Flutter is already running
FLUTTER_RUNNING=false
if pgrep -f "flutter.*run" > /dev/null; then
    FLUTTER_RUNNING=true
    echo -e "${YELLOW}⚠${NC} Flutter already running"
fi

if [ "$FLUTTER_RUNNING" = false ]; then
    echo "   Starting Flutter web app..."
    cd "$PROJECT_DIR"
    # Start Flutter in background, it will auto-open Chrome
    flutter run -d chrome > /tmp/flutter.log 2>&1 &
    
    # Wait for Flutter dev server to start
    echo -n "⏳ Waiting for Flutter dev server..."
    FLUTTER_PORT=""
    for i in {1..60}; do
        # Find the Flutter dev server port
        FLUTTER_PORT=$(ss -tlnp 2>/dev/null | grep -E "flutter|dart" | grep -oP ':\K[0-9]+' | head -1)
        if [ -n "$FLUTTER_PORT" ]; then
            echo -e "\n${GREEN}✓${NC} Flutter running on port $FLUTTER_PORT"
            break
        fi
        echo -n "."
        sleep 1
    done
    
    if [ -z "$FLUTTER_PORT" ]; then
        echo -e "\n${YELLOW}⚠${NC} Flutter port detection failed, but app may still be starting..."
    fi
fi
echo ""

# =============================================================================
# Summary
# =============================================================================

echo "════════════════════════════════════════════════════════════════"
echo -e "${GREEN}🎉 All services are running!${NC}"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo -e "${BLUE}📱 Application URLs:${NC}"
echo "   Flutter Web App:   http://localhost:8080 (or check Chrome)"
echo "   Serverpod API:     http://localhost:8080"
echo "   pgAdmin UI:        http://localhost:5050"
echo ""
echo -e "${BLUE}💾 Database:${NC}"
echo "   PostgreSQL:        localhost:5432"
echo "   Database:          calcetto"
echo "   User:              calcetto / calcetto"
echo ""
echo -e "${BLUE}🔐 pgAdmin Login:${NC}"
echo "   Email:             admin@admin.com"
echo "   Password:          admin"
echo "   Server Host:       calcetto-postgres (container name)"
echo ""
echo -e "${BLUE}📋 Useful Commands:${NC}"
echo "   View Serverpod logs:   tail -f /tmp/serverpod.log"
echo "   View Flutter logs:     tail -f /tmp/flutter.log"
echo "   Stop all services:     ./stop.sh"
echo "   Check ports:           ss -tlnp | grep -E '8080|5050|5432'"
echo ""
echo -e "${BLUE}🧪 Test API:${NC}"
echo "   curl -X POST http://localhost:8080/auth/login \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"email\":\"test@example.com\",\"password\":\"password123\"}'"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo "Press Ctrl+C to stop viewing logs (services keep running)"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Show combined logs
tail -f /tmp/serverpod.log /tmp/flutter.log 2>/dev/null || true