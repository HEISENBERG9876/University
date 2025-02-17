const fs = require('fs');

//callback
fs.readFile('plik.txt', 'utf8', (err, data) => {
    if (err) {
        console.error('ERROR (CALLBACK):', err);
    } else {
        console.log('CALLBACK RESULT:', data);
    }
});


//funkcja zwracajaca promise
function readFilePromise(filePath, encoding) {
    return new Promise((resolve, reject) => {
        fs.readFile(filePath, encoding, (err, data) => {
            if (err) {
                reject(err);
            } else {
                resolve(data);
            }
        });
    });
}

readFilePromise('plik.txt', 'utf8')
    .then(data => console.log('MANUAL PROMISE:', data))
    .catch(err => console.error('ERROR (MANUAL PROMISE):', err));


//promisify
const util = require('util');
const readFileAsync = util.promisify(fs.readFile);

readFileAsync('plik.txt', 'utf8')
    .then(data => console.log('PROMISIFY:', data))
    .catch(err => console.error('ERROR (PROMISIFY):', err));


//fs promises
const { promises: fsPromises } = require('fs');


fsPromises.readFile('plik.txt', 'utf8')
    .then(data => console.log('FS PROMISES:', data))
    .catch(err => console.error('ERROR (FS PROMISES):', err));


//po staremu
fsPromises.readFile('plik.txt', 'utf8')
    .then(data => console.log('PROMISE::THEN:', data))
    .catch(err => console.error('EROR (PROMISE::THEN):', err));

//po nowemu
(async function readFileWithAsyncAwait() {
    try {
        const data = await fsPromises.readFile('plik.txt', 'utf8');
        console.log('ASYNC/AWAIT:', data);
    } catch (err) {
        console.error('ERROR (ASYNC/AWAIT):', err);
    }
})();