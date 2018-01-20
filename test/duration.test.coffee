{should, expect} = require('chai')
should()

{
  duration, stopwatch,
  nanos, micros, millis,seconds
} = require '../src/index.coffee'

describe "duration", ->
  it "should format days and hours correctly", ->
    duration(172800000000000).format().should.equal("2 d, 0 h")
    duration(172799000000000).format().should.equal("1 d, 23 h")
    duration(90000000000000).format().should.equal("1 d, 1 h")
    duration(86400000000000).format().should.equal("1 d, 0 h")

    duration(-86400000000000).format().should.equal("-1 d, 0 h")
    duration(-90000000000000).format().should.equal("-1 d, 1 h")
    duration(-172799000000000).format().should.equal("-1 d, 23 h")
    duration(-172800000000000).format().should.equal("-2 d, 0 h")

  it "should format hours and minutes correctly", ->
    duration(86399999999999).format().should.equal("23 h, 59 min")
    duration(7200000000000).format().should.equal("2 h, 0 min")
    duration(7199000000000).format().should.equal("1 h, 59 min")
    duration(3660000000000).format().should.equal("1 h, 1 min")
    duration(3659000000000).format().should.equal("1 h, 0 min")
    duration(3600000000000).format().should.equal("1 h, 0 min")

    duration(-3600000000000).format().should.equal("-1 h, 0 min")
    duration(-3659000000000).format().should.equal("-1 h, 0 min")
    duration(-3660000000000).format().should.equal("-1 h, 1 min")
    duration(-7199000000000).format().should.equal("-1 h, 59 min")
    duration(-7200000000000).format().should.equal("-2 h, 0 min")
    duration(-86399999999999).format().should.equal("-23 h, 59 min")

  it "should format minutes and seconds correctly", ->
    duration(3599000000000).format().should.equal("59 min, 59 s")
    duration(61000000000).format().should.equal("1 min, 1 s")
    duration(60000000000).format().should.equal("1 min, 0 s")

    duration(-60000000000).format().should.equal("-1 min, 0 s")
    duration(-61000000000).format().should.equal("-1 min, 1 s")
    duration(-3599000000000).format().should.equal("-59 min, 59 s")

  it "should format seconds correctly", ->
    duration(59999000000).format().should.equal("59.999 s")
    duration(59001000000).format().should.equal("59.001 s")
    duration(59000000000).format().should.equal("59.000 s")
    duration(1000000000).format().should.equal("1.000 s")

    duration(-1000000000).format().should.equal("-1.000 s")
    duration(-59000000000).format().should.equal("-59.000 s")
    duration(-59001000000).format().should.equal("-59.001 s")
    duration(-59999000000).format().should.equal("-59.999 s")

  it "should format milliseconds correctly", ->
    duration(999000000).format().should.equal("999.000 ms")
    duration(1999000).format().should.equal("1.999 ms")
    duration(1000000).format().should.equal("1.000 ms")

    duration(-1000000).format().should.equal("-1.000 ms")
    duration(-1999000).format().should.equal("-1.999 ms")
    duration(-999000000).format().should.equal("-999.000 ms")

  it "should format microseconds correctly", ->
    duration(999000).format().should.equal("999.000 us")
    duration(1999).format().should.equal("1.999 us")
    duration(1000).format().should.equal("1.000 us")
    duration(999).format().should.equal("0.999 us")
    duration(1).format().should.equal("0.001 us")

    duration(0).format().should.equal("0.000 us")

    duration(-1).format().should.equal("-0.001 us")
    duration(-999).format().should.equal("-0.999 us")
    duration(-1000).format().should.equal("-1.000 us")
    duration(-1999).format().should.equal("-1.999 us")
    duration(-999000).format().should.equal("-999.000 us")

  it "should return matching values from both format and toString", ->
    watch = stopwatch()
    watch.duration().format().should.equal(watch.duration().toString())
    watch.start()
    watch.stop()
    watch.duration().format().should.equal(watch.duration().toString())

  it "should load duration in nanoseconds", ->
    nanos(0).nanos().should.equal(0)
    nanos(0).micros().should.equal(0)
    nanos(0).millis().should.equal(0)
    nanos(0).seconds().should.equal(0)

    nanos(1).nanos().should.equal(1)
    nanos(1).micros().should.equal(0.001)
    nanos(1).millis().should.equal(0.000001)
    nanos(1).seconds().should.equal(0.000000001)

    nanos(123).nanos().should.equal(123)
    nanos(123).micros().should.equal(0.123)
    nanos(123).millis().should.equal(0.000123)

    nanos(123).seconds().should.equal(0.000000123)

    nanos(20).nanos().should.equal(20)
    nanos(20).micros().should.equal(0.02)
    nanos(20).millis().should.equal(0.00002)
    nanos(20).seconds().should.equal(0.00000002)

    nanos(2000).nanos().should.equal(2000)
    nanos(2000).micros().should.equal(2)
    nanos(2000).millis().should.equal(0.002)
    nanos(2000).seconds().should.equal(0.000002)

    nanos(3000000).nanos().should.equal(3000000)
    nanos(3000000).micros().should.equal(3000)
    nanos(3000000).millis().should.equal(3)
    nanos(3000000).seconds().should.equal(0.003)

    nanos(40000000000).nanos().should.equal(40000000000)
    nanos(40000000000).micros().should.equal(40000000)
    nanos(40000000000).millis().should.equal(40000)
    nanos(40000000000).seconds().should.equal(40)

  it "should load duration in nanoseconds", ->
    micros(0).nanos().should.equal(0)
    micros(0).micros().should.equal(0)
    micros(0).millis().should.equal(0)
    micros(0).seconds().should.equal(0)

    micros(1).nanos().should.equal(1000)
    micros(1).micros().should.equal(1)
    micros(1).millis().should.equal(0.001)
    micros(1).seconds().should.equal(0.000001)

    micros(123).nanos().should.equal(123000)
    micros(123).micros().should.equal(123)
    micros(123).millis().should.equal(0.123)
    micros(123).seconds().should.equal(0.000123)

    micros(20).nanos().should.equal(20000)
    micros(20).micros().should.equal(20)
    micros(20).millis().should.equal(0.02)
    micros(20).seconds().should.equal(0.00002)

    micros(2000).nanos().should.equal(2000000)
    micros(2000).micros().should.equal(2000)
    micros(2000).millis().should.equal(2)
    micros(2000).seconds().should.equal(0.002)

  it "should load duration in milliseconds", ->
    millis(0).nanos().should.equal(0)
    millis(0).micros().should.equal(0)
    millis(0).millis().should.equal(0)
    millis(0).seconds().should.equal(0)

    millis(1).nanos().should.equal(1000000)
    millis(1).micros().should.equal(1000)
    millis(1).millis().should.equal(1)
    millis(1).seconds().should.equal(0.001)

    millis(123).nanos().should.equal(123000000)
    millis(123).micros().should.equal(123000)
    millis(123).millis().should.equal(123)
    millis(123).seconds().should.equal(0.123)

    millis(20).nanos().should.equal(20000000)
    millis(20).micros().should.equal(20000)
    millis(20).millis().should.equal(20)
    millis(20).seconds().should.equal(0.02)

    millis(2000).nanos().should.equal(2000000000)
    millis(2000).micros().should.equal(2000000)
    millis(2000).millis().should.equal(2000)
    millis(2000).seconds().should.equal(2)

  it "should load duration in seconds", ->
    seconds(0).nanos().should.equal(0)
    seconds(0).micros().should.equal(0)
    seconds(0).millis().should.equal(0)
    seconds(0).seconds().should.equal(0)

    seconds(1).nanos().should.equal(1000000000)
    seconds(1).micros().should.equal(1000000)
    seconds(1).millis().should.equal(1000)
    seconds(1).seconds().should.equal(1)

    seconds(20).nanos().should.equal(20000000000)
    seconds(20).micros().should.equal(20000000)
    seconds(20).millis().should.equal(20000)
    seconds(20).seconds().should.equal(20)
