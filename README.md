
Stopwatch
===========

A nanosecond granularity stopwatch with chainable control methods,
and formatting built in.

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

watch = durations.stopwatch()
watch.stop()  # Pauses the stopwatch. Returns the stopwatch.
watch.start() # Starts the stopwatch from where it was last stopped. Returns the stopwatch.
watch.reset() # Reset the stopwatch (duration is set back to zero). Returns the stopwatch.
duration = watch.duration() # Returns the Duration.

console.log "Took", durations.time(someFunction), "to do something."

durations.timeAsync(someFunction).then((duration) ->
  console.log "Took", duration.format(), "to do something."
)

console.log "Duration is", durations.duration(nanoseconds).format()
```
      

Compatibilty
============

The `durations` module uses `process.hrtime()`, therefore it will work only in node.js, not in browsers.

