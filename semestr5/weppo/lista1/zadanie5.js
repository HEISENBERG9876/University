function fibIter(n){
    if(n == 1 || n == 2){
        return 1;
    }

    let f1 = 1;
    let f2 = 1;

    for(let i = 3; i <= n; i++){
        temp = f1;
        f1 = f2;
        f2 = temp + f2;
    }

    return f2;
}

function fibRek(n){
    if(n == 1 || n == 2){
        return 1;
    }
    else{
        return fibRek(n-1) + fibRek(n-2);
    }
}


function fibDynamic(n, memo = {}){
    if(n in memo){
        return memo[n];
    }

    if(n == 1 || n == 2){
        return 1;
    }

    let result = fibDynamic(n-1, memo) + fibDynamic(n-2, memo);
    memo[n] = result;

    return result;
}


function printTable(n){
    for(let i = 10; i <= 40; i++){
        console.time('Dynamic');
        fibDynamic(i);
        console.timeEnd('Dynamic');

        console.time('Rek');
        fibRek(i);
        console.timeEnd('Rek')
    }
}


printTable(40);