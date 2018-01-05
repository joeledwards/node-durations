{duration, stopwatch, time: timeSync, timeAsync} = require './src/index'

##
## Example for README.md (better really work)
##

#{durations, stopwatch, time: timeSync, timeAsync} = require './src/index'

nanoseconds = 987654321
console.log "Duration is", duration(nanoseconds).format()

# Or, since toString() is an alias to format()
console.log "Duration is #{duration(nanoseconds)}"

watch = stopwatch()
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

console.log "Took #{timeSync(someFunction)} to do something"

# Asynchronous work
someOtherFunction = (next) ->
  someFunction()
  next()

timeAsync someOtherFunction, (duration) ->
  console.log "Took #{duration} to do something else."

