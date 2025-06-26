# 👕 Clothly – Fashion Shopping App

Clothly is a modern, responsive cross-platform e-commerce app built with **Flutter**. It offers users a seamless clothing shopping experience with Firebase-powered authentication, real-time Firestore data, Stripe payment integration, and smooth UI/UX design.

![Clothly Banner](Clothly.png)

---

## ✨ Features

- 🔐 Google Sign-In with Firebase Authentication
- 📦 Product categories (T-Shirts, Hoodies, Frocks, etc.)
- 📏 Size selection and quantity adjustment
- 🛒 Real-time shopping cart management
- 💳 Secure Stripe checkout with `flutter_stripe`
- 📡 Cloud Firestore integration for products and cart
- 💡 State management with `Provider`
- 🎨 Beautiful, intuitive UI and smooth navigation
- 🧪 Unit & integration tested for high reliability

---

## 📸 Screenshots

| Login Screen                           | Sign Up Screen                           | Sign In Screen                           | Product List                         | Product Details                          | Shopping Cart                        | Stripe Checkout                          | About Page                             |
| -------------------------------------- | ---------------------------------------- | ---------------------------------------- | ------------------------------------ | ---------------------------------------- | ------------------------------------ | ---------------------------------------- | -------------------------------------- |
| ![Login](assets/screenshots/login.png) | ![Signup](assets/screenshots/signup.png) | ![Signin](assets/screenshots/signin.png) | ![List](assets/screenshots/list.png) | ![Detail](assets/screenshots/detail.png) | ![Cart](assets/screenshots/cart.png) | ![Stripe](assets/screenshots/stripe.png) | ![About](assets/screenshots/about.png) |

> ⚠️ Make sure you create the `/assets/screenshots/` folder and place the respective images there, or update the paths accordingly.

---

## 🧰 Tech Stack

- **Flutter** – UI toolkit for natively compiled apps
- **Firebase** – Auth & Cloud Firestore
- **Stripe** – Payment processing
- **Provider** – State management
- **flutter_dotenv** – Secret management (.env)

---

## 🚀 Getting Started

### ✅ Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Firebase project setup with:
  - Google Sign-In Authentication
  - Cloud Firestore
- Stripe developer account & keys

### 🔧 Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/01Nimantha/clothly.git
   cd clothly
   ```
