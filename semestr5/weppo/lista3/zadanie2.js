function forEach(a, f){
    for (let i = 0; i < a.length; i++) {
        f(a[i], i, a);
    }
}

function map(a, f){
    const result = [];
    for (let i = 0; i < a.length; i++){
        result.push(f(a[i], i , a));
    }
    return result;
}

function filter(a, f){
    const result = [];
    for(let i = 0; i < a.length; i++){
        let x = f(a[i], a, i);
        if (x){
            result.push(a[i]);
        }
    }
    return result;
}

const a = [1, 2, 3, 4, 5];

console.log("ForEach");
forEach(a, x => console.log(x));
forEach(a, function(x) {console.log(x)});


console.log("map");
console.log(map(a, x => x * 2));
console.log(map(a, function(x) {return x * 2}));

console.log("filter");
console.log(filter(a, x => x % 2 == 0));
console.log(filter(a, function(x)  {return x % 2 == 0}));


forEach(a, (x, i, arr) => {
    console.log(`item: ${x}, index: ${i}, a: ${arr}`);
});