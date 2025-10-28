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
- **Dynamic Product Data** – Fetches and displays live data from [DummyJSON REST API](https://dummyjson.com/).
- **MVVM Architecture** – Clear separation of concerns among Model, View, and ViewModel.
- **Nested Routing** – Persistent bottom navigation using `GetRouterOutlet`.
- **Centralized Theme Management** – Unified color scheme, typography, and button styles via `ThemeData`.
- **Reactive UI** – Automatic state updates powered by `Rx` variables and GetX reactivity.
- **Add to Cart Feedback** – Instant `Snackbar` feedback for product interactions.

---

## 🧠 Architecture Overview

Aepp follows a **clean MVVM architecture** with **GetX** for both state management and routing.

lib/
├── data/
│ ├── models/
│ │ └── product_model.dart
│ └── repositories/
│ └── product_repository.dart
├── modules/
│ ├── home/
│ │ ├── home_binding.dart
│ │ ├── home_controller.dart ← ViewModel (business logic)
│ │ └── home_view.dart ← View (UI)
│ ├── category/
│ └── product_detail/
├── routes/
│ └── app_pages.dart
└── main.dart ← Theme setup & root routing


**Layered responsibilities:**
- **Model:** Defines data structures & handles API integration.
- **ViewModel:** Uses `GetxController` to manage reactive state and UI logic.
- **View:** Flutter widgets that reactively render state via GetX observables.

---

## 🛠️ Tech Stack

- **Framework:** Flutter  
- **State Management & Routing:** GetX  
- **HTTP Client:** `http` package  
- **Typography:** Google Fonts (Inter)  
- **Architecture:** MVVM  
- **API:** [DummyJSON](https://dummyjson.com/)  

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
