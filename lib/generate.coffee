Q = require 'q'
donna = require 'donna-vp'
path = require 'path'
tello = require 'tello'
MarkdownGenerator = require './MarkdownGenerator'
prettyTime = require 'pretty-hrtime'
log = require('taglog') 'generate'
{writeFile} = require './util'
timed = require './timed'

save = ( file, data ) ->
  log.v 'saving file:', file
  writeFile file, JSON.stringify data, null, 2
  .then -> data

_run = ( docdir, meta ) -> ( name, args... ) ->
  timed args...
  .then ( [data, t] ) ->
    log.v "#{name}:", prettyTime t
    log.d data
    save path.join(docdir, "#{name}.json"), data if meta and data
    data

gen = ( opts ) ->
  throw new Error 'Missing option: module' unless opts.module
  opts.level ?= 'info'
  opts.doc ?= 'doc'
  opts.name ?= 'api.md'
  opts.template ?= 'api'

  log.level opts.level

  modulePath = path.resolve opts.module
  log.v 'module:', modulePath

  docdir = path.resolve(path.join opts.module, opts.doc)
  log.v 'docdir:', docdir

  log.v 'output file:', opts.name
  run = _run docdir, opts.meta

  Q()
  .then -> run 'donna', donna.generateMetadata, [ opts.module ]
  .then ( metadata )-> run 'tello', -> tello.digest metadata
  .then ( apiData ) ->
    gen = new MarkdownGenerator(
      modulePath : modulePath
      api : apiData,
      docdir : docdir,
      template : opts.template
      name : opts.name)
    run 'markdown', gen.generateMarkdown

gen.MarkdownGenerator = MarkdownGenerator

module.exports = gen 
