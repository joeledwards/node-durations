stopwatch = require './stopwatch'

# Time an operation synchronously, and return the Duration
timeOperation = (operation) ->
  watch = stopwatch.new().start()
  operation()
  watch.stop().duration()

# Invoke the supplied callback once the supplied operation
# has finished, and called the completion function.
# The argument to the callback is the Duration.
timeOperationAsync = (operation, callback) ->
  watch = stopwatch.new().start()

  next = ->
    duration = watch.stop().duration()
    callback(duration)

  operation(next)

module.exports =
  time: timeOperation
  timeAsync: timeOperationAsync
