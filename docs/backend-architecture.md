# Backend Architecture

## Overview

This site should stay split into two layers:

- Flutter web frontend in this repository
- API and persistence layer exposed over HTTPS

GitHub Pages can only host the compiled Flutter web app, so all server-side processing must live outside GitHub Pages.

## Recommended Architecture For This Site

### Frontend

- Flutter web app
- Static hosting on GitHub Pages for public pages
- Form submissions sent to a backend API with JSON payloads
- Optional Firebase Firestore mirroring for lightweight analytics and admin review

### Backend API

- Node.js with Express
- REST endpoints for contact and volunteer submissions
- Validation and sanitization at the API boundary
- CORS restricted to the production site origin and localhost during development

### Data Storage

- Primary option for this simple starter: JSON file storage in the backend project
- Recommended production upgrade: PostgreSQL
- Optional secondary store: Firebase Firestore for low-friction cloud storage and admin inspection

## Request Flow

1. Visitor submits a form in the Flutter app.
2. Flutter validates the form locally.
3. Flutter sends the payload to the REST API.
4. The Node backend validates the payload again.
5. The backend stores the record and returns a JSON response.
6. If Firebase sync is enabled in Flutter, the app also writes a copy to Firestore.

## API Surface

### Health

- `GET /api/health`

### Contact Form

- `POST /api/contact`
- `GET /api/contact`

Payload:

```json
{
  "fullName": "Jane Doe",
  "email": "jane@example.com",
  "message": "I would like to learn more about your work."
}
```

### Volunteer Form

- `POST /api/volunteer`
- `GET /api/volunteer`

Payload:

```json
{
  "fullName": "Jane Doe",
  "email": "jane@example.com",
  "initiative": "Education",
  "motivation": "I want to support literacy programs."
}
```

## Firebase Role In This Repo

Firebase is integrated as an optional secondary backend path:

- `firebase_core` initializes Firebase when runtime config is provided
- `cloud_firestore` stores `contactMessages` and `volunteerApplications`
- Firebase is disabled by default so the app still runs without secret values

This keeps the project deployable without blocking on Firebase project creation while still supporting Firebase-backed submissions when configured.

## Production Recommendations

- Move the Node backend to Render, Railway, Azure App Service, or Cloud Run
- Replace JSON file storage with PostgreSQL
- Add admin authentication before exposing list endpoints publicly
- Add rate limiting, CAPTCHA, and email notifications for form submissions
- Keep Firebase as optional telemetry or a lightweight admin dashboard source

## Environment Configuration

### Flutter

Use `--dart-define` values:

- `API_BASE_URL`
- `ENABLE_FIREBASE_SYNC`
- `FIREBASE_API_KEY`
- `FIREBASE_APP_ID`
- `FIREBASE_MESSAGING_SENDER_ID`
- `FIREBASE_PROJECT_ID`
- `FIREBASE_AUTH_DOMAIN`
- `FIREBASE_STORAGE_BUCKET`
- `FIREBASE_MEASUREMENT_ID`

### Node Backend

Use environment variables:

- `PORT`
- `ALLOWED_ORIGINS`
- `DATA_FILE`

## Deployment Model

- `main` keeps the Flutter source and tracked `build/web` output
- `gh-pages` serves the built Flutter app
- the backend is deployed separately and called from the frontend by URL

## Production Host Wiring

The repository is prepared for a Render deployment via [render.yaml](../render.yaml).

The GitHub Pages workflow reads `PRODUCTION_API_BASE_URL` from repository secrets and injects it into the Flutter production build with `--dart-define=API_BASE_URL=...`.

If `RENDER_DEPLOY_HOOK_URL` is configured as a repository secret, the same workflow can also trigger a Render redeploy after pushes to `main`.