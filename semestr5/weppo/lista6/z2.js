function fib(n) {
    if (n <= 1) {
        return n;
    }
    else {
        return fib(n - 1) + fib(n - 2);
    }
}
function memoize(fn) {
    var cache = {};
    return function (n) {
        if (n in cache) {
            return cache[n];
        }
        else {
            var result = fn(n);
            cache[n] = result;
            return result;
        }
    };
}
var memofib = memoize(fib);
console.log(memofib(10));
console.log(memofib(10));
