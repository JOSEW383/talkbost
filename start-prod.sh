#!/bin/bash

# TalkBost - Production Environment Startup Script

echo "🚀 Starting TalkBost in PRODUCTION mode..."
echo ""

# Check if .env exists, if not create from production template
if [ ! -f ".env" ]; then
    echo "⚠️  No .env file found."
    if [ -f ".env.production" ]; then
        echo "📋 Creating .env from .env.production template..."
        cp .env.production .env
        echo ""
        echo "⚠️  IMPORTANT: Edit .env and change these values:"
        echo "   - DB_PASSWORD"
        echo "   - SECRET_KEY"
        echo "   - ENVIRONMENT (set to 'production')"
        echo ""
        read -p "Press Enter after you've edited .env with secure values..."
    else
        echo "❌ Error: .env.production template not found!"
        exit 1
    fi
fi

# Load environment variables from .env
export $(grep -v '^#' .env | xargs)

# Set BUILD_TARGET and ENVIRONMENT for production
export BUILD_TARGET=production
export ENVIRONMENT=production

echo "🔧 Mode: PRODUCTION"
echo "   BUILD_TARGET=${BUILD_TARGET}"
echo "   ENVIRONMENT=${ENVIRONMENT}"
echo ""

# Stop any running containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start containers in production mode
echo "🏗️  Building production containers..."
docker-compose build --no-cache

echo "🚀 Starting containers in detached mode..."
docker-compose up -d

# Wait a moment for containers to start
sleep 3

# Check if all containers are running
echo ""
echo "🔍 Checking container status..."

failed_containers=()

if ! docker ps --filter "name=talkbost_db" --filter "status=running" | grep -q talkbost_db; then
    failed_containers+=("Database")
fi

if ! docker ps --filter "name=talkbost_backend" --filter "status=running" | grep -q talkbost_backend; then
    failed_containers+=("Backend")
fi

if ! docker ps --filter "name=talkbost_frontend" --filter "status=running" | grep -q talkbost_frontend; then
    failed_containers+=("Frontend")
fi

if ! docker ps --filter "name=talkbost_admin" --filter "status=running" | grep -q talkbost_admin; then
    failed_containers+=("Admin Panel")
fi

# Load actual port values from .env
FRONTEND_PORT=${FRONTEND_PORT:-4321}
ADMIN_PORT=${ADMIN_PORT:-4322}
BACKEND_PORT=${BACKEND_PORT:-8000}

if [ ${#failed_containers[@]} -eq 0 ]; then
    echo "✅ TalkBost is running in production mode!"
    echo ""
    echo "📱 Frontend (Students): http://localhost:${FRONTEND_PORT}"
    echo "⚙️  Admin Panel: http://localhost:${ADMIN_PORT}"
    echo "🔧 Backend API: http://localhost:${BACKEND_PORT}"
    echo ""
    echo "To view logs: docker-compose logs -f"
    echo "To stop: docker-compose down"
else
    echo "❌ Some containers failed to start:"
    for container in "${failed_containers[@]}"; do
        echo "   - $container"
    done
    echo ""
    echo "To view logs: docker-compose logs -f"
    echo "To check status: docker-compose ps"
    echo "To rebuild: docker-compose down && ./start-prod.sh"
    exit 1
fi
