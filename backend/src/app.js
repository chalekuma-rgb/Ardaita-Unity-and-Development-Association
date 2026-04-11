const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const { config } = require('./config');
const { SubmissionStore } = require('./store');
const {
  validateContactPayload,
  validateVolunteerPayload,
} = require('./validation');

const store = new SubmissionStore(config.dataFile);

const app = express();

const parseLimit = (value) => {
  const parsed = Number.parseInt(String(value || '50'), 10);
  if (Number.isNaN(parsed) || parsed <= 0) {
    return 50;
  }

  return Math.min(parsed, 200);
};

const requireAdmin = (request, response, next) => {
  if (!config.adminToken) {
    response.status(503).json({
      ok: false,
      error: 'ADMIN_TOKEN is not configured on the server.',
    });
    return;
  }

  const authHeader = request.get('authorization') || '';
  const bearerToken = authHeader.startsWith('Bearer ')
    ? authHeader.slice('Bearer '.length).trim()
    : '';
  const headerToken = (request.get('x-admin-token') || '').trim();
  const token = bearerToken || headerToken;

  if (token !== config.adminToken) {
    response.status(401).json({
      ok: false,
      error: 'Admin authorization is required.',
    });
    return;
  }

  next();
};

const buildCollectionResponse = (items, limit) => {
  const sorted = [...items].sort((left, right) =>
    right.createdAt.localeCompare(left.createdAt),
  );
  return {
    items: sorted.slice(0, limit),
    total: sorted.length,
    limit,
  };
};

app.use(helmet());
app.use(
  cors({
    origin(origin, callback) {
      if (!origin || config.allowedOrigins.length === 0) {
        callback(null, true);
        return;
      }

      if (config.allowedOrigins.includes(origin)) {
        callback(null, true);
        return;
      }

      callback(new Error(`Origin ${origin} is not allowed by CORS.`));
    },
  }),
);
app.use(express.json({ limit: '1mb' }));

app.get('/api/health', async (_request, response) => {
  await store.ensureFile();
  response.json({
    ok: true,
    service: 'kecho-backend',
    adminConfigured: config.adminToken.length > 0,
  });
});

app.get('/api/contact', requireAdmin, async (request, response, next) => {
  try {
    const records = await store.list('contact');
    response.json(buildCollectionResponse(records, parseLimit(request.query.limit)));
  } catch (error) {
    next(error);
  }
});

app.post('/api/contact', async (request, response, next) => {
  try {
    const result = validateContactPayload(request.body || {});

    if (!result.isValid) {
      response.status(400).json({ ok: false, errors: result.errors });
      return;
    }

    const record = await store.append('contact', result.data);
    response.status(201).json({ ok: true, item: record });
  } catch (error) {
    next(error);
  }
});

app.get('/api/volunteer', requireAdmin, async (request, response, next) => {
  try {
    const records = await store.list('volunteer');
    response.json(buildCollectionResponse(records, parseLimit(request.query.limit)));
  } catch (error) {
    next(error);
  }
});

app.post('/api/volunteer', async (request, response, next) => {
  try {
    const result = validateVolunteerPayload(request.body || {});

    if (!result.isValid) {
      response.status(400).json({ ok: false, errors: result.errors });
      return;
    }

    const record = await store.append('volunteer', result.data);
    response.status(201).json({ ok: true, item: record });
  } catch (error) {
    next(error);
  }
});

app.get('/api/admin/submissions', requireAdmin, async (request, response, next) => {
  try {
    const limit = parseLimit(request.query.limit);
    const [contact, volunteer] = await Promise.all([
      store.list('contact'),
      store.list('volunteer'),
    ]);

    response.json({
      contact: buildCollectionResponse(contact, limit),
      volunteer: buildCollectionResponse(volunteer, limit),
    });
  } catch (error) {
    next(error);
  }
});

app.get('/api/admin/contact', requireAdmin, async (request, response, next) => {
  try {
    const records = await store.list('contact');
    response.json(buildCollectionResponse(records, parseLimit(request.query.limit)));
  } catch (error) {
    next(error);
  }
});

app.get(
  '/api/admin/volunteer',
  requireAdmin,
  async (request, response, next) => {
    try {
      const records = await store.list('volunteer');
      response.json(
        buildCollectionResponse(records, parseLimit(request.query.limit)),
      );
    } catch (error) {
      next(error);
    }
  },
);

app.use((error, _request, response, _next) => {
  const statusCode = error.message?.includes('CORS') ? 403 : 500;
  response.status(statusCode).json({
    ok: false,
    error: error.message || 'Unexpected server error.',
  });
});

module.exports = { app };