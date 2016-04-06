noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set the bandwidth for the HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF device'
  c.inPorts.add 'bandwidth',
    datatype: 'number'
    required: true
    control: true
  c.outPorts.add 'device',
    datatype: 'object'

  c.process (input, output) ->
    return unless input.has 'device', 'bandwidth'
    [device, bandwidth] = input.get 'device', 'bandwidth'
    return unless device.type is 'data'
    device.data.setBandwidth bandwidth.data, (err) ->
      return output.sendDone err if err
      output.sendDone
        device: device.data
