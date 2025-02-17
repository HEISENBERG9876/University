function fib(n: number): number {
    if (n <= 1) {
        return n;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}

function memoize(fn: (n: number) => number): (n: number) => number {
    const cache: { [key: number]: number } = {};
    return function(n: number): number {
        if (n in cache) {
            return cache[n];
        } else {
            const result = fn(n);
            cache[n] = result;
            return result;
        }
    };
}

const memofib = memoize(fib);

console.log(memofib(10));
console.log(memofib(10));
