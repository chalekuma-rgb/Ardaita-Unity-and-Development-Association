# Ardaita Unity and Development Association

A Flutter web application for the Ardaita Unity and Development Association.

---

## Required Dependencies

### SDK Requirements

| Tool        | Required Version          |
|-------------|---------------------------|
| Flutter SDK | `>= 3.18.0-18.0.pre.54`   |
| Dart SDK    | `>= 3.11.0 < 4.0.0`       |

> **Note:** The CI/CD pipeline uses Flutter **3.29.0** (stable channel). It is recommended to use the same version locally to ensure consistent builds.

### Direct (Runtime) Dependencies

These packages are required at runtime and are declared in `pubspec.yaml`:

| Package          | Version   | Description                                      |
|------------------|-----------|--------------------------------------------------|
| `flutter`        | SDK       | The Flutter framework (required)                 |
| `cupertino_icons`| `^1.0.8`  | iOS-style icons for use with `CupertinoIcons`    |

### Dev Dependencies

These packages are only needed during development and testing:

| Package        | Version   | Description                                                  |
|----------------|-----------|--------------------------------------------------------------|
| `flutter_test` | SDK       | Flutter's built-in testing framework                         |
| `flutter_lints`| `^6.0.0`  | Recommended lint rules for Flutter projects                  |

### Assets

The following local assets are bundled with the application (located in the `assets/` directory):

| File                    | Type  |
|-------------------------|-------|
| `Ardaita.jpg`           | Image |
| `Ardaita2.jpg`          | Image |
| `Board_Chair_Man.jpg`   | Image |
| `Ardaita_Amharic.pdf`   | PDF   |

---

## Getting Started

### 1. Install Flutter

Download and install Flutter from the official site: https://docs.flutter.dev/get-started/install

Verify your installation:

```bash
flutter doctor
```

### 2. Install project dependencies

```bash
flutter pub get
```

### 3. Run the app locally

```bash
flutter run -d chrome
```

### 4. Build for web (production)

```bash
flutter build web --release --base-href /Ardaita-Unity-and-Development-Association/
```

---

## CI/CD

This project uses GitHub Actions to automatically build and deploy to **GitHub Pages** on every push to the `main` branch. See [`.github/workflows/main.yml`](.github/workflows/main.yml) for details.

---

## Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [pub.dev package repository](https://pub.dev/)
- [Flutter web deployment guide](https://docs.flutter.dev/deployment/web)
