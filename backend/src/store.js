const fs = require('fs/promises');
const crypto = require('crypto');
const path = require('path');

class SubmissionStore {
  constructor(filePath) {
    this.filePath = filePath;
  }

  async ensureFile() {
    const directory = path.dirname(this.filePath);
    await fs.mkdir(directory, { recursive: true });

    try {
      await fs.access(this.filePath);
    } catch {
      await this.write({ contact: [], volunteer: [] });
    }
  }

  async read() {
    await this.ensureFile();
    const raw = await fs.readFile(this.filePath, 'utf8');
    return JSON.parse(raw);
  }

  async write(data) {
    await fs.writeFile(this.filePath, JSON.stringify(data, null, 2), 'utf8');
  }

  async append(collection, payload) {
    const data = await this.read();
    const record = {
      id: crypto.randomUUID(),
      createdAt: new Date().toISOString(),
      ...payload,
    };

    data[collection].push(record);
    await this.write(data);
    return record;
  }

  async list(collection) {
    const data = await this.read();
    return data[collection];
  }
}

module.exports = { SubmissionStore };