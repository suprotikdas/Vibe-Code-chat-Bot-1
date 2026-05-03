const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 8080;

// Serve all built web assets
app.use(express.static(path.join(__dirname, 'build/web')));

// Fallback for Flutter's single-page app routing
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build/web', 'index.html'));
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Server is running on port ${port}`);
});
