hrtime = require './hrtime'
duration = require './duration'

class Stopwatch
  hrtimeDiffToNanos = (diff) -> diff[0] * 1e9 + diff[1]

  # Parameters:
  # * `options.start` - If false, then watch will be created in a stopped state.  All calls
  #   to `elapsedNanos()` will return 0 until `start()` is called.  Defaults to true, which is like
  #   creating a Stopwatch and calling start immediately.
  constructor: (@hrtime) ->
    @reset()

  # Reset this stopwatch.
  # `elapsedNanos()` will return 0 until the next call to `start()`.
  reset: ->
    @accumulator = 0
    @lastTime = null
    this

  # Start a stopped stopwatch.  If `stop()` has not been called, this has no effect.
  start: ->
    if !@lastTime?
      @lastTime = @hrtime()
    this

  # Stop a stopwatch.
  stop: ->
    if @lastTime?
      @accumulator += hrtimeDiffToNanos(@hrtime(@lastTime))
      @lastTime = null
    this

  duration: -> duration.new(@elapsedNanos())
  format: -> @duration().format()
  toString: -> @format()
   
  elapsedNanos: ->
    if @lastTime?
      @accumulator + hrtimeDiffToNanos(@hrtime(@lastTime))
    else
      @accumulator

  isRunning: -> @lastTime?

module.exports =
  new: -> new Stopwatch(hrtime)
  newWithCustomClock: (clock) -> new Stopwatch(clock)

