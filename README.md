# Ardaita Unity and Development Association

A Flutter web application for the Ardaita Unity and Development Association.

---

## Required Dependencies

### System Requirements

| Tool | Minimum Version | Notes |
|------|----------------|-------|
| [Flutter SDK](https://docs.flutter.dev/get-started/install) | >= 3.18.0 | Includes the Dart SDK |
| [Dart SDK](https://dart.dev/get-dart) | >= 3.11.0, < 4.0.0 | Bundled with Flutter |
| A supported web browser | Any modern browser | Chrome recommended for development |

> **Note:** Flutter ships with Dart, so installing Flutter is sufficient — you do not need to install Dart separately.

### Runtime Dependencies (defined in `pubspec.yaml`)

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | Core UI framework |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Unit and widget testing |
| `flutter_lints` | ^6.0.0 | Recommended lint rules |

---

## Getting Started

### 1. Install Flutter

Follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install) for your operating system.

Verify your installation:

```bash
flutter doctor
```

### 2. Clone the Repository

```bash
git clone https://github.com/chalekuma-rgb/Ardaita-Unity-and-Development-Association.git
cd Ardaita-Unity-and-Development-Association
```

### 3. Install Dart/Flutter Packages

```bash
flutter pub get
```

### 4. Configure Form Backends

The site now supports two backend paths:

- a Node.js REST API in [backend](backend)
- optional Firebase Firestore sync in the Flutter app

Read the full architecture in [docs/backend-architecture.md](docs/backend-architecture.md).

### 5. Run The Node Backend

Install Node.js 20 or newer, then run:

```bash
cd backend
npm install
npm start
```

The API will start on `http://localhost:3000` by default.

### 6. Run The Flutter App Against The API

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000
```

To enable Firebase sync as well, provide Firebase values at runtime:

```bash
flutter run -d chrome \
	--dart-define=API_BASE_URL=http://localhost:3000 \
	--dart-define=ENABLE_FIREBASE_SYNC=true \
	--dart-define=FIREBASE_API_KEY=your-key \
	--dart-define=FIREBASE_APP_ID=your-app-id \
	--dart-define=FIREBASE_MESSAGING_SENDER_ID=your-sender-id \
	--dart-define=FIREBASE_PROJECT_ID=your-project-id \
	--dart-define=FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
```

### 7. Run the App (Development)

```bash
flutter run -d chrome
```

---

## Deployment

### Build for Web

```bash
flutter build web --base-href /Ardaita-Unity-and-Development-Association/
```

The compiled output will be in the `build/web/` directory. Deploy the contents of that directory to any static web hosting service (e.g., Firebase Hosting, GitHub Pages, Netlify, or any web server).

If you need live form submissions in the deployed app, build with your production API URL:

```bash
flutter build web \
	--base-href /Ardaita-Unity-and-Development-Association/ \
	--dart-define=API_BASE_URL=https://your-backend.example.com
```

### Build for Other Platforms

```bash
# Android APK
flutter build apk

# iOS (macOS with Xcode required)
flutter build ios

# Windows desktop
flutter build windows

# macOS desktop
flutter build macos

# Linux desktop
flutter build linux
```

---

## Running Tests

```bash
flutter test
```

---

## Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Flutter installation guide](https://docs.flutter.dev/get-started/install)
- [pub.dev – Dart & Flutter package repository](https://pub.dev)
