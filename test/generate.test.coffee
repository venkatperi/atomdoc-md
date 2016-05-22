should = require 'should'
Generate = require '../lib/MarkdownGenerator'
path = require 'path'

generate = ( name ) ->
  new Generate path : path.join(__dirname, 'fixtures', "#{name}.json")

describe 'generate', ->

  it 'should load a tello api.json file', ( done ) ->
    generate 'PathSearcher'
    .generateMarkdown()
    .then ( output ) ->
      console.log output
      done()
    .fail done
    
    
  