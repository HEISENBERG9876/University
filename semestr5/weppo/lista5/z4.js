const fs = require('fs').promises;

const filePath = 'plik.txt';

fs.readFile(filePath, 'utf8')
  .then((data) => {
    console.log(data);
  })
  .catch((err) => {
    console.error('Błąd podczas odczytu:', err);
  });
