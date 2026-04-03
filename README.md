# Bookstore Management System

A Flutter-based bookstore management system designed for mobile and desktop workflows. The app adapts its entry experience by platform: mobile launches into a touch-friendly home screen, while desktop and other larger-screen platforms use router-driven navigation and a richer management interface.

## Highlights

- Cross-platform Flutter app for bookstore operations
- Mobile-first home screen on Android and iOS
- Router-based experience for desktop and non-mobile platforms
- Light and dark theme switching with `ThemeBloc`
- Local persistence powered by Drift and SQLite
- Product management with add, update, delete, search, and export flows
- ISBN scanning support for mobile and desktop scenarios
- Authentication flow for local user access
- Desktop window management and multi-window support

## Tech Stack

- Flutter
- `flutter_bloc`
- `go_router`
- Drift + SQLite
- `get_it`
- `freezed` + `json_serializable`
- `syncfusion_flutter_datagrid`
- `mobile_scanner`
- `window_manager` + `desktop_multi_window`

## Project Structure

```text
lib/
├── app/         # App entry, bootstrap, routing, scope
├── core/        # Theme, database, DI, shared utilities
├── features/
│   ├── auth/    # Authentication
│   └── product/ # Product management and ISBN scanning
└── inventory/   # Inventory-related pages
```

## Platform Behavior

The application entry is defined in [`lib/app/bookstore_app.dart`](lib/app/bookstore_app.dart):

- On Android and iOS, the app opens `MobileHomeScreen`
- On web/desktop-style environments, the app uses `MaterialApp.router`
- All platforms share the same light/dark theme configuration

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- A configured device or emulator for your target platform

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

## Code Generation And Database Migration

Generate supporting files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generate Drift migrations:

```bash
dart run drift_dev make-migrations
```

## Assets

The project currently includes:

- Custom font: `NotoSansSC`
- App icon assets
- Scanner web assets
- Scan success sound effect

## Status

The codebase is organized around app bootstrap, core infrastructure, and feature modules, making it a solid foundation for continued development and a cleaner GitHub presentation.
