stopwatch = require './stopwatch'

timeOperationSync = (operation) ->
  watch = stopwatch.new().start()
  operation()
  watch.stop().duration()

timeOperationAsync = (operation, callback) ->
  watch = stopwatch.new()
  if typeof callback == 'function'
    next = -> callback watch.stop().duration()
    watch.start()
    operation(next)
    undefined
  else
    new Promise (resolve, reject) ->
      next = (error) ->
        if error?
          reject error
        else
          resolve watch.stop().duration()
      watch.start()
      operation(next)

timeOperationPromised = (operation, callback) ->
  watch = stopwatch.new()
  if typeof callback == 'function'
    watch.start()
    operation().then -> callback(watch.stop().duration())
    undefined
  else
    watch.start()
    operation().then -> watch.stop().duration()

module.exports =
  time: timeOperationSync
  timeAsync: timeOperationAsync
  timePromised: timeOperationPromised
