#!/usr/bin/env coffee

isNode = if process?.hrtime()? then true else false

console.log "hrtime output is:", process.hrtime()
console.log "time is:", new Date().getTime()

console.log "Is Node.js: #{isNode}"

durations = require './src/index.coffee'

watch = durations.stopwatch()
console.log "Duration should be zero:", watch.duration().nanos()
console.log "Formatted, no time registered: ", watch.duration().format()
console.log "Should be same format as above:", watch.format()

watch = durations.stopwatch().start()
console.log "Duration should be non-zero:", watch.duration().nanos()
watch.stop()
console.log "Formatted duration, with time: ", watch.duration().format()
console.log "Should be same format as above:", watch.format()

console.log "Format on creation: ",
  durations.stopwatch().start().stop().format()

action = ->
  num for num in [1 .. 5000000]

actionAsync = (next) ->
  num for num in [5000000 .. 10000000]
  next()

durations.timeAsync(actionAsync).then((duration) ->
  console.log "Async timing:", duration.format()
)

console.log "Sync timing:", durations.time(action).format()

