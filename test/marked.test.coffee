should = require 'should'
marked = require 'marked'

describe 'marked', ->

  it 'should render code fences', ->
    txt = "Creates a immutable {Interval} object\n\n`arg1` can be a:\n\n* {String}: `<number> <sep> <number>` where sep\n  can be any one of a comma, semicolon, or a space\n* {Array}  of two {Number}s\n* {Object} with one of these key combinations:\n    `{from, to}` `{start, end}`  `{a, b}`\n* a {Number}, in which case `arg2` must be defined"
    console.log marked txt
    

