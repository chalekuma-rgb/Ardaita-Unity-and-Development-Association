const path = require('path');

const projectRoot = path.resolve(__dirname, '..');

const parseOrigins = (value) =>
  String(value || '')
    .split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);

const config = {
  port: Number.parseInt(process.env.PORT || '3000', 10),
  allowedOrigins: parseOrigins(process.env.ALLOWED_ORIGINS),
  adminToken: String(process.env.ADMIN_TOKEN || '').trim(),
  dataFile: path.resolve(
    projectRoot,
    process.env.DATA_FILE || './data/submissions.json',
  ),
  email: {
    enabled: process.env.SMTP_HOST ? true : false,
    host: String(process.env.SMTP_HOST || '').trim(),
    port: Number.parseInt(process.env.SMTP_PORT || '587', 10),
    secure: process.env.SMTP_SECURE === 'true',
    auth: {
      user: String(process.env.SMTP_USER || '').trim(),
      pass: String(process.env.SMTP_PASS || '').trim(),
    },
    from: String(process.env.EMAIL_FROM || 'noreply@ardaitaunity.org').trim(),
    to: String(process.env.EMAIL_TO || 'kumachale@gmail.com').trim(),
  },
};

module.exports = { config };