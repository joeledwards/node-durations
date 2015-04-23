
Stopwatch
===========

A stopwatch class built around [`process.hrtime()`](http://nodejs.org/api/process.html#process_process_hrtime),
with all the usual stopwatch methods like "start" and "stop".

Timer
=====

Times the execution of a function, and returns the duration.

Installation
============

    npm install --save durations

Usage
=====

    durations = require 'durations'

    watch = durations.stopwatch()
    watch.stop()  # Pauses the stopwatch. Returns the stopwatch.
    watch.start() # Starts the stopwatch from where it was last stopped. Returns the stopwatch.
    watch.reset() # Reset the stopwatch (duration is set back to zero). Returns the stopwatch.
    duration = watch.duration() # Returns the Duration.


    durations.time(someFunction)
      .then (duration) ->
        console.log "Took", duration.format(), "to do something."
      

Compatibilty
============

The `durations` module uses `process.hrtime()`, therefore it will work only in node.js, not in browsers.

