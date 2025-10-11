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

# Set environment for development
export BUILD_TARGET=development

# Stop any running containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start containers
echo "🏗️  Building and starting containers..."
docker-compose up --build

echo ""
echo "✅ TalkBost is running!"
echo ""
echo "📱 Frontend (Students): http://localhost:4321"
echo "⚙️  Admin Panel: http://localhost:4322"
echo "🔧 Backend API: http://localhost:8000"
echo "📖 API Docs: http://localhost:8000/docs"
echo ""
echo "Press Ctrl+C to stop all services"
