noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Connect to a HackRF device'
  c.inPorts.add 'in',
    datatype: 'bang'
  c.outPorts.add 'device',
    datatype: 'object'
  c.outPorts.add 'error',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    out: 'device'
    forwardGroups: true
    async: true
  , (data, groups, out, callback) ->
    try
      hackrf = require 'hackrf'
      device = hackrf()
    catch e
      return callback e
    out.send device
    do callback
