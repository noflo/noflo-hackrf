noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Get version number of the connected HackRF device'
  c.inPorts.add 'device',
    datatype: 'object'
    description: 'HackRF connection'
  c.outPorts.add 'out',
    datatype: 'string'
  c.outPorts.add 'error',
    datatype: 'object'

  c.process (input, output) ->
    data = input.get 'device'
    return unless data.type is 'data'
    try
      version = data.data.getVersion()
    catch e
      output.sendDone e
      return

    output.sendDone
      out: data.data.getVersion()
