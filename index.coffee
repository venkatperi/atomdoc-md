Q = require 'q'
donna = require 'donna-vp'
path = require 'path'
tello = require 'tello'
MarkdownGenerator = require './lib/MarkdownGenerator'
prettyTime = require 'pretty-hrtime'
log = require('taglog') 'index'
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
.version()
.argv

log.level argv.level
modulePath = path.resolve argv.module
docdir = path.resolve(path.join argv.module, argv.doc)

log.v 'module:', modulePath
log.v 'docdir:', docdir
log.v 'output file:', argv.name

run = ( name, args... ) ->
  timed args...
  .then ( [data, t] ) ->
    log.v "#{name}:", prettyTime t
    log.d data
    save path.join(docdir, "#{name}.json"), data if argv.meta and data
    data

Q()
.then -> run 'donna', donna.generateMetadata, [ argv.module ]
.then ( metadata )-> run 'tello', -> tello.digest metadata
.then ( apiData ) ->
  gen = new MarkdownGenerator(
    modulePath : modulePath
    api : apiData,
    docdir : docdir,
    template : argv.template
    name : argv.name)
  run 'markdown', gen.generateMarkdown
.then -> console.log 'Done.'
.fail ( err ) -> console.log err
.done()
    
module.exports = MarkdownGenerator
