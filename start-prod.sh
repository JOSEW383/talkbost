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
        echo ""
        read -p "Press Enter after you've edited .env with secure values..."
    else
        echo "❌ Error: .env.production template not found!"
        exit 1
    fi
fi

# Set environment for production
export BUILD_TARGET=production

# Warning about production mode
echo "⚠️  WARNING: Running in PRODUCTION mode"
echo "Make sure you have:"
echo "  - Changed the SECRET_KEY in .env"
echo "  - Changed the DB_PASSWORD in .env"
echo "  - Configured proper SSL/TLS certificates (if needed)"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

# Stop any running containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start containers in production mode
echo "🏗️  Building production containers..."
docker-compose build --no-cache

echo "🚀 Starting containers in detached mode..."
docker-compose up -d

echo ""
echo "✅ TalkBost is running in production mode!"
echo ""
echo "📱 Frontend (Students): http://localhost:4321"
echo "⚙️  Admin Panel: http://localhost:4322"
echo "🔧 Backend API: http://localhost:8000"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop: docker-compose down"
