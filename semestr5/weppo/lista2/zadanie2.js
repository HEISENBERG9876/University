console.log('Uzycie operatorow . oraz [] do odwolywania sie do skladowych:');
const person = {
    name: 'Jan',
}
console.log('.')
console.log(person.name);
console.log('[]')
console.log(person['name']);
console.log();

console.log('użycie argumentów innego typu niż string dla operatora [] dostępu do składowej obiektu');
console.log('Co się dzieje jeśli argumentem operatora jest liczba?');
const obj = {};
obj[1] = "jeden";
console.log(obj[1]);
console.log(obj['1']);
console.log('Co się dzieje jeśli argumentem operatora jest inny obiekt?');
obj2 = {val: 1};
obj3 = {};
obj3[obj2] = 'jakas wartosc';
console.log(obj3);
console.log();

console.log('użycie argumentów innego typu niż number dla operatora [] dostępu do tablicy');
console.log('Co się dzieje jeśli argumentem operatora jest napis?');
const arr = [1, 2, 3];
arr['aaa'] = 4;
console.log(arr);
console.log(arr['aaa'])
console.log('Co się dzieje jeśli argumentem operatora jest inny obiekt?');
const arr2 = [1, 2, 3];
arr2[obj2] = 4;
console.log(arr2);
console.log(arr2[obj2])
console.log('Czy można ustawiać wartość atrybutu length tablicy na inną wartość niż liczba elementów w tej tablicy? Co się dzieje jeśli ustawia się wartość mniejszą niż liczba elementów, a co jeśli ustawia się wartość większą niż liczba elementów?');
const arr3 = [1,2, 3];
console.log(arr3);
console.log('length = 1');
arr3.length = 1;
console.log(arr3);
console.log('length = 4');
arr3.length = 4;
console.log(arr3);
console.log(arr3.length);



