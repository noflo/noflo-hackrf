noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set the frequency for the HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF device'
  c.inPorts.add 'frequency',
    datatype: 'number'
    required: true
    control: true
  c.outPorts.add 'device',
    datatype: 'object'
  c.outPorts.add 'error',
    datatype: 'object'

  c.process (input, output) ->
    return unless input.has 'device', 'frequency'
    [device, frequency] = input.get 'device', 'frequency'
    return unless device.type is 'data'
    device.data.setFrequency frequency.data, (err) ->
      return output.sendDone err if err
      output.sendDone
        device: device.data
