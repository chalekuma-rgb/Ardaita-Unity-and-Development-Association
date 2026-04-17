# Deployment Overview

This project has been configured for deployment on **Railway**. This document provides a quick reference for all deployment options.

## Quick Start

### Deploying to Railway

1. **Read**: [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md) - Complete setup guide
2. **Configure**: Set environment variables in Railway dashboard
3. **Deploy**: Push to `main` branch (or manually trigger in Railway)
4. **Update**: Add Railway URL to GitHub Secrets as `PRODUCTION_API_BASE_URL`

### Automatic Deployments

GitHub Actions automatically:
- Builds Flutter web app on every push to `main`
- Deploys web frontend to GitHub Pages
- Triggers Railway backend redeployment (if webhook configured)

See [GITHUB_ACTIONS_SETUP.md](./GITHUB_ACTIONS_SETUP.md) for setup instructions.

## Deployment Files

| File | Purpose |
|------|---------|
| `railway.json` | Railway project configuration |
| `railway.toml` | Railway build settings |
| `backend/Dockerfile` | Docker configuration for Railway |
| `backend/Procfile` | Process file for Railway |
| `.railwayignore` | Files to exclude from Railway deployment |
| `.github/workflows/main.yml` | CI/CD pipeline |

## Architecture

```
┌─────────────────────────────────────┐
│   GitHub Pages (Frontend)           │
│   - Flutter Web App                 │
│   - Hosted at GitHub Pages          │
└──────────────────┬──────────────────┘
                   │ HTTP Requests
                   ↓
┌─────────────────────────────────────┐
│   Railway (Backend API)             │
│   - Node.js/Express                 │
│   - Form submissions endpoint       │
│   - Admin endpoint                  │
└─────────────────────────────────────┘
```

## Environment Variables

### Frontend (GitHub Actions Secrets)

```
PRODUCTION_API_BASE_URL=https://your-railway-app.railway.app
```

### Backend (Railway Environment)

```
NODE_VERSION=24.14.1
PORT=3000
DATA_FILE=./data/submissions.json
ALLOWED_ORIGINS=https://chalekuma-rgb.github.io,http://localhost:3000
ADMIN_TOKEN=<strong-random-token>
```

## Step-by-Step Deployment

### 1. Deploy Backend to Railway

```bash
# Prerequisites: Node.js 24.14.1+, Railway CLI

# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Deploy
railway up
```

Or use Railway Dashboard:
1. Go to [railway.app](https://railway.app)
2. Create new project
3. Connect GitHub repo
4. Use the repository root as the Railway project root
5. Add environment variables
6. Deploy

### 2. Get Railway URL

From Railway Dashboard:
- Find your backend service
- Go to "Settings" → "Domain"
- Copy the public URL

Example: `https://project-name.railway.app`

### 3. Update GitHub Secrets

In GitHub repository settings:

```
PRODUCTION_API_BASE_URL = https://project-name.railway.app
```

### 4. Set Webhook for Auto-Deploy (Optional)

In GitHub repository settings:

```
RAILWAY_DEPLOY_HOOK_URL = <railway-webhook-url>
```

### 5. Deploy Frontend

```bash
git push main
```

This triggers GitHub Actions which:
- Builds Flutter web app
- Deploys to GitHub Pages
- Triggers Railway backend redeploy

## Testing Your Deployment

### Check Backend Health

```bash
curl https://your-railway-url.railway.app/api/health
```

Expected response: `{"status":"ok"}`

### Submit a Test Form

```bash
curl -X POST https://your-railway-url.railway.app/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "message": "Test message"
  }'
```

### Access Admin Endpoints

```bash
curl -H "Authorization: Bearer YOUR_ADMIN_TOKEN" \
  https://your-railway-url.railway.app/api/admin/submissions
```

## Monitoring

### Railway Dashboard
- View logs in real-time
- Monitor resource usage
- Check deployment status
- Manage environment variables

### GitHub Actions
- View build/deploy logs
- Check for failures
- Manually trigger deployments

## Troubleshooting

### Common Issues

**1. Build fails on Railway**
- Check backend logs in Railway Dashboard
- Ensure Node.js version is 24.14.1+
- Verify `backend/package.json` is valid

**2. API calls return CORS error**
- Update `ALLOWED_ORIGINS` to include frontend URL
- Restart Railway service

**3. Submissions not saving**
- Check `DATA_FILE` environment variable
- Verify `/backend/data` directory exists
- Check Railway service logs

**4. Admin endpoints unauthorized**
- Verify `ADMIN_TOKEN` is set
- Check token format in Authorization header
- Ensure token matches environment variable

## Resources

- [Railway Documentation](https://docs.railway.app)
- [Express.js Docs](https://expressjs.com)
- [Flutter Web Docs](https://flutter.dev/web)
- [GitHub Actions Docs](https://docs.github.com/actions)

## Support

For issues or questions:
1. Check the relevant documentation file
2. Review Railway/GitHub logs
3. Open an issue on GitHub repository

---

**Last Updated**: April 2026
**Deployment Platform**: Railway
**Frontend Hosting**: GitHub Pages
