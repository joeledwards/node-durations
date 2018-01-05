assert = require 'assert'
{
  duration, stopwatch,
  nanos, micros, millis,seconds
} = require '../src/index.coffee'

describe "duration", ->
    it "should format days and hours correctly", (done) ->
        try
            assert.equal duration(172800000000000).format(), "2 d, 0 h"
            assert.equal duration(172799000000000).format(), "1 d, 23 h"
            assert.equal duration(90000000000000).format(), "1 d, 1 h"
            assert.equal duration(86400000000000).format(), "1 d, 0 h"

            assert.equal duration(-86400000000000).format(), "-1 d, 0 h"
            assert.equal duration(-90000000000000).format(), "-1 d, 1 h"
            assert.equal duration(-172799000000000).format(), "-1 d, 23 h"
            assert.equal duration(-172800000000000).format(), "-2 d, 0 h"
            done()
        catch err
            done err

    it "should format hours and minutes correctly", (done) ->
        try
            assert.equal duration(86399999999999).format(), "23 h, 59 min"
            assert.equal duration(7200000000000).format(), "2 h, 0 min"
            assert.equal duration(7199000000000).format(), "1 h, 59 min"
            assert.equal duration(3660000000000).format(), "1 h, 1 min"
            assert.equal duration(3659000000000).format(), "1 h, 0 min"
            assert.equal duration(3600000000000).format(), "1 h, 0 min"

            assert.equal duration(-3600000000000).format(), "-1 h, 0 min"
            assert.equal duration(-3659000000000).format(), "-1 h, 0 min"
            assert.equal duration(-3660000000000).format(), "-1 h, 1 min"
            assert.equal duration(-7199000000000).format(), "-1 h, 59 min"
            assert.equal duration(-7200000000000).format(), "-2 h, 0 min"
            assert.equal duration(-86399999999999).format(), "-23 h, 59 min"
            done()
        catch err
            done err

    it "should format minutes and seconds correctly", (done) ->
        try
            assert.equal duration(3599000000000).format(), "59 min, 59 s"
            assert.equal duration(61000000000).format(), "1 min, 1 s"
            assert.equal duration(60000000000).format(), "1 min, 0 s"

            assert.equal duration(-60000000000).format(), "-1 min, 0 s"
            assert.equal duration(-61000000000).format(), "-1 min, 1 s"
            assert.equal duration(-3599000000000).format(), "-59 min, 59 s"
            done()
        catch err
            done err

    it "should format seconds correctly", (done) ->
        try
            assert.equal duration(59999000000).format(), "59.999 s"
            assert.equal duration(59001000000).format(), "59.001 s"
            assert.equal duration(59000000000).format(), "59.000 s"
            assert.equal duration(1000000000).format(), "1.000 s"

            assert.equal duration(-1000000000).format(), "-1.000 s"
            assert.equal duration(-59000000000).format(), "-59.000 s"
            assert.equal duration(-59001000000).format(), "-59.001 s"
            assert.equal duration(-59999000000).format(), "-59.999 s"
            done()
        catch err
            done err

    it "should format milliseconds correctly", (done) ->
        try
            assert.equal duration(999000000).format(), "999.000 ms"
            assert.equal duration(1999000).format(), "1.999 ms"
            assert.equal duration(1000000).format(), "1.000 ms"

            assert.equal duration(-1000000).format(), "-1.000 ms"
            assert.equal duration(-1999000).format(), "-1.999 ms"
            assert.equal duration(-999000000).format(), "-999.000 ms"
            done()
        catch err
            done err

    it "should format microseconds correctly", (done) ->
        try
            assert.equal duration(999000).format(), "999.000 us"
            assert.equal duration(1999).format(), "1.999 us"
            assert.equal duration(1000).format(), "1.000 us"
            assert.equal duration(999).format(), "0.999 us"
            assert.equal duration(1).format(), "0.001 us"

            assert.equal duration(0).format(), "0.000 us"

            assert.equal duration(-1).format(), "-0.001 us"
            assert.equal duration(-999).format(), "-0.999 us"
            assert.equal duration(-1000).format(), "-1.000 us"
            assert.equal duration(-1999).format(), "-1.999 us"
            assert.equal duration(-999000).format(), "-999.000 us"
            done()
        catch err
            done err

    it "should return matching values from both format and toString", (done) ->
        watch = stopwatch()
        try
            assert.equal watch.duration().format(), watch.duration().toString()
            watch.start()
            watch.stop()
            assert.equal watch.duration().format(), watch.duration().toString()
            done()
        catch err
            done err

    it "should load duration in nanoseconds", (done) ->
        assert.equal nanos(0).nanos(), 0
        assert.equal nanos(0).micros(), 0
        assert.equal nanos(0).millis(), 0
        assert.equal nanos(0).seconds(), 0

        assert.equal nanos(1).nanos(), 1
        assert.equal nanos(1).micros(), 0.001
        assert.equal nanos(1).millis(), 0.000001
        assert.equal nanos(1).seconds(), 0.000000001

        assert.equal nanos(123).nanos(), 123
        assert.equal nanos(123).micros(), 0.123
        assert.equal nanos(123).millis(), 0.000123

        assert.equal nanos(123).seconds(), 0.000000123

        assert.equal nanos(20).nanos(), 20
        assert.equal nanos(20).micros(), 0.02
        assert.equal nanos(20).millis(), 0.00002
        assert.equal nanos(20).seconds(), 0.00000002

        assert.equal nanos(2000).nanos(), 2000
        assert.equal nanos(2000).micros(), 2
        assert.equal nanos(2000).millis(), 0.002
        assert.equal nanos(2000).seconds(), 0.000002

        assert.equal nanos(3000000).nanos(), 3000000
        assert.equal nanos(3000000).micros(), 3000
        assert.equal nanos(3000000).millis(), 3
        assert.equal nanos(3000000).seconds(), 0.003

        assert.equal nanos(40000000000).nanos(), 40000000000
        assert.equal nanos(40000000000).micros(), 40000000
        assert.equal nanos(40000000000).millis(), 40000
        assert.equal nanos(40000000000).seconds(), 40

        done()

    it "should load duration in nanoseconds", (done) ->
        assert.equal micros(0).nanos(), 0
        assert.equal micros(0).micros(), 0
        assert.equal micros(0).millis(), 0
        assert.equal micros(0).seconds(), 0

        assert.equal micros(1).nanos(), 1000
        assert.equal micros(1).micros(), 1
        assert.equal micros(1).millis(), 0.001
        assert.equal micros(1).seconds(), 0.000001

        assert.equal micros(123).nanos(), 123000
        assert.equal micros(123).micros(), 123
        assert.equal micros(123).millis(), 0.123
        assert.equal micros(123).seconds(), 0.000123

        assert.equal micros(20).nanos(), 20000
        assert.equal micros(20).micros(), 20
        assert.equal micros(20).millis(), 0.02
        assert.equal micros(20).seconds(), 0.00002

        assert.equal micros(2000).nanos(), 2000000
        assert.equal micros(2000).micros(), 2000
        assert.equal micros(2000).millis(), 2
        assert.equal micros(2000).seconds(), 0.002

        done()

    it "should load duration in milliseconds", (done) ->
        assert.equal millis(0).nanos(), 0
        assert.equal millis(0).micros(), 0
        assert.equal millis(0).millis(), 0
        assert.equal millis(0).seconds(), 0

        assert.equal millis(1).nanos(), 1000000
        assert.equal millis(1).micros(), 1000
        assert.equal millis(1).millis(), 1
        assert.equal millis(1).seconds(), 0.001

        assert.equal millis(123).nanos(), 123000000
        assert.equal millis(123).micros(), 123000
        assert.equal millis(123).millis(), 123
        assert.equal millis(123).seconds(), 0.123

        assert.equal millis(20).nanos(), 20000000
        assert.equal millis(20).micros(), 20000
        assert.equal millis(20).millis(), 20
        assert.equal millis(20).seconds(), 0.02

        assert.equal millis(2000).nanos(), 2000000000
        assert.equal millis(2000).micros(), 2000000
        assert.equal millis(2000).millis(), 2000
        assert.equal millis(2000).seconds(), 2

        done()

    it "should load duration in seconds", (done) ->
        assert.equal seconds(0).nanos(), 0
        assert.equal seconds(0).micros(), 0
        assert.equal seconds(0).millis(), 0
        assert.equal seconds(0).seconds(), 0

        assert.equal seconds(1).nanos(), 1000000000
        assert.equal seconds(1).micros(), 1000000
        assert.equal seconds(1).millis(), 1000
        assert.equal seconds(1).seconds(), 1

        assert.equal seconds(20).nanos(), 20000000000
        assert.equal seconds(20).micros(), 20000000
        assert.equal seconds(20).millis(), 20000
        assert.equal seconds(20).seconds(), 20

        done()
