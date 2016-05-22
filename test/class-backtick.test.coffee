should = require 'should'
assert = require 'assert'
classbt = require '../lib/class-backtick'

describe 'surround class names with backticks', ->

  it 'should do just that, damn it', ->
    res = classbt '{Array} of {String} file paths to search'
    assert res is '`{Array}` of `{String}` file paths to search'


    
  