noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Get version number of the connected HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF connection'
  c.outPorts.add 'out',
    datatype: 'string'

  noflo.helpers.WirePattern c,
    in: ['device']
    out: 'out'
    forwardGroups: true
  , (data, groups, out) ->
    out.send data.getVersion()
  c