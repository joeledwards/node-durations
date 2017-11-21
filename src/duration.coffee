NANOS_PER_MICRO = 1000
NANOS_PER_MILLI = NANOS_PER_MICRO * 1000
NANOS_PER_SECOND = NANOS_PER_MILLI * 1000
NANOS_PER_MINUTE = NANOS_PER_SECOND * 60
NANOS_PER_HOUR = NANOS_PER_MINUTE * 60
NANOS_PER_DAY = NANOS_PER_HOUR * 24

class Duration
  constructor: (duration) ->
    @negative = duration < 0.0
    @sign = if @negative then "-" else ""
    @duration = if @negative then -duration else duration

  nanos: -> @duration
  micros: -> @duration / NANOS_PER_MICRO
  millis: -> @duration / NANOS_PER_MILLI
  seconds: -> @duration / NANOS_PER_SECOND
  minutes: -> @duration / NANOS_PER_MINUTE
  hours: -> @duration / NANOS_PER_HOUR
  days: -> @duration / NANOS_PER_DAY

  format: ->
    switch
      when @duration >= NANOS_PER_DAY then @sign + Math.floor(@hours() / 24) + " d, " + Math.floor(@hours() % 24) + " h"
      when @duration >= NANOS_PER_HOUR then @sign + Math.floor(@minutes() / 60) + " h, " + Math.floor(@minutes() % 60) + " min"
      when @duration >= NANOS_PER_MINUTE then @sign + Math.floor(@seconds() / 60) + " min, " + Math.floor(@seconds() % 60) + " s"
      when @duration >= NANOS_PER_SECOND then @sign + Math.floor(@millis() / 1000) + "." + @zPad(Math.floor(@millis() % 1000)) + " s"
      when @duration >= NANOS_PER_MILLI then @sign + Math.floor(@micros() / 1000) + "." + @zPad(Math.floor(@micros() % 1000)) + " ms"
      else @sign + Math.floor(@duration / 1000) + "." + @zPad(Math.floor(@duration % 1000)) + " us"

  # An alias to the format() method
  toString: ->
    return @format()

  # Pad value with zeros to at most three places
  zPad: (value) ->
    switch
      when value < 10 then "00" + value
      when value < 100 then "0" + value
      else "" + value

diffMoments = (momentA, momentB) ->
  nanos = moment.valueOf() * 1000000 - moment.valueOf() * 1000000
  newDuration nanos

module.exports =
  new: (ns) -> new Duration(ns)
  diffMoments: diffMoments

