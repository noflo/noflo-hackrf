noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Connect to a HackRF device'
  c.inPorts.add 'in',
    datatype: 'bang'
  c.outPorts.add 'device',
    datatype: 'object'
    description: 'HackRF connection'
  c.outPorts.add 'error',
    datatype: 'object'

  c.process (input, output) ->
    data = input.get 'in'
    return unless data.type is 'data'
    try
      hackrf = require 'hackrf'
      device = hackrf()
    catch e
      return output.sendDone e
    output.sendDone
      device: device
