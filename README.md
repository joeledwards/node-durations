# durations

## Compatibilty

Both Node.js and browsers are supported by `durations`. When using Node.js, the nanosecond-granulatiry `process.hrtime()` function is used. The best substitution is selected when in the browser such that consistency is maintained even if time granularity cannot be.

## Installation

```shell
npm install --save durations
```

## Methods

The following functions are exported:
* `duration(nanoseconds)` - constructs a new Duration
* `nanos(nanoseconds)` - constructs a new Duration
* `micros(microseconds)` - constructs a new Duration
* `millis(milliseconds)` - constructs a new Duration
* `seconds(seconds)` - constructs a new Duration
* `stopwatch()` - constructs a new Stopwatch (stopped)
* `time(function)` - times a function
* `timeAsync(function(callback))` - times a function asynchronously

## Duration

Represents a duration with nanosecond granularity, and provides methods
for converting to other granularities, and formatting the duration.

```coffeescript
{duration} = require 'durations'

nanoseconds = 987654321
console.log "Duration is", duration(nanoseconds).format()
```

### Methods
* `format()` - human readable string representing the duration
* `nanos()` - duration as nanoseconds
* `micros()` - duration as microseconds
* `millis()` - duration as milliseconds
* `seconds()` - duration as seconds
* `minutes()` - duration as minutes
* `hours()` - duration as hours
* `days()` - duration as days

# Or, since toString() is an alias to format()
console.log "Duration is #{duration(nanoseconds)}"

## Stopwatch

A nanosecond granularity (on Node.js) stopwatch with chainable control methods,
and built-in formatting.

```coffeescript
{stopwatch} = require 'durations'
watch = stopwatch()
watch.stop()  # Pauses the stopwatch. Returns the stopwatch.
watch.start() # Starts the stopwatch from where it was last stopped. Returns the stopwatch.
watch.reset() # Reset the stopwatch (duration is set back to zero). Returns the stopwatch.
duration = watch.duration() # Returns the Duration.
```

### Methods
* `start()` - start the stopwatch (no-op if already running)
* `stop()` - stop the stopwatch (no-op if not running)
* `reset()` - reset the stopwatch to zero elapsed time (implies stop)
* `duration()` - fetch the elapsed time as a Duration
* `isRunning()` -  is the stopwatch running (`true`/`false`)

## Timer

Times the execution of a function, and returns the duration.

```coffeescript
{time: timeSync, timeAsync} = require 'durations'

# Synchronous work
someFunction = ->
  count = 0
  for c in [1 .. 1000000]
    count += 1
  console.log "Count is: #{count}"

console.log "Took #{timeSync(someFunction)} to do something"

# Asynchronous work
someOtherFunction = (next) ->
  someFunction()
  next()

timeAsync someOtherFunction, (duration) ->
  console.log "Took #{duration} to do something else."
```

