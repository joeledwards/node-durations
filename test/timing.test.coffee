{should, expect} = require('chai')
should()

{
  time, timeAsync, timePromised
} = require '../src/timing.coffee'

describe "timing", ->
    it "should time an sync function", ->
      action = -> [0..1000000].map (i) -> i * 10
      duration = time action
      duration.millis().should.be.above 10

    it "should time an async function with a callback", (done) ->
      action = (next) ->
        setImmediate ->
          [0..1000000].map (i) -> i * 10
          next()

      verify = (duration) ->
        duration.millis().should.be.above 10
        done()

      result = timeAsync action, verify

      expect(result).to.be.undefined

    it "should time an async function and return a promise", (done) ->
      action = (next) ->
        setImmediate ->
          [0..1000000].map (i) -> i * 10
          next()

      verify = (duration) ->
        duration.millis().should.be.above 10
        done()

      timeAsync action
      .then verify, done

    it "should rejected returned promise if next called with error", (done) ->
      action = (next) ->
        setImmediate ->
          next new Error('doom')

      verify = (duration) ->
        duration.millis().should.be.above 10
        done()

      timeAsync action
      .then ->
        expect().to.fail('should not have resolved')
        done()
      .catch (error) ->
        error.message.should.equal('doom')
        done()

    it "should time an promise function with a callback", (done) ->
      action = ->
        new Promise (resolve) ->
          setImmediate ->
            [0..1000000].map (i) -> i * 10
            resolve()

      verify = (duration) ->
        duration.millis().should.be.above 10
        done()

      result = timePromised action, verify

      expect(result).to.be.undefined

    it "should time an promise function and return a promise", (done) ->
      action = ->
        new Promise (resolve) ->
          setImmediate ->
            [0..1000000].map (i) -> i * 10
            resolve()

      verify = (duration) ->
        duration.millis().should.be.above 10
        done()

      timePromised action
      .then verify, done

    it "should rejected returned promise if action promise rejects", (done) ->
      action = (next) ->
        new Promise (resolve, reject) ->
          setImmediate ->
            reject new Error('doom')

      fail = -> done(new Error('should not have resolved'))
      verify = (error) ->
        error.message.should.equal('doom')
        done()

      timePromised action
      .then fail, verify

