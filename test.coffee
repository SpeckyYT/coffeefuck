coffeefuck = require '.'
chai = require 'chai'

should = chai.should()

join = (s) -> s.join ','

helloWorld = coffeefuck """
    ++++++++++[>+++++++>++++++++++>+++>+<<<<-]
    >++.>+.+++++++..+++.>++.<<++++++++++++
    +++.>.+++.------.--------.>+.>.
"""

timeout = coffeefuck "+[]", timeout: 50

# Hello World
should.equal join(helloWorld.output),
    [
        72, 101, 108, 108,111,
        32,
        87,111,114,108,100,33,
        10,
    ].join ','
should.equal join(helloWorld.memory), join([ 0, 87, 100, 33, 10 ])

# Timeout
should.equal timeout.timeout, true
