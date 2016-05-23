Q = require 'q'
donna = require 'donna'
path = require 'path'
tello = require 'tello'
MarkdownGenerator = require './lib/MarkdownGenerator'
prettyTime = require 'pretty-hrtime'
log = require('./lib/log') 'index'
{writeFile} = require './lib/util'
timed = require './lib/timed'

save = ( file, data ) ->
  log.v 'saving file:', file
  writeFile file, JSON.stringify data, null, 2
  .then -> data

argv = require 'yargs'
.command 'generate <module>',
  'generate api markdown docs for the given module'

  module :
    describe : 'path to module'

  doc :
    describe : 'docs directory'
    alias : 'o'
    default : 'doc'

  level :
    alias : 'l'
    describe : 'log level'
    default : 'info'
    choices : [ 'debug', 'verbose', 'info', 'warn', 'error' ]

  template :
    default : 'api'
    describe : 'template name'

  meta :
    describe : 'write donna (donna.json) and tello (tello.json) metadata to' +
      ' doc dir'

  name :
    describe : 'generated file name'
    alias : 'n'
    default : 'api.md'

.demand 1, 'command missing'
.strict()
.argv

log.level argv.level
modulePath = path.resolve argv.module
docdir = path.resolve(path.join argv.module, argv.doc)

log.v 'module:', modulePath
log.v 'docdir:', docdir
log.v 'output file:', argv.name

logSave = ( name ) -> ( data ) ->
  log.d data
  return data unless argv.meta
  save path.join(docdir, name), data

Q()
.then ->
  timed 'donna', donna.generateMetadata, [ argv.module ]
  .then ( [m,t] ) ->
    log.v 'donna:', prettyTime t
    m
.then logSave 'donna.json'
.then ( metadata )->
  timed 'tello', -> tello.digest metadata
  .then ( [m,t] ) ->
    log.v 'tello:', prettyTime t
    m
.then logSave 'tello.json'
.then ( apiData ) ->
  log.d apiData

  gen = new MarkdownGenerator(
    modulePath : modulePath
    api : apiData,
    docdir : docdir,
    template : argv.template
    name : argv.name)
  timed 'generate markdown', gen.generateMarkdown
  .then ( [m,t] ) ->
    log.v 'generate markdown:', prettyTime t
    m
.then (  ) ->
  console.log 'Done.'
.fail ( err ) -> console.log err
  
