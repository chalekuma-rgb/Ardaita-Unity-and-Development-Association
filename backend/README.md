# NGO Backend

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

## Railway Deployment

To deploy on Railway:

1. **Connect Repository**: Link your GitHub repository to Railway at [railway.app](https://railway.app)
2. **Create New Project**: Select "Deploy from GitHub"
3. **Select Repository**: Choose this repository
4. **Configure Settings**:
   - Use the repository root as the Railway project root
   - Railway will use `railway.toml` and `railway.json` from the repository root
   - The Dockerfile is located at `backend/Dockerfile`

6. **Set Environment Variables** in Railway Dashboard:
   - `NODE_VERSION=24.14.1`
   - `PORT=3000`
   - `DATA_FILE=./data/submissions.json`
   - `ALLOWED_ORIGINS=https://your-frontend-url.com,http://localhost:3000`
   - `ADMIN_TOKEN` (generate a strong random token)

6. **Deploy**: Railway will build and deploy automatically

After deployment, Railway will provide a public URL. Update your frontend configuration with this URL as the `API_BASE_URL`.

For more information, visit [Railway Documentation](https://docs.railway.app).

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