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
        watch = durations.stopwatch()

        timeunit.milliseconds.sleep 100, ->
            try
                assert.equal watch.duration().nanos(), 0
                done()
            catch err
                done err

    it "should be stopped when reset() is called", (done) ->
        watch = durations.stopwatch().start()
        watch.reset()

        timeunit.milliseconds.sleep 100, ->
            try
                assert.equal watch.duration().nanos(), 0
                done()
            catch err
                done err

    it "should format days and hours correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal durations.duration(172800000000000).format(), "2 d, 0 h"
            assert.equal durations.duration(172799000000000).format(), "1 d, 23 h"
            assert.equal durations.duration(90000000000000).format(), "1 d, 1 h"
            assert.equal durations.duration(86400000000000).format(), "1 d, 0 h"

            assert.equal durations.duration(-86400000000000).format(), "-1 d, 0 h"
            assert.equal durations.duration(-90000000000000).format(), "-1 d, 1 h"
            assert.equal durations.duration(-172799000000000).format(), "-1 d, 23 h"
            assert.equal durations.duration(-172800000000000).format(), "-2 d, 0 h"
            done()
        catch err
            done err

    it "should format hours and minutes correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal durations.duration(86399999999999).format(), "23 h, 59 min"
            assert.equal durations.duration(7200000000000).format(), "2 h, 0 min"
            assert.equal durations.duration(7199000000000).format(), "1 h, 59 min"
            assert.equal durations.duration(3660000000000).format(), "1 h, 1 min"
            assert.equal durations.duration(3659000000000).format(), "1 h, 0 min"
            assert.equal durations.duration(3600000000000).format(), "1 h, 0 min"

            assert.equal durations.duration(-3600000000000).format(), "-1 h, 0 min"
            assert.equal durations.duration(-3659000000000).format(), "-1 h, 0 min"
            assert.equal durations.duration(-3660000000000).format(), "-1 h, 1 min"
            assert.equal durations.duration(-7199000000000).format(), "-1 h, 59 min"
            assert.equal durations.duration(-7200000000000).format(), "-2 h, 0 min"
            assert.equal durations.duration(-86399999999999).format(), "-23 h, 59 min"
            done()
        catch err
            done err

    it "should format minutes and seconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal durations.duration(3599000000000).format(), "59 min, 59 s"
            assert.equal durations.duration(61000000000).format(), "1 min, 1 s"
            assert.equal durations.duration(60000000000).format(), "1 min, 0 s"

            assert.equal durations.duration(-60000000000).format(), "-1 min, 0 s"
            assert.equal durations.duration(-61000000000).format(), "-1 min, 1 s"
            assert.equal durations.duration(-3599000000000).format(), "-59 min, 59 s"
            done()
        catch err
            done err

    it "should format seconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal durations.duration(59999000000).format(), "59.999 s"
            assert.equal durations.duration(59001000000).format(), "59.001 s"
            assert.equal durations.duration(59000000000).format(), "59.000 s"
            assert.equal durations.duration(1000000000).format(), "1.000 s"

            assert.equal durations.duration(-1000000000).format(), "-1.000 s"
            assert.equal durations.duration(-59000000000).format(), "-59.000 s"
            assert.equal durations.duration(-59001000000).format(), "-59.001 s"
            assert.equal durations.duration(-59999000000).format(), "-59.999 s"
            done()
        catch err
            done err

    it "should format milliseconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal durations.duration(999000000).format(), "999.000 ms"
            assert.equal durations.duration(1999000).format(), "1.999 ms"
            assert.equal durations.duration(1000000).format(), "1.000 ms"

            assert.equal durations.duration(-1000000).format(), "-1.000 ms"
            assert.equal durations.duration(-1999000).format(), "-1.999 ms"
            assert.equal durations.duration(-999000000).format(), "-999.000 ms"
            done()
        catch err
            done err

    it "should format microseconds correctly", (done) ->
        watch = durations.stopwatch().start()
        try
            assert.equal durations.duration(999000).format(), "999.000 us"
            assert.equal durations.duration(1999).format(), "1.999 us"
            assert.equal durations.duration(1000).format(), "1.000 us"
            assert.equal durations.duration(999).format(), "0.999 us"
            assert.equal durations.duration(1).format(), "0.001 us"

            assert.equal durations.duration(0).format(), "0.000 us"

            assert.equal durations.duration(-1).format(), "-0.001 us"
            assert.equal durations.duration(-999).format(), "-0.999 us"
            assert.equal durations.duration(-1000).format(), "-1.000 us"
            assert.equal durations.duration(-1999).format(), "-1.999 us"
            assert.equal durations.duration(-999000).format(), "-999.000 us"
            done()
        catch err
            done err

    it "Stopwatch should return matching values from both format and toString", (done) ->
        watch = durations.stopwatch()
        try
            assert.equal watch.format(), watch.toString()
            watch.start()
            watch.stop()
            assert.equal watch.format(), watch.toString()
            done()
        catch err
            done err

    it "Duration should return matching values from both format and toString", (done) ->
        watch = durations.stopwatch()
        try
            assert.equal watch.duration().format(), watch.duration().toString()
            watch.start()
            watch.stop()
            assert.equal watch.duration().format(), watch.duration().toString()
            done()
        catch err
            done err

    it "Duration should load duration in nanoseconds", (done) ->
        assert.equal durations.nanos(0).nanos(), 0
        assert.equal durations.nanos(0).micros(), 0
        assert.equal durations.nanos(0).millis(), 0
        assert.equal durations.nanos(0).seconds(), 0

        assert.equal durations.nanos(1).nanos(), 1
        assert.equal durations.nanos(1).micros(), 0.001
        assert.equal durations.nanos(1).millis(), 0.000001
        assert.equal durations.nanos(1).seconds(), 0.000000001

        assert.equal durations.nanos(123).nanos(), 123
        assert.equal durations.nanos(123).micros(), 0.123
        assert.equal durations.nanos(123).millis(), 0.000123
        assert.equal durations.nanos(123).seconds(), 0.000000123

        assert.equal durations.nanos(20).nanos(), 20
        assert.equal durations.nanos(20).micros(), 0.02
        assert.equal durations.nanos(20).millis(), 0.00002
        assert.equal durations.nanos(20).seconds(), 0.00000002

        assert.equal durations.nanos(2000).nanos(), 2000
        assert.equal durations.nanos(2000).micros(), 2
        assert.equal durations.nanos(2000).millis(), 0.002
        assert.equal durations.nanos(2000).seconds(), 0.000002

        assert.equal durations.nanos(3000000).nanos(), 3000000
        assert.equal durations.nanos(3000000).micros(), 3000
        assert.equal durations.nanos(3000000).millis(), 3
        assert.equal durations.nanos(3000000).seconds(), 0.003

        assert.equal durations.nanos(40000000000).nanos(), 40000000000
        assert.equal durations.nanos(40000000000).micros(), 40000000
        assert.equal durations.nanos(40000000000).millis(), 40000
        assert.equal durations.nanos(40000000000).seconds(), 40

        done()

    it "Duration should load duration in nanoseconds", (done) ->
        assert.equal durations.micros(0).nanos(), 0
        assert.equal durations.micros(0).micros(), 0
        assert.equal durations.micros(0).millis(), 0
        assert.equal durations.micros(0).seconds(), 0

        assert.equal durations.micros(1).nanos(), 1000
        assert.equal durations.micros(1).micros(), 1
        assert.equal durations.micros(1).millis(), 0.001
        assert.equal durations.micros(1).seconds(), 0.000001

        assert.equal durations.micros(123).nanos(), 123000
        assert.equal durations.micros(123).micros(), 123
        assert.equal durations.micros(123).millis(), 0.123
        assert.equal durations.micros(123).seconds(), 0.000123

        assert.equal durations.micros(20).nanos(), 20000
        assert.equal durations.micros(20).micros(), 20
        assert.equal durations.micros(20).millis(), 0.02
        assert.equal durations.micros(20).seconds(), 0.00002

        assert.equal durations.micros(2000).nanos(), 2000000
        assert.equal durations.micros(2000).micros(), 2000
        assert.equal durations.micros(2000).millis(), 2
        assert.equal durations.micros(2000).seconds(), 0.002

        done()

    it "Duration should load duration in milliseconds", (done) ->
        assert.equal durations.millis(0).nanos(), 0
        assert.equal durations.millis(0).micros(), 0
        assert.equal durations.millis(0).millis(), 0
        assert.equal durations.millis(0).seconds(), 0

        assert.equal durations.millis(1).nanos(), 1000000
        assert.equal durations.millis(1).micros(), 1000
        assert.equal durations.millis(1).millis(), 1
        assert.equal durations.millis(1).seconds(), 0.001

        assert.equal durations.millis(123).nanos(), 123000000
        assert.equal durations.millis(123).micros(), 123000
        assert.equal durations.millis(123).millis(), 123
        assert.equal durations.millis(123).seconds(), 0.123

        assert.equal durations.millis(20).nanos(), 20000000
        assert.equal durations.millis(20).micros(), 20000
        assert.equal durations.millis(20).millis(), 20
        assert.equal durations.millis(20).seconds(), 0.02

        assert.equal durations.millis(2000).nanos(), 2000000000
        assert.equal durations.millis(2000).micros(), 2000000
        assert.equal durations.millis(2000).millis(), 2000
        assert.equal durations.millis(2000).seconds(), 2

        done()

    it "Duration should load duration in seconds", (done) ->
        assert.equal durations.seconds(0).nanos(), 0
        assert.equal durations.seconds(0).micros(), 0
        assert.equal durations.seconds(0).millis(), 0
        assert.equal durations.seconds(0).seconds(), 0

        assert.equal durations.seconds(1).nanos(), 1000000000
        assert.equal durations.seconds(1).micros(), 1000000
        assert.equal durations.seconds(1).millis(), 1000
        assert.equal durations.seconds(1).seconds(), 1

        assert.equal durations.seconds(20).nanos(), 20000000000
        assert.equal durations.seconds(20).micros(), 20000000
        assert.equal durations.seconds(20).millis(), 20000
        assert.equal durations.seconds(20).seconds(), 20

        done()


