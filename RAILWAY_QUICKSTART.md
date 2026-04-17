# Railway Deployment Quick Reference

## 5-Minute Setup

### Step 1: Go to Railway
Visit [railway.app](https://railway.app) → Sign in → New Project

### Step 2: Connect Repository
- Select "Deploy from GitHub"
- Choose `Ardaita-Unity-and-Development-Association`

### Step 3: Configure
In Railway Dashboard:
1. Use the **Repository Root** as the project root
2. Add **Environment Variables**:
   ```
   NODE_VERSION=24.14.1
   PORT=3000
   DATA_FILE=./data/submissions.json
   ALLOWED_ORIGINS=https://your-domain.com,http://localhost:3000
   ADMIN_TOKEN=<generate-random-token>
   ```

### Step 4: Deploy
Click **Deploy** button

### Step 5: Get URL
- Copy public URL from Domains section
- Add to GitHub Secrets as `PRODUCTION_API_BASE_URL`

## File Reference

| File | Location | Purpose |
|------|----------|---------|
| Dockerfile | `backend/Dockerfile` | Docker build config |
| Procfile | `backend/Procfile` | Process startup config |
| railway.json | root | Railway config |
| railway.toml | root | Railway build settings |

## Useful Commands

```bash
# Check backend health
curl https://your-railway-url.railway.app/api/health

# Test contact form
curl -X POST https://your-railway-url.railway.app/api/contact \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","email":"test@test.com","message":"Hi"}'

# Admin access
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://your-railway-url.railway.app/api/admin/submissions
```

## Environment Variables Explained

| Variable | Example | Notes |
|----------|---------|-------|
| `NODE_VERSION` | `24.14.1` | Must be 20+ |
| `PORT` | `3000` | Keep as is |
| `ALLOWED_ORIGINS` | `https://domain.com` | Add your frontend URL |
| `ADMIN_TOKEN` | 32+ char random string | Generate with: `openssl rand -base64 32` |
| `DATA_FILE` | `./data/submissions.json` | Keep as is |

## Documentation

- **Full Setup**: [RAILWAY_DEPLOYMENT.md](RAILWAY_DEPLOYMENT.md)
- **Deployment Overview**: [DEPLOYMENT_OVERVIEW.md](DEPLOYMENT_OVERVIEW.md)
- **GitHub Actions**: [GITHUB_ACTIONS_SETUP.md](GITHUB_ACTIONS_SETUP.md)
- **Backend**: [backend/README.md](backend/README.md)

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Build fails | Check Node version, verify `backend/package.json` |
| CORS error | Update `ALLOWED_ORIGINS` to include frontend URL |
| API not connecting | Verify `PRODUCTION_API_BASE_URL` in GitHub Secrets |
| No deployment trigger | Check GitHub Actions logs, verify webhook setup |

## Next Steps

1. ✅ Deploy backend to Railway
2. ✅ Get Railway URL
3. ✅ Add to `PRODUCTION_API_BASE_URL` GitHub Secret
4. ✅ (Optional) Add `RAILWAY_DEPLOY_HOOK_URL` for auto-deployment
5. ✅ Push to `main` to trigger GitHub Actions
6. ✅ Frontend deploys to GitHub Pages with Railway backend configured

---

**Status**: ✅ Ready for Railway deployment  
**Frontend**: GitHub Pages  
**Backend**: Railway  
**CI/CD**: GitHub Actions
