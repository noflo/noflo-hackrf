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

  c.process (input, output) ->
    return unless input.has 'device', 'gain'
    [device, gain] = input.get 'device', 'gain'
    return unless device.type is 'data'
    if gain.data < 0 or gain.data > 40
      return output.sendDone new Error 'Gain must be 0-40'

    device.data.setLNAGain gain.data, (err) ->
      return output.sendDone err if err
      output.sendDone
        device: device.data
