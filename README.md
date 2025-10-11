# TalkBost - Aplicación de Gestión de Cursos de Inglés

Una aplicación web completa para gestionar cursos de inglés con frontend para alumnos, panel de administración y backend API.

## 🏗️ Estructura del Proyecto

```
/talkbost
├── frontend/          # Aplicación para alumnos (Astro + React + Tailwind)
├── admin-panel/       # Panel de administración (Astro + React + Tailwind)
├── backend/           # API Backend (FastAPI)
├── db/                # Scripts de base de datos (PostgreSQL)
├── .env               # Variables de entorno (principal)
├── .env.development   # Template para desarrollo
├── .env.production    # Template para producción
├── docker-compose.yml # Orquestación de contenedores
├── start-dev.sh       # Script para iniciar en desarrollo
├── start-prod.sh      # Script para iniciar en producción
└── DEPLOYMENT.md      # Guía de deployment detallada
```

## ⚙️ Configuración de Environment

**Importante:** Este proyecto usa un único archivo `.env` en el directorio raíz que comparten todos los servicios.

El archivo `.env` se crea automáticamente al ejecutar `start-dev.sh` o `start-prod.sh` si no existe.

## 🚀 Inicio Rápido

### Prerequisitos

- Docker y Docker Compose instalados
- Puertos 4321, 4322, 5432 y 8000 disponibles

### Desarrollo

```bash
# Dar permisos de ejecución a los scripts (solo primera vez)
chmod +x start-dev.sh start-prod.sh

# Iniciar en modo desarrollo (crea .env automáticamente si no existe)
./start-dev.sh
```

Los servicios estarán disponibles en:
- **Frontend (Alumnos)**: http://localhost:4321
- **Panel de Administración**: http://localhost:4322
- **API Backend**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs

### Producción

```bash
# Iniciar en modo producción
# El script te pedirá editar valores sensibles si .env no existe
./start-prod.sh
```

## 👤 Credenciales por Defecto

### Admin Panel
- Usuario: `admin`
- Contraseña: `admin123`

⚠️ **IMPORTANTE**: Cambia estas credenciales en producción.

## 📱 Funcionalidades

### Frontend (Alumnos)
- ✅ Registro y autenticación de usuarios
- ✅ Dashboard con progreso del curso
- ✅ Vista de clases organizadas por días
- ✅ Actividades con checks de completado
- ✅ Anotaciones personales y públicas
- ✅ Sistema de progreso con estadísticas
- ✅ Diseño responsive y minimalista

### Panel de Administración
- ✅ Autenticación de administrador
- ✅ Gestión de cursos (crear, editar, eliminar)
- ✅ Gestión de lecciones y actividades
- ✅ Vista de progreso de todos los alumnos
- ✅ Consulta de anotaciones (públicas y privadas)
- ✅ Dashboard con estadísticas

### Backend API
- ✅ Autenticación JWT
- ✅ Endpoints RESTful completos
- ✅ PostgreSQL como base de datos
- ✅ Gestión de usuarios, cursos, lecciones, progreso y anotaciones
- ✅ Documentación automática (Swagger/OpenAPI)

## 📚 Estructura de Clases

Cada clase incluye:

1. **🎯 Objetivos del día**: Descripción de lo que se va a practicar
2. **💬 Warm-up**: Introducción oral y activación de vocabulario
3. **🗣️ Speaking Focus**: Role-plays y práctica principal
4. **🧠 Vocabulary & Grammar**: Palabras y expresiones útiles
5. **🎨 Visual Speaking**: Descripción de imágenes
6. **✅ Check Your Progress**: Lista de checks para marcar
7. **📝 Notas**: Anotaciones personales y públicas

## 🗄️ Base de Datos

PostgreSQL con las siguientes tablas:
- `users` - Alumnos
- `admins` - Administradores
- `courses` - Cursos
- `lessons` - Lecciones (días del curso)
- `activities` - Actividades y tareas
- `annotations` - Anotaciones de alumnos
- `progress` - Progreso de actividades
- `lesson_checks` - Items del checklist
- `user_lesson_checks` - Completado de checks por usuario
- `enrollments` - Inscripciones a cursos

## 🛠️ Tecnologías

### Frontend & Admin Panel
- Astro 4.x
- React 18
- TailwindCSS 3
- TypeScript
- Zustand (gestión de estado)
- Axios (cliente HTTP)

### Backend
- FastAPI
- SQLAlchemy (ORM)
- PostgreSQL
- JWT Authentication
- Pydantic (validación)

### Infraestructura
- Docker & Docker Compose
- Multi-stage Dockerfiles
- Health checks
- Persistent volumes

## 🐳 Comandos Docker Útiles

```bash
# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f backend

# Detener todos los servicios
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v

# Reconstruir imágenes
docker-compose build --no-cache

# Acceder a la base de datos
docker exec -it talkbost_db psql -U talkbost -d talkbost_db
```

## 🔒 Seguridad

En producción, asegúrate de:
- ✅ Cambiar todas las contraseñas por defecto
- ✅ Usar SECRET_KEY fuerte (mínimo 32 caracteres aleatorios)
- ✅ Configurar CORS correctamente
- ✅ Usar HTTPS/SSL
- ✅ Implementar rate limiting
- ✅ Realizar backups regulares de la base de datos

## 📖 Documentación API

La documentación interactiva de la API está disponible en:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc
