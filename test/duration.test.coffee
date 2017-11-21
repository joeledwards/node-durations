assert = require 'assert'
{duration, stopwatch} = require '../src/index.coffee'

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

