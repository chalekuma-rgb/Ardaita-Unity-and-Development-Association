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

### 4. Run the App (Development)

```bash
flutter run -d chrome
```

---

## Deployment

### Build for Web

```bash
flutter build web
```

The compiled output will be in the `build/web/` directory. Deploy the contents of that directory to any static web hosting service (e.g., Firebase Hosting, GitHub Pages, Netlify, or any web server).

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
