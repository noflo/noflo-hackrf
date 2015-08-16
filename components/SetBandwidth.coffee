noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set the bandwidth for the HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF device'
  c.inPorts.add 'bandwidth',
    datatype: 'number'
    required: true
  c.outPorts.add 'device',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    in: 'device'
    out: 'device'
    params: ['bandwidth']
    forwardGroups: true
    async: true
  , (data, groups, out, callback) ->
    data.setBandwidth c.params.bandwidth, (err) ->
      return callback err if err
      out.send data
      do callback
  c