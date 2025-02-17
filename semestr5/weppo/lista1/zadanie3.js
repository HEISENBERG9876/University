function isDivisible(x, y){
    return (x % y == 0);
}


function isPrime(x){
    for(let i = 2; i<x; i++){
        if (isDivisible(x, i)){
            return false;
        }
    }
    return true;
}

function getPrimeSet(){
    const result = [];
    for(let i = 2; i <= 100000; i++){
        if(isPrime(i)){
            result.push(i);
        }
    }

    return result;
}

console.log(getPrimeSet());