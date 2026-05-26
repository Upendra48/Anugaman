# Anugaman 

A job application tracking backend system built with **Django REST Framework**, **MongoDB**.

Anugaman helps users manage and track their job applications using a modern Kanban-style workflow.

---

# Features

- JWT Authentication
- User Registration & Login
- Protected API Routes
- Auto Board Initialization
- Kanban Board System
- Job Application Management
- Redis Caching
- REST API Backend
- Dockerized Backend
- CI/CD with GitHub Actions
- Scalable Project Architecture

---

# Tech Stack

## Backend
- Django
- Django REST Framework
- MongoDB
- Redis
- JWT Authentication
- Docker
- GitHub Actions


---

# Project Structure

```bash
Anugaman/
│
├── backend/
│   ├── apps/
│   ├── config/
│   ├── requirements.txt
│   └── manage.py
│
|
│
├── docker-compose.yml
│
└── README.md
```

---

# Backend Setup

## 1. Clone Repository

```bash
git clone https://github.com/Upendra48/Anugaman.git

cd Anugaman
```

---

## 2. Start Docker Containers

```bash
docker compose up --build
```

---

## 3. Backend Runs At

```bash
http://127.0.0.1:8000/
```

---

# Authentication

Authentication uses JWT Tokens.

After login:
- Access Token is returned
- Use token in protected routes

Example:

```http
Authorization: Bearer YOUR_ACCESS_TOKEN
```

---

# API Endpoints

## Authentication APIs

### Register User

```http
POST /api/auth/register/
```

### Login User

```http
POST /api/auth/login/
```

### Get Current User

```http
GET /api/auth/me/
```

Protected Route 

---

## Board APIs

### Get User Boards

```http
GET /api/boards/
```

Protected Route 

---

### Get Board Columns

```http
GET /api/boards/{board_id}/columns/
```

Protected Route 

---

## Job APIs

### Create Job Application

```http
POST /api/jobs/
```

Protected Route 

---

### Get Jobs (Paginated)

```http
GET /api/jobs/
```

Protected Route 

---

### Update Job

```http
PATCH /api/jobs/{job_id}/
```

Protected Route 

---

### Delete Job

```http
DELETE /api/jobs/{job_id}/
```

Protected Route 

---

# Redis Cache

Redis is used for caching frequently accessed data to improve API performance.

## Cached Features
- Job Listings
- Board Data
- Faster API Responses

## Benefits
- Reduced database load
- Faster response time
- Better scalability

---

# API Testing

API testing is done using Postman.

---

# Docker

The backend is fully dockerized.

## Services
- Django Backend
- MongoDB
- Redis

Run:

```bash
docker compose up
```

---

# CI/CD

GitHub Actions automatically:

- Installs dependencies
- Runs backend checks
- Validates pull requests

---

# Branching Strategy

```bash
main
develop
feature/*
```

## Workflow

1. Create feature branch
2. Push changes
3. Open Pull Request
4. Merge into develop
5. Merge develop → main

---

# Future Improvements

- Analytics Dashboard
- Drag & Drop Kanban
- Notifications
- Resume Uploads
- AI Resume Analysis
- Job Search Integration

---

# Author

Upendra Raj Joshi

GitHub:
https://github.com/Upendra48
