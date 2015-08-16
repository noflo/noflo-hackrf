# noflo-hackrf [![Build Status](https://secure.travis-ci.org/noflo/noflo-hackrf.png?branch=master)](http://travis-ci.org/noflo/noflo-hackrf)

HackRF components for NoFlo. These can be used to receive and transmit radio via a [HackRF](https://greatscottgadgets.com/hackrf/) compatible device, for example the CCCamp 2015 [rad1o badge](https://rad1o.badge.events.ccc.de/).

Basic usage:

* Create a Node.js project depending on this module
* Install and set up a [noflo-nodejs runtime](https://github.com/noflo/noflo-nodejs#noflo-nodejs-runtime-environment)
* Start the runtime and log into [Flowhub](http://app.flowhub.io). The runtime should show up
* Connect the HackRF device to the computer running noflo-nodejs
* Create a graph. To connect to HackRF, add a `hackrf/Connect` node and send a packet to its inport
