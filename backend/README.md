# Kecho Backend

This directory contains a simple Express backend for the Ardaita website.

## Features

- `GET /api/health`
- `POST /api/contact`
- `POST /api/volunteer`
- `GET /api/contact` with admin token
- `GET /api/volunteer` with admin token
- `GET /api/admin/contact` with admin token
- `GET /api/admin/volunteer` with admin token
- `GET /api/admin/submissions` with admin token

## Setup

1. Install Node.js 20 or newer.
2. Copy `.env.example` to `.env` if you want custom values.
3. Run `npm install`.
4. Run `npm start`.

## Render Deployment

This repository includes a root-level [render.yaml](../render.yaml) blueprint for deploying the backend on Render.

Expected production values:

- `ALLOWED_ORIGINS=https://chalekuma-rgb.github.io`
- generated `ADMIN_TOKEN`
- `DATA_FILE=./data/submissions.json`

After the Render service is created, copy its public URL into the GitHub repository secret `PRODUCTION_API_BASE_URL` so the production Flutter build can call the live backend.

## Storage

Submitted data is written to `backend/data/submissions.json`.

That file is ignored by git so local form submissions do not pollute the repository.

## CORS

Set `ALLOWED_ORIGINS` to a comma-separated list of allowed frontend URLs.

Example:

```bash
ALLOWED_ORIGINS=http://localhost:3000,https://chalekuma-rgb.github.io
```

## Admin Access

Set `ADMIN_TOKEN` in the backend environment and send it in either:

- `Authorization: Bearer <token>`
- `x-admin-token: <token>`

Example:

```bash
curl -H "Authorization: Bearer replace-with-a-long-random-secret" http://localhost:3000/api/admin/submissions
```