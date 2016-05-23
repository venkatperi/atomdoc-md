Q = require 'q'
donna = require 'donna'
path = require 'path'
tello = require 'tello'
MarkdownGenerator = require './lib/MarkdownGenerator'
prettyTime = require 'pretty-hrtime'
log = require('./lib/log') 'index'

time = ( name, f, args... ) ->
  start = process.hrtime()
  Q.fapply f, args...
  .then ( res ) ->
    end = process.hrtime start
    log.v "#{name}:", prettyTime end
    res

argv = require 'yargs'
.command 'generate <module>',
  'generate api markdown docs for the given module'

  module :
    describe : 'path to module'

  doc :
    describe : 'docs directory'
    alias : 'o'
    default : 'doc'

  verbose :
    alias : 'v'
    describe : 'verbose mode'

  template :
    default : 'api'
    describe : 'template name'

  name :
    describe : 'generated file name'
    alias : 'n'
    default : 'api.md'

.boolean 'verbose'
.demand 1, 'command missing'
.strict()
.argv

log.level if argv.verbose then 'verbose' else 'info'
modulePath = path.resolve argv.module
docdir = path.resolve(path.join argv.module, argv.doc)

log.v 'module:', modulePath
log.v 'docdir:', docdir
log.v 'output file:', argv.name

Q()
.then ->
  time 'donna', donna.generateMetadata, [ argv.module ]
.then ( metadata )->
  time 'tello', tello.digest, metadata
.then ( apiData ) ->
  gen = new MarkdownGenerator(
    api : apiData,
    docdir : docdir,
    template : argv.template
    name : argv.name)
  time 'generate markdown', gen.generateMarkdown
.then ( res ) ->
  console.log 'Done.'
.fail ( err ) -> console.log err
  
