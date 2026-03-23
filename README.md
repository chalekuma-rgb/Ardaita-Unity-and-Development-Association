# Ardaita Unity and Development Association (AUDA)

Official web application of the **Ardaita Unity and Development Association**, built with [Flutter Web](https://flutter.dev).

## Live Site

The application is deployed and accessible at:  
**https://chalekuma-rgb.github.io/Ardaita-Unity-and-Development-Association/**

## About

AUDA is a community organisation dedicated to unity, development, and support for the Ardaita community. This website provides:

- Information about the association, its board, and objectives
- Community projects and initiatives
- Resources and gallery
- Contact and donation information

## Running Locally

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel, ≥ 3.x)
- A web browser (Chrome recommended for development)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/chalekuma-rgb/Ardaita-Unity-and-Development-Association.git
cd Ardaita-Unity-and-Development-Association

# 2. Install dependencies
flutter pub get

# 3. Run on localhost
flutter run -d chrome
```

The application will open at `http://localhost:<port>` in your browser.

## Deploying to GitHub Pages

Deployment is fully automated via GitHub Actions. Any push to the `main` branch triggers the workflow defined in `.github/workflows/main.yml`, which:

1. Checks out the repository
2. Sets up the Flutter SDK
3. Installs dependencies (`flutter pub get`)
4. Builds the web app for release:
   ```bash
   flutter build web --release --base-href /Ardaita-Unity-and-Development-Association/
   ```
5. Publishes the `build/web` output to the `gh-pages` branch using [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages)

### Manual Deployment

If you need to deploy manually:

```bash
# Build the release web bundle
flutter build web --release --base-href /Ardaita-Unity-and-Development-Association/

# The output is in build/web — push it to the gh-pages branch
# (the CI workflow handles this automatically on every push to main)
```

### Enabling GitHub Pages

To enable GitHub Pages for the repository:

1. Go to **Settings → Pages** in the GitHub repository.
2. Under **Build and deployment**, set the source to **Deploy from a branch**.
3. Select the `gh-pages` branch and `/ (root)` folder.
4. Click **Save**.

After the first successful workflow run, the site will be live at  
`https://<your-github-username>.github.io/Ardaita-Unity-and-Development-Association/`.

## Project Structure

```
lib/
  main.dart          # Flutter application entry point and all UI
assets/
  Ardaita.jpg        # Organisation images
  Ardaita2.jpg
  Board_Chair_Man.jpg
  Ardaita_Amharic.pdf
web/
  index.html         # Web entry point
  manifest.json      # PWA manifest
.github/workflows/
  main.yml           # CI/CD — build & deploy to GitHub Pages
```

## Technologies

- **Flutter** (Dart) — cross-platform UI framework
- **GitHub Actions** — CI/CD pipeline
- **GitHub Pages** — static hosting
