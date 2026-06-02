# 📝 Notes JWT App

Aplikasi Notes Mobile berbasis Flutter dengan sistem autentikasi JWT menggunakan Laravel API Backend.

---

## 🚀 Features

✅ Register User
✅ Login JWT Authentication
✅ Auto Login Session
✅ Secure Token Storage
✅ Create Notes
✅ Read Notes
✅ Update Notes
✅ Delete Notes
✅ Logout Session
✅ Multi User Notes
✅ Custom API Key Middleware

---

# 🛠️ Tech Stack

## Frontend

* Flutter
* Provider State Management
* HTTP Package
* Flutter Secure Storage

## Backend

* Laravel 10
* JWT Authentication
* MySQL Database
* REST API

---

# 📂 Project Structure

## Flutter

```bash
lib/
│
├── models/
│   └── note_model.dart
│
├── providers/
│   └── auth_provider.dart
│
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
│
├── views/
│   ├── login_view.dart
│   ├── register_view.dart
│   └── home_view.dart
│
└── main.dart
```

---

# 🔐 JWT Authentication Flow

1. User Login
2. Laravel API generates JWT Token
3. Flutter stores token using Secure Storage
4. Every request sends:

   ```http
   Authorization: Bearer TOKEN
   ```
5. API validates token
6. User can access protected routes

---

# 🔑 Custom API Key

This project also implements custom API Key Middleware.

Example header:

```http
set-apikey: AKMAL-API-KEY
```

---

# ⚙️ Installation

## Clone Repository

```bash
git clone https://github.com/username/notes-jwt-app.git
```

---

# 📱 Flutter Setup

## Install Dependencies

```bash
flutter pub get
```

## Run Flutter App

```bash
flutter run
```

---

# 🖥️ Laravel Backend Setup

## Install Composer Dependencies

```bash
composer install
```

---

## Generate App Key

```bash
php artisan key:generate
```

---

## Generate JWT Secret

```bash
php artisan jwt:secret
```

---

## Migration & Seeder

```bash
php artisan migrate:fresh --seed
```

---

## Run Laravel Server

```bash
php artisan serve
```

---

# 🧪 Dummy Login

## User 1

```txt
Email:
akmal@gmail.com

Password:
akmal
```

---

# 📡 API Endpoints

| Method | Endpoint          | Description   |
| ------ | ----------------- | ------------- |
| POST   | `/api/register`   | Register User |
| POST   | `/api/login`      | Login User    |
| GET    | `/api/notes`      | Get Notes     |
| POST   | `/api/notes`      | Create Note   |
| PUT    | `/api/notes/{id}` | Update Note   |
| DELETE | `/api/notes/{id}` | Delete Note   |

---

# 🔒 Request Headers

```http
Content-Type: application/json
Authorization: Bearer TOKEN
set-apikey: AKMAL-API-KEY
```

---

# 📦 Packages Used

## Flutter

```yaml
provider:
http:
flutter_secure_storage:
```

---

## Laravel

```bash
tymon/jwt-auth
```

---

# 👨‍💻 Developer

Developed by Akmal 🚀

---

# ⭐ License

This project is open-source and available for educational purposes.
