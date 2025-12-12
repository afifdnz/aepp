# Aepp 🛍️  
> A clean modern Flutter e-commerce prototype showcasing MVVM and GetX architecture.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Mobile-lightgrey.svg)]()

---

## 🌐 Overview

**Aepp** is a single-vendor e-commerce mobile prototype built with **Flutter**, designed to demonstrate a scalable and maintainable implementation of the **MVVM (Model-View-ViewModel)** pattern using **GetX**.  
It emphasizes a **clean, brand-centric UI**, real-time product fetching from a live REST API, and a smooth user experience that reflects modern design principles.

This project is ideal as both a **technical showcase** of Flutter architecture and a **foundation** for future full-featured e-commerce applications.

---

## ✨ Features

- **Modern & Brand-Centric UI** – Minimalistic, product-focused interface with consistent design language.
- **Persistent Backend Data** – Uses a custom Go backend with MySQL to allow real CRUD operations (Register, Login, Cart, Wishlist).
- **MVVM Architecture** – Clear separation of concerns among Model, View, and ViewModel.
- **Nested Routing** – Persistent bottom navigation using `GetRouterOutlet`.
- **Centralized Theme Management** – Unified color scheme, typography, and button styles via `ThemeData`.
- **Reactive UI** – Automatic state updates powered by `Rx` variables and GetX reactivity.
- **Add to Cart Feedback** – Instant `Snackbar` feedback for product interactions.

---

## 🔌 Backend & API
This project connects to a custom **RESTful API** built with **Go (Golang)** and **Docker**.

🚀 How to Run Backend Locally
If you want to run the server on your own machine (Localhost):
1. Clone this repository
2. Run with Docker Compose:
   
   ```txt
   docker-compose up --build
   ```
   This will automatically spin up:
   - **Go API Server** at http://localhost:8080
   - **MySQL Database** (Pre-configured)
   - **phpMyAdmin** at http://localhost:8081
4. **Seed Data (Optional)**: Once running, visit http://localhost:8080/seed to populate the database with dummy products.

**Data Source & Persistence**

   ⚠️ Note on Data Origin:
   While the initial catalog data (Products, Categories, Images) is seeded from the public DummyJSON API, it is stored and managed in a private    MySQL database.

   Unlike using the public DummyJSON directly (which is read-only), this custom backend allows for full data persistence. This means User          Registration, Cart updates, Wishlist management, and Orders are saved permanently.

**API Endpoints**
The application interacts with the following endpoints:

| Feature    | Method | Endpoint                             | Description                          |
|:----------:|:------:|:-------------------------------------:|:--------------------------------------|
| Auth       | `POST` | `/api/users/register`                 | Register new user.                    |
| Auth       | `POST` | `/api/users/login`                    | User login (email & password).        |
| User       | `GET`  | `/api/users/{id}`                     | Get user profile.                     |
| User       | `GET`  | `/api/users/{id}/addresses`           | Get user shipping addresses.          |
| Products   | `GET`  | `/api/products`                       | Fetch all products.                   |
| Products   | `GET`  | `/api/products/{id}`                  | Fetch single product details.         |
| Categories | `GET`  | `/api/categories`                     | Fetch product categories.             |
| Categories | `GET`  | `/api/categories/{id}/products`       | Fetch products by category.           |
| Wishlist   | `GET`  | `/api/users/{id}/wishlist`            | Get user's wishlist.                  |
| Wishlist   | `POST` | `/api/wishlist`                       | Add item to wishlist.                 |
| Wishlist   | `DELETE` | `/api/wishlist/{id}`                | Remove item from wishlist.            |
| Cart       | `GET`  | `/api/users/{id}/cart`                | Get user's shopping cart.             |
| Cart       | `POST` | `/api/cart`                           | Add to cart / Update quantity.        |
| Cart       | `PUT`  | `/api/cart/{id}`                      | Update cart item quantity.            |
| Cart       | `DELETE` | `/api/cart/{id}`                    | Remove item from cart.                |
| Order      | `POST` | `/api/orders/checkout`                | Process checkout (Transaction).       |


### 🌐 Live Demo API

The backend is deployed and currently running on **Hugging Face Spaces**. You can test the connectivity or use this Base URL for the Flutter application.

**Base URL:** `https://aepp-project-mobile-aepp.hf.space`

> **⚠️ Note:** Since this runs on a free tier instance, the server might "sleep" after periods of inactivity. If the first request is slow or fails, please wait a moment and try again while the container wakes up.

---

## 🧠 Architecture Overview

Aepp follows a **clean MVVM architecture** with **GetX** for both state management and routing.

```txt
lib/
├── bindings/
│ ├── about_bindings.dart
│ ├── home_bindings.dart
│ └── product_list_bindings.dart
├── model/
│ └── product_model.dart
├── repositories/
│ └── product_repository.dart
├── routes/
│ ├── app_pages.dart
│ └── app_utes.dart
├── views/
│ ├── about.dart
│ ├── home.dart
│ └── product_list.dart
├── viewmodel/
│ ├── about_viewmodel.dart
│ ├── home_viewmodel.dart
│ └── product_list_viewmodel.dart
├── widgets/
│ ├── category_card.dart
│ └── product_card.dart
└── main.dart ← Theme setup & root routing
```

**Layered responsibilities:**
- **Model:** Defines data structures & handles API integration.
- **ViewModel:** Uses `GetxController` to manage reactive state and UI logic.
- **View:** Flutter widgets that reactively render state via GetX observables.

---

## 🛠️ Tech Stack

- **Framework:** Flutter  
- **State Management & Routing:** GetX  
- **Backend Language:** Go (Golang)
- **Database:** MySQL (Local Docker / TiBD Cloud)  
- **Hosting:** Hungging Face Spaces (Docker)  
- **Architecture:** MVVM  
- **Seed:** [DummyJSON](https://dummyjson.com/)  

---

## 📱 Screenshots

| Home | Product List | Product Detail |
|:----:|:-------------:|:--------------:|
| *(coming soon)* | *(coming soon)* | *(coming soon)* |

---

## ⚙️ Getting Started

To run this project locally:

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/Aepp.git
cd Aepp

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
