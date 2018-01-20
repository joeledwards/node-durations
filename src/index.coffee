duration = require './duration'
stopwatch = require './stopwatch'
timing = require './timing'

module.exports =
  diffMoments: duration.diffMoments
  duration: duration.new
  nanos: duration.nanos
  micros: duration.micros
  millis: duration.millis
  seconds: duration.seconds
  stopwatch: stopwatch.new
  time: timing.time
  timeAsync: timing.timeAsync
  timePromised: timing.timePromised

