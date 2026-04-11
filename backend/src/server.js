const { app } = require('./app');
const { config } = require('./config');

app.listen(config.port, () => {
  console.log(`NGO backend listening on port ${config.port}`);
});