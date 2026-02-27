# Multi Vendor Medicine Pharmacy Delivery App

[![Flutter](https://img.shields.io/badge/Flutter-3.13-blue)](https://flutter.dev/)  
[![Dart](https://img.shields.io/badge/Dart-3.2-blue)](https://dart.dev/)

## Overview

The **Multi Vendor Medicine Pharmacy Delivery App** is a Flutter mobile application designed to facilitate medicine ordering and delivery. It supports **three user roles**:

1. **Patient** – Browses pharmacies, places medicine orders, tracks deliveries.  
2. **Pharmacy** – Manages inventory, receives orders, and prepares packages for delivery.  
3. **Driver/Delivery** – Accepts delivery tasks, updates order status, and ensures timely delivery.

The system provides real-time updates, secure authentication, and role-specific dashboards for seamless workflow.

---

## Features

### Patient
- Browse pharmacies and available medicines  
- Search and filter by medicine type or brand  
- Place orders and select preferred pharmacy  
- Track order status in real-time  
- Receive notifications about delivery updates  

### Pharmacy
- Manage medicine inventory (add, edit, remove items)  
- View and manage incoming orders  
- Update order status for driver pickup  
- Analytics for sales and stock management  

### Driver / Delivery
- View available delivery orders  
- Accept or reject assigned deliveries  
- Track delivery status  
- Update order status to delivered or failed  

---

## Screens

- Splash Screen → Onboarding → User Type Selection  
- Patient Dashboard → Cart → Checkout → Order Tracking  
- Pharmacy Dashboard → Inventory Management → Order Management  
- Driver Dashboard → Available Deliveries → Active Orders → Delivery Completion  

---

## Tech Stack

- **Frontend:** Flutter, Dart, Flutter ScreenUtil  
- **State Management:** Bloc/Cubit  
- **Backend:** REST API 
- **Local Storage:** SharedPreferences  
- **Navigation:** GoRouter  
- **Authentication:** Email/password + Google Sign-in  

---

<img width="822" height="348" alt="Screenshot 2026-02-27 at 22 07 22" src="https://github.com/user-attachments/assets/a415eb66-a6cb-4963-8eb4-e000064bb91b" />
