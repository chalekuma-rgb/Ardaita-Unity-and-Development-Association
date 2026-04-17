# GitHub Actions Setup for Railway Deployment

This guide explains how to set up GitHub Actions to automatically deploy the backend to Railway on every push to `main`.

## Prerequisites

- Railway account with backend service deployed
- GitHub repository with this code
- Administrator access to the repository settings

## Getting Your Railway Webhook URL

1. Log in to [railway.app](https://railway.app)
2. Select your Ardaita project
3. Go to the backend service settings
4. Look for **"Webhooks"** or **"Deploy Hooks"** section
5. Create a new webhook and copy the URL

## Setting GitHub Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **"New repository secret"** and add:

### Required Secrets:

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `PRODUCTION_API_BASE_URL` | `https://your-railway-url.up.railway.app` | Railway backend URL |
| `RAILWAY_DEPLOY_HOOK_URL` | (Railway webhook URL) | For automatic Railway deployments |

### Optional Secrets:

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `RENDER_DEPLOY_HOOK_URL` | (Render webhook URL) | Only if still using Render |

## How It Works

When you push to `main`:

1. GitHub Actions builds the Flutter web app
2. Builds it with `PRODUCTION_API_BASE_URL` from secrets
3. Deploys the web frontend to GitHub Pages
4. **Triggers Railway webhook** to redeploy the backend
5. The backend restarts with latest code (if any changes)

## Troubleshooting

### Deployment not triggering
- Verify `RAILWAY_DEPLOY_HOOK_URL` is set correctly in GitHub Secrets
- Check the Actions tab in GitHub for error logs

### API not connecting
- Verify `PRODUCTION_API_BASE_URL` matches your Railway service URL
- Check CORS settings in Railway environment variables
- Ensure `ALLOWED_ORIGINS` includes your GitHub Pages URL

### Webhook not working
- Test the webhook manually: `curl -X POST "YOUR_WEBHOOK_URL"`
- Check Railway service logs for errors

## Manual Trigger

To manually trigger Railway deployment without pushing code:

```bash
curl -X POST "https://your-railway-url.up.railway.app/api/health"
```

Or use Railway CLI:
```bash
railway up
```

---

**Documentation**: See [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md) for full Railway setup instructions.
