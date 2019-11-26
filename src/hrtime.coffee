perf = global.performance || {}
{now, mozNow, msNow, oNow, webkitNow} = perf

polyNow = -> (new Date()).getTime()
perfNow = now || mozNow || msNow || oNow || webkitNow || polyNow

hrtime = (prevTime) ->
  clockTime = perfNow.call(perf) * 1e-3
  seconds = Math.floor clockTime
  ns = Math.floor((clockTime % 1) * 1e9)

  if prevTime
    seconds = seconds - prevTime[0]
    ns = ns - prevTime[1]
    if ns < 0
      seconds--
      ns += 1e9
  [seconds, ns]

module.exports = process.hrtime || hrtime
