noflo = require 'noflo'
hackrf = require 'hackrf'
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Connect to a HackRF device'
  c.inPorts.add 'in',
    datatype: 'bang'
  c.outPorts.add 'device',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    out: 'device'
    forwardGroups: true
  , (data, groups, out) ->
    out.send hackrf()
