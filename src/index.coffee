duration = require './duration'
stopwatch = require './stopwatch'
timing = require './timing'

module.exports =
  diffMoments: duration.diffMoments
  duration: duration.new
  stopwatch: stopwatch.new
  time: timing.time
  timeAsync: timing.timeAsync

