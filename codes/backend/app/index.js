const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors());

app.get('/api/message', (req, res) => {
  res.json({ message: 'こんにちは、フロントエンドさん！CIでビルドされました。' });
});

app.listen(PORT, () => {
  console.log(`Backend listening on port ${PORT}`);
}); 