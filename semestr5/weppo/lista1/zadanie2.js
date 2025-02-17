function isSatisfying(x){
    let digits = x.toString();
    let sum = 0;
    for(let digit of digits){
        digit = parseInt(digit);
        sum += digit;
        if(digit == 0 || x % digit != 0){
            return false;
        }
    }
    return (x % sum == 0);
}


function getSet(){
    const result = []
    for(let i = 1; i <= 100000; i++){
        if(isSatisfying(i)){
            result.push(i);
        }
    }
    return result;
}

console.log(getSet());