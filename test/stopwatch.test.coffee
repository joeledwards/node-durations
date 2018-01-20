{should, expect} = require('chai')
should()

timeunit = require 'timeunit'
{duration, stopwatch} = require '../src/index.coffee'

describe "stopwatch", ->
    it "should correctly record time for a second", (done) ->
        watch = stopwatch().start()
        start = Date.now()

        timeunit.seconds.sleep 1, ->
            try
                end = Date.now()
                elapsedInMs = end - start
                measuredInMs = timeunit.nanoseconds.toMillis(watch.duration().nanos())
                deltaInMs = elapsedInMs - measuredInMs
                Math.abs(deltaInMs).should.be.below(10, "Delta should be less than 10ms, was #{deltaInMs}ms")
                done()
            catch err
                done err

    it "should be created stopped", (done) ->
        watch = stopwatch()

        timeunit.milliseconds.sleep 100, ->
            try
                watch.duration().nanos().should.equal(0)
                done()
            catch err
                done err

    it "should be stopped when reset() is called", (done) ->
        watch = stopwatch().start()
        watch.reset()

        timeunit.milliseconds.sleep 100, ->
            try
                watch.duration().nanos().should.equal(0)
                done()
            catch err
                done err

    it "should return matching values from both format and toString", (done) ->
        watch = stopwatch()
        try
            watch.format().should.equal(watch.toString())
            watch.start()
            watch.stop()
            watch.format().should.equal(watch.toString())
            done()
        catch err
            done err

