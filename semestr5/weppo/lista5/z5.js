const https = require('https');

function fetchContent(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (response) => {
      let data = '';

      response.on('data', (chunk) => {
        data += chunk;
      });

      response.on('end', () => {
        resolve(data);
      });

      response.on('error', (err) => {
        reject(err);
      });
    });
  });
}


const url = 'https://lipsum.com';

fetchContent(url)
  .then((data) => {
    console.log('Zawartość strony:', data);
  })
  .catch((err) => {
    console.error('Błąd podczas pobierania strony:', err);
  });
