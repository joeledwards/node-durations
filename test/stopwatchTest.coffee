assert = require 'assert'
timeunit = require 'timeunit'
durations = require '../src/index.coffee'

describe "stopwatch", ->
    it "should correctly record time for a second", (done) ->
        watch = durations.stopwatch().start()
        start = Date.now()

        timeunit.seconds.sleep 1, ->
            try
                end = Date.now()
                elapsedInMs = end - start
                measuredInMs = timeunit.nanoseconds.toMillis(watch.duration().nanos())
                deltaInMs = elapsedInMs - measuredInMs
                assert(Math.abs(deltaInMs) < 10, "Delta should be less than 10ms, was #{deltaInMs}ms")
                done()
            catch err
                done err

    it "should be created stopped", (done) ->
        watch = duration.stopwatch()

        timeunit.milliseconds.sleep 100, ->
            try
                assert.equal watch.getTime(), 0
                done()
            catch err
                done err

    it "should be stopped when reset() is called", (done) ->
        watch = durations.stopwatch().start()
        watch.reset()

        timeunit.milliseconds.sleep 100, ->
            try
                assert.equal watch.getTime(), 0
                done()
            catch err
                done err

    it "should format hours and minutes correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal watch.formatDuration(7200000000000), "2 h, 0 min"
            assert.equal watch.formatDuration(7199000000000), "1 h, 59 min"
            assert.equal watch.formatDuration(3660000000000), "1 h, 1 min"
            assert.equal watch.formatDuration(3659000000000), "1 h, 0 min"
            assert.equal watch.formatDuration(3600000000000), "1 h, 0 min"
            done()
        catch err
            done err

    it "should format minutes and seconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal watch.duration().formatDuration(3599000000000), "59 min, 59 s"
            assert.equal watch.duration().formatDuration(61000000000), "1 min, 1 s"
            assert.equal watch.duration().formatDuration(60000000000), "1 min, 0 s"
            done()
        catch err
            done err

    it "should format seconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal watch.duration().formatDuration(59999000000), "59.999 s"
            assert.equal watch.duration().formatDuration(59001000000), "59.001 s"
            assert.equal watch.duration().formatDuration(59000000000), "59.000 s"
            assert.equal watch.duration().formatDuration(1000000000), "1.000 s"
            done()
        catch err
            done err

    it "should format milliseconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal watch.duration().formatDuration(999000000), "999.000 ms"
            assert.equal watch.duration().formatDuration(1999000), "1.999 ms"
            assert.equal watch.duration().formatDuration(1000000), "1.000 ms"
            done()
        catch err
            done err

    it "should format microseconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal watch.duration().formatDuration(999000), "999.000 us"
            assert.equal watch.duration().formatDuration(1999), "1.999 us"
            assert.equal watch.duration().formatDuration(1000), "1.000 us"
            assert.equal watch.duration().formatDuration(999), "0.999 us"
            assert.equal watch.duration().formatDuration(1), "0.001 us"
            assert.equal watch.duration().formatDuration(0), "0.000 us"
            done()
        catch err
            done err

    it "should return matching values from both format and toString methods", (done) ->
        watch = durations.stopwatch()
        try
            assert.equal watch.duration().format(), watch.duration().toString()
            watch.start()
            watch.stop()
            assert.equal watch.duration().format(), watch.duration().toString()
            done()
        catch err
            done err

