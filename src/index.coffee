brainfuck = (instructions, options = {}) ->
  isOptionNumber = (n) ->
    (not isNaN n) and
    (Number.isInteger n) and
    (n > 0)

  length = if isOptionNumber options.length then options.length else 2**32-1
  size = if isOptionNumber options.size then options.size else 2**8
  timeout = if Number.isFinite options.timeout then options.timeout else Infinity
  inputs = if Array.isArray options.inputs then options.inputs else []

  start = new Date()
  output = []
  memory = []
  loops = []
  skip = 0
  pos = 0
  cell = 0
  inputsIndex = 0

  time = ->
    new Date() - start
  exceededTimeout = ->
    time() >= timeout
  loopCondition = ->
    pos < instructions.length && not exceededTimeout()
  buildOutput = ->
    output: output
    memory: memory
    timeout: exceededTimeout()
    time: time()

  return buildOutput() if typeof instructions isnt 'string'

  iteration = ->
    memory.push 0 if cell >= memory.length

    switch instructions[pos]
      when '['
        if memory[cell] isnt 0 then loops.push pos else skip++
      when ']'
        if memory[cell] isnt 0 then pos = loops[loops.length-1] else
          if skip > 0 then skip-- else loops.pop()

    if skip is 0
      switch instructions[pos]
        when '>'
          if cell >= length-1 then cell = length-1 else cell++
        when '<'
          if cell <= 0 then cell = 0 else cell--
        when '+'
          memory[cell] = (memory[cell]+1) %% size
        when '-'
          memory[cell] = (memory[cell]-1) %% size
        when '.'
          output.push memory[cell]
        when ','
          if typeof inputs[inputsIndex] is 'number' and not isNaN inputs[inputsIndex]
            memory[cell] = (inputs[inputsIndex]) %% size
          inputsIndex++
    pos++

  if options.async
    new Promise (res,rej) ->
      while loopCondition()
        await new Promise (r) -> setImmediate r
        iteration()
      res buildOutput()
  else
    while loopCondition()
      iteration()
    buildOutput()

module.exports = brainfuck
