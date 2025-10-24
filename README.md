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
- ✅ Gamification system (coins, levels, shop, leaderboard)
- ✅ Real-time reactions and interactions
- ✅ Vocabulary management
- ✅ Audio sound effects
- ✅ Responsive and minimalist design

### Admin Panel
- ✅ Administrator authentication
- ✅ Course management (create, edit, delete)
- ✅ Lesson and activity management
- ✅ View progress of all students
- ✅ View annotations (public and private)
- ✅ Dashboard with statistics
- ✅ Gamification management
- ✅ Vocabulary oversight

### Backend API
- ✅ JWT Authentication
- ✅ Complete RESTful endpoints
- ✅ PostgreSQL as database
- ✅ User, course, lesson, progress, and annotation management
- ✅ Gamification API (coins, shop, inventory)
- ✅ Vocabulary management
- ✅ Engagement tracking and analytics
- ✅ WebSocket support for real-time features
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
- date-fns (date utilities)
- react-markdown & remark-gfm (markdown rendering)

### Backend
- FastAPI
- SQLAlchemy (ORM)
- PostgreSQL
- JWT Authentication
- Pydantic (validation)
- Alembic (database migrations)
- asyncpg (async PostgreSQL driver)
- email-validator

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
├── .env.example       # Environment variables template
├── docker-compose.yml # Container orchestration
```

## ⚙️ Environment Configuration

**Important:** This project uses a single `.env` file in the root directory shared by all services. Use `.env.example` as a template.

The `ENVIRONMENT` variable defines the deployment mode (`development` or `production`), which controls the Docker build target and runtime behavior.

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
# Copy environment template if .env doesn't exist
cp .env.example .env

# Start in development mode
docker-compose up --build
```

### Production

```bash
# Edit .env file with production values (change ENVIRONMENT=production and secure passwords)
nano .env  # or your preferred editor

# Start in production mode (detached)
docker-compose up --build -d
```

Services will be available at the ports configured in `.env`:
- **Frontend (Students)**: http://localhost:${FRONTEND_PORT}
- **Admin Panel**: http://localhost:${ADMIN_PORT}
- **Backend API**: http://localhost:${BACKEND_PORT}
- **API Docs**: http://localhost:${BACKEND_PORT}/docs

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

## 🐳 Docker Compose Setup

To run the complete application in development or production using Docker Compose, create a `docker-compose.yml` file in the project root with the following content:

```yaml
services:
  # PostgreSQL Database
  db:
    image: postgres:15-alpine
    container_name: talkbost_db
    environment:
      POSTGRES_USER: ${DB_USER:-talkbost}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-talkbost2025}
      POSTGRES_DB: ${DB_NAME:-talkbost_db}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "${DB_PORT:-5432}:5432"
    healthcheck:
      test: [ "CMD-SHELL", "pg_isready -U ${DB_USER:-talkbost} -d ${DB_NAME:-talkbost_db}" ]
      interval: 10s
      timeout: 5s
      retries: 5

  # Backend
  backend:
    image: ghcr.io/josew383/talkbost:latest-backend
    container_name: talkbost_backend
    environment:
      DATABASE_URL: postgresql://${DB_USER:-talkbost}:${DB_PASSWORD:-talkbost2025}@db:5432/${DB_NAME:-talkbost_db}
      SECRET_KEY: ${SECRET_KEY:-your-secret-key-change-in-production}
      ENVIRONMENT: ${ENVIRONMENT:-development}
      ALLOWED_HOSTS_FRONTEND: ${ALLOWED_HOSTS_FRONTEND:-http://localhost:4321}
      ALLOWED_HOSTS_ADMIN: ${ALLOWED_HOSTS_ADMIN:-http://localhost:4322}
    ports:
      - "${BACKEND_PORT}:8000"
    depends_on:
      db:
        condition: service_healthy
    x-credentials: *ghcr-auth

  # Frontend
  frontend:
    image: ghcr.io/josew383/talkbost:latest-frontend
    container_name: talkbost_frontend
    environment:
      PUBLIC_API_URL: ${PUBLIC_API_URL}
      ALLOWED_HOSTS_FRONTEND: ${ALLOWED_HOSTS_FRONTEND}
    ports:
      - "${FRONTEND_PORT}:80"
    depends_on:
      - backend
    x-credentials: *ghcr-auth

  # Admin Panel
  admin:
    image: ghcr.io/josew383/talkbost:latest-admin-panel
    container_name: talkbost_admin
    environment:
      PUBLIC_API_URL: ${PUBLIC_API_URL}
      ALLOWED_HOSTS_ADMIN: ${ALLOWED_HOSTS_ADMIN}
    ports:
      - "${ADMIN_PORT}:80"
    depends_on:
      - backend
    x-credentials: *ghcr-auth

volumes:
  postgres_data:
```

### Instructions for using Docker Compose:
1. Copy the content above into `docker-compose.yml`.
2. Create a `.env` file in the project root (or use the existing one) with the required environment variables.
3. Log in to GitHub Container Registry (if pulling images from ghcr.io):

  docker login ghcr.io -u <USERNAME>

  You will be prompted for your GitHub personal access token as the password. Make sure the token has the appropriate permissions to read packages.
1. Run `docker-compose up -d` to start the services.
2. Access the services at:
  - Frontend: `http://localhost:${FRONTEND_PORT}`
  - Admin Panel: `http://localhost:${ADMIN_PORT}`
  - Backend API: `http://localhost:${BACKEND_PORT}`
