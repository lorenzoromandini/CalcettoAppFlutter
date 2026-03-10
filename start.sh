#!/bin/bash

# Calcetto App Flutter - Start all services script
# Usage: ./start.sh

set -e

echo "🚀 Starting Calcetto App Flutter services..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

PROJECT_DIR="/home/lromandini/projects/calcetto-app-flutter"
BACKEND_DIR="$PROJECT_DIR/calcetto_backend/calcetto_backend_server"
cd "$PROJECT_DIR"

# Function to check if a port is listening
check_port() {
    local port=$1
    local name=$2
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $name is running on port $port"
        return 0
    else
        return 1
    fi
}

# Function to wait for a service
wait_for_service() {
    local port=$1
    local name=$2
    local max_attempts=30
    local attempt=1
    
    echo -n "⏳ Waiting for $name..."
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

echo "📦 Step 1/3: Starting PostgreSQL Docker container..."
if docker ps | grep -q "calcetto-postgres"; then
    echo -e "${GREEN}✓${NC} PostgreSQL container already running"
else
    if docker ps -a | grep -q "calcetto-postgres"; then
        echo "   Starting existing container..."
        docker start calcetto-postgres
    else
        echo "   Creating new PostgreSQL container..."
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

echo "⚙️  Step 2/3: Starting Serverpod backend..."
if check_port 8080 "Serverpod"; then
    echo -e "${YELLOW}⚠${NC} Serverpod already running on port 8080"
else
    # Kill any existing Serverpod processes
    pkill -f "dart bin/main.dart" 2>/dev/null || true
    sleep 2
    
    # Start Serverpod backend
    cd "$BACKEND_DIR"
    nohup dart bin/main.dart > /tmp/serverpod.log 2>&1 &
    wait_for_service 8080 "Serverpod"
fi
echo ""

echo "🎨 Step 3/3: Starting Flutter web app..."
if check_port 8080 "Flutter" || lsof -Pi :$(seq 9000 9999 | shuf | head -1) -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠${NC} Flutter web may already running"
else
    cd "$PROJECT_DIR"
    echo "   Starting Flutter web in debug mode..."
    # Flutter will auto-open in Chrome
    flutter run -d chrome --no-sound-null-safety > /tmp/flutter.log 2>&1 &
    echo -e "${GREEN}✓${NC} Flutter web starting (check Chrome window)"
fi
echo ""

echo "═══════════════════════════════════════════════════"
echo -e "${GREEN}🎉 All services are running!${NC}"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📱 Flutter App:     http://localhost:8080 (or auto-opened in Chrome)"
echo "⚙️  Serverpod API:  http://localhost:8080"
echo "💾 PostgreSQL:     localhost:5432"
echo ""
echo "📋 Useful commands:"
echo "   View Serverpod logs:  tail -f /tmp/serverpod.log"
echo "   View Flutter logs:   tail -f /tmp/flutter.log"
echo "   Stop all services:   ./stop.sh"
echo "   Check running ports: lsof -i :5432 -i :8080"
echo ""
echo "🧪 Test API endpoints:"
echo "   curl -X POST http://localhost:8080/auth/signup \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"email\":\"test@example.com\",\"password\":\"password123\",\"firstName\":\"Test\"}'"
echo ""
echo "   curl -X POST http://localhost:8080/auth/login \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"email\":\"test@example.com\",\"password\":\"password123\"}'"
echo ""
echo "Press Ctrl+C to stop viewing logs (services keep running)"
echo ""

# Show combined logs
tail -f /tmp/serverpod.log /tmp/flutter.log 2>/dev/null || true
