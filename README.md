# TalkBost - English Course Management Application

A complete web application for managing English courses with a student frontend, admin panel, and backend API.

## 📱 Features

### Frontend (Students)
- ✅ User registration and authentication
- ✅ Dashboard with course progress
- ✅ Class view organized by days
- ✅ Activities with completion checks
- ✅ Personal and public annotations
- ✅ Progress system with statistics
- ✅ Responsive and minimalist design

### Admin Panel
- ✅ Administrator authentication
- ✅ Course management (create, edit, delete)
- ✅ Lesson and activity management
- ✅ View progress of all students
- ✅ View annotations (public and private)
- ✅ Dashboard with statistics

### Backend API
- ✅ JWT Authentication
- ✅ Complete RESTful endpoints
- ✅ PostgreSQL as database
- ✅ User, course, lesson, progress, and annotation management
- ✅ Automatic documentation (Swagger/OpenAPI)

## 📚 Class Structure

Each class includes:

1. **🎯 Daily Objectives**: Description of what will be practiced
2. **💬 Warm-up**: Oral introduction and vocabulary activation
3. **🗣️ Speaking Focus**: Role-plays and main practice
4. **🧠 Vocabulary & Grammar**: Useful words and expressions
5. **🎨 Visual Speaking**: Image description
6. **✅ Check Your Progress**: Checklist to mark off
7. **📝 Notes**: Personal and public annotations

## 🛠️ Technologies

### Frontend & Admin Panel
- Astro 4.x
- React 18
- TailwindCSS 3
- TypeScript
- Zustand (state management)
- Axios (HTTP client)

### Backend
- FastAPI
- SQLAlchemy (ORM)
- PostgreSQL
- JWT Authentication
- Pydantic (validation)

### Infrastructure
- Docker & Docker Compose
- Multi-stage Dockerfiles
- Health checks
- Persistent volumes

## 🏗️ Project Structure

```
/talkbost
├── frontend/          # Student application (Astro + React + Tailwind)
├── admin-panel/       # Admin panel (Astro + React + Tailwind)
├── backend/           # Backend API (FastAPI)
├── db/                # Database scripts (PostgreSQL)
├── .env               # Environment variables (main)
├── .env.development   # Development template
├── .env.production    # Production template
├── docker-compose.yml # Container orchestration
├── start-dev.sh       # Script to start in development
├── start-prod.sh      # Script to start in production
```

## ⚙️ Environment Configuration

**Important:** This project uses a single `.env` file in the root directory shared by all services.

The `.env` file is automatically created when running `start-dev.sh` or `start-prod.sh` if it doesn't exist.

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose installed
- Ports 4321, 4322, 5432, and 8000 available

### Installation

```bash
# Clone with submodules
git clone --recursive https://github.com/JOSEW383/talkbost.git
cd talkbost

# Or if you already cloned without --recursive
git submodule update --init --recursive

### Update all submodules to latest
git submodule update --remote --merge

### Pull latest changes including submodules
git pull --recurse-submodules
```

### Development

```bash
# Give execution permissions to scripts (first time only)
chmod +x start-dev.sh start-prod.sh

# Start in development mode (creates .env automatically if it doesn't exist)
./start-dev.sh
```

Services will be available at:
- **Frontend (Students)**: http://localhost:4321
- **Admin Panel**: http://localhost:4322
- **Backend API**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs

### Production

```bash
# Start in production mode
# The script will ask you to edit sensitive values if .env doesn't exist
./start-prod.sh
```

## 🐳 Useful Docker Commands

```bash
# View logs in real-time
docker-compose logs -f

# View logs for a specific service
docker-compose logs -f backend

# Stop all services
docker-compose down

# Stop and remove volumes
docker-compose down -v

# Rebuild images
docker-compose build --no-cache

# Access the database
docker exec -it talkbost_db psql -U talkbost -d talkbost_db
```

## 📖 API Documentation

Interactive API documentation is available at:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc
