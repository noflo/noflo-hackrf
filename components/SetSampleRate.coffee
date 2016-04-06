noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set the sample rate for the HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF device'
  c.inPorts.add 'rate',
    datatype: 'number'
    required: true
    control: true
  c.outPorts.add 'device',
    datatype: 'object'

  c.process (input, output) ->
    return unless input.has 'device', 'rate'
    [device, rate] = input.get 'device', 'rate'
    return unless device.type is 'data'
    device.data.setSampleRate rate.data, (err) ->
      return output.sendDone err if err
      output.sendDone
        device: device.data
