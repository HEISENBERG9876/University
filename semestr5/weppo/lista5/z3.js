const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const randomNumber = Math.floor(Math.random() * 101);

const askQuestion = () => {
  rl.question('Podaj liczbę od 0 do 100: ', (input) => {
    const userNumber = parseInt(input, 10);

    if (userNumber === randomNumber) {
      console.log('To jest właśnie ta liczba!');
      rl.close();
    } 
    else if (userNumber < randomNumber) {
      console.log('Moja liczba jest większa!');
      askQuestion();
    } 
    else if (userNumber > randomNumber) {
      console.log('Moja liczba jest mniejsza!');
      askQuestion();
    } 
    else {
      console.log('Nie podałeś prawidłowej liczby. Spróbuj ponownie.');
      askQuestion();
    }
  });
};

askQuestion();
