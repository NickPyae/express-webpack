import express from 'express';
import myMod from './myMod';

const app = express();

app.get('*', (req, res) => {
  res.json({
    myMod,
  });
});

const PORT = process.env.PORT || 9000;

app.listen(PORT, () => {
  console.log(`App listening to ${PORT}....`);
  console.log('Press Ctrl+C to quit.');
});
