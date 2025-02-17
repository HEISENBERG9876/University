function createGenerator() {
    var _state = 0;
    return {
        next : function() {
            return {
            value : _state,
            done : _state++ >= 10
            }
        }
    }
}


function createGenerator2(k) {
    var _state = 0;
    return {
        next : function() {
            return {
            value : _state,
            done : _state++ >= k
            }
        }
    }
}


var foo1 = {
    [Symbol.iterator] : function(){
        return createGenerator2(5)
    }
};

for ( var f of foo1 )
    console.log(f)


var foo2 = {
    [Symbol.iterator] : function(){
        return createGenerator2(12)
    }
};

for ( var f of foo2 )
    console.log(f)