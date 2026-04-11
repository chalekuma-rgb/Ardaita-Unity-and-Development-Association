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
};

module.exports = { config };