import { helloWorldFromB } from './z1moduleB.js';

export function helloWorldFromA() {
  console.log("Hello from A!");
  helloWorldFromB();
}


// const {helloWorldFromB} = require('./z1moduleB');

// module.exports.helloWorldFromA = function() {
//   console.log("Hello from A!");
//   helloWorldFromB();
// }