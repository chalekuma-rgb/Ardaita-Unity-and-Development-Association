# Supabase Integration Guide

This project is now integrated with Supabase as the backend for form submissions and volunteer applications.

## Supabase Project Details

- **API URL**: `https://qkvroehsycfvrlfclskp.supabase.co/rest/v1`
- **Project Reference**: `qkvroehsycfvrlfclskp`

## How It Works

The Flutter web application sends form submissions to the Supabase REST API instead of a separate backend server. This includes:

- **Contact Form Submissions** → `/api/contact`
- **Volunteer Applications** → `/api/volunteer`

## Running Locally

To test with Supabase locally, run:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=https://qkvroehsycfvrlfclskp.supabase.co/rest/v1
```

## Production Deployment

The GitHub Actions workflow automatically uses the Supabase API URL when building for production. The workflow:

1. Reads `PRODUCTION_API_BASE_URL` from GitHub Secrets
2. If not set, defaults to the Supabase URL
3. Injects it into the Flutter build with `--dart-define=API_BASE_URL=...`

### To Use a Custom API URL

Add `PRODUCTION_API_BASE_URL` to GitHub Secrets:

1. Go to your repository **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Name: `PRODUCTION_API_BASE_URL`
4. Value: Your custom API URL (e.g., a Railway/Render URL)
5. Click **Add secret**

On the next push to `main`, the workflow will use your custom URL.

## Supabase Database Schema

Your Supabase project should have the following tables:

### `contact` table
```sql
CREATE TABLE contact (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fullName TEXT NOT NULL,
  email TEXT NOT NULL,
  message TEXT NOT NULL,
  createdAt TIMESTAMP DEFAULT NOW()
);
```

### `volunteer` table
```sql
CREATE TABLE volunteer (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fullName TEXT NOT NULL,
  email TEXT NOT NULL,
  initiative TEXT NOT NULL,
  motivation TEXT NOT NULL,
  createdAt TIMESTAMP DEFAULT NOW()
);
```

## API Endpoints

### Contact Form
- **Endpoint**: `POST /api/contact`
- **Body**:
```json
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "message": "Your message here"
}
```

### Volunteer Application
- **Endpoint**: `POST /api/volunteer`
- **Body**:
```json
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "initiative": "Education",
  "motivation": "Your motivation here"
}
```

## Environment Variables

When deploying the backend separately, set:

- `API_BASE_URL`: The Supabase REST API URL

## Troubleshooting

### Submissions not appearing in Supabase
1. Verify the API URL is correct
2. Check browser console for network errors (F12 → Network tab)
3. Ensure Supabase tables exist with correct schema
4. Check Supabase project is active and not rate-limited

### API Connection Errors
- Ensure the Supabase project is running
- Check CORS settings in Supabase
- Verify `PRODUCTION_API_BASE_URL` is set correctly in GitHub Secrets

## Email Notifications

Volunteer and contact submissions can be sent to an email address using the optional email service. See [backend email configuration](./backend/src/mail.js) for setup instructions.

For Gmail, use:
```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-gmail@gmail.com
SMTP_PASS=your-app-password
EMAIL_TO=kumachale@gmail.com
```

## Support

For issues with Supabase integration, check:
- [Supabase Documentation](https://supabase.com/docs)
- [Supabase REST API Reference](https://supabase.com/docs/guides/api)
