const express = require('express');
const app = express();
app.use(express.json());

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Other routes for users, bands, rehearsals, attendance etc

module.exports = app;