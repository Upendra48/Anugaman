# Job Application Tracker

A full-stack job application tracking system built with Django, Flutter, MongoDB, and Redis.

## Tech Stack

### Backend

* Django
* Django REST Framework
* MongoDB (PyMongo)
* Redis
* JWT Authentication
* Docker

### Frontend

* Flutter

### Tools & DevOps

* Postman
* Git & GitHub
* Docker Compose
* CI/CD (Planned)

---

# Features Implemented

## Backend Setup

* Django project setup
* MongoDB connection
* Redis setup
* Docker configuration
* Environment variable management

## Authentication System

* User Registration API
* User Login API
* Password hashing using bcrypt
* JWT Authentication
* Protected Routes
* Current User Endpoint
* Auto board initialization

---

# Project Structure

```text
backend/
│
├── apps/
│   ├── authentication/
│   ├── boards/
│   ├── jobs/
│   └── analytics/
│
├── core/
├── services/
│
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── manage.py
```

---

# Run Project

## Create `.env`

```env
SECRET_KEY=your_secret_key
DEBUG=True

MONGODB_URI=mongodb://mongodb:27017
MONGODB_DB=job_tracker

REDIS_HOST=redis
REDIS_PORT=6379
```

## Run with Docker

```bash
docker compose up --build
```

---

# API Endpoints

## Register

```http
POST /api/auth/register/
```

## Login

```http
POST /api/auth/login/
```

## Current User

```http
GET /api/auth/me/
```

Requires:

```text
Authorization: Bearer <access_token>
```

---

# Auto Board Initialization

Each new user automatically gets:

* Wishlist
* Applied
* Interviewing
* Offer
* Rejected

---

# API Testing

APIs are tested using Postman.

---

# Upcoming Features

* Board CRUD APIs
* Job CRUD APIs
* Kanban drag-and-drop
* Analytics dashboard
* Flutter frontend
* Redis caching
* CI/CD pipeline

---

# License

Developed for learning and portfolio purposes.
