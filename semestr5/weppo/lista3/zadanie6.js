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

console.log('AAAAAAAAA');
for (var i of fib()) {
    console.log(i);
    if (i > 100) break;
}
console.log('AAAAAAAAA');


var _it = fib();
for (var _result; _result = _it.next(), !_result.done;) {
    console.log(_result.value);
    if (_result.value > 100) break;
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

var _it = fib();


console.log('AAAAAAAAA');
for (var i of fib()) {
    console.log(i);
    if (i > 100) break;
}
console.log('AAAAAAAAA');

for (var _result; _result = _it.next(), !_result.done;) {
    console.log(_result.value);
    if (_result.value > 100) break;
}

