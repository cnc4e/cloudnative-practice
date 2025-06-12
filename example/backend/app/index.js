const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT;

app.use(cors());

app.get('/api/message', (req, res) => {
  res.json({ message: 'こんにちは、フロントエンドさん！imageupdater' });
});

app.listen(PORT, () => {
  console.log(`Backend listening on port ${PORT}`);
});