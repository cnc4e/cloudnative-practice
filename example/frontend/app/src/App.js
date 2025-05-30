import React, { useEffect, useState } from 'react';

function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('/api/message')
      .then(res => res.json())
      .then(data => setMessage(data.message));
  }, []);

  return (
    <div style={{ textAlign: 'center', marginTop: '3em' }}>
      <h1>フロントエンドからのメッセージ</h1>
      <p>{message}</p>
    </div>
  );
}

export default App; 