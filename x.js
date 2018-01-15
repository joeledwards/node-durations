const {duration, stopwatch, time: timeSync, timeAsync} = require('./lib/index')

const nanoseconds = 987654321
console.log("Duration is", duration(nanoseconds).format())

// Or, since toString() is an alias to format()
console.log(`Duration is ${duration(nanoseconds)}`)

const watch = stopwatch()

// Pauses the stopwatch. Returns the stopwatch.
watch.stop()

// Starts the stopwatch from where it was last stopped. Returns the stopwatch.
watch.start()

// Reset the stopwatch (duration is set back to zero). Returns the stopwatch.
watch.reset()

console.log(`${watch.duration().seconds()} seconds have elapsed`)
// OR
console.log(`${watch} have elapsed`)

// Synchronous work
const someFunction = () => {
  let count = 0

  while (count < 1000000) {
    count++
  }

  console.log(`Count is: ${count}`)
}

console.log(`Took ${timeSync(someFunction)} to do something`)

// Asynchronous work
const someOtherFunction = next => {
  someFunction()
  next()
}

timeAsync(someOtherFunction, duration => {
  console.log(`Took ${duration} to do something else.`)
})
