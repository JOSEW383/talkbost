#!/bin/bash

# TalkBost - Development Environment Startup Script

echo "🚀 Starting TalkBost in DEVELOPMENT mode..."
echo ""

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "⚠️  No .env file found. Creating from template..."
    if [ -f ".env.development" ]; then
        cp .env.development .env
        echo "✅ Created .env from .env.development"
    else
        echo "❌ Error: .env.development template not found!"
        exit 1
    fi
else
    echo "✅ Using existing .env file"
fi

echo ""

# Load environment variables from .env
export $(grep -v '^#' .env | xargs)

# Set BUILD_TARGET and ENVIRONMENT for development
export BUILD_TARGET=development
export ENVIRONMENT=development

echo "🔧 Mode: DEVELOPMENT"
echo "   BUILD_TARGET=${BUILD_TARGET}"
echo "   ENVIRONMENT=${ENVIRONMENT}"
echo ""

# Stop any running containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start containers
echo "🏗️  Building and starting containers..."
docker-compose up --build &

# Store the PID of docker-compose
COMPOSE_PID=$!

# Wait for docker-compose to fail or start successfully
sleep 10

# Load actual port values from .env
FRONTEND_PORT=${FRONTEND_PORT:-4321}
ADMIN_PORT=${ADMIN_PORT:-4322}
BACKEND_PORT=${BACKEND_PORT:-8000}

# Check if docker-compose is still running
if kill -0 $COMPOSE_PID 2>/dev/null; then
    echo ""
    echo "✅ TalkBost is running in development mode!"
    echo ""
    echo "📱 Frontend (Students): http://localhost:${FRONTEND_PORT}"
    echo "⚙️  Admin Panel: http://localhost:${ADMIN_PORT}"
    echo "🔧 Backend API: http://localhost:${BACKEND_PORT}"
    echo "📖 API Docs: http://localhost:${BACKEND_PORT}/docs"
    echo ""
    echo "Press Ctrl+C to stop all services"
    
    # Wait for docker-compose to finish (or Ctrl+C)
    wait $COMPOSE_PID
else
    echo ""
    echo "❌ Failed to start TalkBost"
    echo "Check the logs above for errors"
    exit 1
fi
