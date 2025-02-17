import { helloWorldFromA } from './z1moduleA.js';

export function helloWorldFromB() {
  console.log("Hello from B!");
  helloWorldFromA();
}


// const {helloWorldFromA} = require('./z1moduleA');

// module.exports.helloWorldFromB = function() {
//   console.log("Hello from B!");
//   helloWorldFromA();
// }