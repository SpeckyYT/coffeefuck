# CoffeeFuck

A BrainFuck interpreter written in CoffeeScript.

## Installation

```sh
npm install --save coffeefuck
```

## Usage

```js
const coffeefuck = require('coffeefuck');
const result = coffeefuck('++++++++[->+++++<]');
console.log(result.memory);
```

## Return

```js
const {
    output,     // Array of the bytes extracted with "."
    memory,     // Array of the memory
    timeout,    // True if the time exceeded the timeout
    time,       // The time that it took (will be similar to the timeout if set)
} = coffeefuck('++[->+<]');
```

## Options

### options.length

Defines the maximal length of memory.
(default: 2**32-1)

```js
const result = coffeefuck('+>+>+>+>+>+', { length: 3 });
console.log(result);
```

### options.size

Defines the size of the bytes in the memory.
(default: 2**8)

```js
const result = coffeefuck('-', { size: 2**16 });
console.log(result);
```

### options.timeout

Stops running the BrainFuck interpretation after a specific time in milliseconds.
(default: Infinity)

```js
const result = coffeefuck('+[]', { timeout: 500 });
console.log(result);
```

### options.inputs

If you know what BrainFuck is, then you know for what this is for.
(default: [])

```js
const result = coffeefuck(',[->+<],', { inputs: [69,21] });
console.log(result);
```

### options.async

Returns a promise instead of running synchronously.
(default: false)

Note: This makes the interpretation slower.

```js
const result = await coffeefuck('+[>+[>+[+]<+]+[+]<+]', { async: true });
console.log(result);
```
