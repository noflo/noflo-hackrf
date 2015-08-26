noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set the LNA gain for the HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF device'
  c.inPorts.add 'gain',
    datatype: 'number'
    required: true
  c.outPorts.add 'device',
    datatype: 'object'
  c.outPorts.add 'error',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    in: 'device'
    out: 'device'
    params: ['gain']
    forwardGroups: true
    async: true
  , (data, groups, out, callback) ->
    if c.params.gain < 0 or c.params.gain > 40
      return callback new Error 'Gain must be 0-40'
    data.setLNAGain c.params.gain
    out.send data
    do callback
  c