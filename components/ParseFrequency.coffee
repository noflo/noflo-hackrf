noflo = require 'noflo'

parse = (freq) ->
  return freq if typeof freq is 'number'
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

  noflo.helpers.WirePattern c,
    in: 'in'
    out: 'out'
    forwardGroups: true
  , (data, groups, out) ->
    out.send parse data