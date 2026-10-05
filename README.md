# Food Order App V1 🍔

A food ordering app built with Flutter, a personal project built to go deep on state management, backend architecture, and real payment integration.

**Portfolio:** https://khalilh.com/

## Overview

This app lets users browse restaurants, create an order, and pay securely through Stripe, with realtime order status updates.

### Why I built this

My goals were to:
- Learn state management with Riverpod
- Integrate real payments with Stripe
- Practice building a proper production setup (CI pipelines, clean architecture, result pattern for error handling)
- Work with realtime data

## Features

- Browse restaurants and menus
- Order menu items
- Shopping cart with quantity management
- Payments with Stripe
- Order history
- User settings
- Realtime order status via Supabase

## Architecture & Tech Stack

- **Framework:** Flutter
- **State management:** Riverpod (user/auth state, cart, quantity counters)
- **Error handling:** `Result` type paired with custom exceptions, so failures can be caught in the UI and shown as a specific, user-facing message when needed
- **Database:** Supabase
- **CI:** GitHub Actions


## Getting Started
 
1. Clone the repo
2. run `flutter pub get`
4. run  `flutter run`


## Future features

- [ ] Push notifications (Android)
- [ ] Category filtering
- [ ] Search for restaurants
- [ ] Fetching nearby restaurant based on user location
- [ ] Scheduled orders
- [ ] refactor authentication to passwordless authenthication
- [ ] Further UI polish


## Demo

📹 [Watch the demo video](https://youtu.be/2QFizEVJClQ)
