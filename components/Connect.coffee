noflo = require 'noflo'
hackrf = require 'hackrf'
exports.getComponent = ->
  c = new noflo.Component
  c.description = 'do X'
  c.inPorts.add 'in',
    datatype: 'bang'
  c.outPorts.add 'out',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    forwardGroups: true
  , (data, groups, out) ->
    out.send hackrf()
