Q = require 'q'

NANOS_PER_MICRO = 1000
NANOS_PER_MILLI = NANOS_PER_MICRO * 1000
NANOS_PER_SECOND = NANOS_PER_MILLI * 1000
NANOS_PER_MINUTE = NANOS_PER_SECOND * 60
NANOS_PER_HOUR = NANOS_PER_MINUTE * 60
NANOS_PER_DAY = NANOS_PER_HOUR * 24

class Duration
  constructor: (@duration) ->

  nanos: ->
    return @duration

  micros: ->
    return @duration / NANOS_PER_MICRO

  millis: ->
    return @duration / NANOS_PER_MILLI

  seconds: ->
    return @durations / NANOS_PER_SECOND

  minutes: ->
    return @durations / NANOS_PER_MINUTE

  hours: ->
    return @durations / NANOS_PER_HOUR

  days: ->
    return @durations / NANOS_PER_DAY

  format: ->
    nanos = @duration
    if nanos >= NANOS_PER_HOUR
      minutes = nanos / NANOS_PER_MINUTE
      return Math.floor(minutes / 60) + " h, " + Math.floor(minutes % 60) + " min"

    if nanos >= NANOS_PER_MINUTE
      seconds = nanos / NANOS_PER_SECOND
      return Math.floor(seconds / 60) + " min, " + Math.floor(seconds % 60) + " s"

    if nanos >= NANOS_PER_SECOND
      millis = nanos / NANOS_PER_MILLI
      return Math.floor(millis / 1000) + "." + @zPad(Math.floor(millis % 1000)) + " s"

    if nanos >= NANOS_PER_MILLI
      micros = nanos / NANOS_PER_MICRO
      return Math.floor(micros / 1000) + "." + @zPad(Math.floor(micros % 1000)) + " ms"

    return Math.floor(nanos / 1000) + "." + @zPad(Math.floor(nanos % 1000)) + " us"

  # An alias to the format() method
  toString: ->
    return @format()

  # Pad value with zeros to at most three places
  zPad: (value) ->
    if value < 10
      return "00" + value
    if value < 100
      return "0" + value
    return "" + value

class Stopwatch
  hrtimeDiffToNanos = (diff) -> diff[0] * 1e9 + diff[1]

  # Parameters:
  # * `options.start` - If false, then watch will be created in a stopped state.  All calls
  #   to `elapsedNanos()` will return 0 until `start()` is called.  Defaults to true, which is like
  #   creating a Stopwatch and calling start immediately.
  constructor: ->
    @reset()

  # Reset this stopwatch.
  # `elapsedNanos()` will return 0 until the next call to `start()`.
  reset: ->
    @accumulator = 0
    @lastTime = null
    return this

  # Start a stopped stopwatch.  If `stop()` has not been called, this has no effect.
  start: ->
    if !@lastTime? then @lastTime = process.hrtime()
    return this

  # Stop a stopwatch.
  stop: ->
    if @lastTime?
      diff = process.hrtime(@lastTime)
      @accumulator += hrtimeDiffToNanos diff
      @lastTime = null
    return this

  # Get the elapsed Duration
  duration: ->
    return newDuration(@elapsedNanos())

  format: ->
    return @duration().format()

  toString: ->
    return @format()
   
  elapsedNanos: ->
    if @lastTime?
      diff = process.hrtime(@lastTime)
      return @accumulator + hrtimeDiffToNanos diff
    else
      return @accumulator

# Time an operation synchronously, and return the Duration
timeOperation = (operation) ->
  watch = newStopwatch().start()
  operation()
  return watch.stop().duration()

# Return a promise which will be resolved once the supplied 
# operations has been run, and called the completion function.
# The resolution of the promise is the Duration.
timeOperationAsync = (operation) ->
  deferred = Q.defer()
  watch = newStopwatch().start()

  next = ->
    duration = watch.stop().duration()
    deferred.resolve(duration)

  operation(next)

  return deferred.promise

newStopwatch = ->
  return new Stopwatch()

newDuration = (nanoseconds) ->
  return new Duration(nanoseconds)

module.exports =
  duration: newDuration
  stopwatch : newStopwatch
  time : timeOperation
  timeAsync : timeOperationAsync

