function* take(it, max) {
    let count = 0;
    while (count < max) {
        let result = it.next();
        if (result.done) return;
        yield result.value;
        count++;
    }
}



function fib() {
    let a = 1, b = 1;
    return {
        next: function() {
            let value = a;
            a = b;
            b = value + b;
            return {
                value: value,
                done: false
            };
        }
    };
}


for (let num of take( fib(), 10 ) ) {
    console.log(num);
}
    

function* fib() {
    let a = 1, b = 1;
    while (true) {
        yield a;
        let value = a;
        a = b;
        b = value + b;
    }
}


for (let num of take( fib(), 10 ) ) {
    console.log(num);
}