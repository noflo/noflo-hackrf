noflo = require 'noflo'

parse = (freq) ->
  return freq if typeof freq is 'number'
  freq = freq.replace /G/i, '* 1000000000'
  freq = freq.replace /M/i, '* 1000000'
  freq = freq.replace /k/i, '* 1000'
  freq = freq.replace /hz/, ''
  eval freq

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Convert frequency strings to numbers'
  c.inPorts.add 'in',
    datatype: 'string'
    description: 'Frequency string, e.g. "96.2Mhz"'
  c.outPorts.add 'out',
    datatype: 'number'

  c.process (input, output) ->
    data = input.get 'in'
    return unless data.type is 'data'
    output.sendDone
      out: parse data.data
