# Railway Deployment Guide

This guide explains how to deploy the Ardaita NGO website backend on Railway.

## Prerequisites

- GitHub account with this repository
- Railway account (sign up at [railway.app](https://railway.app))

## Quick Start

### Step 1: Connect Your Repository

1. Go to [railway.app](https://railway.app) and sign in
2. Click **"New Project"**
3. Select **"Deploy from GitHub"**
4. Connect your GitHub account if prompted
5. Select the `Ardaita-Unity-and-Development-Association` repository

### Step 2: Configure the Service

1. Railway will detect the project structure
2. Use the repository root as the Railway project root
3. Railway will automatically use the `backend/Dockerfile` for building

### Step 3: Set Environment Variables

In the Railway dashboard, add the following environment variables:

| Variable | Value | Notes |
|----------|-------|-------|
| `NODE_VERSION` | `24.14.1` | Node.js version |
| `PORT` | `3000` | Port the app runs on |
| `DATA_FILE` | `./data/submissions.json` | Where form submissions are stored |
| `ALLOWED_ORIGINS` | `https://your-domain.com,http://localhost:3000` | CORS allowed origins |
| `ADMIN_TOKEN` | (generate strong token) | For admin endpoints, use something like `head -c 32 /dev/urandom \| base64` |

### Step 4: Deploy

1. Click the **"Deploy"** button
2. Railway will build the Docker image and start the service
3. Wait for deployment to complete (usually 2-5 minutes)

### Step 5: Get Your API URL

Once deployed:
1. Go to your Railway project
2. Find the **"Domains"** section
3. Copy your public URL (e.g., `https://project-name-production.up.railway.app`)

## Connect Frontend

Update your Flutter web app to use the Railway API URL:

```dart
// In your app configuration
const String API_BASE_URL = 'https://your-railway-url.up.railway.app';
```

Or set it as an environment variable in your GitHub Actions workflow.

## Monitoring & Logs

1. In Railway dashboard, select your service
2. Click **"Logs"** tab to view real-time application logs
3. Use `curl` to test the health endpoint:

```bash
curl https://your-railway-url.up.railway.app/api/health
```

## Database/Storage

Form submissions are stored in `backend/data/submissions.json`. This file:
- Is created automatically on first submission
- Persists as long as the Railway service is running
- Is NOT backed up between deployments

For production, consider:
1. Saving to a database (MongoDB, PostgreSQL, etc.)
2. Using Railway's database addon
3. Backing up data to external storage

## Environment Variable Examples

### Development (local)
```bash
NODE_VERSION=24.14.1
PORT=3000
DATA_FILE=./data/submissions.json
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8080
ADMIN_TOKEN=dev-token-change-in-production
```

### Production (Railway)
```bash
NODE_VERSION=24.14.1
PORT=3000
DATA_FILE=./data/submissions.json
ALLOWED_ORIGINS=https://chalekuma-rgb.github.io,https://your-custom-domain.com
ADMIN_TOKEN=<generate-strong-random-token>
```

## Admin Access

To access admin endpoints with your Railway deployment:

```bash
curl -H "Authorization: Bearer YOUR_ADMIN_TOKEN" \
  https://your-railway-url.up.railway.app/api/admin/submissions
```

## Troubleshooting

### Service won't start
1. Check logs in Railway dashboard
2. Verify all environment variables are set
3. Ensure `backend/src/server.js` exists

### CORS errors
1. Update `ALLOWED_ORIGINS` to include your frontend URL
2. Clear browser cache and try again

### Health check failing
1. Check that PORT is set to `3000`
2. Verify the service has enough memory (512MB is sufficient)

### Data not persisting
1. Note that `submissions.json` resets on service restart
2. For persistent storage, migrate to a database

## Further Deployment Options

- **Database**: Add PostgreSQL or MySQL addon in Railway
- **Custom Domain**: Configure a custom domain in Railway settings
- **CI/CD**: Enable automatic deployments on Git push
- **Scaling**: Upgrade Railway plan for better resources if needed

## Support

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.railway.app
- GitHub Issues: Open an issue in the repository

---

**Last Updated**: April 2026
