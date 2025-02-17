const cat = {
    name: 'Stefan',

    meow() {
        console.log('meow');
    },

    get getName() {
        return this.name;
    },

    set setName(newName) {
        this.name = newName;
    }
};


const dog = {};
dog.name = 'Tofik'
dog.bark = function(){
    console.log('hau hau');
}

Object.defineProperty(dog, 'getName', {
    get: function() {
        return this.name;
    }
});

Object.defineProperty(dog, 'setName', {
    set: function(newName) {
        this.name = newName;
    }
});

//gettery i settery musza byc uzywane z defineProperty, bez tego trzeba uzywac nawiasow jak przy normalnych metodach.