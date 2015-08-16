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
  c.outPorts.add 'error',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    in: 'device'
    out: 'device'
    params: ['frequency']
    forwardGroups: true
    async: true
  , (data, groups, out, callback) ->
    data.setFrequency c.params.frequency, (err) ->
      return callback err if err
      out.send data
      do callback
  c