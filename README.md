
Stopwatch
===========

A nanosecond granularity (on Node.js) stopwatch with chainable control methods,
and built-in formatting.

Timer
=====

Times the execution of a function, and returns the duration.

Duration
========

Represents a duration with nanosecond granularity, and provides methods
for converting to other granularities, and formatting the duration.

Installation
============

```bash
npm install --save durations
```

Usage
=====

```coffeescript
durations = require 'durations'

nanoseconds = 987654321
console.log "Duration is", durations.duration(nanoseconds).format()

# Or, since toString() is an alias to format()
console.log "Duration is #{durations.duration(nanoseconds)}"

watch = durations.stopwatch()
watch.stop()  # Pauses the stopwatch. Returns the stopwatch.
watch.start() # Starts the stopwatch from where it was last stopped. Returns the stopwatch.
watch.reset() # Reset the stopwatch (duration is set back to zero). Returns the stopwatch.
duration = watch.duration() # Returns the Duration.

# Synchronous work
someFunction = ->
  count = 0
  for c in [1 .. 1000000]
    count += 1
  console.log "Count is: #{count}"

console.log "Took #{durations.time(someFunction)} to do something"

# Asynchronous work
someOtherFunction = (next) ->
  someFunction()
  next()

durations.timeAsync someOtherFunction, (duration) ->
  console.log "Took #{duration} to do something else."
```
      

Compatibilty
============

The `durations` module uses the `browser-process-hrtime` module in order to
support both Node.js and browsers. When using Node.js, the nanosecond-granulatiry 
`process.hrtime()` function is used. The best substitution is selected when
in the browser such that consistency is maintained even if time granularity
cannot be.

