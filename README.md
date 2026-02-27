Multi Vendor Medicine Pharmacy Delivery App




Overview

The Multi Vendor Medicine Pharmacy Delivery App is a Flutter mobile application designed to facilitate medicine ordering and delivery. It supports three user roles:

Patient – Browses pharmacies, places medicine orders, tracks deliveries.

Pharmacy – Manages inventory, receives orders, prepares packages for delivery.

Driver/Delivery – Accepts delivery tasks, updates order status, and ensures timely delivery.

The system provides real-time updates, secure authentication, and role-specific dashboards for seamless workflow.

Features
Patient

Browse pharmacies and available medicines

Search and filter by medicine type or brand

Place orders and select preferred pharmacy

Track order status in real-time

Receive notifications about delivery updates

Pharmacy

Manage medicine inventory (add, edit, remove items)

View and manage incoming orders

Update order status for driver pickup

Analytics for sales and stock management

Driver / Delivery

View available delivery orders

Accept or reject assigned deliveries

Track delivery status

Update order status to delivered or failed

Screens

Splash Screen → Onboarding → User Type Selection

Patient Dashboard → Cart → Checkout → Order Tracking

Pharmacy Dashboard → Inventory Management → Order Management

Driver Dashboard → Available Deliveries → Active Orders → Delivery Completion

Tech Stack

Frontend: Flutter, Dart, Flutter ScreenUtil

State Management: Bloc/Cubit

Backend: REST API (Firebase / Node.js or your chosen backend)

Local Storage: SharedPreferences

Navigation: GoRouter

Authentication: Email/password + Google Sign-in

Installation

Clone the repository:

git clone https://github.com/yourusername/multi_vendor_medicene_pharmacy_delivery_app.git

Install dependencies:

flutter pub get

Run the app:

flutter run
Project Structure
lib/
├── core/               # Constants, themes, utilities
├── features/
│   ├── auth/           # Login, SignUp, Forget Password
│   ├── onboarding/     # Onboarding & user type selection
│   ├── patient/        # Patient dashboard & cart
│   ├── pharmacy/       # Pharmacy dashboard & inventory
│   └── driver/         # Driver dashboard & delivery management
├── routes/             # App routes using GoRouter
├── shared/             # Models, services (API calls, Auth)
└── main.dart           # App entry point
Usage

Open the app → Splash Screen → Onboarding

Select user type: Patient, Pharmacy, or Driver

Sign up or login based on the selected role

Use role-specific features (browse orders, manage inventory, track delivery)

