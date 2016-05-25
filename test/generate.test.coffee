should = require 'should'
gen = require '../index'
assert = require 'assert'

describe 'generate', ->

  it 'should generate markdown, damn it', (done) ->
    gen 
      module: '.'
      doc : './test/tmp'
      level: 'verbose'
    .then (output) ->
      assert output.indexOf('<a name=\'classes\'>API</a>') > 0
      done()
    .fail done
    

