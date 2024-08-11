// Importing a module (assume utils.js exists)
import { add, subtract } from './utils.js';

// Async/Await and Promises
async function fetchData() {
    try {
        let response = await fetch('https://jsonplaceholder.typicode.com/posts/1');
        let data = await response.json();
        console.log(data);
    } catch (error) {
        console.error('Error fetching data:', error);
    }
}

fetchData();

// Object and array destructuring
const person = { name: "Bob", age: 25 };
const { name, age } = person;
console.log(name, age);

const numbers = [1, 2, 3];
const [first, , third] = numbers;
console.log(first, third);

// Class and inheritance
class Animal {
    constructor(name) {
        this.name = name;
    }

    speak() {
        console.log(`${this.name} makes a noise.`);
    }
}

class Dog extends Animal {
    speak() {
        console.log(`${this.name} barks.`);
    }
}

let dog = new Dog("Rex");
dog.speak();

// ES6 Modules usage
console.log(add(2, 3));
console.log(subtract(5, 2));
