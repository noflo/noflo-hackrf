noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set the frequency for the HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF device'
  c.inPorts.add 'frequency',
    datatype: 'number'
    required: true
  c.outPorts.add 'device',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    in: 'device'
    out: 'device'
    params: ['frequency']
    forwardGroups: true
  , (data, groups, out) ->
    data.setFrequency c.params.frequency
    out.send data
  c